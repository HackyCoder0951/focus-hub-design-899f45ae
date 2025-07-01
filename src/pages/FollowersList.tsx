import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { supabase } from "@/integrations/supabase/client";

const FollowersList = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [followers, setFollowers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const searchParams = new URLSearchParams(location.search);
  const userId = searchParams.get("user_id");

  useEffect(() => {
    const fetchFollowers = async () => {
      setLoading(true);
      const { data, error } = await supabase
        .from('followers')
        .select('follower_id, follower_profile:profiles!follower_id(full_name, avatar_url)')
        .eq('following_id', userId)
        .order('created_at', { ascending: false });
      setFollowers(data || []);
      setLoading(false);
    };
    if (userId) fetchFollowers();
  }, [userId]);

  return (
    <div className="max-w-2xl mx-auto py-8 space-y-6">
      <Card>
        <CardHeader className="flex flex-row items-center justify-between">
          <CardTitle>Followers</CardTitle>
          <Button variant="outline" onClick={() => navigate(-1)}>Back</Button>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div>Loading...</div>
          ) : followers.length === 0 ? (
            <div className="text-muted-foreground">No followers found.</div>
          ) : (
            <ul className="space-y-3">
              {followers.map((item: any) => (
                <li key={item.follower_id} className="flex items-center gap-3">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src={item.follower_profile?.avatar_url} />
                    <AvatarFallback>{item.follower_profile?.full_name?.charAt(0) || "?"}</AvatarFallback>
                  </Avatar>
                  <a
                    href={`/app/profile?user_id=${item.follower_id}`}
                    className="hover:underline text-primary font-medium"
                  >
                    {item.follower_profile?.full_name || item.follower_id}
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

export default FollowersList; 