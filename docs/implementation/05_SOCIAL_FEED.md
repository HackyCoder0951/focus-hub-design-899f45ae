# Social Feed Module Implementation

## Overview

The Social Feed module is the core social networking feature of Focus Hub, providing users with the ability to create, share, and interact with posts in real-time.

## Core Components

### 1. Feed Page Component

**File**: `src/pages/Feed.tsx`
```typescript
import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { PostCard } from '@/components/PostCard';
import { CreatePost } from '@/components/CreatePost';
import { Button } from '@/components/ui/button';
import { RefreshCw, Loader2 } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

interface Post {
  id: string;
  content: string;
  media_url?: string;
  created_at: string;
  user_id: string;
  profiles: {
    full_name: string;
    avatar_url?: string;
  };
  likes: { id: string }[];
  comments: { id: string }[];
}

const Feed = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [hasMore, setHasMore] = useState(true);
  const [page, setPage] = useState(0);
  const postsPerPage = 10;

  const fetchPosts = async (reset = false) => {
    try {
      const currentPage = reset ? 0 : page;
      const from = currentPage * postsPerPage;
      const to = from + postsPerPage - 1;

      const { data, error } = await supabase
        .from('posts')
        .select(`
          *,
          profiles (full_name, avatar_url),
          likes (id),
          comments (id)
        `)
        .eq('is_deleted', false)
        .order('created_at', { ascending: false })
        .range(from, to);

      if (error) throw error;

      if (reset) {
        setPosts(data || []);
      } else {
        setPosts(prev => [...prev, ...(data || [])]);
      }

      setHasMore((data || []).length === postsPerPage);
      setPage(currentPage + 1);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load posts",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useEffect(() => {
    fetchPosts(true);

    // Set up real-time subscription
    const channel = supabase
      .channel('posts')
      .on('postgres_changes', 
        { event: '*', schema: 'public', table: 'posts' },
        (payload) => {
          if (payload.eventType === 'INSERT' && !payload.new.is_deleted) {
            // Add new post to the top
            setPosts(prev => [payload.new as Post, ...prev]);
          } else if (payload.eventType === 'UPDATE') {
            // Update existing post
            setPosts(prev => 
              prev.map(post => 
                post.id === payload.new.id ? payload.new as Post : post
              )
            );
          } else if (payload.eventType === 'DELETE') {
            // Remove deleted post
            setPosts(prev => prev.filter(post => post.id !== payload.old.id));
          }
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, []);

  const handleRefresh = () => {
    setRefreshing(true);
    setPage(0);
    fetchPosts(true);
  };

  const handleLoadMore = () => {
    if (!loading && hasMore) {
      fetchPosts();
    }
  };

  const handlePostCreated = (newPost: Post) => {
    setPosts(prev => [newPost, ...prev]);
  };

  if (loading && posts.length === 0) {
    return (
      <div className="flex items-center justify-center h-64">
        <Loader2 className="h-8 w-8 animate-spin" />
      </div>
    );
  }

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">Feed</h1>
        <Button
          variant="outline"
          size="sm"
          onClick={handleRefresh}
          disabled={refreshing}
        >
          <RefreshCw className={`h-4 w-4 mr-2 ${refreshing ? 'animate-spin' : ''}`} />
          Refresh
        </Button>
      </div>

      <CreatePost onPostCreated={handlePostCreated} />

      <div className="space-y-4">
        {posts.map((post) => (
          <PostCard
            key={post.id}
            post={post}
            currentUserId={user?.id}
            onUpdate={() => fetchPosts(true)}
          />
        ))}
      </div>

      {hasMore && (
        <div className="text-center">
          <Button
            variant="outline"
            onClick={handleLoadMore}
            disabled={loading}
          >
            {loading ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                Loading...
              </>
            ) : (
              'Load More'
            )}
          </Button>
        </div>
      )}

      {posts.length === 0 && !loading && (
        <div className="text-center py-12">
          <p className="text-muted-foreground">No posts yet. Be the first to share something!</p>
        </div>
      )}
    </div>
  );
};

export default Feed;
```

### 2. Create Post Component

