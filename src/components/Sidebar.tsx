import { NavLink } from "react-router-dom";
import { cn } from "@/lib/utils";
import { useAuth } from "@/contexts/AuthContext";
import ChatNotification from "./ChatNotification";
import {
  Activity,
  MessageCircle,
  User,
  Book,
  FileText,
  Settings,
  Cog
} from "lucide-react";

interface NavigationItem {
  name: string;
  href: string;
  icon: React.ComponentType<{ className?: string; 'aria-hidden'?: boolean }>;
  showNotification?: boolean;
}

const Sidebar = () => {
  const { isAdmin } = useAuth();

  // Define navigation items for regular users
  const userNavigation: NavigationItem[] = [
    { name: "Feed", href: "/app", icon: Activity },
    { name: "Q&A", href: "/app/qa", icon: Book },
    { name: "Resources", href: "/app/resources", icon: FileText },
    { name: "Chat", href: "/app/chat", icon: MessageCircle, showNotification: true },
    { name: "Profile", href: "/app/profile", icon: User },
    { name: "Settings", href: "/app/settings", icon: Settings },
  ];

  // Define navigation items for admin users
  const adminNavigation: NavigationItem[] = [
    { name: "Admin Dashboard", href: "/app/admin", icon: Cog },
    { name: "Profile", href: "/app/profile", icon: User },
    { name: "Settings", href: "/app/settings", icon: Settings },
    
  ];

  // Use appropriate navigation based on user role
  const navigation = isAdmin ? adminNavigation : userNavigation;

  return (
    <div className="hidden lg:fixed lg:inset-y-0 lg:z-50 lg:flex lg:w-72 lg:flex-col">
      <div className="flex grow flex-col gap-y-5 overflow-y-auto border-r border-border bg-card px-6 pb-4 pt-20">
        <nav className="flex flex-1 flex-col">
          <ul role="list" className="flex flex-1 flex-col gap-y-7">
            <li>
              <ul role="list" className="-mx-2 space-y-1">
                {navigation.map((item) => (
                  <li key={item.name}>
                    <NavLink
                      to={item.href}
                      end={item.href === "/app"}
                      className={({ isActive }) =>
                        cn(
                          isActive
                            ? "bg-primary text-primary-foreground"
                            : "text-muted-foreground hover:text-foreground hover:bg-muted",
                          "group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-medium transition-colors"
                        )
                      }
                    >
                      <div className="relative">
                      <item.icon className="h-6 w-6 shrink-0" aria-hidden="true" />
                        {item.showNotification && (
                          <ChatNotification className="absolute -top-1 -right-1" />
                        )}
                      </div>
                      {item.name}
                    </NavLink>
                  </li>
                ))}
              </ul>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  );
};

export default Sidebar;
