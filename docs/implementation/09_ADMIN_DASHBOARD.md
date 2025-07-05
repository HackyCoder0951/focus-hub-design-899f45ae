# Admin Dashboard Implementation

## Overview

The Admin Dashboard provides comprehensive administrative tools for user management, content moderation, system analytics, and platform oversight.

## Core Components

### 1. Admin Dashboard Page

**File**: `src/pages/AdminDashboard.tsx`
```typescript
import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Badge } from '@/components/ui/badge';
import { Users, Flag, BarChart3, Settings, Shield } from 'lucide-react';
import { UserManagement } from '@/components/admin/UserManagement';
import { ContentModeration } from '@/components/admin/ContentModeration';
import { SystemAnalytics } from '@/components/admin/SystemAnalytics';
import { useToast } from '@/hooks/use-toast';

interface DashboardStats {
  totalUsers: number;
  activeUsers: number;
  bannedUsers: number;
  totalPosts: number;
  flaggedContent: number;
  totalQuestions: number;
  answeredQuestions: number;
}

const AdminDashboard = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchStats = async () => {
    try {
      // Fetch user statistics
      const { count: totalUsers } = await supabase
        .from('profiles')
        .select('*', { count: 'exact', head: true });

      const { count: activeUsers } = await supabase
        .from('profiles')
        .select('*', { count: 'exact', head: true })
        .eq('status', 'active');

      const { count: bannedUsers } = await supabase
        .from('profiles')
        .select('*', { count: 'exact', head: true })
        .eq('status', 'banned');

      // Fetch content statistics
      const { count: totalPosts } = await supabase
        .from('posts')
        .select('*', { count: 'exact', head: true })
        .eq('is_deleted', false);

      const { count: flaggedContent } = await supabase
        .from('content_flags')
        .select('*', { count: 'exact', head: true })
        .eq('status', 'pending');

      const { count: totalQuestions } = await supabase
        .from('questionanswers')
        .select('*', { count: 'exact', head: true });

      const { count: answeredQuestions } = await supabase
        .from('questionanswers')
        .select('*', { count: 'exact', head: true })
        .eq('is_answered', true);

      setStats({
        totalUsers: totalUsers || 0,
        activeUsers: activeUsers || 0,
        bannedUsers: bannedUsers || 0,
        totalPosts: totalPosts || 0,
        flaggedContent: flaggedContent || 0,
        totalQuestions: totalQuestions || 0,
        answeredQuestions: answeredQuestions || 0,
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load dashboard statistics",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchStats();
  }, []);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Admin Dashboard</h1>
          <p className="text-muted-foreground">
            Manage users, moderate content, and monitor platform activity
          </p>
        </div>
        <Badge variant="secondary" className="bg-blue-100 text-blue-800">
          <Shield className="h-4 w-4 mr-1" />
          Administrator
        </Badge>
      </div>

      {/* Statistics Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Users</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalUsers}</div>
            <p className="text-xs text-muted-foreground">
              {stats?.activeUsers} active, {stats?.bannedUsers} banned
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Posts</CardTitle>
            <BarChart3 className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalPosts}</div>
            <p className="text-xs text-muted-foreground">
              Platform content
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Flagged Content</CardTitle>
            <Flag className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.flaggedContent}</div>
            <p className="text-xs text-muted-foreground">
              Pending review
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Q&A Activity</CardTitle>
            <BarChart3 className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalQuestions}</div>
            <p className="text-xs text-muted-foreground">
              {stats?.answeredQuestions} answered
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Admin Tabs */}
      <Tabs defaultValue="users" className="space-y-4">
        <TabsList>
          <TabsTrigger value="users">
            <Users className="h-4 w-4 mr-2" />
            User Management
          </TabsTrigger>
          <TabsTrigger value="moderation">
            <Flag className="h-4 w-4 mr-2" />
            Content Moderation
          </TabsTrigger>
          <TabsTrigger value="analytics">
            <BarChart3 className="h-4 w-4 mr-2" />
            Analytics
          </TabsTrigger>
        </TabsList>

        <TabsContent value="users" className="space-y-4">
          <UserManagement onUserUpdated={fetchStats} />
        </TabsContent>

        <TabsContent value="moderation" className="space-y-4">
          <ContentModeration onContentModerated={fetchStats} />
        </TabsContent>

        <TabsContent value="analytics" className="space-y-4">
          <SystemAnalytics />
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default AdminDashboard;
```

