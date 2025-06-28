
import { Bell } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Badge } from "@/components/ui/badge";

const NotificationDropdown = () => {
  const notifications = [
    { id: 1, text: "John liked your post", time: "2m ago", unread: true },
    { id: 2, text: "Sarah commented on your photo", time: "5m ago", unread: true },
    { id: 3, text: "Mike started following you", time: "1h ago", unread: false },
  ];

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" size="icon" className="relative">
          <Bell className="h-6 w-6" />
          <Badge className="absolute -top-1 -right-1 h-5 w-5 p-0 text-xs">
            3
          </Badge>
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end" className="w-80 p-0">
        <div className="p-4 border-b">
          <h3 className="font-semibold">Notifications</h3>
        </div>
        <div className="max-h-96 overflow-auto">
          {notifications.map((notification) => (
            <DropdownMenuItem key={notification.id} className="p-4 border-b last:border-b-0">
              <div className="flex items-start gap-3">
                {notification.unread && (
                  <div className="w-2 h-2 rounded-full bg-blue-500 mt-2" />
                )}
                <div className="flex-1">
                  <p className="text-sm">{notification.text}</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    {notification.time}
                  </p>
                </div>
              </div>
            </DropdownMenuItem>
          ))}
        </div>
      </DropdownMenuContent>
    </DropdownMenu>
  );
};

export default NotificationDropdown;
