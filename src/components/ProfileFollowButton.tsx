import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { useAuth } from "@/contexts/AuthContext";

const ProfileFollowButton = ({ profileUserId }: { profileUserId: string }) => {
  const { user } = useAuth();
  const [isFollowing, setIsFollowing] = useState(false);

  useEffect(() => {
    const checkFollowing = async () => {
      if (!user) return;
      const { data } = await supabase
        .from('followers')
        .select('id')
        .eq('follower_id', user.id)
        .eq('following_id', profileUserId)
        .single();
      setIsFollowing(!!data);
    };
    checkFollowing();
  }, [user, profileUserId]);

  const handleFollow = async () => {
    if (!user) return;
    if (isFollowing) {
      await supabase.from('followers')
        .delete()
        .eq('follower_id', user.id)
        .eq('following_id', profileUserId);
      setIsFollowing(false);
    } else {
      await supabase.from('followers').insert({
        follower_id: user.id,
        following_id: profileUserId
      });
      setIsFollowing(true);
    }
  };

  if (!user || user.id === profileUserId) return null; // Don't show for self

  return (
    <Button onClick={handleFollow} variant={isFollowing ? "outline" : "default"}>
      {isFollowing ? "Unfollow" : "Follow"}
    </Button>
  );
};

export default ProfileFollowButton; 