**File**: `src/components/CreatePost.tsx`
```typescript
import { useState, useRef } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import { Card, CardContent } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Image, X, Loader2 } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

interface CreatePostProps {
  onPostCreated: (post: any) => void;
}

export const CreatePost = ({ onPostCreated }: CreatePostProps) => {
  const { profile } = useAuth();
  const { toast } = useToast();
  const [content, setContent] = useState('');
  const [mediaFile, setMediaFile] = useState<File | null>(null);
  const [mediaPreview, setMediaPreview] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      // Validate file type
      if (!file.type.startsWith('image/')) {
        toast({
          title: "Invalid file type",
          description: "Please select an image file",
          variant: "destructive",
        });
        return;
      }

      // Validate file size (5MB limit)
      if (file.size > 5 * 1024 * 1024) {
        toast({
          title: "File too large",
          description: "Please select a file smaller than 5MB",
          variant: "destructive",
        });
        return;
      }

      setMediaFile(file);
      
      // Create preview
      const reader = new FileReader();
      reader.onload = (e) => {
        setMediaPreview(e.target?.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const removeMedia = () => {
    setMediaFile(null);
    setMediaPreview(null);
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  const uploadMedia = async (): Promise<string | null> => {
    if (!mediaFile) return null;

    const fileExt = mediaFile.name.split('.').pop();
    const fileName = `${Date.now()}-${Math.random().toString(36).substring(2)}.${fileExt}`;
    const filePath = `posts/${fileName}`;

    const { error } = await supabase.storage
      .from('uploads')
      .upload(filePath, mediaFile);

    if (error) {
      throw new Error('Failed to upload media');
    }

    const { data: { publicUrl } } = supabase.storage
      .from('uploads')
      .getPublicUrl(filePath);

    return publicUrl;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!content.trim() && !mediaFile) {
      toast({
        title: "Empty post",
        description: "Please add some content or media to your post",
        variant: "destructive",
      });
      return;
    }

    setIsSubmitting(true);

    try {
      let mediaUrl = null;
      
      if (mediaFile) {
        mediaUrl = await uploadMedia();
      }

      const { data, error } = await supabase
        .from('posts')
        .insert([{
          content: content.trim(),
          media_url: mediaUrl,
          user_id: profile?.id
        }])
        .select(`
          *,
          profiles (full_name, avatar_url),
          likes (id),
          comments (id)
        `)
        .single();

      if (error) throw error;

      // Reset form
      setContent('');
      removeMedia();
      
      // Notify parent component
      onPostCreated(data);

      toast({
        title: "Success",
        description: "Your post has been published",
      });

    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "Failed to create post",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <Card>
      <CardContent className="p-4">
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="flex space-x-3">
            <Avatar>
              <AvatarImage src={profile?.avatar_url} />
              <AvatarFallback>
                {profile?.full_name?.charAt(0) || 'U'}
              </AvatarFallback>
            </Avatar>
            
            <div className="flex-1">
              <Textarea
                placeholder="What's on your mind?"
                value={content}
                onChange={(e) => setContent(e.target.value)}
                className="min-h-[100px] resize-none border-0 focus-visible:ring-0"
                disabled={isSubmitting}
              />
            </div>
          </div>

          {mediaPreview && (
            <div className="relative">
              <img
                src={mediaPreview}
                alt="Preview"
                className="rounded-lg max-h-64 object-cover"
              />
              <Button
                type="button"
                variant="destructive"
                size="sm"
                className="absolute top-2 right-2"
                onClick={removeMedia}
              >
                <X className="h-4 w-4" />
              </Button>
            </div>
          )}

          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <input
                ref={fileInputRef}
                type="file"
                accept="image/*"
                onChange={handleFileSelect}
                className="hidden"
              />
              <Button
                type="button"
                variant="outline"
                size="sm"
                onClick={() => fileInputRef.current?.click()}
                disabled={isSubmitting}
              >
                <Image className="h-4 w-4 mr-2" />
                Add Image
              </Button>
            </div>

            <Button
              type="submit"
              disabled={isSubmitting || (!content.trim() && !mediaFile)}
            >
              {isSubmitting ? (
                <>
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  Publishing...
                </>
              ) : (
                'Publish'
              )}
            </Button>
          </div>
        </form>
      </CardContent>
    </Card>
  );
};
```

### 3. Post Card Component