### 2. User Management Component

**File**: `src/components/admin/UserManagement.tsx`
```typescript
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Search, MoreHorizontal, Shield, UserX, UserCheck } from 'lucide-react';
import { formatDistanceToNow } from 'date-fns';
import { useToast } from '@/hooks/use-toast';

interface User {
  id: string;
  email: string;
  full_name: string | null;
  avatar_url: string | null;
  status: string | null;
  member_type: string | null;
  created_at: string;
  last_seen: string | null;
  user_roles: { role: string }[];
}

interface UserManagementProps {
  onUserUpdated: () => void;
}

export const UserManagement = ({ onUserUpdated }: UserManagementProps) => {
  const { toast } = useToast();
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState<string>('all');

  const fetchUsers = async () => {
    try {
      let query = supabase
        .from('profiles')
        .select(`
          *,
          user_roles (role)
        `)
        .order('created_at', { ascending: false });

      if (statusFilter !== 'all') {
        query = query.eq('status', statusFilter);
      }

      if (searchQuery.trim()) {
        query = query.or(`full_name.ilike.%${searchQuery}%,email.ilike.%${searchQuery}%`);
      }

      const { data, error } = await query;

      if (error) throw error;
      setUsers(data || []);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load users",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, [statusFilter, searchQuery]);

  const handleStatusChange = async (userId: string, newStatus: string) => {
    try {
      const { error } = await supabase
        .from('profiles')
        .update({ status: newStatus })
        .eq('id', userId);

      if (error) throw error;

      setUsers(prev => 
        prev.map(user => 
          user.id === userId ? { ...user, status: newStatus } : user
        )
      );

      onUserUpdated();

      toast({
        title: "Success",
        description: `User status updated to ${newStatus}`,
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to update user status",
        variant: "destructive",
      });
    }
  };

  const handleRoleChange = async (userId: string, newRole: string) => {
    try {
      const { error } = await supabase
        .from('user_roles')
        .upsert({
          user_id: userId,
          role: newRole
        });

      if (error) throw error;

      setUsers(prev => 
        prev.map(user => 
          user.id === userId 
            ? { ...user, user_roles: [{ role: newRole }] }
            : user
        )
      );

      toast({
        title: "Success",
        description: `User role updated to ${newRole}`,
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to update user role",
        variant: "destructive",
      });
    }
  };

  const getStatusBadge = (status: string | null) => {
    switch (status) {
      case 'active':
        return <Badge className="bg-green-100 text-green-800">Active</Badge>;
      case 'banned':
        return <Badge variant="destructive">Banned</Badge>;
      case 'inactive':
        return <Badge variant="secondary">Inactive</Badge>;
      default:
        return <Badge variant="outline">Unknown</Badge>;
    }
  };

  const getRoleBadge = (roles: { role: string }[]) => {
    const role = roles[0]?.role;
    return role === 'admin' 
      ? <Badge className="bg-blue-100 text-blue-800"><Shield className="h-3 w-3 mr-1" />Admin</Badge>
      : <Badge variant="outline">User</Badge>;
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle>User Management</CardTitle>
        <div className="flex items-center space-x-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-muted-foreground h-4 w-4" />
            <Input
              placeholder="Search users..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-10"
            />
          </div>
          <Select value={statusFilter} onValueChange={setStatusFilter}>
            <SelectTrigger className="w-40">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Status</SelectItem>
              <SelectItem value="active">Active</SelectItem>
              <SelectItem value="inactive">Inactive</SelectItem>
              <SelectItem value="banned">Banned</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {users.map((user) => (
            <div key={user.id} className="flex items-center justify-between p-4 border rounded-lg">
              <div className="flex items-center space-x-4">
                <Avatar>
                  <AvatarImage src={user.avatar_url} />
                  <AvatarFallback>
                    {user.full_name?.charAt(0) || 'U'}
                  </AvatarFallback>
                </Avatar>
                
                <div>
                  <p className="font-medium">{user.full_name || 'No name'}</p>
                  <p className="text-sm text-muted-foreground">{user.email}</p>
                  <div className="flex items-center space-x-2 mt-1">
                    {getStatusBadge(user.status)}
                    {getRoleBadge(user.user_roles)}
                    <Badge variant="outline">{user.member_type}</Badge>
                  </div>
                </div>
              </div>

              <div className="flex items-center space-x-2">
                <div className="text-right">
                  <p className="text-sm text-muted-foreground">
                    Joined {formatDistanceToNow(new Date(user.created_at), { addSuffix: true })}
                  </p>
                  {user.last_seen && (
                    <p className="text-xs text-muted-foreground">
                      Last seen {formatDistanceToNow(new Date(user.last_seen), { addSuffix: true })}
                    </p>
                  )}
                </div>

                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="sm">
                      <MoreHorizontal className="h-4 w-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end">
                    <DropdownMenuItem onClick={() => handleStatusChange(user.id, 'active')}>
                      <UserCheck className="h-4 w-4 mr-2" />
                      Activate
                    </DropdownMenuItem>
                    <DropdownMenuItem onClick={() => handleStatusChange(user.id, 'inactive')}>
                      <UserX className="h-4 w-4 mr-2" />
                      Deactivate
                    </DropdownMenuItem>
                    <DropdownMenuItem onClick={() => handleStatusChange(user.id, 'banned')}>
                      <UserX className="h-4 w-4 mr-2" />
                      Ban User
                    </DropdownMenuItem>
                    <DropdownMenuItem onClick={() => handleRoleChange(user.id, 'admin')}>
                      <Shield className="h-4 w-4 mr-2" />
                      Make Admin
                    </DropdownMenuItem>
                    <DropdownMenuItem onClick={() => handleRoleChange(user.id, 'user')}>
                      <UserCheck className="h-4 w-4 mr-2" />
                      Make User
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>
            </div>
          ))}
        </div>
      </CardContent>
    </Card>
  );
};
```

