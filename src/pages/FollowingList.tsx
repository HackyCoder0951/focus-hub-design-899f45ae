import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

const FollowingList = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { user } = useAuth();
  const [following, setFollowing] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [followingIds, setFollowingIds] = useState<string[]>([]);
  const [actionLoading, setActionLoading] = useState<string | null>(null);

  const searchParams = new URLSearchParams(location.search);
  const userId = searchParams.get("user_id");

  useEffect(() => {
    const fetchFollowing = async () => {
      setLoading(true);
      // Step 1: Get following IDs
      const { data: followingRows } = await supabase
        .from('followers')
        .select('following_id')
        .eq('follower_id', userId)
        .order('created_at', { ascending: false });
      if (!followingRows || followingRows.length === 0) {
        setFollowing([]);
        setLoading(false);
        return;
      }
      const ids = followingRows.map((row: any) => row.following_id);
      // Step 2: Fetch profiles for those IDs
      const { data: profiles } = await supabase
        .from('profiles')
        .select('id, full_name, avatar_url, bio')
        .in('id', ids);
      // Merge profiles with IDs (keep order)
      const merged = ids.map((id: string) => profiles?.find((p: any) => p.id === id) || { id });
      setFollowing(merged);
      setLoading(false);
    };
    if (userId) fetchFollowing();
  }, [userId]);

  useEffect(() => {
    // Fetch who the logged-in user is following
    const fetchFollowing = async () => {
      if (!user) return;
      const { data } = await supabase
        .from('followers')
        .select('following_id')
        .eq('follower_id', user.id);
      setFollowingIds(data ? data.map((row: any) => row.following_id) : []);
    };
    fetchFollowing();
  }, [user]);

  const handleFollowToggle = async (targetId: string, isFollowing: boolean) => {
    if (!user) return;
    setActionLoading(targetId);
    if (isFollowing) {
      // Unfollow
      await supabase
        .from('followers')
        .delete()
        .eq('follower_id', user.id)
        .eq('following_id', targetId);
      setFollowingIds((prev) => prev.filter((id) => id !== targetId));
    } else {
      // Follow
      await supabase
        .from('followers')
        .insert({ follower_id: user.id, following_id: targetId });
      setFollowingIds((prev) => [...prev, targetId]);
    }
    setActionLoading(null);
  };

  return (
    <div className="max-w-2xl mx-auto py-8 space-y-6">
      <Card>
        <CardHeader className="flex flex-row items-center justify-between">
          <CardTitle>Following</CardTitle>
          <Button variant="outline" onClick={() => navigate(-1)}>Back</Button>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div>Loading...</div>
          ) : following.length === 0 ? (
            <div className="text-muted-foreground">No following found.</div>
          ) : (
            <ul className="space-y-3">
              {following.map((item: any) => (
                <li key={item.id} className="flex items-center justify-between gap-4 p-3 border-b last:border-b-0">
                  <div className="flex items-center gap-4 min-w-0">
                    <Avatar className="h-12 w-12">
                      <AvatarImage src={item.avatar_url} />
                      <AvatarFallback>{item.full_name?.charAt(0) || "?"}</AvatarFallback>
                    </Avatar>
                    <div className="min-w-0">
                      <a
                        href={`/app/profile?user_id=${item.id}`}
                        className="hover:underline text-primary font-semibold block truncate"
                      >
                        {item.full_name || item.id}
                      </a>
                      <div className="text-xs text-muted-foreground truncate max-w-xs">{item.bio || ""}</div>
                    </div>
                  </div>
                  {user && user.id !== item.id && (
                    <Button
                      variant={followingIds.includes(item.id) ? "outline" : "default"}
                      size="sm"
                      disabled={actionLoading === item.id}
                      onClick={() => handleFollowToggle(item.id, followingIds.includes(item.id))}
                    >
                      {actionLoading === item.id
                        ? "..."
                        : followingIds.includes(item.id)
                        ? "Following"
                        : "Follow"}
                    </Button>
                  )}
                </li>
              ))}
            </ul>
          )}
        </CardContent>
      </Card>
    </div>
  );
};

export default FollowingList; 