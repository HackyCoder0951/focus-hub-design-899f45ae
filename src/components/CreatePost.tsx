import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Image as ImageIcon, Smile, Loader2 } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";

interface CreatePostProps {
  onPostCreated?: () => void;
}

const CreatePost = ({ onPostCreated }: CreatePostProps) => {
  const [content, setContent] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { user, profile } = useAuth();
  const { toast } = useToast();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!user) {
      toast({
        title: "Authentication required",
        description: "Please sign in to create a post.",
        variant: "destructive",
      });
      return;
    }

    if (!content.trim()) {
      toast({
        title: "Content required",
        description: "Please enter some content for your post.",
        variant: "destructive",
      });
      return;
    }

    setIsSubmitting(true);

    try {
      const { error } = await supabase
        .from('posts')
        .insert({
          user_id: user.id,
          content: content.trim(),
        });

      if (error) {
        throw error;
      }

      toast({
        title: "Post created!",
        description: "Your post has been published successfully.",
      });

      setContent("");
      
      // Notify parent component to refresh posts
      if (onPostCreated) {
        onPostCreated();
      }
    } catch (error: any) {
      console.error('Error creating post:', error);
      toast({
        title: "Error creating post",
        description: error.message || "Something went wrong. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <Card>
      <CardContent className="p-6">
        <div className="flex gap-4">
          <Avatar>
            <AvatarImage src={profile?.avatar_url || undefined} />
            <AvatarFallback>
              {profile?.full_name ? profile.full_name[0] : user?.email?.[0] || 'U'}
            </AvatarFallback>
          </Avatar>
          <div className="flex-1">
            <form onSubmit={handleSubmit} className="space-y-4">
              <Textarea
                placeholder="What's on your mind?"
                value={content}
                onChange={(e) => setContent(e.target.value)}
                className="min-h-[100px] resize-none border-0 p-0 text-lg placeholder:text-muted-foreground focus-visible:ring-0"
                disabled={isSubmitting}
              />
              <div className="flex items-center justify-between">
                <div className="flex gap-2">
                  <Button type="button" variant="ghost" size="sm" disabled={isSubmitting}>
                    <ImageIcon className="h-4 w-4 mr-2" />
                    Photo
                  </Button>
                  <Button type="button" variant="ghost" size="sm" disabled={isSubmitting}>
                    <Smile className="h-4 w-4 mr-2" />
                    Emoji
                  </Button>
                </div>
                <Button 
                  type="submit" 
                  disabled={!content.trim() || isSubmitting}
                  className="min-w-[80px]"
                >
                  {isSubmitting ? (
                    <>
                      <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                      Posting...
                    </>
                  ) : (
                    'Post'
                  )}
                </Button>
              </div>
            </form>
          </div>
        </div>
      </CardContent>
    </Card>
  );
};

export default CreatePost;
