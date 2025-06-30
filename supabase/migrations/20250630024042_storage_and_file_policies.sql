-- =====================================================
-- STORAGE BUCKET CREATION
-- =====================================================

-- Create the uploads storage bucket
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'uploads',
  'uploads',
  true,
  52428800, -- 50MB limit
  ARRAY[
    'image/*',
    'video/*',
    'application/pdf',
    'text/*',
    'application/json',
    'application/javascript',
    'text/javascript',
    'text/css',
    'text/html',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'application/zip',
    'application/x-rar-compressed',
    'application/x-7z-compressed'
  ]
) ON CONFLICT (id) DO NOTHING;

-- =====================================================
-- STORAGE POLICIES
-- =====================================================

-- Allow authenticated users to upload files
CREATE POLICY "Allow authenticated uploads" ON storage.objects
FOR INSERT WITH CHECK (
  bucket_id = 'uploads' AND 
  auth.role() = 'authenticated'
);

-- Allow users to view their own files and public files
CREATE POLICY "Allow file viewing" ON storage.objects
FOR SELECT USING (
  bucket_id = 'uploads' AND (
    auth.uid()::text = (storage.foldername(name))[1] OR
    EXISTS (
      SELECT 1 FROM public.filemodels 
      WHERE file_url LIKE '%' || name || '%' 
      AND is_public = true
    )
  )
);

-- Allow users to update their own files
CREATE POLICY "Allow file updates" ON storage.objects
FOR UPDATE USING (
  bucket_id = 'uploads' AND 
  auth.uid()::text = (storage.foldername(name))[1]
);

-- Allow users to delete their own files
CREATE POLICY "Allow file deletion" ON storage.objects
FOR DELETE USING (
  bucket_id = 'uploads' AND 
  auth.uid()::text = (storage.foldername(name))[1]
);

-- =====================================================
-- FILEMODELS RLS POLICIES
-- =====================================================

-- Enable RLS on filemodels table
ALTER TABLE public.filemodels ENABLE ROW LEVEL SECURITY;

-- Allow users to view their own files and public files
CREATE POLICY "Users can view own and public files" ON public.filemodels
FOR SELECT USING (
  auth.uid() = user_id OR is_public = true
);

-- Allow users to insert their own files
CREATE POLICY "Users can insert own files" ON public.filemodels
FOR INSERT WITH CHECK (
  auth.uid() = user_id
);

-- Allow users to update their own files
CREATE POLICY "Users can update own files" ON public.filemodels
FOR UPDATE USING (
  auth.uid() = user_id
);

-- Allow users to delete their own files
CREATE POLICY "Users can delete own files" ON public.filemodels
FOR DELETE USING (
  auth.uid() = user_id
);

-- =====================================================
-- FUNCTIONS FOR FILE OPERATIONS
-- =====================================================

-- Function to delete file from storage when filemodel is deleted
CREATE OR REPLACE FUNCTION public.handle_file_deletion()
RETURNS TRIGGER AS $$
BEGIN
  -- Extract filename from file_url
  DECLARE
    file_path TEXT;
  BEGIN
    -- Extract the path from the file_url (remove domain and bucket prefix)
    file_path := REPLACE(OLD.file_url, 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/', '');
    
    -- Delete from storage
    DELETE FROM storage.objects 
    WHERE bucket_id = 'uploads' 
    AND name = file_path;
    
    RETURN OLD;
  EXCEPTION
    WHEN OTHERS THEN
      -- Log error but don't fail the deletion
      RAISE WARNING 'Failed to delete file from storage: %', SQLERRM;
      RETURN OLD;
  END;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to automatically delete storage files when filemodel is deleted
CREATE TRIGGER file_deletion_trigger
  AFTER DELETE ON public.filemodels
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_file_deletion();

-- Function to update file in storage when filemodel is updated
CREATE OR REPLACE FUNCTION public.handle_file_update()
RETURNS TRIGGER AS $$
BEGIN
  -- If file_url changed, delete old file from storage
  IF OLD.file_url != NEW.file_url THEN
    DECLARE
      old_file_path TEXT;
    BEGIN
      -- Extract the path from the old file_url
      old_file_path := REPLACE(OLD.file_url, 'https://hfiltwodcwlqwxrwfjyp.supabase.co/storage/v1/object/public/uploads/', '');
      
      -- Delete old file from storage
      DELETE FROM storage.objects 
      WHERE bucket_id = 'uploads' 
      AND name = old_file_path;
    EXCEPTION
      WHEN OTHERS THEN
        -- Log error but don't fail the update
        RAISE WARNING 'Failed to delete old file from storage: %', SQLERRM;
    END;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to handle file updates
CREATE TRIGGER file_update_trigger
  AFTER UPDATE ON public.filemodels
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_file_update();

-- =====================================================
-- INDEXES FOR BETTER PERFORMANCE
-- =====================================================

-- Index for file search by name and description
CREATE INDEX IF NOT EXISTS idx_filemodels_search 
ON public.filemodels USING gin(to_tsvector('english', file_name || ' ' || COALESCE(description, '')));

-- Index for public files
CREATE INDEX IF NOT EXISTS idx_filemodels_public 
ON public.filemodels(is_public) WHERE is_public = true;

-- Index for user files
CREATE INDEX IF NOT EXISTS idx_filemodels_user_created 
ON public.filemodels(user_id, created_at DESC); 