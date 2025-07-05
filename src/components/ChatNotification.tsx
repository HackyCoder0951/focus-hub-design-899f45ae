import { useEffect, useState } from "react";
import { Badge } from "@/components/ui/badge";
import { MessageCircle } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

interface ChatNotificationProps {
  className?: string;
}

const ChatNotification = ({ className }: ChatNotificationProps) => {
  const { user } = useAuth();
  const [unreadCount, setUnreadCount] = useState(0);

  useEffect(() => {
    if (!user) return;

    // Get unread message count
    const fetchUnreadCount = async () => {
      try {
        // Get all chats where user is a member
        const { data: userChats } = await supabase
          .from('chat_members')
          .select('chat_id')
          .eq('user_id', user.id);

        if (!userChats) return;

        const chatIds = userChats.map(chat => chat.chat_id);
        
        // Count messages in user's chats that are not from the user
        const { count } = await supabase
          .from('chat_messages')
          .select('*', { count: 'exact', head: true })
          .in('chat_id', chatIds)
          .neq('user_id', user.id);

        setUnreadCount(count || 0);
      } catch (error) {
        console.error('Error fetching unread count:', error);
      }
    };

    fetchUnreadCount();

    // Set up real-time subscription for new messages
    const channel = supabase
      .channel('chat_notifications')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'chat_messages'
        },
        (payload) => {
          const newMessage = payload.new as any;
          if (newMessage.user_id !== user.id) {
            setUnreadCount(prev => prev + 1);
          }
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [user]);

  if (unreadCount === 0) return null;

  return (
    <div className={`relative ${className}`}>
      <MessageCircle className="h-5 w-5" />
      <Badge 
        variant="destructive" 
        className="absolute -top-2 -right-2 h-5 w-5 p-0 text-xs flex items-center justify-center"
      >
        {unreadCount > 99 ? '99+' : unreadCount}
      </Badge>
    </div>
  );
};

export default ChatNotification; 