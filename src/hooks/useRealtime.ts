import { useEffect, useState, useCallback } from 'react';
import { supabase } from '../integrations/supabase/client';
import { RealtimeChannel } from '@supabase/supabase-js';
import { Tables } from '@/integrations/supabase/types';

interface VoteUpdate {
  target_type: 'question' | 'answer';
  target_id: number;
  vote_count: number;
  vote_score: number;
  user_id: string;
  vote_value: number;
}

interface CommentUpdate {
  id: number;
  answer_id: number;
  user_id: string;
  body: string;
  parent_comment_id?: number;
  created_at: string;
  action: 'INSERT' | 'UPDATE' | 'DELETE';
}

interface NotificationUpdate {
  id: number;
  user_id: string;
  notification_type: string;
  message: string;
  is_read: boolean;
  related_id?: number;
  created_at: string;
  action: 'INSERT' | 'UPDATE' | 'DELETE';
}

interface UseRealtimeOptions {
  userId?: string;
  onVoteUpdate?: (update: VoteUpdate) => void;
  onCommentUpdate?: (update: CommentUpdate) => void;
  onNotificationUpdate?: (update: NotificationUpdate) => void;
}

export const useRealtime = (options: UseRealtimeOptions = {}) => {
  const [isConnected, setIsConnected] = useState(false);
  const [channels, setChannels] = useState<RealtimeChannel[]>([]);

  const { userId, onVoteUpdate, onCommentUpdate, onNotificationUpdate } = options;

  const subscribeToVoteUpdates = useCallback(() => {
    const channel = supabase
      .channel('vote_updates')
      .on('postgres_changes', {
        event: '*',
        schema: 'public',
        table: 'question_votes'
      }, (payload) => {
        if (onVoteUpdate) {
          const newRecord = payload.new as Tables<'question_votes'> | null;
          const oldRecord = payload.old as Tables<'question_votes'> | null;
          onVoteUpdate({
            target_type: 'question',
            target_id: newRecord?.question_id || oldRecord?.question_id || 0,
            vote_count: 0, // Will be calculated by the trigger
            vote_score: 0, // Will be calculated by the trigger
            user_id: newRecord?.user_id || oldRecord?.user_id || '',
            vote_value: newRecord?.vote_value || oldRecord?.vote_value || 0
          });
        }
      })
      .on('postgres_changes', {
        event: '*',
        schema: 'public',
        table: 'answer_votes'
      }, (payload) => {
        if (onVoteUpdate) {
          const newRecord = payload.new as Tables<'answer_votes'> | null;
          const oldRecord = payload.old as Tables<'answer_votes'> | null;
          onVoteUpdate({
            target_type: 'answer',
            target_id: newRecord?.answer_id || oldRecord?.answer_id || 0,
            vote_count: 0, // Will be calculated by the trigger
            vote_score: 0, // Will be calculated by the trigger
            user_id: newRecord?.user_id || oldRecord?.user_id || '',
            vote_value: newRecord?.vote_value || oldRecord?.vote_value || 0
          });
        }
      })
      .subscribe((status) => {
        setIsConnected(status === 'SUBSCRIBED');
      });

    setChannels(prev => [...prev, channel]);
    return channel;
  }, [onVoteUpdate]);

  const subscribeToCommentUpdates = useCallback(() => {
    const channel = supabase
      .channel('comment_updates')
      .on('postgres_changes', {
        event: '*',
        schema: 'public',
        table: 'answer_comments'
      }, (payload) => {
        if (onCommentUpdate) {
          const newRecord = payload.new as Tables<'answer_comments'> | null;
          const oldRecord = payload.old as Tables<'answer_comments'> | null;
          onCommentUpdate({
            id: newRecord?.id || oldRecord?.id || 0,
            answer_id: newRecord?.answer_id || oldRecord?.answer_id || 0,
            user_id: newRecord?.user_id || oldRecord?.user_id || '',
            body: newRecord?.body || oldRecord?.body || '',
            parent_comment_id: newRecord?.parent_comment_id || oldRecord?.parent_comment_id,
            created_at: newRecord?.created_at || oldRecord?.created_at || '',
            action: payload.eventType as 'INSERT' | 'UPDATE' | 'DELETE'
          });
        }
      })
      .subscribe((status) => {
        setIsConnected(status === 'SUBSCRIBED');
      });

    setChannels(prev => [...prev, channel]);
    return channel;
  }, [onCommentUpdate]);

  const subscribeToNotificationUpdates = useCallback(() => {
    if (!userId) return;

    const channel = supabase
      .channel('notification_updates')
      .on('postgres_changes', {
        event: '*',
        schema: 'public',
        table: 'question_notifications',
        filter: `user_id=eq.${userId}`
      }, (payload) => {
        if (onNotificationUpdate) {
          const newRecord = payload.new as Tables<'question_notifications'> | null;
          const oldRecord = payload.old as Tables<'question_notifications'> | null;
          onNotificationUpdate({
            id: newRecord?.id || oldRecord?.id || 0,
            user_id: newRecord?.user_id || oldRecord?.user_id || '',
            notification_type: newRecord?.notification_type || oldRecord?.notification_type || '',
            message: newRecord?.message || oldRecord?.message || '',
            is_read: newRecord?.is_read || oldRecord?.is_read || false,
            related_id: newRecord?.related_id || oldRecord?.related_id,
            created_at: newRecord?.created_at || oldRecord?.created_at || '',
            action: payload.eventType as 'INSERT' | 'UPDATE' | 'DELETE'
          });
        }
      })
      .on('postgres_changes', {
        event: '*',
        schema: 'public',
        table: 'answer_notifications',
        filter: `user_id=eq.${userId}`
      }, (payload) => {
        if (onNotificationUpdate) {
          const newRecord = payload.new as Tables<'answer_notifications'> | null;
          const oldRecord = payload.old as Tables<'answer_notifications'> | null;
          onNotificationUpdate({
            id: newRecord?.id || oldRecord?.id || 0,
            user_id: newRecord?.user_id || oldRecord?.user_id || '',
            notification_type: newRecord?.notification_type || oldRecord?.notification_type || '',
            message: newRecord?.message || oldRecord?.message || '',
            is_read: newRecord?.is_read || oldRecord?.is_read || false,
            related_id: newRecord?.related_id || oldRecord?.related_id,
            created_at: newRecord?.created_at || oldRecord?.created_at || '',
            action: payload.eventType as 'INSERT' | 'UPDATE' | 'DELETE'
          });
        }
      })
      .subscribe((status) => {
        setIsConnected(status === 'SUBSCRIBED');
      });

    setChannels(prev => [...prev, channel]);
    return channel;
  }, [userId, onNotificationUpdate]);

  const unsubscribeAll = useCallback(() => {
    channels.forEach(channel => {
      supabase.removeChannel(channel);
    });
    setChannels([]);
    setIsConnected(false);
  }, [channels]);

  useEffect(() => {
    // Subscribe to all real-time updates
    subscribeToVoteUpdates();
    subscribeToCommentUpdates();
    subscribeToNotificationUpdates();

    return () => {
      unsubscribeAll();
    };
  }, [subscribeToVoteUpdates, subscribeToCommentUpdates, subscribeToNotificationUpdates, unsubscribeAll]);

  return {
    isConnected,
    unsubscribeAll
  };
}; 