### 3. Content Moderation Component

**File**: `src/components/admin/ContentModeration.tsx`
```typescript
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { CheckCircle, XCircle, Eye } from 'lucide-react';
import { formatDistanceToNow } from 'date-fns';
import { useToast } from '@/hooks/use-toast';

interface FlaggedContent {
  id: string;
  flagged_by_user_id: string;
  post_id: string | null;
  comment_id: string | null;
  reason: string | null;
  status: string | null;
  created_at: string;
  flagged_by: {
    full_name: string;
  };
  post?: {
    content: string;
    profiles: {
      full_name: string;
    };
  };
  comment?: {
    content: string;
    profiles: {
      full_name: string;
    };
  };
}

interface ContentModerationProps {
  onContentModerated: () => void;
}

export const ContentModeration = ({ onContentModerated }: ContentModerationProps) => {
  const { toast } = useToast();
  const [flaggedContent, setFlaggedContent] = useState<FlaggedContent[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchFlaggedContent = async () => {
    try {
      const { data, error } = await supabase
        .from('content_flags')
        .select(`
          *,
          flagged_by:profiles!flagged_by_user_id(full_name),
          post:posts(content, profiles(full_name)),
          comment:comments(content, profiles(full_name))
        `)
        .eq('status', 'pending')
        .order('created_at', { ascending: false });

      if (error) throw error;
      setFlaggedContent(data || []);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load flagged content",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchFlaggedContent();
  }, []);

  const handleModeration = async (flagId: string, action: 'approve' | 'delete') => {
    try {
      const flag = flaggedContent.find(f => f.id === flagId);
      if (!flag) return;

      if (action === 'delete') {
        // Delete the flagged content
        if (flag.post_id) {
          await supabase
            .from('posts')
            .update({ is_deleted: true })
            .eq('id', flag.post_id);
        } else if (flag.comment_id) {
          await supabase
            .from('comments')
            .delete()
            .eq('id', flag.comment_id);
        }
      }

      // Update flag status
      await supabase
        .from('content_flags')
        .update({ 
          status: action === 'approve' ? 'resolved' : 'actioned' 
        })
        .eq('id', flagId);

      // Remove from list
      setFlaggedContent(prev => prev.filter(f => f.id !== flagId));
      onContentModerated();

      toast({
        title: "Success",
        description: `Content ${action === 'approve' ? 'approved' : 'deleted'}`,
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to moderate content",
        variant: "destructive",
      });
    }
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle>Content Moderation</CardTitle>
        <p className="text-sm text-muted-foreground">
          Review and moderate flagged content
        </p>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {flaggedContent.map((flag) => (
            <div key={flag.id} className="border rounded-lg p-4">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center space-x-2 mb-2">
                    <Badge variant="destructive">Flagged</Badge>
                    <span className="text-sm text-muted-foreground">
                      by {flag.flagged_by?.full_name}
                    </span>
                    <span className="text-sm text-muted-foreground">
                      {formatDistanceToNow(new Date(flag.created_at), { addSuffix: true })}
                    </span>
                  </div>

                  <div className="bg-muted p-3 rounded mb-3">
                    <p className="text-sm font-medium mb-1">
                      {flag.post ? 'Post by ' + flag.post.profiles?.full_name : 'Comment by ' + flag.comment?.profiles?.full_name}:
                    </p>
                    <p className="text-sm">
                      {flag.post?.content || flag.comment?.content}
                    </p>
                  </div>

                  {flag.reason && (
                    <p className="text-sm text-muted-foreground">
                      <strong>Reason:</strong> {flag.reason}
                    </p>
                  )}
                </div>

                <div className="flex space-x-2 ml-4">
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => handleModeration(flag.id, 'approve')}
                  >
                    <CheckCircle className="h-4 w-4 mr-1" />
                    Approve
                  </Button>
                  <Button
                    size="sm"
                    variant="destructive"
                    onClick={() => handleModeration(flag.id, 'delete')}
                  >
                    <XCircle className="h-4 w-4 mr-1" />
                    Delete
                  </Button>
                </div>
              </div>
            </div>
          ))}

          {flaggedContent.length === 0 && !loading && (
            <div className="text-center py-8">
              <Eye className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
              <p className="text-muted-foreground">No flagged content to review</p>
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
};
```

