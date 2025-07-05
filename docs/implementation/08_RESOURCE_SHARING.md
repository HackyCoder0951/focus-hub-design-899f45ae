# Resource Sharing Module Implementation

## Overview

The Resource Sharing module allows users to upload, share, and manage files with public/private visibility controls and download tracking.

## Core Components

### 1. Resources Page Component

**File**: `src/pages/Resources.tsx`
```typescript
import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Upload, Search, Filter, Download, Eye, EyeOff } from 'lucide-react';
import { FileCard } from '@/components/FileCard';
import { UploadFile } from '@/components/UploadFile';
import { useToast } from '@/hooks/use-toast';

interface FileModel {
  id: string;
  file_name: string;
  file_url: string;
  file_type: string | null;
  file_size: number | null;
  description: string | null;
  is_public: boolean;
  created_at: string;
  user_id: string;
  profiles: {
    full_name: string;
    avatar_url: string | null;
  };
}

const Resources = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [files, setFiles] = useState<FileModel[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [filter, setFilter] = useState<'all' | 'my' | 'public'>('all');
  const [showUpload, setShowUpload] = useState(false);

  const fetchFiles = async () => {
    try {
      let query = supabase
        .from('filemodels')
        .select(`
          *,
          profiles (full_name, avatar_url)
        `)
        .order('created_at', { ascending: false });

      // Apply filters
      if (filter === 'my') {
        query = query.eq('user_id', user?.id);
      } else if (filter === 'public') {
        query = query.eq('is_public', true);
      }

      // Apply search
      if (searchQuery.trim()) {
        query = query.ilike('file_name', `%${searchQuery}%`);
      }

      const { data, error } = await query;

      if (error) throw error;
      setFiles(data || []);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load files",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchFiles();
  }, [filter, searchQuery]);

  const handleFileUploaded = () => {
    setShowUpload(false);
    fetchFiles();
  };

  const handleFileDeleted = (fileId: string) => {
    setFiles(prev => prev.filter(file => file.id !== fileId));
  };

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">Resources</h1>
        <Button onClick={() => setShowUpload(true)}>
          <Upload className="h-4 w-4 mr-2" />
          Upload File
        </Button>
      </div>

      <div className="flex items-center space-x-4">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-muted-foreground h-4 w-4" />
          <Input
            placeholder="Search files..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-10"
          />
        </div>
        <Button variant="outline">
          <Filter className="h-4 w-4 mr-2" />
          Filter
        </Button>
      </div>

      <Tabs value={filter} onValueChange={(value) => setFilter(value as any)}>
        <TabsList>
          <TabsTrigger value="all">All Files</TabsTrigger>
          <TabsTrigger value="my">My Files</TabsTrigger>
          <TabsTrigger value="public">Public Files</TabsTrigger>
        </TabsList>
      </Tabs>

      {showUpload && (
        <UploadFile onFileUploaded={handleFileUploaded} />
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {files.map((file) => (
          <FileCard
            key={file.id}
            file={file}
            currentUserId={user?.id}
            onDelete={handleFileDeleted}
          />
        ))}
      </div>

      {files.length === 0 && !loading && (
        <div className="text-center py-12">
          <p className="text-muted-foreground">No files found.</p>
        </div>
      )}
    </div>
  );
};

export default Resources;
```

### 2. File Card Component

