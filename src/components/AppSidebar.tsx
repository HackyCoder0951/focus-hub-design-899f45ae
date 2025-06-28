
import { NavLink } from "react-router-dom";
import { cn } from "@/lib/utils";
import {
  Activity,
  MessageCircle,
  User,
  Book,
  FileText,
  Settings,
  Cog
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
  const { state } = useSidebar();
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
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>Focus</SidebarGroupLabel>
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
                      {state === "expanded" && <span>{item.name}</span>}
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
  );
}