**File**: `src/components/PostCard.tsx`
```typescript
import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader } from '@/components/ui/card';
import { Textarea } from '@/components/ui/textarea';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { Heart, MessageCircle, Share, MoreHorizontal, Edit, Trash2, Flag } from 'lucide-react';
import { formatDistanceToNow } from 'date-fns';
import { useToast } from '@/hooks/use-toast';

interface PostCardProps {
  post: any;
  currentUserId?: string;
  onUpdate: () => void;
}

export const PostCard = ({ post, currentUserId, onUpdate }: PostCardProps) => {
  const { profile } = useAuth();
  const { toast } = useToast();
  const [isLiked, setIsLiked] = useState(false);
  const [likeCount, setLikeCount] = useState(0);
  const [commentCount, setCommentCount] = useState(0);
  const [showComments, setShowComments] = useState(false);
  const [newComment, setNewComment] = useState('');
  const [comments, setComments] = useState<any[]>([]);
  const [isEditing, setIsEditing] = useState(false);
  const [editContent, setEditContent] = useState(post.content);
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    // Check if current user liked the post
    setIsLiked(post.likes?.some((like: any) => like.user_id === currentUserId) || false);
    setLikeCount(post.likes?.length || 0);
    setCommentCount(post.comments?.length || 0);
  }, [post, currentUserId]);

  const handleLike = async () => {
    if (!currentUserId) return;

    try {
      if (isLiked) {
        // Unlike
        await supabase
          .from('likes')
          .delete()
          .eq('post_id', post.id)
          .eq('user_id', currentUserId);
        setLikeCount(prev => prev - 1);
      } else {
        // Like
        await supabase
          .from('likes')
          .insert({ post_id: post.id, user_id: currentUserId });
        setLikeCount(prev => prev + 1);
      }
      setIsLiked(!isLiked);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to update like",
        variant: "destructive",
      });
    }
  };

  const fetchComments = async () => {
    try {
      const { data, error } = await supabase
        .from('comments')
        .select(`
          *,
          profiles (full_name, avatar_url)
        `)
        .eq('post_id', post.id)
        .order('created_at', { ascending: true });

      if (error) throw error;
      setComments(data || []);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load comments",
        variant: "destructive",
      });
    }
  };

  const handleComment = async () => {
    if (!currentUserId || !newComment.trim()) return;

    setIsSubmitting(true);
    try {
      const { error } = await supabase
        .from('comments')
        .insert({
          post_id: post.id,
          user_id: currentUserId,
          content: newComment.trim()
        });

      if (error) throw error;

      setNewComment('');
      setCommentCount(prev => prev + 1);
      fetchComments();
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to add comment",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleEdit = async () => {
    if (!editContent.trim()) return;

    setIsSubmitting(true);
    try {
      const { error } = await supabase
        .from('posts')
        .update({ 
          content: editContent.trim(),
          updated_at: new Date().toISOString()
        })
        .eq('id', post.id);

      if (error) throw error;

      setIsEditing(false);
      onUpdate();
      toast({
        title: "Success",
        description: "Post updated successfully",
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to update post",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleDelete = async () => {
    try {
      const { error } = await supabase
        .from('posts')
        .update({ is_deleted: true })
        .eq('id', post.id);

      if (error) throw error;

      onUpdate();
      toast({
        title: "Success",
        description: "Post deleted successfully",
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to delete post",
        variant: "destructive",
      });
    }
  };

  const handleFlag = async () => {
    if (!currentUserId) return;

    try {
      const { error } = await supabase
        .from('content_flags')
        .insert({
          flagged_by_user_id: currentUserId,
          post_id: post.id,
          reason: 'Inappropriate content'
        });

      if (error) throw error;

      toast({
        title: "Success",
        description: "Post has been flagged for review",
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to flag post",
        variant: "destructive",
      });
    }
  };

  const isOwner = currentUserId === post.user_id;
  const isAdmin = profile?.userRole === 'admin';

  return (
    <Card>
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <Avatar>
              <AvatarImage src={post.profiles?.avatar_url} />
              <AvatarFallback>
                {post.profiles?.full_name?.charAt(0) || 'U'}
              </AvatarFallback>
            </Avatar>
            <div>
              <p className="font-medium">{post.profiles?.full_name}</p>
              <p className="text-sm text-muted-foreground">
                {formatDistanceToNow(new Date(post.created_at), { addSuffix: true })}
              </p>
            </div>
          </div>
          
          {(isOwner || isAdmin) && (
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" size="sm">
                  <MoreHorizontal className="h-4 w-4" />
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                {isOwner && (
                  <DropdownMenuItem onClick={() => setIsEditing(true)}>
                    <Edit className="h-4 w-4 mr-2" />
                    Edit
                  </DropdownMenuItem>
                )}
                {(isOwner || isAdmin) && (
                  <DropdownMenuItem onClick={handleDelete}>
                    <Trash2 className="h-4 w-4 mr-2" />
                    Delete
                  </DropdownMenuItem>
                )}
                {!isOwner && (
                  <DropdownMenuItem onClick={handleFlag}>
                    <Flag className="h-4 w-4 mr-2" />
                    Flag
                  </DropdownMenuItem>
                )}
              </DropdownMenuContent>
            </DropdownMenu>
          )}
        </div>
      </CardHeader>

      <CardContent className="space-y-4">
        {isEditing ? (
          <div className="space-y-2">
            <Textarea
              value={editContent}
              onChange={(e) => setEditContent(e.target.value)}
              rows={3}
            />
            <div className="flex space-x-2">
              <Button size="sm" onClick={handleEdit} disabled={isSubmitting}>
                {isSubmitting ? 'Saving...' : 'Save'}
              </Button>
              <Button size="sm" variant="outline" onClick={() => setIsEditing(false)}>
                Cancel
              </Button>
            </div>
          </div>
        ) : (
          <p className="whitespace-pre-wrap">{post.content}</p>
        )}

        {post.media_url && (
          <img
            src={post.media_url}
            alt="Post media"
            className="rounded-lg max-w-full h-auto"
          />
        )}

        <div className="flex items-center justify-between pt-4 border-t">
          <div className="flex items-center space-x-4">
            <Button
              variant="ghost"
              size="sm"
              onClick={handleLike}
              className={isLiked ? 'text-red-500' : ''}
            >
              <Heart className={`h-4 w-4 mr-1 ${isLiked ? 'fill-current' : ''}`} />
              {likeCount}
            </Button>
            
            <Button
              variant="ghost"
              size="sm"
              onClick={() => {
                setShowComments(!showComments);
                if (!showComments) {
                  fetchComments();
                }
              }}
            >
              <MessageCircle className="h-4 w-4 mr-1" />
              {commentCount}
            </Button>
          </div>

          <Button variant="ghost" size="sm">
            <Share className="h-4 w-4" />
          </Button>
        </div>

        {showComments && (
          <div className="space-y-3 pt-4 border-t">
            <div className="flex space-x-2">
              <Textarea
                placeholder="Write a comment..."
                value={newComment}
                onChange={(e) => setNewComment(e.target.value)}
                rows={2}
                disabled={isSubmitting}
              />
              <Button onClick={handleComment} disabled={isSubmitting}>
                {isSubmitting ? 'Posting...' : 'Post'}
              </Button>
            </div>
            
            <div className="space-y-2">
              {comments.map((comment) => (
                <div key={comment.id} className="flex space-x-2">
                  <Avatar className="h-6 w-6">
                    <AvatarImage src={comment.profiles?.avatar_url} />
                    <AvatarFallback>
                      {comment.profiles?.full_name?.charAt(0)}
                    </AvatarFallback>
                  </Avatar>
                  <div className="flex-1">
                    <p className="text-sm">
                      <span className="font-medium">{comment.profiles?.full_name}</span>
                      {' '}{comment.content}
                    </p>
                    <p className="text-xs text-muted-foreground">
                      {formatDistanceToNow(new Date(comment.created_at), { addSuffix: true })}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
};
```

