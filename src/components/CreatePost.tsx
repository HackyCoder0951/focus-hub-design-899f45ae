import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Image as ImageIcon, Smile, Loader2, X } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";
import Picker from '@emoji-mart/react';

interface CreatePostProps {
  onPostCreated?: () => void;
}

interface EmojiData {
  native: string;
}

const CreatePost = ({ onPostCreated }: CreatePostProps) => {
  const [content, setContent] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { user, profile } = useAuth();
  const { toast } = useToast();
  const [image, setImage] = useState<File | null>(null);
  const [imagePreview, setImagePreview] = useState<string | null>(null);
  const [showEmojiPicker, setShowEmojiPicker] = useState(false);

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setImage(file);
      setImagePreview(URL.createObjectURL(file));
    }
  };

  const handleEmojiSelect = (emoji: EmojiData) => {
    setContent(content + emoji.native);
    setShowEmojiPicker(false);
  };

  const handleRemoveImage = () => {
    setImage(null);
    setImagePreview(null);
  };

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
    let imageUrl = null;
    try {
      // Upload image if present
      if (image) {
        const { data, error } = await supabase.storage.from('post-media').upload(`images/${Date.now()}_${image.name}`, image, { upsert: true });
        if (error) throw error;
        const { data: publicUrlData } = supabase.storage.from('post-media').getPublicUrl(data.path);
        imageUrl = publicUrlData.publicUrl;
      }
      const { error } = await supabase
        .from('posts')
        .insert({
          user_id: user.id,
          content: content.trim(),
          image_url: imageUrl,
        });

      if (error) {
        throw error;
      }

      toast({
        title: "Post created!",
        description: "Your post has been published successfully.",
      });

      setContent("");
      setImage(null);
      setImagePreview(null);
      
      // Notify parent component to refresh posts
      if (onPostCreated) {
        onPostCreated();
      }
    } catch (error: unknown) {
      const errorMessage = error instanceof Error ? error.message : 'Something went wrong';
      console.error('Error creating post:', error);
      toast({
        title: "Error creating post",
        description: errorMessage || "Something went wrong. Please try again.",
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
              {imagePreview && (
                <div className="relative w-32 h-32 mb-2">
                  <img src={imagePreview} alt="Preview" className="object-cover w-full h-full rounded" />
                  <Button type="button" size="icon" variant="ghost" className="absolute top-0 right-0" onClick={handleRemoveImage}><X className="w-4 h-4" /></Button>
                </div>
              )}
              <div className="flex items-center justify-between">
                <div className="flex gap-2">
                  <input type="file" accept="image/*" className="hidden" id="image-upload" onChange={handleImageChange} disabled={isSubmitting} />
                  <label htmlFor="image-upload">
                    <Button type="button" variant="ghost" size="sm" asChild disabled={isSubmitting}>
                      <span><ImageIcon className="h-4 w-4 mr-2" />Photo</span>
                  </Button>
                  </label>
                  <Button type="button" variant="ghost" size="sm" onClick={() => setShowEmojiPicker((v) => !v)} disabled={isSubmitting}>
                    <Smile className="h-4 w-4 mr-2" />Emoji
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
              {showEmojiPicker && (
                <div className="absolute z-50 mt-2">
                  <Picker onEmojiSelect={handleEmojiSelect} theme="light" />
                </div>
              )}
            </form>
          </div>
        </div>
      </CardContent>
    </Card>
  );
};

export default CreatePost;
