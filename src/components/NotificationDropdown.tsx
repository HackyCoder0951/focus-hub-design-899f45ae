import { useEffect, useState } from "react";
import { Bell } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Badge } from "@/components/ui/badge";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

const NotificationDropdown = () => {
  const { user } = useAuth();
  const [notifications, setNotifications] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchNotifications = async () => {
      if (!user) return;
      const { data, error } = await supabase
        .from('notifications')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });
      if (!error && data) setNotifications(data);
      setLoading(false);
    };
    fetchNotifications();
  }, [user]);

  const unreadCount = notifications.filter(n => !n.is_read).length;

  // Mark notification as read and remove from list
  const handleNotificationClick = async (notificationId) => {
    await supabase
      .from('notifications')
      .update({ is_read: true })
      .eq('id', notificationId);
    setNotifications((prev) => prev.filter(n => n.id !== notificationId));
  };

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" size="icon" className="relative">
          <Bell className="h-6 w-6" />
          {unreadCount > 0 && (
            <Badge className="absolute -top-1 -right-1 h-5 w-5 p-0 text-xs">
              {unreadCount}
            </Badge>
          )}
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end" className="w-80 p-0">
        <div className="p-4 border-b">
          <h3 className="font-semibold">Notifications</h3>
        </div>
        <div className="max-h-96 overflow-auto">
          {loading ? (
            <div className="p-4 text-center text-muted-foreground">Loading...</div>
          ) : notifications.filter(n => !n.is_read).length === 0 ? (
            <div className="p-4 text-center text-muted-foreground">No notifications.</div>
          ) : (
            notifications.filter(n => !n.is_read).map((notification) => (
              <DropdownMenuItem key={notification.id} className="p-4 border-b last:border-b-0" onClick={() => handleNotificationClick(notification.id)}>
                <div className="flex items-start gap-3">
                  {!notification.is_read && (
                    <div className="w-2 h-2 rounded-full bg-blue-500 mt-2" />
                  )}
                  <div className="flex-1">
                    <p className="text-sm">{notification.data?.text || notification.type}</p>
                    <p className="text-xs text-muted-foreground mt-1">
                      {notification.created_at ? new Date(notification.created_at).toLocaleString() : ""}
                    </p>
                  </div>
                </div>
              </DropdownMenuItem>
            ))
          )}
        </div>
      </DropdownMenuContent>
    </DropdownMenu>
  );
};

export default NotificationDropdown;