## Real-time Features

### 1. Live Updates

The feed uses Supabase real-time subscriptions to automatically update when new posts are created, updated, or deleted:

```typescript
// Real-time subscription setup
const channel = supabase
  .channel('posts')
  .on('postgres_changes', 
    { event: '*', schema: 'public', table: 'posts' },
    (payload) => {
      if (payload.eventType === 'INSERT' && !payload.new.is_deleted) {
        // Add new post to the top
        setPosts(prev => [payload.new as Post, ...prev]);
      } else if (payload.eventType === 'UPDATE') {
        // Update existing post
        setPosts(prev => 
          prev.map(post => 
            post.id === payload.new.id ? payload.new as Post : post
          )
        );
      } else if (payload.eventType === 'DELETE') {
        // Remove deleted post
        setPosts(prev => prev.filter(post => post.id !== payload.old.id));
      }
    }
  )
  .subscribe();
```

### 2. Live Like Updates

Likes are updated in real-time across all connected clients:

```typescript
// Subscribe to like changes
const likesChannel = supabase
  .channel('likes')
  .on('postgres_changes', 
    { event: '*', schema: 'public', table: 'likes' },
    (payload) => {
      if (payload.eventType === 'INSERT') {
        // Increment like count
        setLikeCount(prev => prev + 1);
        if (payload.new.user_id === currentUserId) {
          setIsLiked(true);
        }
      } else if (payload.eventType === 'DELETE') {
        // Decrement like count
        setLikeCount(prev => prev - 1);
        if (payload.old.user_id === currentUserId) {
          setIsLiked(false);
        }
      }
    }
  )
  .subscribe();
```

