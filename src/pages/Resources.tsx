import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search, Upload, Download, FileText, Image as ImageIcon, File, Filter, Loader2, X, CheckCircle, Eye, Play, FileVideo, Trash2, Edit } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";

const Resources = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [searchQuery, setSearchQuery] = useState("");
  const [files, setFiles] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [isUploading, setIsUploading] = useState(false);
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [fileDescription, setFileDescription] = useState("");
  const [isPublic, setIsPublic] = useState(false);
  const [showUploadSuccess, setShowUploadSuccess] = useState(false);
  const [uploadedFileName, setUploadedFileName] = useState("");
  const [dialogOpen, setDialogOpen] = useState(false);
  const [previewFile, setPreviewFile] = useState<any>(null);
  const [previewOpen, setPreviewOpen] = useState(false);
  const [textContent, setTextContent] = useState("");
  const [loadingText, setLoadingText] = useState(false);
  const [deleteFile, setDeleteFile] = useState<any>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [editFile, setEditFile] = useState<any>(null);
  const [editDialogOpen, setEditDialogOpen] = useState(false);
  const [editDescription, setEditDescription] = useState("");
  const [editIsPublic, setEditIsPublic] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);
  const [isUpdating, setIsUpdating] = useState(false);

  const fetchFiles = async () => {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('filemodels')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .order('created_at', { ascending: false });
      
      if (error) {
        console.error('Error fetching files:', error);
        return;
      }

      setFiles(data || []);
    } catch (error) {
      console.error('Error fetching files:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchFiles();
  }, []);

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      setSelectedFile(file);
    }
  };

  const handleUpload = async () => {
    if (!user || !selectedFile) {
      toast({
        title: "Upload failed",
        description: "Please select a file to upload.",
        variant: "destructive",
      });
      return;
    }

    setIsUploading(true);

    try {
      // Create a unique file name
      const fileExt = selectedFile.name.split('.').pop();
      const fileName = `${user.id}/${Date.now()}.${fileExt}`;

      // Upload file to Supabase Storage
      const { data: uploadData, error: uploadError } = await supabase.storage
        .from('uploads')
        .upload(fileName, selectedFile);

      if (uploadError) throw uploadError;

      // Get the public URL
      const { data: urlData } = supabase.storage
        .from('uploads')
        .getPublicUrl(fileName);

      // Save file metadata to database
      const { error: dbError } = await supabase
        .from('filemodels')
        .insert({
          user_id: user.id,
          file_url: urlData.publicUrl,
          file_name: selectedFile.name,
          file_type: selectedFile.type,
          file_size: selectedFile.size,
          description: fileDescription.trim() || null,
          is_public: isPublic,
        });

      if (dbError) throw dbError;

      // Show success state instead of immediately resetting
      setUploadedFileName(selectedFile.name);
      setShowUploadSuccess(true);

      // Refresh files list
      fetchFiles();
    } catch (error: any) {
      console.error('Error uploading file:', error);
      toast({
        title: "Upload failed",
        description: error.message || "Something went wrong. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsUploading(false);
    }
  };

  const handleUploadMore = () => {
    // Reset form for next upload
    setSelectedFile(null);
    setFileDescription("");
    setIsPublic(false);
    setShowUploadSuccess(false);
    setUploadedFileName("");
  };

  const handleCloseUpload = () => {
    // Reset form and close dialog
    setSelectedFile(null);
    setFileDescription("");
    setIsPublic(false);
    setShowUploadSuccess(false);
    setUploadedFileName("");
    setDialogOpen(false);
  };

  const handlePreview = async (file: any) => {
    setPreviewFile(file);
    setPreviewOpen(true);
    
    // If it's a text file, load its content
    if (file.file_type?.startsWith('text/') || 
        file.file_name?.endsWith('.txt') || 
        file.file_name?.endsWith('.md') ||
        file.file_name?.endsWith('.json') ||
        file.file_name?.endsWith('.js') ||
        file.file_name?.endsWith('.ts') ||
        file.file_name?.endsWith('.jsx') ||
        file.file_name?.endsWith('.tsx') ||
        file.file_name?.endsWith('.css') ||
        file.file_name?.endsWith('.html')) {
      setLoadingText(true);
      try {
        const response = await fetch(file.file_url);
        const text = await response.text();
        setTextContent(text);
      } catch (error) {
        console.error('Error loading text content:', error);
        setTextContent('Unable to load file content');
      } finally {
        setLoadingText(false);
      }
    }
  };

  const closePreview = () => {
    setPreviewOpen(false);
    setPreviewFile(null);
    setTextContent("");
  };

  const filteredFiles = files.filter(file => 
    file.file_name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    (file.description && file.description.toLowerCase().includes(searchQuery.toLowerCase()))
  );

  const getFileIcon = (type: string) => {
    if (!type) return <File className="h-8 w-8 text-gray-500" />;
    if (type.startsWith("image")) return <ImageIcon className="h-8 w-8 text-green-500" />;
    if (type.startsWith("video")) return <FileVideo className="h-8 w-8 text-purple-500" />;
    if (type.includes("pdf") || type.includes("doc")) return <FileText className="h-8 w-8 text-blue-500" />;
    return <File className="h-8 w-8 text-gray-500" />;
  };

  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  };

  const canPreview = (file: any) => {
    const type = file.file_type?.toLowerCase() || '';
    const name = file.file_name?.toLowerCase() || '';
    
    return type.startsWith('image/') ||
           type.startsWith('video/') ||
           type.startsWith('text/') ||
           type.includes('pdf') ||
           name.endsWith('.txt') ||
           name.endsWith('.md') ||
           name.endsWith('.json') ||
           name.endsWith('.js') ||
           name.endsWith('.ts') ||
           name.endsWith('.jsx') ||
           name.endsWith('.tsx') ||
           name.endsWith('.css') ||
           name.endsWith('.html');
  };

  const renderPreview = () => {
    if (!previewFile) return null;

    const type = previewFile.file_type?.toLowerCase() || '';
    const name = previewFile.file_name?.toLowerCase() || '';

    // Image preview
    if (type.startsWith('image/')) {
      return (
        <div className="flex justify-center">
          <img 
            src={previewFile.file_url} 
            alt={previewFile.file_name}
            className="max-w-full max-h-[70vh] object-contain rounded-lg"
          />
        </div>
      );
    }

    // Video preview
    if (type.startsWith('video/')) {
      return (
        <div className="flex justify-center">
          <video 
            controls 
            className="max-w-full max-h-[70vh] rounded-lg"
            src={previewFile.file_url}
          >
            Your browser does not support the video tag.
          </video>
        </div>
      );
    }

    // PDF preview
    if (type.includes('pdf') || name.endsWith('.pdf')) {
      return (
        <div className="w-full h-[70vh]">
          <iframe
            src={`${previewFile.file_url}#toolbar=0`}
            className="w-full h-full border rounded-lg"
            title={previewFile.file_name}
          />
        </div>
      );
    }

    // Text file preview
    if (type.startsWith('text/') || 
        name.endsWith('.txt') || 
        name.endsWith('.md') ||
        name.endsWith('.json') ||
        name.endsWith('.js') ||
        name.endsWith('.ts') ||
        name.endsWith('.jsx') ||
        name.endsWith('.tsx') ||
        name.endsWith('.css') ||
        name.endsWith('.html')) {
      return (
        <div className="w-full h-[70vh] overflow-auto">
          {loadingText ? (
            <div className="flex items-center justify-center h-full">
              <Loader2 className="h-8 w-8 animate-spin" />
              <span className="ml-2">Loading content...</span>
            </div>
          ) : (
            <pre className="bg-muted p-4 rounded-lg text-sm overflow-auto h-full whitespace-pre-wrap">
              {textContent}
            </pre>
          )}
        </div>
      );
    }

    // Default: show file info
    return (
      <div className="text-center space-y-4">
        <div className="flex justify-center">
          {getFileIcon(previewFile.file_type)}
        </div>
        <div>
          <h3 className="text-lg font-semibold">{previewFile.file_name}</h3>
          <p className="text-sm text-muted-foreground">
            {formatFileSize(previewFile.file_size || 0)} • {previewFile.file_type}
          </p>
        </div>
        <Button asChild>
          <a href={previewFile.file_url} download target="_blank" rel="noopener noreferrer">
            <Download className="h-4 w-4 mr-2" />
            Download File
          </a>
        </Button>
      </div>
    );
  };

  const handleDeleteFile = async () => {
    if (!deleteFile) return;

    setIsDeleting(true);
    try {
      // Delete from database (storage deletion is handled by trigger)
      const { error } = await supabase
        .from('filemodels')
        .delete()
        .eq('id', deleteFile.id);

      if (error) throw error;

      toast({
        title: "File deleted",
        description: "File has been deleted successfully.",
      });

      // Refresh files list
      fetchFiles();
      setDeleteDialogOpen(false);
      setDeleteFile(null);
    } catch (error: any) {
      console.error('Error deleting file:', error);
      toast({
        title: "Delete failed",
        description: error.message || "Something went wrong. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsDeleting(false);
    }
  };

  const handleEditFile = async () => {
    if (!editFile) return;

    setIsUpdating(true);
    try {
      const { error } = await supabase
        .from('filemodels')
        .update({
          description: editDescription.trim() || null,
          is_public: editIsPublic,
        })
        .eq('id', editFile.id);

      if (error) throw error;

      toast({
        title: "File updated",
        description: "File has been updated successfully.",
      });

      // Refresh files list
      fetchFiles();
      setEditDialogOpen(false);
      setEditFile(null);
      setEditDescription("");
      setEditIsPublic(false);
    } catch (error: any) {
      console.error('Error updating file:', error);
      toast({
        title: "Update failed",
        description: error.message || "Something went wrong. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsUpdating(false);
    }
  };

  const openEditDialog = (file: any) => {
    setEditFile(file);
    setEditDescription(file.description || "");
    setEditIsPublic(file.is_public || false);
    setEditDialogOpen(true);
  };

  const openDeleteDialog = (file: any) => {
    setDeleteFile(file);
    setDeleteDialogOpen(true);
  };

  const canManageFile = (file: any) => {
    return user && file.user_id === user.id;
  };

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex flex-col md:flex-row gap-4 items-start md:items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Resources</h1>
          <p className="text-muted-foreground">Share and discover useful files and documents</p>
        </div>
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogTrigger asChild>
            <Button className="flex items-center gap-2">
              <Upload className="h-4 w-4" />
              Upload File
            </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[500px]">
            <DialogHeader>
              <DialogTitle>
                {showUploadSuccess ? "Upload Successful!" : "Upload File"}
              </DialogTitle>
            </DialogHeader>
            
            {showUploadSuccess ? (
              // Success state
              <div className="space-y-6">
                <div className="text-center space-y-4">
                  <div className="flex justify-center">
                    <CheckCircle className="h-16 w-16 text-green-500" />
                  </div>
                  <div>
                    <h3 className="text-lg font-semibold text-green-600">File uploaded successfully!</h3>
                    <p className="text-sm text-muted-foreground mt-1">
                      "{uploadedFileName}" has been uploaded to your resources.
                    </p>
                  </div>
                </div>
                
                <div className="flex gap-3">
                  <Button 
                    onClick={handleUploadMore}
                    className="flex-1"
                    variant="outline"
                  >
                    Upload Another File
                  </Button>
                  <Button 
                    onClick={handleCloseUpload}
                    className="flex-1"
                  >
                    Close
                  </Button>
                </div>
              </div>
            ) : (
              // Upload form
              <div className="space-y-4">
                <div>
                  <Label htmlFor="file">Select File</Label>
                  <Input
                    id="file"
                    type="file"
                    onChange={handleFileSelect}
                    disabled={isUploading}
                  />
                  {selectedFile && (
                    <div className="mt-2 flex items-center gap-2 text-sm text-muted-foreground">
                      <span>{selectedFile.name}</span>
                      <span>({formatFileSize(selectedFile.size)})</span>
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => setSelectedFile(null)}
                        disabled={isUploading}
                      >
                        <X className="h-4 w-4" />
                      </Button>
                    </div>
                  )}
                </div>
                
                <div>
                  <Label htmlFor="description">Description (optional)</Label>
                  <Textarea
                    id="description"
                    placeholder="Describe your file..."
                    value={fileDescription}
                    onChange={(e) => setFileDescription(e.target.value)}
                    disabled={isUploading}
                  />
                </div>

                <div className="flex items-center space-x-2">
                  <input
                    type="checkbox"
                    id="isPublic"
                    checked={isPublic}
                    onChange={(e) => setIsPublic(e.target.checked)}
                    disabled={isUploading}
                  />
                  <Label htmlFor="isPublic">Make file public</Label>
                </div>

                <div className="flex justify-end gap-2">
                  <Button
                    onClick={handleUpload}
                    disabled={!selectedFile || isUploading}
                  >
                    {isUploading ? (
                      <>
                        <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                        Uploading...
                      </>
                    ) : (
                      'Upload File'
                    )}
                  </Button>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>

      {/* Search and Filters */}
      <Card>
        <CardContent className="p-6">
          <div className="space-y-4">
            <div className="flex flex-col md:flex-row gap-4">
              <div className="relative flex-1">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                <Input
                  placeholder="Search files..."
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  className="pl-10"
                />
              </div>
              <Button variant="outline" className="flex items-center gap-2">
                <Filter className="h-4 w-4" />
                Filter
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Files Grid */}
      <Tabs defaultValue="grid" className="space-y-6">
        <TabsList>
          <TabsTrigger value="grid">Grid View</TabsTrigger>
          <TabsTrigger value="list">List View</TabsTrigger>
        </TabsList>
        
        <TabsContent value="grid">
          {loading ? (
            <div className="text-center py-10">
              <Loader2 className="h-8 w-8 animate-spin mx-auto" />
              <p className="mt-2 text-muted-foreground">Loading files...</p>
            </div>
          ) : filteredFiles.length === 0 ? (
            <div className="text-center py-10 text-muted-foreground">No files found.</div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
              {filteredFiles.map((file) => (
                <Card key={file.id} className="group hover:shadow-lg transition-all duration-300 cursor-pointer min-w-[320px] w-fit mx-auto">
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
                        <div className="flex items-center gap-1 text-xs text-muted-foreground">
                          <Avatar className="h-4 w-4">
                            <AvatarImage src={file.profiles?.avatar_url} />
                            <AvatarFallback>{file.profiles?.full_name?.charAt(0)}</AvatarFallback>
                          </Avatar>
                          <span>{file.profiles?.full_name}</span>
                        </div>
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
                        {canPreview(file) && (
                          <Button 
                            size="sm" 
                            variant="secondary"
                            onClick={(e) => {
                              e.preventDefault();
                              e.stopPropagation();
                              handlePreview(file);
                            }}
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
                        {canManageFile(file) && (
                          <>
                            <Button 
                              size="sm" 
                              variant="secondary"
                              onClick={(e) => {
                                e.preventDefault();
                                e.stopPropagation();
                                openEditDialog(file);
                              }}
                            >
                              <Edit className="h-4 w-4 mr-1" />
                              Edit
                            </Button>
                            <Button 
                              size="sm" 
                              variant="destructive"
                              onClick={(e) => {
                                e.preventDefault();
                                e.stopPropagation();
                                openDeleteDialog(file);
                              }}
                            >
                              <Trash2 className="h-4 w-4 mr-1" />
                              Delete
                            </Button>
                          </>
                        )}
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>
        
        <TabsContent value="list">
          <Card>
            <CardContent className="p-0">
              {loading ? (
                <div className="text-center py-10">
                  <Loader2 className="h-8 w-8 animate-spin mx-auto" />
                  <p className="mt-2 text-muted-foreground">Loading files...</p>
                </div>
              ) : filteredFiles.length === 0 ? (
                <div className="text-center py-10 text-muted-foreground">No files found.</div>
              ) : (
                <div className="divide-y">
                  {filteredFiles.map((file) => (
                    <div key={file.id} className="p-4 hover:bg-muted/50 transition-colors">
                      <div className="flex items-center gap-4">
                        <div className="flex-shrink-0">
                          <div className="w-12 h-12 bg-muted rounded flex items-center justify-center">
                            {getFileIcon(file.file_type)}
                          </div>
                        </div>
                        <div className="flex-1 min-w-0">
                          <h3 className="font-semibold truncate">{file.file_name}</h3>
                          <div className="flex items-center gap-4 text-sm text-muted-foreground">
                            <span>{formatFileSize(file.file_size || 0)}</span>
                            <span>•</span>
                            <span>{file.created_at ? new Date(file.created_at).toLocaleDateString() : ''}</span>
                          </div>
                          <div className="flex flex-wrap gap-1 mt-2">
                            {file.description && (
                              <Badge variant="secondary" className="text-xs">
                                {file.description}
                              </Badge>
                            )}
                            {file.is_public && (
                              <Badge variant="outline" className="text-xs">Public</Badge>
                            )}
                          </div>
                        </div>
                        <div className="flex items-center gap-2">
                          <Avatar className="h-8 w-8">
                            <AvatarImage src={file.profiles?.avatar_url} />
                            <AvatarFallback>{file.profiles?.full_name?.charAt(0)}</AvatarFallback>
                          </Avatar>
                          <div className="flex gap-1">
                            {canPreview(file) && (
                              <Button 
                                size="sm" 
                                variant="outline"
                                onClick={(e) => {
                                  e.preventDefault();
                                  e.stopPropagation();
                                  handlePreview(file);
                                }}
                              >
                                <Eye className="h-4 w-4" />
                              </Button>
                            )}
                            <Button size="sm" variant="outline" asChild>
                              <a href={file.file_url} download target="_blank" rel="noopener noreferrer">
                                <Download className="h-4 w-4" />
                              </a>
                            </Button>
                            {canManageFile(file) && (
                              <>
                                <Button 
                                  size="sm" 
                                  variant="outline"
                                  onClick={(e) => {
                                    e.preventDefault();
                                    e.stopPropagation();
                                    openEditDialog(file);
                                  }}
                                >
                                  <Edit className="h-4 w-4" />
                                </Button>
                                <Button 
                                  size="sm" 
                                  variant="outline"
                                  onClick={(e) => {
                                    e.preventDefault();
                                    e.stopPropagation();
                                    openDeleteDialog(file);
                                  }}
                                >
                                  <Trash2 className="h-4 w-4" />
                                </Button>
                              </>
                            )}
                          </div>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      {/* File Preview Modal */}
      <Dialog open={previewOpen} onOpenChange={setPreviewOpen}>
        <DialogContent className="max-w-4xl max-h-[90vh] overflow-hidden">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <Eye className="h-5 w-5" />
              Preview: {previewFile?.file_name}
            </DialogTitle>
          </DialogHeader>
          <div className="flex-1 overflow-hidden">
            {renderPreview()}
          </div>
          <div className="flex justify-end gap-2 pt-4 border-t">
            <Button variant="outline" onClick={closePreview}>
              Close
            </Button>
            {previewFile && (
              <Button asChild>
                <a href={previewFile.file_url} download target="_blank" rel="noopener noreferrer">
                  <Download className="h-4 w-4 mr-2" />
                  Download
                </a>
              </Button>
            )}
          </div>
        </DialogContent>
      </Dialog>

      {/* Delete Confirmation Dialog */}
      <Dialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Delete File</DialogTitle>
            <DialogDescription>
              Are you sure you want to delete "{deleteFile?.file_name}"? This action cannot be undone.
            </DialogDescription>
          </DialogHeader>
          <DialogFooter>
            <Button 
              variant="outline" 
              onClick={() => setDeleteDialogOpen(false)}
              disabled={isDeleting}
            >
              Cancel
            </Button>
            <Button 
              variant="destructive" 
              onClick={handleDeleteFile}
              disabled={isDeleting}
            >
              {isDeleting ? (
                <>
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  Deleting...
                </>
              ) : (
                <>
                  <Trash2 className="h-4 w-4 mr-2" />
                  Delete
                </>
              )}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Edit File Dialog */}
      <Dialog open={editDialogOpen} onOpenChange={setEditDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Edit File</DialogTitle>
            <DialogDescription>
              Update the description and visibility of "{editFile?.file_name}"
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-4">
            <div>
              <Label htmlFor="edit-description">Description (optional)</Label>
              <Textarea
                id="edit-description"
                placeholder="Describe your file..."
                value={editDescription}
                onChange={(e) => setEditDescription(e.target.value)}
                disabled={isUpdating}
              />
            </div>

            <div className="flex items-center space-x-2">
              <input
                type="checkbox"
                id="edit-isPublic"
                checked={editIsPublic}
                onChange={(e) => setEditIsPublic(e.target.checked)}
                disabled={isUpdating}
              />
              <Label htmlFor="edit-isPublic">Make file public</Label>
            </div>
          </div>
          <DialogFooter>
            <Button 
              variant="outline" 
              onClick={() => setEditDialogOpen(false)}
              disabled={isUpdating}
            >
              Cancel
            </Button>
            <Button 
              onClick={handleEditFile}
              disabled={isUpdating}
            >
              {isUpdating ? (
                <>
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  Updating...
                </>
              ) : (
                <>
                  <Edit className="h-4 w-4 mr-2" />
                  Update
                </>
              )}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default Resources;
