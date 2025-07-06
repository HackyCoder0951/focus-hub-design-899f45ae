import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Eye, Download, Edit, Trash2, FileImage, FileVideo, FileText, FileArchive, File, FileAudio, FileCode, FileSpreadsheet, FileType2, Presentation } from "lucide-react";
import React from "react";
import { Tables } from "@/integrations/supabase/types";

type FileWithProfile = Tables<'filemodels'> & {
  profiles?: Tables<'profiles'> | null;
};

interface FileCardProps {
  file: FileWithProfile;
  onPreview?: (file: FileWithProfile) => void;
  onEdit?: (file: FileWithProfile) => void;
  onDelete?: (file: FileWithProfile) => void;
  canManageFile?: boolean;
}

const formatFileSize = (bytes: number) => {
  if (!bytes) return "0 KB";
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
};

const getFileIcon = (type: string, name?: string) => {
  const ext = name?.split('.').pop()?.toLowerCase() || '';
  if (type.startsWith("image")) return <FileImage className="h-8 w-8 text-green-500" />;
  if (type.startsWith("video")) return <FileVideo className="h-8 w-8 text-purple-500" />;
  if (type === "application/pdf" || ext === "pdf") return <FileText className="h-8 w-8 text-red-500" />;
  if (["doc", "docx"].includes(ext)) return <FileType2 className="h-8 w-8 text-blue-500" />;
  if (["xls", "xlsx"].includes(ext)) return <FileSpreadsheet className="h-8 w-8 text-green-700" />;
  if (["ppt", "pptx"].includes(ext)) return <Presentation className="h-8 w-8 text-orange-500" />;
  if (["zip", "rar", "7z"].includes(ext)) return <FileArchive className="h-8 w-8 text-yellow-500" />;
  if (["txt", "md", "json"].includes(ext) || type.startsWith("text/")) return <FileText className="h-8 w-8 text-gray-500" />;
  if (["mp3", "wav", "ogg"].includes(ext) || type.startsWith("audio/")) return <FileAudio className="h-8 w-8 text-pink-500" />;
  if (["js", "ts", "jsx", "tsx", "css", "html"].includes(ext)) return <FileCode className="h-8 w-8 text-blue-400" />;
  return <File className="h-8 w-8 text-gray-400" />;
};

const FileCard: React.FC<FileCardProps> = ({ file, onPreview, onEdit, onDelete, canManageFile }) => {
  return (
    <Card className="group hover:shadow-lg transition-all duration-300 cursor-pointer min-w-[320px] w-fit mx-auto">
      <CardContent className="p-4">
        <div className="space-y-3">
          {/* File Preview */}
          <div className="aspect-video bg-muted rounded-lg flex items-center justify-center relative overflow-hidden">
            {getFileIcon(file.file_type, file.file_name)}
          </div>
          {/* File Info */}
          <div className="space-y-2">
            <h3 className="font-semibold text-sm truncate" title={file.file_name}>
              {file.file_name}
            </h3>
            <p className="text-xs text-muted-foreground">{formatFileSize(file.file_size || 0)}</p>
            {file.profiles && (
              <div className="flex items-center gap-1 text-xs text-muted-foreground">
                <Avatar className="h-4 w-4">
                  <AvatarImage src={file.profiles?.avatar_url} />
                  <AvatarFallback>{file.profiles?.full_name?.charAt(0)}</AvatarFallback>
                </Avatar>
                <span>{file.profiles?.full_name}</span>
              </div>
            )}
            <div className="text-xs text-muted-foreground">
              Uploaded {file.created_at ? new Date(file.created_at).toLocaleDateString() : ''}
            </div>
            {file.description && (
              <div className="text-xs text-muted-foreground">{file.description}</div>
            )}
            {file.is_public && (
              <Badge variant="secondary" className="text-xs">Public</Badge>
            )}
          </div>
          {/* Action Buttons */}
          <div className="flex flex-wrap justify-center gap-2 mt-4">
            {onPreview && (
              <Button 
                size="sm" 
                variant="secondary"
                onClick={e => { e.preventDefault(); e.stopPropagation(); onPreview(file); }}
              >
                <Eye className="h-4 w-4 mr-1" />
                Preview
              </Button>
            )}
            <Button size="sm" variant="secondary" asChild>
              <a href={file.file_url} download target="_blank" rel="noopener noreferrer">
                <Download className="h-4 w-4 mr-1" />
                Download
              </a>
            </Button>
            {canManageFile && onEdit && (
              <Button 
                size="sm" 
                variant="secondary"
                onClick={e => { e.preventDefault(); e.stopPropagation(); onEdit(file); }}
              >
                <Edit className="h-4 w-4 mr-1" />
                Edit
              </Button>
            )}
            {canManageFile && onDelete && (
              <Button 
                size="sm" 
                variant="destructive"
                onClick={e => { e.preventDefault(); e.stopPropagation(); onDelete(file); }}
              >
                <Trash2 className="h-4 w-4 mr-1" />
                Delete
              </Button>
            )}
          </div>
        </div>
      </CardContent>
    </Card>
  );
};

export default FileCard; 