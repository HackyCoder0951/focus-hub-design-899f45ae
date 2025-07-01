import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { supabase } from "@/integrations/supabase/client";

const FollowingList = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [following, setFollowing] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const searchParams = new URLSearchParams(location.search);
  const userId = searchParams.get("user_id");

  useEffect(() => {
    const fetchFollowing = async () => {
      setLoading(true);
      const { data, error } = await supabase
        .from('followers')
        .select('following_id, following_profile:profiles!following_id(full_name, avatar_url)')
        .eq('follower_id', userId)
        .order('created_at', { ascending: false });
      setFollowing(data || []);
      setLoading(false);
    };
    if (userId) fetchFollowing();
  }, [userId]);

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
                <li key={item.following_id} className="flex items-center gap-3">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src={item.following_profile?.avatar_url} />
                    <AvatarFallback>{item.following_profile?.full_name?.charAt(0) || "?"}</AvatarFallback>
                  </Avatar>
                  <a
                    href={`/app/profile?user_id=${item.following_id}`}
                    className="hover:underline text-primary font-medium"
                  >
                    {item.following_profile?.full_name || item.following_id}
                  </a>
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