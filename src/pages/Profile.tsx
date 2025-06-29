import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Edit, MapPin, Calendar, Link as LinkIcon } from "lucide-react";
import PostCard from "@/components/PostCard";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

const Profile = () => {
  const { user, profile } = useAuth();
  const [profileData, setProfileData] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProfile = async () => {
      if (!user) return;
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', user.id)
        .single();
      if (!error) setProfileData(data);
      setLoading(false);
    };
    fetchProfile();
  }, [user]);

  if (loading) return <div className="text-center py-10">Loading...</div>;
  if (!profileData) return <div className="text-center py-10">Profile not found.</div>;

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* Profile Header */}
      <Card>
        <CardContent className="p-6">
          <div className="flex flex-col md:flex-row gap-6">
            <Avatar className="h-32 w-32">
              <AvatarImage src={profileData.avatar_url || undefined} />
              <AvatarFallback className="text-2xl">
                {profileData.full_name ? profileData.full_name[0] : 'U'}
              </AvatarFallback>
            </Avatar>
            <div className="flex-1 space-y-4">
              <div className="flex flex-col md:flex-row md:items-center md:justify-between">
                <div>
                  <h1 className="text-3xl font-bold">{profileData.full_name}</h1>
                  <p className="text-muted-foreground">{profileData.email}</p>
                  <Badge variant="secondary" className="mt-1">Pro Member</Badge>
                </div>
                <div className="flex gap-2">
                  {user && user.id === profileData.id && (
                    <Button variant="outline" size="sm">
                      <Edit className="h-4 w-4 mr-2" />
                      Edit Profile
                    </Button>
                  )}
                  {/* Follow button for other users could go here */}
                </div>
              </div>
              <p className="text-sm">{profileData.bio}</p>
              <div className="flex flex-wrap gap-4 text-sm text-muted-foreground">
                {profileData.location && (
                  <div className="flex items-center gap-1">
                    <MapPin className="h-4 w-4" />
                    {profileData.location}
                  </div>
                )}
                {profileData.website && (
                  <div className="flex items-center gap-1">
                    <LinkIcon className="h-4 w-4" />
                    <a href={profileData.website} className="text-primary hover:underline" target="_blank" rel="noopener noreferrer">{profileData.website}</a>
                  </div>
                )}
                <div className="flex items-center gap-1">
                  <Calendar className="h-4 w-4" />
                  Joined {profileData.created_at ? new Date(profileData.created_at).toLocaleDateString() : ''}
                </div>
              </div>
              {/* Stats could be fetched and shown here */}
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
          {/* TODO: Fetch and map real posts for this user */}
          {/* {userPosts.map((post) => (
            <PostCard key={post.id} post={post} />
          ))} */}
          <div className="text-muted-foreground">User posts will appear here.</div>
        </TabsContent>
        <TabsContent value="about">
          <Card>
            <CardHeader>
              <CardTitle>About</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <h4 className="font-semibold mb-2">Bio</h4>
                <p className="text-sm text-muted-foreground">{profileData.bio}</p>
              </div>
              <div>
                <h4 className="font-semibold mb-2">Website</h4>
                <p className="text-sm text-muted-foreground">{profileData.website}</p>
              </div>
              <div>
                <h4 className="font-semibold mb-2">Location</h4>
                <p className="text-sm text-muted-foreground">{profileData.location}</p>
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
              {/* TODO: Fetch and map real uploaded files for this user */}
              <div className="text-muted-foreground">User files will appear here.</div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default Profile;
