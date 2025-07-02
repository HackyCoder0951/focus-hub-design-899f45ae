import { useState, useEffect, useRef } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Heart, MessageCircle, Share, MoreHorizontal, Loader2, Flag } from "lucide-react";
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
import { Textarea } from "@/components/ui/textarea";
import {
  Dialog,
  DialogTrigger,
  DialogContent,
  DialogTitle
} from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";
// import { Document, Page } from 'react-pdf';
// import 'react-pdf/dist/Page/AnnotationLayer.css';
// import 'react-pdf/dist/Page/TextLayer.css';
// import { getDocument, GlobalWorkerOptions } from 'pdfjs-dist';

interface Post {
  id: string;
  user_id: string;
  content: string;
  media_url?: string;
  image_url?: string;
  file_url?: string;
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
  flag_status?: string;
}

interface PostCardProps {
  post: Post;
  onPostUpdated?: () => void;
}

// // Custom PDFCanvasViewer component
// function PDFCanvasViewer({ url, open, onClose }) {
//   const canvasRef = useRef(null);
//   const [pageNum, setPageNum] = useState(1);
//   const [numPages, setNumPages] = useState(0);

//   useEffect(() => {
//     if (!open) return;
//     let pdfDoc = null;
//     let isMounted = true;
//     GlobalWorkerOptions.workerSrc = `https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js`;
//     getDocument(url).promise.then(doc => {
//       if (!isMounted) return;
//       pdfDoc = doc;
//       setNumPages(doc.numPages);
//       return doc.getPage(pageNum);
//     }).then(page => {
//       if (!isMounted) return;
//       const viewport = page.getViewport({ scale: 1.5 });
//       const canvas = canvasRef.current;
//       const context = canvas.getContext('2d');
//       canvas.height = viewport.height;
//       canvas.width = viewport.width;
//       page.render({ canvasContext: context, viewport });
//     });
//     return () => { isMounted = false; };
//   }, [url, pageNum, open]);

//   return (
//     <div className="w-full h-full flex flex-col bg-black">
//       <div className="w-full flex items-center justify-between px-6 py-3 bg-black text-white border-b" style={{ position: 'absolute', top: 0, left: 0, zIndex: 10 }}>
//         <span className="font-semibold text-base truncate mx-auto" style={{ flex: 1, textAlign: 'center' }}>
//           {url.split('/').pop()}
//         </span>
//         <button onClick={onClose} className="text-white text-2xl px-2 absolute right-4 top-1">×</button>
//       </div>
//       <div className="flex-1 flex items-center justify-center bg-neutral-900 overflow-auto">
//         <canvas ref={canvasRef} className="bg-white shadow-xl rounded" />
//       </div>
//       <div className="flex items-center justify-between px-6 py-3 bg-black text-white border-t">
//         <div className="flex gap-2 items-center">
//           <button onClick={() => setPageNum(p => Math.max(1, p - 1))} disabled={pageNum <= 1} className="px-3 py-1 bg-gray-700 rounded text-white">Prev</button>
//           <span className="text-xs">Page {pageNum} of {numPages}</span>
//           <button onClick={() => setPageNum(p => Math.min(numPages, p + 1))} disabled={pageNum >= numPages} className="px-3 py-1 bg-gray-700 rounded text-white">Next</button>
//         </div>
//         <button onClick={() => setPageNum(1)} disabled={pageNum === 1} className="px-3 py-1 bg-gray-700 rounded text-white">First</button>
//       </div>
//     </div>
//   );
// }

// function PDFThumbnail({ url, onClick }) {
//   const canvasRef = useRef(null);
//   useEffect(() => {
//     let isMounted = true;
//     GlobalWorkerOptions.workerSrc = `https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js`;
//     getDocument(url).promise.then(doc => doc.getPage(1)).then(page => {
//       if (!isMounted) return;
//       const viewport = page.getViewport({ scale: 0.5 });
//       const canvas = canvasRef.current;
//       const context = canvas.getContext('2d');
//       canvas.height = viewport.height;
//       canvas.width = viewport.width;
//       page.render({ canvasContext: context, viewport });
//     });
//     return () => { isMounted = false; };
//   }, [url]);
//   return (
//     <div className="relative cursor-pointer w-full flex justify-center bg-white py-2" onClick={onClick}>
//       <canvas ref={canvasRef} className="bg-white shadow rounded w-auto max-w-full max-h-60" />
//       <div className="absolute bottom-2 left-2 bg-black bg-opacity-60 text-white text-xs px-2 py-1 rounded">
//         PDF Preview
//       </div>
//     </div>
//   );
// }

