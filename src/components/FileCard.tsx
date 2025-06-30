import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Eye, Download, Edit, Trash2 } from "lucide-react";
import React from "react";

interface FileCardProps {
  file: any;
  onPreview?: (file: any) => void;
  onEdit?: (file: any) => void;
  onDelete?: (file: any) => void;
  canManageFile?: boolean;
}

const formatFileSize = (bytes: number) => {
  if (!bytes) return "0 KB";
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
};

const getFileIcon = (type: string) => {
  if (!type) return <span className="h-8 w-8" />;
  if (type.startsWith("image")) return <span className="h-8 w-8 text-green-500">🖼️</span>;
  if (type.startsWith("video")) return <span className="h-8 w-8 text-purple-500">🎬</span>;
  if (type.includes("pdf") || type.includes("doc")) return <span className="h-8 w-8 text-blue-500">📄</span>;
  return <span className="h-8 w-8 text-gray-500">📁</span>;
};

const FileCard: React.FC<FileCardProps> = ({ file, onPreview, onEdit, onDelete, canManageFile }) => {
  return (
    <Card className="group hover:shadow-lg transition-all duration-300 cursor-pointer min-w-[320px] w-fit mx-auto">
      <CardContent className="p-4">
        <div className="space-y-3">
          {/* File Preview */}
          <div className="aspect-video bg-muted rounded-lg flex items-center justify-center relative overflow-hidden">
            {getFileIcon(file.file_type)}
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