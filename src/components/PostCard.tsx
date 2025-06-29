import { useState, useEffect } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Heart, MessageCircle, Share, MoreHorizontal, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator
} from "@/components/ui/dropdown-menu";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogClose } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";

interface Post {
  id: string;
  user_id: string;
  content: string;
  media_url?: string;
  created_at: string;
  updated_at: string;
  is_deleted: boolean;
  profiles: {
    full_name: string;
    avatar_url?: string;
    email: string;
  };
  likes_count?: number;
  comments_count?: number;
}

interface PostCardProps {
  post: Post;
  onPostUpdated?: () => void;
}

const PostCard = ({ post, onPostUpdated }: PostCardProps) => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [isLiked, setIsLiked] = useState(false);
  const [likesCount, setLikesCount] = useState(post.likes_count || 0);
  const [isLiking, setIsLiking] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [editContent, setEditContent] = useState(post.content);
  const [deleting, setDeleting] = useState(false);
  const [sharing, setSharing] = useState(false);
  const postUrl = `${window.location.origin}/app/post/${post.id}`;
  const isOwner = user && user.id === post.user_id;
  const [editLoading, setEditLoading] = useState(false);
  const [confirmingDelete, setConfirmingDelete] = useState(false);

  // Check if user has liked this post
  useEffect(() => {
    const checkLikeStatus = async () => {
      if (!user) return;
      
      const { data, error } = await supabase
        .from('likes')
        .select('id')
        .eq('post_id', post.id)
        .eq('user_id', user.id)
        .single();

      if (!error && data) {
        setIsLiked(true);
      }
    };

    checkLikeStatus();
  }, [user, post.id]);

  useEffect(() => {
    if (!editOpen) {
      setEditLoading(false);
      // Remove pointer-events from all elements that might have it
      document.querySelectorAll('[style*="pointer-events: none"]').forEach(el => {
        (el as HTMLElement).style.pointerEvents = '';
      });
    }
  }, [editOpen]);

  const handleLike = async () => {
    if (!user) {
      toast({
        title: "Authentication required",
        description: "Please sign in to like posts.",
        variant: "destructive",
      });
      return;
    }

    setIsLiking(true);

    try {
      if (isLiked) {
        // Unlike the post
        const { error } = await supabase
          .from('likes')
          .delete()
          .eq('post_id', post.id)
          .eq('user_id', user.id);

        if (error) throw error;

        setIsLiked(false);
        setLikesCount(prev => prev - 1);
      } else {
        // Like the post
        const { error } = await supabase
          .from('likes')
          .insert({
            post_id: post.id,
            user_id: user.id,
          });

        if (error) throw error;

        setIsLiked(true);
        setLikesCount(prev => prev + 1);
      }

      // Notify parent component to refresh
      if (onPostUpdated) {
        onPostUpdated();
      }
    } catch (error: any) {
      console.error('Error toggling like:', error);
      toast({
        title: "Error",
        description: "Failed to update like. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsLiking(false);
    }
  };

  const handleEdit = async (e: React.FormEvent) => {
    e.preventDefault();
    setEditLoading(true);
    await supabase.from('posts').update({ content: editContent, updated_at: new Date().toISOString() }).eq('id', post.id);
    setEditLoading(false);
    setEditOpen(false);
    if (onPostUpdated) onPostUpdated();
  };

  const handleDelete = async () => {
    setDeleting(true);
    await supabase.from('posts').update({ is_deleted: true }).eq('id', post.id);
    setDeleting(false);
    setConfirmingDelete(false);
    if (onPostUpdated) onPostUpdated();
  };

  const handleCopyLink = async () => {
    await navigator.clipboard.writeText(postUrl);
    toast({ title: "Link copied!", description: "Post link copied to clipboard." });
  };

  const formatTimestamp = (timestamp: string) => {
    const date = new Date(timestamp);
    const now = new Date();
    const diffInSeconds = Math.floor((now.getTime() - date.getTime()) / 1000);

    if (diffInSeconds < 60) return 'just now';
    if (diffInSeconds < 3600) return `${Math.floor(diffInSeconds / 60)}m ago`;
    if (diffInSeconds < 86400) return `${Math.floor(diffInSeconds / 3600)}h ago`;
    if (diffInSeconds < 2592000) return `${Math.floor(diffInSeconds / 86400)}d ago`;
    
    return date.toLocaleDateString();
  };

  return (
    <Card className="hover:shadow-md transition-shadow">
      <CardContent className="p-6">
        <div className="flex items-start gap-3">
          <Avatar>
            <AvatarImage src={post.profiles?.avatar_url} />
            <AvatarFallback>{post.profiles?.full_name?.charAt(0) || "?"}</AvatarFallback>
          </Avatar>
          <div className="flex-1">
            <div className="flex items-center justify-between">
              <div>
                <h4 className="font-semibold">{post.profiles?.full_name || "Unknown User"}</h4>
                <p className="text-sm text-muted-foreground">
                  {formatTimestamp(post.created_at)}
                </p>
              </div>
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="ghost" size="icon">
                    <MoreHorizontal className="h-4 w-4" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent>
                  {isOwner && (
                    <DropdownMenuItem onClick={() => setEditOpen(true)}>Edit</DropdownMenuItem>
                  )}
                  {isOwner && (
                    <DropdownMenuItem onClick={() => setConfirmingDelete(true)} disabled={deleting}>Delete</DropdownMenuItem>
                  )}
                  {(isOwner || !isOwner) && (
                    <>
                      <DropdownMenuSeparator />
                      <DropdownMenuItem onClick={handleCopyLink}>Copy Link</DropdownMenuItem>
                    </>
                  )}
                </DropdownMenuContent>
              </DropdownMenu>
            </div>
            
            <div className="mt-3 space-y-3">
              <p className="text-sm leading-relaxed">{post.content}</p>
              
              {post.media_url && (
                <div className="rounded-lg overflow-hidden">
                  <img
                    src={post.media_url}
                    alt="Post content"
                    className="w-full h-auto object-cover"
                  />
                </div>
              )}
            </div>
            
            <div className="flex items-center justify-between mt-4 pt-2 border-t">
              <Button
                variant="ghost"
                size="sm"
                onClick={handleLike}
                disabled={isLiking}
                className={cn(
                  "flex items-center gap-2",
                  isLiked && "text-red-500"
                )}
              >
                {isLiking ? (
                  <Loader2 className="h-4 w-4 animate-spin" />
                ) : (
                  <Heart className={cn("h-4 w-4", isLiked && "fill-current")} />
                )}
                {likesCount}
              </Button>
              <Button variant="ghost" size="sm" className="flex items-center gap-2">
                <MessageCircle className="h-4 w-4" />
                {post.comments_count || 0}
              </Button>
              <Button variant="ghost" size="sm" className="flex items-center gap-2" onClick={handleCopyLink}>
                <Share className="h-4 w-4" />
                Share
              </Button>
            </div>
          </div>
        </div>
        <Dialog
          open={editOpen}
          onOpenChange={(open) => {
            setEditOpen(open);
            if (!open) setEditLoading(false);
          }}
        >
          <DialogContent>
            <DialogHeader>
              <DialogTitle>Edit Post</DialogTitle>
            </DialogHeader>
            <form onSubmit={handleEdit} className="space-y-4 relative">
              <div className="relative">
                <Textarea
                  value={editContent}
                  onChange={e => setEditContent(e.target.value)}
                  rows={5}
                  maxLength={1000}
                  className="w-full rounded-lg border border-input p-3 text-base resize-none focus:ring-2 focus:ring-primary focus:border-primary bg-background"
                  disabled={editLoading}
                  placeholder="What do you want to talk about?"
                />
                <div className="absolute bottom-2 right-3 text-xs text-muted-foreground">
                  {editContent.length}/1000
                </div>
              </div>
              <DialogFooter>
                <Button type="submit" disabled={editLoading} className="w-full h-10 text-base font-semibold">
                  {editLoading ? <Loader2 className="animate-spin h-5 w-5 mr-2" /> : null}
                  Save
                </Button>
                <DialogClose asChild>
                  <Button type="button" variant="outline" disabled={editLoading}>Cancel</Button>
                </DialogClose>
              </DialogFooter>
              {editLoading && (
                <div className="absolute inset-0 bg-black/30 flex items-center justify-center z-10 rounded-lg">
                  <Loader2 className="animate-spin h-8 w-8 text-primary" />
                </div>
              )}
            </form>
          </DialogContent>
        </Dialog>
        {confirmingDelete && (
          <div className="mt-2 flex gap-2 items-center bg-muted p-3 rounded shadow">
            <span>Are you sure you want to delete this post?</span>
            <Button size="sm" variant="destructive" onClick={handleDelete} disabled={deleting}>
              {deleting ? "Deleting..." : "Delete"}
            </Button>
            <Button size="sm" variant="outline" onClick={() => setConfirmingDelete(false)} disabled={deleting}>
              Cancel
            </Button>
          </div>
        )}
      </CardContent>
    </Card>
  );
};

export default PostCard;
