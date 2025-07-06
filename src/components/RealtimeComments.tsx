import React, { useEffect, useState } from 'react';
import { Button } from './ui/button';
import { Textarea } from './ui/textarea';
import { Avatar, AvatarFallback, AvatarImage } from './ui/avatar';
import { useRealtime } from '../hooks/useRealtime';
import { supabase } from '../integrations/supabase/client';
import { useAuth } from '../contexts/AuthContext';

interface Comment {
  id: number;
  answer_id: number;
  user_id: string;
  body: string;
  parent_comment_id?: number;
  created_at: string;
  user?: {
    full_name?: string;
    avatar_url?: string;
  };
}

interface RealtimeCommentsProps {
  answerId: number;
  onCommentAdded?: (comment: Comment) => void;
}

export const RealtimeComments: React.FC<RealtimeCommentsProps> = ({
  answerId,
  onCommentAdded
}) => {
  const [comments, setComments] = useState<Comment[]>([]);
  const [newComment, setNewComment] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { user } = useAuth();

  // Fetch comments
  const fetchComments = async () => {
    try {
      const { data, error } = await supabase
        .from('comments')
        .select(`
          *,
          user:profiles(full_name, avatar_url)
        `)
        .eq('answer_id', answerId)
        .order('created_at', { ascending: true });

      if (error) throw error;
      setComments(data || []);
    } catch (error) {
      console.error('Error fetching comments:', error);
    }
  };

  // Add new comment
  const handleSubmitComment = async () => {
    if (!user || !newComment.trim() || isSubmitting) return;

    setIsSubmitting(true);
    
    try {
      const { data, error } = await supabase
        .from('comments')
        .insert({
          answer_id: answerId,
          user_id: user.id,
          body: newComment.trim()
        })
        .select()
        .single();

      if (error) throw error;

      setNewComment('');
      onCommentAdded?.(data);
    } catch (error) {
      console.error('Error adding comment:', error);
    } finally {
      setIsSubmitting(false);
    }
  };

  // Handle real-time comment updates
  const handleCommentUpdate = (update: any) => {
    if (update.answer_id === answerId) {
      if (update.action === 'INSERT') {
        // Add new comment
        setComments(prev => [...prev, update]);
      } else if (update.action === 'UPDATE') {
        // Update existing comment
        setComments(prev => 
          prev.map(c => c.id === update.id ? { ...c, ...update } : c)
        );
      } else if (update.action === 'DELETE') {
        // Remove comment
        setComments(prev => prev.filter(c => c.id !== update.id));
      }
    }
  };

  // Set up real-time subscription
  useRealtime({
    onCommentUpdate: handleCommentUpdate
  });

  useEffect(() => {
    fetchComments();
  }, [answerId]);

  return (
    <div className="space-y-4">
      <h3 className="text-lg font-semibold">Comments ({comments.length})</h3>
      
      {/* Comment form */}
      {user && (
        <div className="space-y-2">
          <Textarea
            placeholder="Add a comment..."
            value={newComment}
            onChange={(e) => setNewComment(e.target.value)}
            className="min-h-[80px]"
          />
          <div className="flex justify-end">
            <Button
              onClick={handleSubmitComment}
              disabled={!newComment.trim() || isSubmitting}
              size="sm"
            >
              {isSubmitting ? 'Posting...' : 'Post Comment'}
            </Button>
          </div>
        </div>
      )}

      {/* Comments list */}
      <div className="space-y-3">
        {comments.map((comment) => (
          <div key={comment.id} className="flex gap-3 p-3 bg-gray-50 rounded-lg">
            <Avatar className="h-8 w-8">
              <AvatarImage src={comment.user?.avatar_url} />
              <AvatarFallback>
                {comment.user?.full_name?.charAt(0) || 'U'}
              </AvatarFallback>
            </Avatar>
            
            <div className="flex-1">
              <div className="flex items-center gap-2 mb-1">
                <span className="font-medium text-sm">
                  {comment.user?.full_name || 'Anonymous'}
                </span>
                <span className="text-xs text-gray-500">
                  {new Date(comment.created_at).toLocaleString()}
                </span>
              </div>
              <p className="text-sm text-gray-700">{comment.body}</p>
            </div>
          </div>
        ))}
        
        {comments.length === 0 && (
          <p className="text-center text-gray-500 py-4">
            No comments yet. Be the first to comment!
          </p>
        )}
      </div>
    </div>
  );
}; 