## Database Schema

### Content Flags Table
```sql
CREATE TABLE content_flags (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  flagged_by_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  reason TEXT,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### User Roles Table
```sql
CREATE TABLE user_roles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  role app_role DEFAULT 'user',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Admin Functions

### 1. Role Check Function
```sql
CREATE OR REPLACE FUNCTION has_role(_user_id UUID, _role app_role)
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id
      AND role = _role
  )
$$ LANGUAGE sql STABLE SECURITY DEFINER;
```

### 2. Admin-Only RLS Policies
```sql
-- Admin can view all content
CREATE POLICY "Admin can view all content" ON posts
  FOR SELECT USING (
    has_role(auth.uid(), 'admin')
  );

-- Admin can delete any content
CREATE POLICY "Admin can delete any content" ON posts
  FOR DELETE USING (
    has_role(auth.uid(), 'admin')
  );

-- Admin can view all user profiles
CREATE POLICY "Admin can view all profiles" ON profiles
  FOR SELECT USING (
    has_role(auth.uid(), 'admin')
  );

-- Admin can update any profile
CREATE POLICY "Admin can update any profile" ON profiles
  FOR UPDATE USING (
    has_role(auth.uid(), 'admin')
  );
```

This admin dashboard provides comprehensive administrative tools for managing users, moderating content, and monitoring platform activity with proper role-based access controls. 