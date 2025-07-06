import React, { useEffect, useState } from 'react';
import { Badge } from './ui/badge';
import { Bell } from 'lucide-react';
import { useRealtime } from '../hooks/useRealtime';
import { supabase } from '../integrations/supabase/client';
import { useAuth } from '../contexts/AuthContext';

interface Notification {
  id: number;
  user_id: string;
  notification_type: string;
  message: string;
  is_read: boolean;
  related_id?: number;
  created_at: string;
}

export const RealtimeNotificationBadge: React.FC = () => {
  const [unreadCount, setUnreadCount] = useState(0);
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const { user } = useAuth();

  // Fetch initial unread count
  const fetchUnreadCount = async () => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .rpc('get_unread_notification_count', { user_uuid: user.id });
      
      if (error) throw error;
      setUnreadCount(data || 0);
    } catch (error) {
      console.error('Error fetching unread count:', error);
    }
  };

  // Fetch recent notifications
  const fetchNotifications = async () => {
    if (!user) return;
    
    try {
      const { data: questionNotifications, error: questionError } = await supabase
        .from('question_notifications')
        .select('*')
        .eq('user_id', user.id)
        .eq('is_read', false)
        .order('created_at', { ascending: false })
        .limit(10);

      const { data: answerNotifications, error: answerError } = await supabase
        .from('answer_notifications')
        .select('*')
        .eq('user_id', user.id)
        .eq('is_read', false)
        .order('created_at', { ascending: false })
        .limit(10);

      if (questionError) throw questionError;
      if (answerError) throw answerError;

      const allNotifications = [
        ...(questionNotifications || []),
        ...(answerNotifications || [])
      ].sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime());

      setNotifications(allNotifications);
    } catch (error) {
      console.error('Error fetching notifications:', error);
    }
  };

  // Mark notifications as read
  const markAsRead = async (notificationIds: number[]) => {
    if (!user) return;
    
    try {
      const { error } = await supabase
        .rpc('mark_notifications_as_read', { 
          user_uuid: user.id, 
          notification_ids: notificationIds 
        });
      
      if (error) throw error;
      
      // Update local state
      setNotifications(prev => 
        prev.filter(n => !notificationIds.includes(n.id))
      );
      setUnreadCount(prev => Math.max(0, prev - notificationIds.length));
    } catch (error) {
      console.error('Error marking notifications as read:', error);
    }
  };

  // Handle real-time notification updates
  const handleNotificationUpdate = (update: any) => {
    if (update.action === 'INSERT') {
      // Add new notification
      setNotifications(prev => [update, ...prev]);
      setUnreadCount(prev => prev + 1);
    } else if (update.action === 'UPDATE') {
      // Update existing notification
      setNotifications(prev => 
        prev.map(n => n.id === update.id ? { ...n, ...update } : n)
      );
    } else if (update.action === 'DELETE') {
      // Remove notification
      setNotifications(prev => prev.filter(n => n.id !== update.id));
      setUnreadCount(prev => Math.max(0, prev - 1));
    }
  };

  // Set up real-time subscriptions
  useRealtime({
    userId: user?.id,
    onNotificationUpdate: handleNotificationUpdate
  });

  useEffect(() => {
    if (user) {
      fetchUnreadCount();
      fetchNotifications();
    }
  }, [user]);

  if (!user) return null;

  return (
    <div className="relative">
      <div className="flex items-center gap-2">
        <Bell className="h-5 w-5" />
        {unreadCount > 0 && (
          <Badge 
            variant="destructive" 
            className="absolute -top-2 -right-2 h-5 w-5 rounded-full p-0 flex items-center justify-center text-xs"
          >
            {unreadCount > 99 ? '99+' : unreadCount}
          </Badge>
        )}
      </div>
      
      {/* Notification dropdown (you can expand this) */}
      {notifications.length > 0 && (
        <div className="absolute top-full right-0 mt-2 w-80 bg-white border rounded-lg shadow-lg z-50 max-h-96 overflow-y-auto">
          <div className="p-2">
            <h3 className="font-semibold text-sm mb-2">Recent Notifications</h3>
            {notifications.slice(0, 5).map((notification) => (
              <div 
                key={notification.id}
                className="p-2 hover:bg-gray-50 rounded cursor-pointer"
                onClick={() => markAsRead([notification.id])}
              >
                <p className="text-sm text-gray-800">{notification.message}</p>
                <p className="text-xs text-gray-500 mt-1">
                  {new Date(notification.created_at).toLocaleString()}
                </p>
              </div>
            ))}
            {notifications.length > 5 && (
              <button 
                className="w-full text-center text-sm text-blue-600 hover:text-blue-800 mt-2"
                onClick={() => markAsRead(notifications.map(n => n.id))}
              >
                Mark all as read
              </button>
            )}
          </div>
        </div>
      )}
    </div>
  );
}; 