## Content Moderation

### 1. Flagging System

Users can flag inappropriate content for admin review:

```typescript
const handleFlag = async () => {
  if (!currentUserId) return;

  try {
    const { error } = await supabase
      .from('content_flags')
      .insert({
        flagged_by_user_id: currentUserId,
        post_id: post.id,
        reason: 'Inappropriate content'
      });

    if (error) throw error;

    toast({
      title: "Success",
      description: "Post has been flagged for review",
    });
  } catch (error: any) {
    toast({
      title: "Error",
      description: "Failed to flag post",
      variant: "destructive",
    });
  }
};
```

### 2. Admin Moderation

Admins can review and take action on flagged content:

```typescript
const handleModerate = async (action: 'approve' | 'delete') => {
  try {
    if (action === 'delete') {
      await supabase
        .from('posts')
        .update({ is_deleted: true })
        .eq('id', post.id);
    }

    // Update flag status
    await supabase
      .from('content_flags')
      .update({ status: action === 'approve' ? 'resolved' : 'actioned' })
      .eq('post_id', post.id);

    onUpdate();
  } catch (error: any) {
    toast({
      title: "Error",
      description: "Failed to moderate post",
      variant: "destructive",
    });
  }
};
```

## Performance Optimizations

### 1. Pagination

Posts are loaded in chunks to improve performance:

```typescript
const postsPerPage = 10;

const fetchPosts = async (reset = false) => {
  const currentPage = reset ? 0 : page;
  const from = currentPage * postsPerPage;
  const to = from + postsPerPage - 1;

  const { data, error } = await supabase
    .from('posts')
    .select(`
      *,
      profiles (full_name, avatar_url),
      likes (id),
      comments (id)
    `)
    .eq('is_deleted', false)
    .order('created_at', { ascending: false })
    .range(from, to);

  // Update state accordingly
};
```

### 2. Optimistic Updates

UI updates immediately for better user experience:

```typescript
const handleLike = async () => {
  // Optimistic update
  setIsLiked(!isLiked);
  setLikeCount(prev => isLiked ? prev - 1 : prev + 1);

  try {
    if (isLiked) {
      await supabase
        .from('likes')
        .delete()
        .eq('post_id', post.id)
        .eq('user_id', currentUserId);
    } else {
      await supabase
        .from('likes')
        .insert({ post_id: post.id, user_id: currentUserId });
    }
  } catch (error: any) {
    // Revert optimistic update on error
    setIsLiked(isLiked);
    setLikeCount(prev => isLiked ? prev + 1 : prev - 1);
    
    toast({
      title: "Error",
      description: "Failed to update like",
      variant: "destructive",
    });
  }
};
```

## Database Schema

### Posts Table
```sql
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  media_url TEXT,
  is_deleted BOOLEAN DEFAULT FALSE,
  flag_status TEXT DEFAULT 'clean',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Likes Table
```sql
CREATE TABLE likes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(post_id, user_id)
);
```

### Comments Table
```sql
CREATE TABLE comments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  parent_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

This social feed implementation provides a comprehensive, real-time social networking experience with proper content moderation, performance optimizations, and user interaction features. 