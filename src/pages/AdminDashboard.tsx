import React, { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Users, FileText, MessageCircle, TrendingUp, MoreHorizontal, ArrowUpRight, ArrowDownRight } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";

function getMonthRange(offset = 0) {
  const now = new Date();
  const year = now.getFullYear();
  const month = now.getMonth() + offset;
  const start = new Date(year, month, 1);
  const end = new Date(year, month + 1, 1);
  return { start: start.toISOString(), end: end.toISOString() };
}

const AdminDashboard = () => {
  const [stats, setStats] = useState<any>(null);
  const [recentUsers, setRecentUsers] = useState<any[]>([]);
  const [allUsers, setAllUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [userActionLoading, setUserActionLoading] = useState<string | null>(null);
  const [systemHealth, setSystemHealth] = useState<any>({});

  // Fetch stats, users, and system health
  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      // Date ranges
      const curr = getMonthRange(0);
      const prev = getMonthRange(-1);
      // Stats queries
      const [
        { count: userCurr },
        { count: userPrev },
        { count: postCurr },
        { count: postPrev },
        { count: msgCurr },
        { count: msgPrev },
        { count: fileCurr },
        { count: filePrev }
      ] = await Promise.all([
        supabase.from("profiles").select("id", { count: "exact", head: true }).gte("created_at", curr.start).lt("created_at", curr.end),
        supabase.from("profiles").select("id", { count: "exact", head: true }).gte("created_at", prev.start).lt("created_at", prev.end),
        supabase.from("posts").select("id", { count: "exact", head: true }).gte("created_at", curr.start).lt("created_at", curr.end),
        supabase.from("posts").select("id", { count: "exact", head: true }).gte("created_at", prev.start).lt("created_at", prev.end),
        supabase.from("chat_messages").select("id", { count: "exact", head: true }).gte("created_at", curr.start).lt("created_at", curr.end),
        supabase.from("chat_messages").select("id", { count: "exact", head: true }).gte("created_at", prev.start).lt("created_at", prev.end),
        supabase.from("filemodels").select("id", { count: "exact", head: true }).gte("created_at", curr.start).lt("created_at", curr.end),
        supabase.from("filemodels").select("id", { count: "exact", head: true }).gte("created_at", prev.start).lt("created_at", prev.end)
      ]);
      // Helper for percent
      const percent = (curr, prev) => {
        if (prev === 0) return curr > 0 ? 100 : 0;
        return Math.round(((curr - prev) / prev) * 100);
      };
      setStats([
        {
          title: "Total Users",
          value: userCurr ?? 0,
          change: percent(userCurr ?? 0, userPrev ?? 0),
          icon: Users,
          color: "text-blue-500"
        },
        {
          title: "Total Posts",
          value: postCurr ?? 0,
          change: percent(postCurr ?? 0, postPrev ?? 0),
          icon: FileText,
          color: "text-green-500"
        },
        {
          title: "Messages",
          value: msgCurr ?? 0,
          change: percent(msgCurr ?? 0, msgPrev ?? 0),
          icon: MessageCircle,
          color: "text-purple-500"
        },
        {
          title: "Files Uploaded",
          value: fileCurr ?? 0,
          change: percent(fileCurr ?? 0, filePrev ?? 0),
          icon: TrendingUp,
          color: "text-orange-500"
        }
      ]);
      // Recent users (last 5)
      const { data: usersData } = await supabase
        .from("profiles")
        .select("id, full_name, email, avatar_url, created_at, status")
        .order("created_at", { ascending: false })
        .limit(5);
      setRecentUsers(
        (usersData || []).map((user) => ({
          id: user.id,
          name: user.full_name || user.email,
          email: user.email,
          avatar: user.avatar_url,
          joinDate: new Date(user.created_at).toLocaleDateString(),
          status: user.status || "active"
        }))
      );
      // All users
      const { data: allUsersData } = await supabase
        .from("profiles")
        .select("id, full_name, email, avatar_url, created_at, status")
        .order("created_at", { ascending: false });
      setAllUsers(
        (allUsersData || []).map((user) => ({
          id: user.id,
          name: user.full_name || user.email,
          email: user.email,
          avatar: user.avatar_url,
          joinDate: new Date(user.created_at).toLocaleDateString(),
          status: user.status || "active"
        }))
      );
      // System health (initial, will be updated by polling)
      setSystemHealth({
        server: "Online",
        database: "Healthy",
        fileStorage: `${Math.min(100, Math.round(((fileCurr ?? 0) / 1000) * 100))}% Used`,
        apiResponse: "~120ms"
      });
      setLoading(false);
    };
    fetchData();
  }, []);

  // Real-time system health polling
  useEffect(() => {
    const pollSystemHealth = async () => {
      let server = "Online";
      let database = "Healthy";
      let fileStorage = "0% Used";
      let apiResponse = "-";
      const start = performance.now();
      try {
        // Lightweight query
        const { count, error } = await supabase.from("profiles").select("id", { count: "exact", head: true });
        const end = performance.now();
        apiResponse = `${Math.round(end - start)}ms`;
        if (error) {
          server = "Offline";
          database = "Unhealthy";
        } else {
          // File storage
          const { count: fileCount } = await supabase.from("filemodels").select("id", { count: "exact", head: true });
          fileStorage = `${Math.min(100, Math.round(((fileCount ?? 0) / 1000) * 100))}% Used`;
        }
      } catch {
        server = "Offline";
        database = "Unhealthy";
        apiResponse = "Timeout";
      }
      setSystemHealth({ server, database, fileStorage, apiResponse });
    };
    pollSystemHealth();
    const interval = setInterval(pollSystemHealth, 10000); // 10 seconds
    return () => clearInterval(interval);
  }, []);

  // User status actions
  const handleUserStatus = async (id: string, status: string) => {
    setUserActionLoading(id + status);
    const { error } = await supabase.from("profiles").update({ status }).eq("id", id);
    if (error) {
      console.error("Status update error:", error);
    }
    setAllUsers((users) =>
      users.map((u) => (u.id === id ? { ...u, status } : u))
    );
    setUserActionLoading(null);
  };
  // Remove user
  const handleRemoveUser = async (id: string) => {
    setUserActionLoading(id + "remove");
    await supabase.from("profiles").delete().eq("id", id);
    setAllUsers((users) => users.filter((u) => u.id !== id));
    setUserActionLoading(null);
  };

  if (loading || !stats) {
    return <div className="max-w-7xl mx-auto p-8 text-center">Loading dashboard...</div>;
  }

  return (
    <div className="max-w-7xl mx-auto space-y-6">
      <div>
        <h1 className="text-3xl font-bold">Admin Dashboard</h1>
        <p className="text-muted-foreground">Monitor and manage your Focus platform</p>
      </div>
      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {stats.map((stat, index) => (
          <Card key={index}>
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground">{stat.title}</p>
                  <p className="text-3xl font-bold">{stat.value}</p>
                  <p className={
                    `text-sm flex items-center gap-1 ` +
                    (stat.change >= 0 ? "text-green-600" : "text-red-600")
                  }>
                    {stat.change >= 0 ? <ArrowUpRight className="inline h-4 w-4" /> : <ArrowDownRight className="inline h-4 w-4" />}
                    {Math.abs(stat.change)}% {stat.change >= 0 ? "from last month" : "decrease from last month"}
                  </p>
                </div>
                <stat.icon className={`h-12 w-12 ${stat.color}`} />
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
      {/* Main Content */}
      <Tabs defaultValue="overview" className="space-y-6">
        <TabsList>
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="users">Users</TabsTrigger>
          <TabsTrigger value="content">Content</TabsTrigger>
          <TabsTrigger value="reports">Reports</TabsTrigger>
        </TabsList>
        <TabsContent value="overview" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/* Recent Activity (placeholder) */}
            <Card>
              <CardHeader>
                <CardTitle>Recent Activity</CardTitle>
                <CardDescription>Latest platform activities</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4 text-muted-foreground">(Coming soon)</div>
              </CardContent>
            </Card>
            {/* System Health */}
            <Card>
              <CardHeader>
                <CardTitle>System Health</CardTitle>
                <CardDescription>Platform status and performance</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <span className="text-sm">Server Status</span>
                    <Badge className="bg-green-500">{systemHealth.server}</Badge>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-sm">Database</span>
                    <Badge className="bg-green-500">{systemHealth.database}</Badge>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-sm">File Storage</span>
                    <Badge className="bg-yellow-500">{systemHealth.fileStorage}</Badge>
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-sm">API Response Time</span>
                    <Badge variant="outline">{systemHealth.apiResponse}</Badge>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>
        <TabsContent value="users">
          <Card>
            <CardHeader>
              <CardTitle>User Management</CardTitle>
              <CardDescription>Manage platform users and their permissions</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4 max-h-[500px] overflow-y-auto pr-2">
                {allUsers.map((user) => (
                  <div key={user.id} className="flex items-center justify-between p-4 border rounded-lg">
                    <div className="flex items-center gap-4">
                      <Avatar>
                        <AvatarImage src={user.avatar} />
                        <AvatarFallback>{user.name.charAt(0)}</AvatarFallback>
                      </Avatar>
                      <div>
                        <h4 className="font-semibold">{user.name}</h4>
                        <p className="text-sm text-muted-foreground">{user.email}</p>
                        <p className="text-xs text-muted-foreground">Joined {user.joinDate}</p>
                        <p className="text-xs">Status: <Badge variant={user.status === "active" ? "default" : user.status === "banned" ? "destructive" : "secondary"}>{user.status}</Badge></p>
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      {user.status !== "banned" && (
                        <Button size="sm" variant="destructive" disabled={userActionLoading === user.id + "banned"} onClick={() => handleUserStatus(user.id, "banned")}>Ban</Button>
                      )}
                      {user.status !== "inactive" && (
                        <Button size="sm" variant="secondary" disabled={userActionLoading === user.id + "inactive"} onClick={() => handleUserStatus(user.id, "inactive")}>Deactivate</Button>
                      )}
                      {user.status !== "active" && (
                        <Button size="sm" variant="default" disabled={userActionLoading === user.id + "active"} onClick={() => handleUserStatus(user.id, "active")}>Activate</Button>
                      )}
                      <Button size="sm" variant="ghost" disabled={userActionLoading === user.id + "remove"} onClick={() => handleRemoveUser(user.id)}>Remove</Button>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
        <TabsContent value="content">
          <Card>
            <CardHeader>
              <CardTitle>Flagged Content</CardTitle>
              <CardDescription>Content flagged by users for review</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-muted-foreground">(Coming soon)</div>
            </CardContent>
          </Card>
        </TabsContent>
        <TabsContent value="reports">
          <Card>
            <CardHeader>
              <CardTitle>Reports</CardTitle>
              <CardDescription>Review all recent reports</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-muted-foreground">(Coming soon)</div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default AdminDashboard;
