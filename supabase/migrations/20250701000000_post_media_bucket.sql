-- Create the post-media storage bucket
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'post-media',
  'post-media',
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

-- Allow public read access to post-media bucket
CREATE POLICY IF NOT EXISTS "Public read access to post-media" ON storage.objects
FOR SELECT USING (bucket_id = 'post-media'); 