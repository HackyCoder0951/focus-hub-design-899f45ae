import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";

const FollowersStats = ({ profileUserId }: { profileUserId: string }) => {
  const [followers, setFollowers] = useState(0);
  const [following, setFollowing] = useState(0);

  useEffect(() => {
    const fetchStats = async () => {
      const [{ count: followersCount }, { count: followingCount }] = await Promise.all([
        supabase
          .from('followers')
          .select('*', { count: 'exact', head: true })
          .eq('following_id', profileUserId),
        supabase
          .from('followers')
          .select('*', { count: 'exact', head: true })
          .eq('follower_id', profileUserId)
      ]);
      setFollowers(followersCount || 0);
      setFollowing(followingCount || 0);
    };
    fetchStats();
  }, [profileUserId]);

  return (
    <>
      <span><b>{followers}</b> Followers</span>
      <span><b>{following}</b> Following</span>
    </>
  );
};

export default FollowersStats; 