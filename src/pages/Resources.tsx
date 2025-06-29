import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search, Upload, Download, FileText, Image as ImageIcon, File, Filter } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { supabase } from "@/integrations/supabase/client";

const Resources = () => {
  const [searchQuery, setSearchQuery] = useState("");
  const [files, setFiles] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchFiles = async () => {
      const { data, error } = await supabase
        .from('filemodels')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .order('created_at', { ascending: false });
      if (!error && data) setFiles(data);
      setLoading(false);
    };
    fetchFiles();
  }, []);

  const getFileIcon = (type: string) => {
    if (!type) return <File className="h-8 w-8 text-gray-500" />;
    if (type.startsWith("image")) return <ImageIcon className="h-8 w-8 text-green-500" />;
    if (type.startsWith("video")) return <File className="h-8 w-8 text-purple-500" />;
    if (type.includes("pdf") || type.includes("doc")) return <FileText className="h-8 w-8 text-blue-500" />;
    return <File className="h-8 w-8 text-gray-500" />;
  };

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex flex-col md:flex-row gap-4 items-start md:items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Resources</h1>
          <p className="text-muted-foreground">Share and discover useful files and documents</p>
        </div>
        <Button className="flex items-center gap-2">
          <Upload className="h-4 w-4" />
          Upload File
        </Button>
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
            <div className="text-center py-10">Loading...</div>
          ) : files.length === 0 ? (
            <div className="text-center py-10 text-muted-foreground">No files found.</div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
              {files.map((file) => (
                <Card key={file.id} className="group hover:shadow-lg transition-all duration-300 cursor-pointer">
                  <CardContent className="p-4">
                    <div className="space-y-3">
                      {/* File Preview */}
                      <div className="aspect-video bg-muted rounded-lg flex items-center justify-center relative overflow-hidden">
                        {getFileIcon(file.file_type)}
                        <div className="absolute inset-0 bg-black/20 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                          <Button size="sm" variant="secondary" asChild>
                            <a href={file.file_url} download target="_blank" rel="noopener noreferrer">
                              <Download className="h-4 w-4 mr-2" />
                              Download
                            </a>
                          </Button>
                        </div>
                      </div>
                      {/* File Info */}
                      <div className="space-y-2">
                        <h3 className="font-semibold text-sm truncate" title={file.file_name}>
                          {file.file_name}
                        </h3>
                        <p className="text-xs text-muted-foreground">{(file.file_size / 1024 / 1024).toFixed(2)} MB</p>
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
                <div className="text-center py-10">Loading...</div>
              ) : files.length === 0 ? (
                <div className="text-center py-10 text-muted-foreground">No files found.</div>
              ) : (
                <div className="divide-y">
                  {files.map((file) => (
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
                            <span>{(file.file_size / 1024 / 1024).toFixed(2)} MB</span>
                            <span>•</span>
                            <span>{file.created_at ? new Date(file.created_at).toLocaleDateString() : ''}</span>
                          </div>
                          <div className="flex flex-wrap gap-1 mt-2">
                            {file.description && (
                              <Badge variant="secondary" className="text-xs">
                                {file.description}
                              </Badge>
                            )}
                          </div>
                        </div>
                        <div className="flex items-center gap-2">
                          <Avatar className="h-8 w-8">
                            <AvatarImage src={file.profiles?.avatar_url} />
                            <AvatarFallback>{file.profiles?.full_name?.charAt(0)}</AvatarFallback>
                          </Avatar>
                          <Button size="sm" variant="outline" asChild>
                            <a href={file.file_url} download target="_blank" rel="noopener noreferrer">
                              <Download className="h-4 w-4" />
                            </a>
                          </Button>
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
    </div>
  );
};

export default Resources;