**File**: `src/components/FileCard.tsx`
```typescript
import { useState } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { Download, Eye, EyeOff, MoreHorizontal, Trash2, Copy } from 'lucide-react';
import { formatDistanceToNow } from 'date-fns';
import { useToast } from '@/hooks/use-toast';

interface FileCardProps {
  file: any;
  currentUserId?: string;
  onDelete: (fileId: string) => void;
}

export const FileCard = ({ file, currentUserId, onDelete }: FileCardProps) => {
  const { toast } = useToast();
  const [isPublic, setIsPublic] = useState(file.is_public);

  const getFileIcon = (fileType: string | null) => {
    if (!fileType) return '📄';
    
    if (fileType.startsWith('image/')) return '🖼️';
    if (fileType.startsWith('video/')) return '🎥';
    if (fileType.startsWith('audio/')) return '🎵';
    if (fileType.includes('pdf')) return '📕';
    if (fileType.includes('word') || fileType.includes('document')) return '📝';
    if (fileType.includes('excel') || fileType.includes('spreadsheet')) return '📊';
    if (fileType.includes('powerpoint') || fileType.includes('presentation')) return '📽️';
    if (fileType.includes('zip') || fileType.includes('archive')) return '📦';
    
    return '📄';
  };

  const formatFileSize = (bytes: number | null) => {
    if (!bytes) return 'Unknown size';
    
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(1024));
    return Math.round(bytes / Math.pow(1024, i) * 100) / 100 + ' ' + sizes[i];
  };

  const handleDownload = async () => {
    try {
      const link = document.createElement('a');
      link.href = file.file_url;
      link.download = file.file_name;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);

      // Track download
      await supabase
        .from('file_downloads')
        .insert({
          file_id: file.id,
          user_id: currentUserId,
          downloaded_at: new Date().toISOString()
        });

      toast({
        title: "Download started",
        description: "File download has begun",
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to download file",
        variant: "destructive",
      });
    }
  };

  const handleToggleVisibility = async () => {
    try {
      const { error } = await supabase
        .from('filemodels')
        .update({ is_public: !isPublic })
        .eq('id', file.id);

      if (error) throw error;

      setIsPublic(!isPublic);
      toast({
        title: "Success",
        description: `File is now ${!isPublic ? 'public' : 'private'}`,
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to update file visibility",
        variant: "destructive",
      });
    }
  };

  const handleDelete = async () => {
    try {
      const { error } = await supabase
        .from('filemodels')
        .delete()
        .eq('id', file.id);

      if (error) throw error;

      onDelete(file.id);
      toast({
        title: "Success",
        description: "File deleted successfully",
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to delete file",
        variant: "destructive",
      });
    }
  };

  const copyFileUrl = async () => {
    try {
      await navigator.clipboard.writeText(file.file_url);
      toast({
        title: "Copied",
        description: "File URL copied to clipboard",
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to copy URL",
        variant: "destructive",
      });
    }
  };

  const isOwner = currentUserId === file.user_id;

  return (
    <Card>
      <CardHeader className="pb-3">
        <div className="flex items-start justify-between">
          <div className="flex items-center space-x-3">
            <div className="text-2xl">
              {getFileIcon(file.file_type)}
            </div>
            <div className="flex-1 min-w-0">
              <CardTitle className="text-sm truncate">
                {file.file_name}
              </CardTitle>
              <p className="text-xs text-muted-foreground">
                {formatFileSize(file.file_size)}
              </p>
            </div>
          </div>
          
          <div className="flex items-center space-x-2">
            <Badge variant={isPublic ? "default" : "secondary"}>
              {isPublic ? "Public" : "Private"}
            </Badge>
            
            {isOwner && (
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="ghost" size="sm">
                    <MoreHorizontal className="h-4 w-4" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem onClick={handleToggleVisibility}>
                    {isPublic ? (
                      <>
                        <EyeOff className="h-4 w-4 mr-2" />
                        Make Private
                      </>
                    ) : (
                      <>
                        <Eye className="h-4 w-4 mr-2" />
                        Make Public
                      </>
                    )}
                  </DropdownMenuItem>
                  <DropdownMenuItem onClick={copyFileUrl}>
                    <Copy className="h-4 w-4 mr-2" />
                    Copy URL
                  </DropdownMenuItem>
                  <DropdownMenuItem onClick={handleDelete} className="text-red-600">
                    <Trash2 className="h-4 w-4 mr-2" />
                    Delete
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            )}
          </div>
        </div>
      </CardHeader>

      <CardContent className="space-y-3">
        {file.description && (
          <p className="text-sm text-muted-foreground">
            {file.description}
          </p>
        )}

        <div className="flex items-center justify-between text-xs text-muted-foreground">
          <div className="flex items-center space-x-2">
            <Avatar className="h-4 w-4">
              <AvatarImage src={file.profiles?.avatar_url} />
              <AvatarFallback>
                {file.profiles?.full_name?.charAt(0)}
              </AvatarFallback>
            </Avatar>
            <span>{file.profiles?.full_name}</span>
          </div>
          <span>{formatDistanceToNow(new Date(file.created_at), { addSuffix: true })}</span>
        </div>

        <Button onClick={handleDownload} className="w-full" size="sm">
          <Download className="h-4 w-4 mr-2" />
          Download
        </Button>
      </CardContent>
    </Card>
  );
};
```

### 3. Upload File Component

