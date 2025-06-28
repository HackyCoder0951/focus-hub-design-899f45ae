
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search, Upload, Download, FileText, Image as ImageIcon, File, Filter } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";

const Resources = () => {
  const [searchQuery, setSearchQuery] = useState("");
  
  const fileTypes = ["All", "Documents", "Images", "Videos", "Other"];
  
  const resources = [
    {
      id: 1,
      name: "React Best Practices Guide.pdf",
      type: "document",
      size: "2.4 MB",
      uploadedBy: {
        name: "Sarah Johnson",
        avatar: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=40&h=40&fit=crop&crop=face"
      },
      uploadDate: "2 hours ago",
      downloads: 45,
      tags: ["React", "Guide", "Best Practices"],
      thumbnail: null
    },
    {
      id: 2,
      name: "UI Design Mockups.fig",
      type: "design",
      size: "15.7 MB",
      uploadedBy: {
        name: "Alex Chen",
        avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=40&h=40&fit=crop&crop=face"
      },
      uploadDate: "1 day ago",
      downloads: 23,
      tags: ["Design", "UI", "Figma"],
      thumbnail: "https://images.unsplash.com/photo-1649972904349-6e44c42644a7?w=200&h=150&fit=crop"
    },
    {
      id: 3,
      name: "Project Demo Video.mp4",
      type: "video",
      size: "127.3 MB",
      uploadedBy: {
        name: "Maria Garcia",
        avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=40&h=40&fit=crop&crop=face"
      },
      uploadDate: "3 days ago",
      downloads: 78,
      tags: ["Demo", "Video", "Tutorial"],
      thumbnail: "https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?w=200&h=150&fit=crop"
    },
    {
      id: 4,
      name: "API Documentation.docx",
      type: "document",
      size: "856 KB",
      uploadedBy: {
        name: "John Smith",
        avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=40&h=40&fit=crop&crop=face"
      },
      uploadDate: "1 week ago",
      downloads: 156,
      tags: ["API", "Documentation", "Backend"],
      thumbnail: null
    }
  ];

  const getFileIcon = (type: string) => {
    switch (type) {
      case "document":
        return <FileText className="h-8 w-8 text-blue-500" />;
      case "image":
        return <ImageIcon className="h-8 w-8 text-green-500" />;
      case "video":
        return <File className="h-8 w-8 text-purple-500" />;
      default:
        return <File className="h-8 w-8 text-gray-500" />;
    }
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
            <div className="flex flex-wrap gap-2">
              {fileTypes.map((type) => (
                <Badge
                  key={type}
                  variant={type === "All" ? "default" : "outline"}
                  className="cursor-pointer hover:bg-primary hover:text-primary-foreground"
                >
                  {type}
                </Badge>
              ))}
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
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {resources.map((resource) => (
              <Card key={resource.id} className="group hover:shadow-lg transition-all duration-300 cursor-pointer">
                <CardContent className="p-4">
                  <div className="space-y-3">
                    {/* File Preview */}
                    <div className="aspect-video bg-muted rounded-lg flex items-center justify-center relative overflow-hidden">
                      {resource.thumbnail ? (
                        <img
                          src={resource.thumbnail}
                          alt={resource.name}
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        getFileIcon(resource.type)
                      )}
                      <div className="absolute inset-0 bg-black/20 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                        <Button size="sm" variant="secondary">
                          <Download className="h-4 w-4 mr-2" />
                          Download
                        </Button>
                      </div>
                    </div>

                    {/* File Info */}
                    <div className="space-y-2">
                      <h3 className="font-semibold text-sm truncate" title={resource.name}>
                        {resource.name}
                      </h3>
                      <p className="text-xs text-muted-foreground">{resource.size}</p>
                      
                      <div className="flex flex-wrap gap-1">
                        {resource.tags.slice(0, 2).map((tag) => (
                          <Badge key={tag} variant="secondary" className="text-xs">
                            {tag}
                          </Badge>
                        ))}
                        {resource.tags.length > 2 && (
                          <Badge variant="outline" className="text-xs">
                            +{resource.tags.length - 2}
                          </Badge>
                        )}
                      </div>

                      <div className="flex items-center justify-between text-xs text-muted-foreground">
                        <div className="flex items-center gap-1">
                          <Avatar className="h-4 w-4">
                            <AvatarImage src={resource.uploadedBy.avatar} />
                            <AvatarFallback>{resource.uploadedBy.name.charAt(0)}</AvatarFallback>
                          </Avatar>
                          <span>{resource.uploadedBy.name}</span>
                        </div>
                        <span>{resource.downloads} downloads</span>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>

        <TabsContent value="list">
          <Card>
            <CardContent className="p-0">
              <div className="divide-y">
                {resources.map((resource) => (
                  <div key={resource.id} className="p-4 hover:bg-muted/50 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="flex-shrink-0">
                        {resource.thumbnail ? (
                          <img
                            src={resource.thumbnail}
                            alt={resource.name}
                            className="w-12 h-12 object-cover rounded"
                          />
                        ) : (
                          <div className="w-12 h-12 bg-muted rounded flex items-center justify-center">
                            {getFileIcon(resource.type)}
                          </div>
                        )}
                      </div>
                      
                      <div className="flex-1 min-w-0">
                        <h3 className="font-semibold truncate">{resource.name}</h3>
                        <div className="flex items-center gap-4 text-sm text-muted-foreground">
                          <span>{resource.size}</span>
                          <span>•</span>
                          <span>{resource.uploadDate}</span>
                          <span>•</span>
                          <span>{resource.downloads} downloads</span>
                        </div>
                        <div className="flex flex-wrap gap-1 mt-2">
                          {resource.tags.map((tag) => (
                            <Badge key={tag} variant="secondary" className="text-xs">
                              {tag}
                            </Badge>
                          ))}
                        </div>
                      </div>
                      
                      <div className="flex items-center gap-2">
                        <Avatar className="h-8 w-8">
                          <AvatarImage src={resource.uploadedBy.avatar} />
                          <AvatarFallback>{resource.uploadedBy.name.charAt(0)}</AvatarFallback>
                        </Avatar>
                        <Button size="sm" variant="outline">
                          <Download className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default Resources;
