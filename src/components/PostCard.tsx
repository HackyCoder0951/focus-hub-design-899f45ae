import { useState, useEffect, useRef } from "react";
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
// import { Input } from "@/components/ui/input";
// import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogClose } from "@/components/ui/dialog";
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
  const [editing, setEditing] = useState(false);
  const [editContent, setEditContent] = useState(post.content);
  const [deleting, setDeleting] = useState(false);
  const [sharing, setSharing] = useState(false);
  const postUrl = `${window.location.origin}/app/post/${post.id}`;
  const isOwner = user && user.id === post.user_id;
  const [editLoading, setEditLoading] = useState(false);
  const [confirmingDelete, setConfirmingDelete] = useState(false);
  const [comments, setComments] = useState<any[]>([]);
  const [commentInput, setCommentInput] = useState("");
  const [commentLoading, setCommentLoading] = useState(false);
  const commentInputRef = useRef<HTMLInputElement>(null);

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
    if (!editing) {
      setEditLoading(false);
      // Remove pointer-events from all elements that might have it
      document.querySelectorAll('[style*="pointer-events: none"]').forEach(el => {
        (el as HTMLElement).style.pointerEvents = '';
      });
    }
  }, [editing]);

  // Fetch comments for this post (threaded)
  useEffect(() => {
    const fetchComments = async () => {
      const { data, error } = await supabase
        .from('comments')
        .select(`*, profiles:profiles(full_name, avatar_url)`)
        .eq('post_id', post.id)
        .order('created_at', { ascending: true });
      if (!error) setComments(data || []);
    };
    fetchComments();
  }, [post.id, editing, confirmingDelete]);

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

  const handleEdit = async (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    setEditLoading(true);
    await supabase.from('posts').update({ content: editContent, updated_at: new Date().toISOString() }).eq('id', post.id);
    setEditLoading(false);
    setEditing(false);
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

  const handleAddComment = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user || !commentInput.trim()) return;
    setCommentLoading(true);
    const { error } = await supabase.from('comments').insert({
      post_id: post.id,
      user_id: user.id,
      content: commentInput.trim(),
    });
    setCommentInput("");
    setCommentLoading(false);
    // Refetch comments
    const { data } = await supabase
      .from('comments')
      .select(`*, profiles:profiles(full_name, avatar_url)`)
      .eq('post_id', post.id)
      .order('created_at', { ascending: true });
    setComments(data || []);
    if (commentInputRef.current) commentInputRef.current.focus();
  };

  // Helper: recursively render comments and replies
  const CommentThread = ({ comments, parentId, user, onRefresh }: any) => {
    return comments
      .filter((c: any) => c.parent_id === parentId)
      .map((comment: any) => <CommentItem key={comment.id} comment={comment} comments={comments} user={user} onRefresh={onRefresh} />);
  };

  const CommentItem = ({ comment, comments, user, onRefresh }: any) => {
    const [editing, setEditing] = useState(false);
    const [editContent, setEditContent] = useState(comment.content);
    const [replying, setReplying] = useState(false);
    const [replyContent, setReplyContent] = useState("");
    const [loading, setLoading] = useState(false);
    const [likeCount, setLikeCount] = useState(comment.likes_count || 0);
    const [liked, setLiked] = useState(false);

    // Check if user liked this comment
    useEffect(() => {
      const checkLiked = async () => {
        if (!user) return;
        const { data } = await supabase
          .from('comment_likes')
          .select('id')
          .eq('comment_id', comment.id)
          .eq('user_id', user.id)
          .single();
        setLiked(!!data);
      };
      checkLiked();
    }, [user, comment.id]);

    const handleLike = async () => {
      if (!user) return;
      setLoading(true);
      if (liked) {
        await supabase.from('comment_likes').delete().eq('comment_id', comment.id).eq('user_id', user.id);
        setLikeCount((c: number) => c - 1);
        setLiked(false);
      } else {
        await supabase.from('comment_likes').insert({ comment_id: comment.id, user_id: user.id });
        setLikeCount((c: number) => c + 1);
        setLiked(true);
      }
      setLoading(false);
      if (onRefresh) onRefresh();
    };

    const handleEdit = async (e: React.FormEvent) => {
      e.preventDefault();
      setLoading(true);
      await supabase.from('comments').update({ content: editContent }).eq('id', comment.id);
      setEditing(false);
      setLoading(false);
      if (onRefresh) onRefresh();
    };

    const handleDelete = async () => {
      setLoading(true);
      await supabase.from('comments').delete().eq('id', comment.id);
      setLoading(false);
      if (onRefresh) onRefresh();
    };

    const handleReply = async (e: React.FormEvent) => {
      e.preventDefault();
      if (!user || !replyContent.trim()) return;
      setLoading(true);
      await supabase.from('comments').insert({
        post_id: comment.post_id,
        user_id: user.id,
        content: replyContent.trim(),
        parent_id: comment.id
      });
      setReplyContent("");
      setReplying(false);
      setLoading(false);
      if (onRefresh) onRefresh();
    };

    const isOwner = user && user.id === comment.user_id;

    return (
      <div className="flex gap-2 items-start mt-2">
        <Avatar className="h-7 w-7">
          <AvatarImage src={comment.profiles?.avatar_url} />
          <AvatarFallback>{comment.profiles?.full_name?.charAt(0) || "?"}</AvatarFallback>
        </Avatar>
        <div className="bg-muted rounded-lg px-3 py-2 flex-1">
          <div className="flex items-center gap-2">
            <span className="font-medium text-xs">{comment.profiles?.full_name || "Unknown User"}</span>
            <span className="text-xs text-muted-foreground">{formatTimestamp(comment.created_at)}</span>
          </div>
          {editing ? (
            <form onSubmit={handleEdit} className="flex flex-col gap-2 mt-1">
              <Textarea
                value={editContent}
                onChange={e => setEditContent(e.target.value)}
                rows={2}
                maxLength={500}
                className="w-full rounded border p-2 text-sm"
                disabled={loading}
              />
              <div className="flex gap-2 justify-end">
                <Button size="sm" type="submit" disabled={loading}>Save</Button>
                <Button size="sm" variant="outline" type="button" onClick={() => setEditing(false)} disabled={loading}>Cancel</Button>
              </div>
            </form>
          ) : (
            <div className="text-sm mt-1">{comment.content}</div>
          )}
          <div className="flex gap-2 mt-1 items-center">
            <Button size="sm" variant="ghost" onClick={handleLike} disabled={loading} className={liked ? "text-primary" : ""}>
              <Heart className="h-3 w-3" /> {likeCount}
            </Button>
            <Button size="sm" variant="ghost" onClick={() => setReplying(!replying)} disabled={loading}>Reply</Button>
            {isOwner && !editing && (
              <>
                <Button size="sm" variant="ghost" onClick={() => setEditing(true)} disabled={loading}>Edit</Button>
                <Button size="sm" variant="ghost" onClick={handleDelete} disabled={loading}>Delete</Button>
              </>
            )}
          </div>
          {replying && (
            <form onSubmit={handleReply} className="flex gap-2 mt-2">
              <Textarea
                value={replyContent}
                onChange={e => setReplyContent(e.target.value)}
                rows={2}
                maxLength={500}
                className="w-full rounded border p-2 text-sm"
                disabled={loading}
                placeholder="Write a reply..."
              />
              <Button size="sm" type="submit" disabled={loading || !replyContent.trim()}>Reply</Button>
              <Button size="sm" variant="outline" type="button" onClick={() => setReplying(false)} disabled={loading}>Cancel</Button>
            </form>
          )}
          {/* Render replies recursively */}
          <div className="pl-6">
            <CommentThread comments={comments} parentId={comment.id} user={user} onRefresh={onRefresh} />
          </div>
        </div>
      </div>
    );
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
                    <DropdownMenuItem onClick={() => { setEditing(true); setEditContent(post.content); }}>Edit</DropdownMenuItem>
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
              {editing ? (
                <form onSubmit={handleEdit} className="flex flex-col gap-2">
                  <Textarea
                    value={editContent}
                    onChange={e => setEditContent(e.target.value)}
                    rows={5}
                    maxLength={1000}
                    className="w-full rounded-lg border border-input p-3 text-base resize-none focus:ring-2 focus:ring-primary focus:border-primary bg-background"
                    disabled={editLoading}
                    placeholder="What do you want to talk about?"
                  />
                  <div className="flex items-center justify-between">
                    <span className="text-xs text-muted-foreground">{editContent.length}/1000</span>
                    <div className="flex gap-2">
                      <Button size="sm" type="submit" disabled={editLoading}>
                        {editLoading ? <Loader2 className="animate-spin h-4 w-4 mr-2" /> : null}
                        Save
                      </Button>
                      <Button size="sm" variant="outline" type="button" onClick={() => setEditing(false)} disabled={editLoading}>
                        Cancel
                      </Button>
                    </div>
                  </div>
                </form>
              ) : (
                <p className="text-sm leading-relaxed">{post.content}</p>
              )}
              {post.media_url && !editing && (
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
                {comments.length}
              </Button>
              <Button variant="ghost" size="sm" className="flex items-center gap-2" onClick={handleCopyLink}>
                <Share className="h-4 w-4" />
                Share
              </Button>
            </div>
            {/* Comments Section */}
            <div className="mt-3">
              {comments.filter(c => !c.parent_id).length > 0 && (
                <div className="space-y-3">
                  <CommentThread comments={comments} parentId={null} user={user} onRefresh={() => {
                    // refetch comments
                    supabase
                      .from('comments')
                      .select(`*, profiles:profiles(full_name, avatar_url)`)
                      .eq('post_id', post.id)
                      .order('created_at', { ascending: true })
                      .then(({ data }) => setComments(data || []));
                  }} />
                </div>
              )}
              {user && (
                <form onSubmit={handleAddComment} className="flex gap-2 items-center mt-3">
                  <Avatar className="h-7 w-7">
                    <AvatarImage src={user?.user_metadata?.avatar_url} />
                    <AvatarFallback>{user?.user_metadata?.full_name?.charAt(0) || "U"}</AvatarFallback>
                  </Avatar>
                  <input
                    ref={commentInputRef}
                    type="text"
                    className="flex-1 rounded-full border px-3 py-2 text-sm bg-background focus:outline-none focus:ring-2 focus:ring-primary"
                    placeholder="Add a comment..."
                    value={commentInput}
                    onChange={e => setCommentInput(e.target.value)}
                    disabled={commentLoading}
                    maxLength={500}
                  />
                  <Button type="submit" size="sm" disabled={commentLoading || !commentInput.trim()}>
                    Post
                  </Button>
                </form>
              )}
            </div>
          </div>
        </div>
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
