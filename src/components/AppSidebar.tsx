import { NavLink } from "react-router-dom";
import { cn } from "@/lib/utils";
import {
  Activity,
  MessageCircle,
  User,
  Book,
  FileText,
  Settings,
  Cog,
} from "lucide-react";
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  useSidebar,
} from "@/components/ui/sidebar";
import { useAuth } from "@/contexts/AuthContext";

export function AppSidebar() {
  const { state, toggleSidebar } = useSidebar();
  const { isAdmin } = useAuth();

  const navigation = [
    { name: "Feed", href: "/app", icon: Activity },
    { name: "Q&A", href: "/app/qa", icon: Book },
    { name: "Resources", href: "/app/resources", icon: FileText },
    { name: "Chat", href: "/app/chat", icon: MessageCircle },
    { name: "Profile", href: "/app/profile", icon: User },
    { name: "Settings", href: "/app/settings", icon: Settings },
    ...(isAdmin ? [{ name: "Admin", href: "/app/admin", icon: Cog }] : []),
  ];

  return (
    <Sidebar collapsible="icon">
      <div
        className={cn(
          "transition-all duration-700 bg-background text-sidebar-foreground min-h-screen overflow-hidden flex flex-col items-start",
          state === "collapsed" ? "w-14" : "w-68"
        )}
      >
        <SidebarContent className="flex-1 w-full">
          <div className="p-2 w-full flex items-center justify-end">
            <button
              onClick={toggleSidebar}
              className="rounded hover:bg-muted transition-colors p-1 text-sidebar-foreground"
              aria-label={state === "expanded" ? "Collapse sidebar" : "Expand sidebar"}
              style={{ background: 'transparent' }}
            >
              <svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
                <rect y="6" width="28" height="2.5" rx="1.25" fill="currentColor" />
                <rect y="13" width="28" height="2.5" rx="1.25" fill="currentColor" />
                <rect y="20" width="28" height="2.5" rx="1.25" fill="currentColor" />
              </svg>
            </button>
          </div>
          <SidebarGroup>
           <SidebarGroupLabel className="w-full justify-center">Focus Hub</SidebarGroupLabel>
            <SidebarGroupContent>
              <SidebarMenu>
                {navigation.map((item) => (
                  <SidebarMenuItem key={item.name}>
                    <SidebarMenuButton asChild>
                      <NavLink
                        to={item.href}
                        end={item.href === "/app"}
                        className={({ isActive }) =>
                          cn(
                            "flex items-center gap-3 rounded-lg px-3 py-2 transition-all hover:text-primary",
                            isActive
                              ? "bg-muted text-primary"
                              : "text-muted-foreground"
                          )
                        }
                      >
                        <item.icon className="h-4 w-4" />
                        <span
                          className={
                            cn(
                              "inline-block transition-all duration-700",
                              state === "collapsed"
                                ? "opacity-0 ml-0 w-0 pointer-events-none"
                                : "opacity-100 ml-2 w-auto"
                            )
                          }
                        >
                          {item.name}
                        </span>
                      </NavLink>
                    </SidebarMenuButton>
                  </SidebarMenuItem>
                ))}
              </SidebarMenu>
            </SidebarGroupContent>
          </SidebarGroup>
        </SidebarContent>
      </div>
    </Sidebar>
  );
}