**File**: `src/components/UploadFile.tsx`
```typescript
import { useState, useRef } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Checkbox } from '@/components/ui/checkbox';
import { Label } from '@/components/ui/label';
import { Upload, X, Loader2 } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

interface UploadFileProps {
  onFileUploaded: () => void;
}

export const UploadFile = ({ onFileUploaded }: UploadFileProps) => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [description, setDescription] = useState('');
  const [isPublic, setIsPublic] = useState(false);
  const [isUploading, setIsUploading] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      // Validate file size (50MB limit)
      if (file.size > 50 * 1024 * 1024) {
        toast({
          title: "File too large",
          description: "Please select a file smaller than 50MB",
          variant: "destructive",
        });
        return;
      }

      setSelectedFile(file);
    }
  };

  const removeFile = () => {
    setSelectedFile(null);
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  const uploadFile = async () => {
    if (!selectedFile || !user) return;

    setIsUploading(true);

    try {
      // Upload to storage
      const fileExt = selectedFile.name.split('.').pop();
      const fileName = `${Date.now()}-${Math.random().toString(36).substring(2)}.${fileExt}`;
      const filePath = `uploads/${fileName}`;

      const { error: uploadError } = await supabase.storage
        .from('uploads')
        .upload(filePath, selectedFile);

      if (uploadError) throw uploadError;

      // Get public URL
      const { data: { publicUrl } } = supabase.storage
        .from('uploads')
        .getPublicUrl(filePath);

      // Save file record to database
      const { error: dbError } = await supabase
        .from('filemodels')
        .insert({
          file_name: selectedFile.name,
          file_url: publicUrl,
          file_type: selectedFile.type,
          file_size: selectedFile.size,
          description: description.trim() || null,
          is_public: isPublic,
          user_id: user.id
        });

      if (dbError) throw dbError;

      // Reset form
      setSelectedFile(null);
      setDescription('');
      setIsPublic(false);
      if (fileInputRef.current) {
        fileInputRef.current.value = '';
      }

      toast({
        title: "Success",
        description: "File uploaded successfully",
      });

      onFileUploaded();

    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "Failed to upload file",
        variant: "destructive",
      });
    } finally {
      setIsUploading(false);
    }
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle>Upload File</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="space-y-2">
          <Label htmlFor="file">Select File</Label>
          <input
            ref={fileInputRef}
            type="file"
            id="file"
            onChange={handleFileSelect}
            className="hidden"
          />
          
          {!selectedFile ? (
            <div
              className="border-2 border-dashed border-muted-foreground/25 rounded-lg p-6 text-center cursor-pointer hover:border-muted-foreground/50 transition-colors"
              onClick={() => fileInputRef.current?.click()}
            >
              <Upload className="h-8 w-8 mx-auto text-muted-foreground mb-2" />
              <p className="text-muted-foreground">Click to select a file</p>
              <p className="text-xs text-muted-foreground mt-1">
                Maximum file size: 50MB
              </p>
            </div>
          ) : (
            <div className="flex items-center justify-between p-3 border rounded-lg">
              <div className="flex items-center space-x-3">
                <div className="text-2xl">
                  {selectedFile.type.startsWith('image/') ? '🖼️' : '📄'}
                </div>
                <div>
                  <p className="font-medium">{selectedFile.name}</p>
                  <p className="text-sm text-muted-foreground">
                    {(selectedFile.size / 1024 / 1024).toFixed(2)} MB
                  </p>
                </div>
              </div>
              <Button
                variant="ghost"
                size="sm"
                onClick={removeFile}
              >
                <X className="h-4 w-4" />
              </Button>
            </div>
          )}
        </div>

        <div className="space-y-2">
          <Label htmlFor="description">Description (Optional)</Label>
          <Textarea
            id="description"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Add a description for this file..."
            rows={3}
          />
        </div>

        <div className="flex items-center space-x-2">
          <Checkbox
            id="isPublic"
            checked={isPublic}
            onCheckedChange={(checked) => setIsPublic(checked as boolean)}
          />
          <Label htmlFor="isPublic">Make this file public</Label>
        </div>

        <div className="flex space-x-2">
          <Button
            onClick={uploadFile}
            disabled={!selectedFile || isUploading}
            className="flex-1"
          >
            {isUploading ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                Uploading...
              </>
            ) : (
              <>
                <Upload className="h-4 w-4 mr-2" />
                Upload File
              </>
            )}
          </Button>
        </div>
      </CardContent>
    </Card>
  );
};
```

## Database Schema

### File Models Table
```sql
CREATE TABLE filemodels (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  file_name TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_type TEXT,
  file_size INTEGER,
  description TEXT,
  is_public BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### File Downloads Table (Optional)
```sql
CREATE TABLE file_downloads (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  file_id UUID REFERENCES filemodels(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  downloaded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## File Management Functions

### 1. File Deletion Handler
```sql
CREATE OR REPLACE FUNCTION handle_file_deletion()
RETURNS TRIGGER AS $$
BEGIN
  DECLARE
    file_path TEXT;
  BEGIN
    -- Extract the path from the file_url
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
```

### 2. File Update Handler
```sql
CREATE OR REPLACE FUNCTION handle_file_update()
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
```

## Storage Configuration

### 1. Storage Bucket Setup
```sql
-- Create uploads bucket
INSERT INTO storage.buckets (id, name, public)
VALUES ('uploads', 'uploads', true);

-- Set up storage policies
CREATE POLICY "Public files are viewable by everyone" ON storage.objects
  FOR SELECT USING (bucket_id = 'uploads');

CREATE POLICY "Users can upload files" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'uploads' AND auth.uid() IS NOT NULL);

CREATE POLICY "Users can update their own files" ON storage.objects
  FOR UPDATE USING (bucket_id = 'uploads' AND auth.uid() IS NOT NULL);

CREATE POLICY "Users can delete their own files" ON storage.objects
  FOR DELETE USING (bucket_id = 'uploads' AND auth.uid() IS NOT NULL);
```

This resource sharing module provides comprehensive file management capabilities with proper storage handling, visibility controls, and download tracking. 