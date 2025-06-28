
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Edit, MapPin, Calendar, Link as LinkIcon } from "lucide-react";
import PostCard from "@/components/PostCard";

const Profile = () => {
  const [isFollowing, setIsFollowing] = useState(false);
  
  const userPosts = [
    {
      id: 1,
      author: {
        name: "John Doe",
        username: "@johndoe",
        avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=40&h=40&fit=crop&crop=face"
      },
      content: "Working on some exciting new features for our platform. Can't wait to share them with everyone! 🚀",
      timestamp: "1 day ago",
      likes: 45,
      comments: 12,
      shares: 5
    }
  ];

  const uploadedFiles = [
    { name: "Project_Proposal.pdf", size: "2.3 MB", date: "2 days ago" },
    { name: "Design_Mockups.figma", size: "15.7 MB", date: "1 week ago" },
    { name: "Meeting_Notes.docx", size: "156 KB", date: "2 weeks ago" }
  ];

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* Profile Header */}
      <Card>
        <CardContent className="p-6">
          <div className="flex flex-col md:flex-row gap-6">
            <Avatar className="h-32 w-32">
              <AvatarImage src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=128&h=128&fit=crop&crop=face" />
              <AvatarFallback className="text-2xl">JD</AvatarFallback>
            </Avatar>
            
            <div className="flex-1 space-y-4">
              <div className="flex flex-col md:flex-row md:items-center md:justify-between">
                <div>
                  <h1 className="text-3xl font-bold">John Doe</h1>
                  <p className="text-muted-foreground">@johndoe</p>
                  <Badge variant="secondary" className="mt-1">Pro Member</Badge>
                </div>
                <div className="flex gap-2">
                  <Button variant="outline" size="sm">
                    <Edit className="h-4 w-4 mr-2" />
                    Edit Profile
                  </Button>
                  <Button 
                    variant={isFollowing ? "outline" : "default"}
                    size="sm"
                    onClick={() => setIsFollowing(!isFollowing)}
                  >
                    {isFollowing ? "Following" : "Follow"}
                  </Button>
                </div>
              </div>
              
              <p className="text-sm">
                Full-stack developer passionate about creating amazing user experiences. 
                Love working with React, Node.js, and modern web technologies.
              </p>
              
              <div className="flex flex-wrap gap-4 text-sm text-muted-foreground">
                <div className="flex items-center gap-1">
                  <MapPin className="h-4 w-4" />
                  San Francisco, CA
                </div>
                <div className="flex items-center gap-1">
                  <LinkIcon className="h-4 w-4" />
                  <a href="#" className="text-primary hover:underline">johndoe.dev</a>
                </div>
                <div className="flex items-center gap-1">
                  <Calendar className="h-4 w-4" />
                  Joined March 2023
                </div>
              </div>
              
              <div className="flex gap-6 text-sm">
                <div>
                  <span className="font-bold">1,234</span>
                  <span className="text-muted-foreground ml-1">Following</span>
                </div>
                <div>
                  <span className="font-bold">5,678</span>
                  <span className="text-muted-foreground ml-1">Followers</span>
                </div>
                <div>
                  <span className="font-bold">89</span>
                  <span className="text-muted-foreground ml-1">Posts</span>
                </div>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Profile Content */}
      <Tabs defaultValue="posts" className="space-y-6">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="posts">Posts</TabsTrigger>
          <TabsTrigger value="about">About</TabsTrigger>
          <TabsTrigger value="files">Files</TabsTrigger>
        </TabsList>
        
        <TabsContent value="posts" className="space-y-6">
          {userPosts.map((post) => (
            <PostCard key={post.id} post={post} />
          ))}
        </TabsContent>
        
        <TabsContent value="about">
          <Card>
            <CardHeader>
              <CardTitle>About</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <h4 className="font-semibold mb-2">Bio</h4>
                <p className="text-sm text-muted-foreground">
                  Passionate software developer with 5+ years of experience building web applications. 
                  I love creating intuitive user interfaces and scalable backend systems.
                </p>
              </div>
              <div>
                <h4 className="font-semibold mb-2">Skills</h4>
                <div className="flex flex-wrap gap-2">
                  {["React", "TypeScript", "Node.js", "Python", "AWS", "Docker"].map((skill) => (
                    <Badge key={skill} variant="outline">{skill}</Badge>
                  ))}
                </div>
              </div>
              <div>
                <h4 className="font-semibold mb-2">Experience</h4>
                <div className="space-y-3">
                  <div className="border-l-2 border-primary pl-4">
                    <h5 className="font-medium">Senior Frontend Developer</h5>
                    <p className="text-sm text-muted-foreground">TechCorp Inc. • 2022 - Present</p>
                  </div>
                  <div className="border-l-2 border-muted pl-4">
                    <h5 className="font-medium">Full Stack Developer</h5>
                    <p className="text-sm text-muted-foreground">StartupXYZ • 2020 - 2022</p>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
        
        <TabsContent value="files">
          <Card>
            <CardHeader>
              <CardTitle>Uploaded Files</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {uploadedFiles.map((file, index) => (
                  <div key={index} className="flex items-center justify-between p-3 border rounded-lg">
                    <div>
                      <p className="font-medium">{file.name}</p>
                      <p className="text-sm text-muted-foreground">{file.size} • {file.date}</p>
                    </div>
                    <Button variant="outline" size="sm">Download</Button>
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

export default Profile;