const PostCard = ({ post, onPostUpdated }: PostCardProps) => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [isLiked, setIsLiked] = useState(false);
  const [likesCount, setLikesCount] = useState(post.likes_count || 0);
  const [isLiking, setIsLiking] = useState(false);
  const [isPostAnimating, setIsPostAnimating] = useState(false);
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
  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewType, setPreviewType] = useState<'image' | 'pdf' | 'video' | null>(null);
  const [numPages, setNumPages] = useState<number>(0);
  const [pageNumber, setPageNumber] = useState<number>(1);
  const [mediaType, setMediaType] = useState<'image' | 'pdf' | 'video' | null>(null);
  const [flagDialogOpen, setFlagDialogOpen] = useState(false);
  const [flagReason, setFlagReason] = useState("");
  const [flagLoading, setFlagLoading] = useState(false);
  const [hasFlagged, setHasFlagged] = useState(false);

  // Check if user has liked this post
  useEffect(() => {
    const checkLikeStatus = async () => {
      if (!user) return;
      
      const { data, error } = await supabase
        .from('likes')
        .select('id')
        .eq('post_id', post.id)
        .eq('user_id', user.id);

      if (data && data.length > 0) {
        setIsLiked(true);
      }
    };

    checkLikeStatus();
  }, [user, post.id]);

  // Check if user has flagged this post
  useEffect(() => {
    const checkFlagged = async () => {
      if (!user) return setHasFlagged(false);
      const { data } = await supabase
        .from('content_flags')
        .select('id')
        .eq('post_id', post.id)
        .eq('flagged_by_user_id', user.id)
        .single();
      setHasFlagged(!!data);
    };
    checkFlagged();
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
        .select(`
          *,
          profiles:profiles(full_name, avatar_url),
          comment_likes(count)
        `)
        .eq('post_id', post.id)
        .order('created_at', { ascending: true });
      if (!error) {
        setComments(data || []);
      }
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
    setIsPostAnimating(true);

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
        setLikesCount(prev => Math.max(prev - 1, 0));
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

      // // Notify parent component to refresh
      // if (onPostUpdated) {
      //   onPostUpdated();
      // }
    } catch (error: any) {
      console.error('Error toggling like:', error);
      toast({
        title: "Error",
        description: "Failed to update like. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsLiking(false);
      
      // Stop animation after a short delay
      setTimeout(() => {
        setIsPostAnimating(false);
      }, 600);
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
    await supabase.from('posts').delete().eq('id', post.id);
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
      .select(`
        *,
        profiles:profiles(full_name, avatar_url),
        comment_likes(count)
      `)
      .eq('post_id', post.id)
      .order('created_at', { ascending: true });
    setComments(data || []);
    if (commentInputRef.current) commentInputRef.current.focus();
  };

  // Helper: recursively render comments and replies
  const CommentThread = ({ comments, parentId, user, onRefresh, depth = 0 }: any) => {
    const filtered = comments.filter((c: any) => c.parent_id == parentId);
    return filtered.map((comment: any) => (
      <CommentItem
        key={comment.id}
        comment={comment}
        comments={comments}
        user={user}
        onRefresh={onRefresh}
        depth={depth}
      />
    ));
  };

  const CommentItem = ({ comment, comments, user, onRefresh, depth = 0 }: any) => {
    const [editing, setEditing] = useState(false);
    const [editContent, setEditContent] = useState(comment.content);
    const [replying, setReplying] = useState(false);
    const [replyContent, setReplyContent] = useState("");
    const [loading, setLoading] = useState(false);
    const [likeCount, setLikeCount] = useState(comment.comment_likes?.[0]?.count || 0);
    const [liked, setLiked] = useState(false);
    const [isAnimating, setIsAnimating] = useState(false);

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
      setIsAnimating(true);
      if (liked) {
        await supabase.from('comment_likes').delete().eq('comment_id', comment.id).eq('user_id', user.id);
        setLikeCount((c: number) => Math.max(c - 1, 0));
        setLiked(false);
      } else {
        await supabase.from('comment_likes').insert({ comment_id: comment.id, user_id: user.id });
        setLikeCount((c: number) => c + 1);
        setLiked(true);
      }
      setLoading(false);
      setTimeout(() => {
        setIsAnimating(false);
      }, 600);
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
            <Button
              size="sm"
              variant="ghost"
              onClick={handleLike}
              disabled={loading}
              className={cn(
                liked ? "text-red-500" : "",
                isAnimating && (depth === 0 ? "animate-bounce" : "animate-pulse")
              )}
            >
              <span className={cn("flex items-center gap-1", liked && "text-red-500")}> 
                <Heart className={cn("h-3 w-3", liked && "fill-current text-red-500")}/>
                <span>{likeCount}</span>
              </span>
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
            <CommentThread comments={comments} parentId={comment.id} user={user} onRefresh={onRefresh} depth={depth + 1} />
          </div>
        </div>
      </div>
    );
  };

  // Helper to determine file type
  const getFileType = (url: string) => {
    if (url.match(/\.(pdf)$/i)) return 'pdf';
    if (url.match(/\.(mp4|webm|ogg)$/i)) return 'video';
    if (url.match(/\.(jpg|jpeg|png|gif|bmp|svg|webp)$/i)) return 'image';
    return null;
  };

  const handleFlagPost = async () => {
    if (!user) {
      toast({
        title: "Authentication required",
        description: "Please sign in to flag posts.",
        variant: "destructive",
      });
      return;
    }
    setFlagLoading(true);
    // Prevent duplicate flags
    const { data: existing } = await supabase
      .from("content_flags")
      .select("id")
      .eq("post_id", post.id)
      .eq("flagged_by_user_id", user.id)
      .single();
    if (existing) {
      toast({
        title: "Already flagged",
        description: "You have already flagged this post.",
        variant: "default",
      });
      setFlagLoading(false);
      setFlagDialogOpen(false);
      setHasFlagged(true);
      return;
    }
    // Insert flag
    const { error } = await supabase.from("content_flags").insert({
      post_id: post.id,
      flagged_by_user_id: user.id,
      reason: flagReason,
    });
    // Notify all admins and post owner (except flagger)
    const { data: admins, error: adminError } = await supabase
      .from("user_roles")
      .select("user_id")
      .eq("role", "admin");
    console.log('Admins:', admins, adminError);
    const { data: postData } = await supabase
      .from("posts")
      .select("user_id")
      .eq("id", post.id)
      .single();
    const recipients = [
      ...(admins?.map(a => a.user_id) || []),
      postData?.user_id
    ].filter(uid => uid && uid !== user.id);
    const notifications = recipients.map((uid) => ({
      user_id: uid,
      type: "flagged_post",
      data: {
        post_id: post.id,
        flagged_by: user.id,
        reason: flagReason,
        text: `A post you own or moderate was flagged by a user.`
      },
      is_read: false
    }));
    console.log('Admins:', admins);
    console.log('Notifications to insert:', notifications);
    const { error: notifError } = await supabase.from("notifications").insert(notifications);
    if (notifError) {
      console.error("Notification insert error:", notifError);
    }
    setFlagLoading(false);
    setFlagDialogOpen(false);
    setFlagReason("");
    if (error) {
      toast({
        title: "Error",
        description: "Failed to flag post. Please try again.",
        variant: "destructive",
      });
    } else {
      toast({
        title: "Post flagged",
        description: "Thank you for reporting. Our team will review this post.",
      });
      setHasFlagged(true);
    }
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
                <h4 className="font-semibold">
                  <a
                    href={`/app/profile?user_id=${post.user_id}`}
                    className="hover:underline text-primary"
                  >
                    {post.profiles?.full_name || "Unknown User"}
                  </a>
                </h4>
                <p className="text-sm text-muted-foreground">
                  {formatTimestamp(post.created_at)}
                </p>
                {post.flag_status && post.flag_status !== 'normal' && (
                  <Badge variant={
                    post.flag_status === 'flagged'
                      ? 'destructive'
                      : post.flag_status === 'reviewed' || post.flag_status === 'resolved'
                        ? 'secondary'
                        : 'default'
                  }>
                    {post.flag_status === 'flagged'
                      ? 'Flagged'
                      : post.flag_status === 'reviewed'
                        ? 'Reviewed'
                        : post.flag_status === 'resolved'
                          ? 'Resolved'
                          : post.flag_status}
                  </Badge>
                )}
              </div>
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="ghost" size="icon">
                    <MoreHorizontal className="h-4 w-4" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent>
                  {isOwner && (
                    <DropdownMenuItem onClick={() => { setEditing(true); setEditContent(post.content); }} disabled={post.flag_status && post.flag_status !== 'normal'}>Edit</DropdownMenuItem>
                  )}
                  {isOwner && (
                    <DropdownMenuItem onClick={() => setConfirmingDelete(true)} disabled={deleting || (post.flag_status && post.flag_status !== 'normal')}>Delete</DropdownMenuItem>
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
              {!editing && (
                <>
                  {/* IMAGE PREVIEW */}
                  {post.image_url && (
                    <div className="rounded-lg overflow-hidden mt-2 relative">
                      <img
                        src={post.image_url}
                        alt="Post image"
                        className="w-full h-auto object-cover max-h-96 cursor-pointer"
                        onClick={() => { setPreviewType('image'); setMediaType('image'); setPreviewOpen(true); }}
                      />
                      <Dialog open={previewOpen && previewType === 'image'} onOpenChange={open => setPreviewOpen(open)}>
                        <DialogContent className="w-screen max-w-full h-screen max-h-full flex flex-col p-0 bg-black">
                          <div className="flex items-center justify-between px-6 py-3 bg-black text-white border-b">
                            <span className="font-semibold text-base truncate">Image Preview</span>
                            <Button size="icon" variant="ghost" className="text-white" onClick={() => setPreviewOpen(false)}>
                              <span className="sr-only">Close</span>
                              ×
                            </Button>
                          </div>
                          <div className="flex-1 flex items-center justify-center bg-neutral-900">
                            <img src={post.image_url} alt="Post image" className="max-h-[80vh] max-w-full object-contain bg-white shadow-xl rounded" />
                          </div>
                        </DialogContent>
                      </Dialog>
                    </div>
                  )}
                  {/* Other file types */}
                  {post.file_url && !getFileType(post.file_url) && (
                    <div className="rounded-lg overflow-hidden mt-2">
                      <a
                        href={post.file_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-blue-600 underline"
                      >
                        Download attached file
                      </a>
                    </div>
                  )}
                </>
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
                  isLiked && "text-red-500",
                  isPostAnimating && "animate-bounce"
                )}
              >
                {isLiking ? (
                  <Loader2 className="h-4 w-4 animate-spin" />
                ) : (
                  <Heart className={cn("h-4 w-4", isLiked && "fill-current text-red-500")} />
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
              {!isOwner && (
                <Dialog open={flagDialogOpen} onOpenChange={setFlagDialogOpen}>
                  <DialogTrigger asChild>
                    <Button variant="ghost" size="sm" className="flex items-center gap-2 text-yellow-600" onClick={() => setFlagDialogOpen(true)} disabled={hasFlagged}>
                      <Flag className="h-4 w-4" />
                      Flag
                    </Button>
                  </DialogTrigger>
                  <DialogContent>
                    <DialogTitle>Report this post</DialogTitle>
                    <p className="text-sm text-muted-foreground mb-2">Please let us know why you are flagging this post (optional):</p>
                    <Textarea
                      value={flagReason}
                      onChange={e => setFlagReason(e.target.value)}
                      placeholder="Reason (optional)"
                      rows={3}
                    />
                    <div className="flex gap-2 mt-4">
                      <Button onClick={handleFlagPost} disabled={flagLoading}>
                        {flagLoading ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : null}
                        Submit
                      </Button>
                      <Button variant="outline" onClick={() => setFlagDialogOpen(false)} disabled={flagLoading}>Cancel</Button>
                    </div>
                  </DialogContent>
                </Dialog>
              )}
              {hasFlagged && (
                <Badge variant="secondary" className="ml-2">Flagged</Badge>
              )}
            </div>
            {/* Comments Section */}
            <div className="mt-3">
              {comments.filter(c => !c.parent_id).length > 0 && (
                <div className="space-y-3">
                  <CommentThread comments={comments} parentId={null} user={user} onRefresh={() => {
                    // refetch comments
                    supabase
                      .from('comments')
                      .select(`
                        *,
                        profiles:profiles(full_name, avatar_url),
                        comment_likes(count)
                      `)
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
        <Dialog open={confirmingDelete} onOpenChange={setConfirmingDelete}>
          <DialogContent>
            <DialogTitle>Delete post?</DialogTitle>
            <p>Are you sure you want to permanently remove this post?</p>
            <div className="flex justify-end gap-2 mt-4">
              <Button variant="outline" onClick={() => setConfirmingDelete(false)} disabled={deleting}>Cancel</Button>
              <Button variant="destructive" onClick={handleDelete} disabled={deleting}>
                {deleting ? "Deleting..." : "Delete"}
              </Button>
            </div>
          </DialogContent>
        </Dialog>
      </CardContent>
    </Card>
  );
};

export default PostCard;
