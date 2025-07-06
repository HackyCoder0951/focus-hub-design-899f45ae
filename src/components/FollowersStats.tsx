import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { useNavigate } from "react-router-dom";
import { Tables } from "@/integrations/supabase/types";

interface FollowerItem {
  follower_id: string;
  profiles: {
    full_name: string | null;
    avatar_url: string | null;
  } | null;
}

interface FollowingItem {
  following_id: string;
  profiles: {
    full_name: string | null;
    avatar_url: string | null;
  } | null;
}

const FollowersStats = ({ profileUserId }: { profileUserId: string }) => {
  const [followers, setFollowers] = useState(0);
  const [following, setFollowing] = useState(0);
  const [showList, setShowList] = useState<null | "followers" | "following">(null);
  const [followersList, setFollowersList] = useState<FollowerItem[]>([]);
  const [followingList, setFollowingList] = useState<FollowingItem[]>([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

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

  const handleShowFollowers = async () => {
    setShowList(showList === "followers" ? null : "followers");
    if (showList !== "followers") {
      setLoading(true);
      const { data, error } = await supabase
        .from('followers')
        .select('follower_id, profiles!followers_follower_id_fkey(full_name, avatar_url)')
        .eq('following_id', profileUserId)
        .order('created_at', { ascending: false });
      setFollowersList(data || []);
      setLoading(false);
    }
  };

  const handleShowFollowing = async () => {
    setShowList(showList === "following" ? null : "following");
    if (showList !== "following") {
      setLoading(true);
      const { data, error } = await supabase
        .from('followers')
        .select('following_id, profiles!followers_following_id_fkey(full_name, avatar_url)')
        .eq('follower_id', profileUserId)
        .order('created_at', { ascending: false });
      setFollowingList(data || []);
      setLoading(false);
    }
  };

  return (
    <div>
      <span style={{ cursor: 'pointer', color: '#2563eb' }} onClick={() => navigate(`/app/followers?user_id=${profileUserId}`)}>
        <b>{followers}</b> Followers
      </span>
      {" "}
      <span style={{ cursor: 'pointer', color: '#2563eb' }} onClick={() => navigate(`/app/following?user_id=${profileUserId}`)}>
        <b>{following}</b> Following
      </span>
      {/* Followers List */}
      {showList === "followers" && (
        <div style={{ marginTop: 8 }}>
          <b>Followers List</b>
          {loading ? (
            <div>Loading...</div>
          ) : followersList.length === 0 ? (
            <div>No followers found.</div>
          ) : (
            <ul style={{ marginTop: 4 }}>
              {followersList.map((item: FollowerItem) => (
                <li key={item.follower_id} style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 4 }}>
                  {item.profiles?.avatar_url && (
                    <img src={item.profiles.avatar_url} alt="avatar" style={{ width: 24, height: 24, borderRadius: '50%' }} />
                  )}
                  <span>{item.profiles?.full_name || item.follower_id}</span>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
      {/* Following List */}
      {showList === "following" && (
        <div style={{ marginTop: 8 }}>
          <b>Following List</b>
          {loading ? (
            <div>Loading...</div>
          ) : followingList.length === 0 ? (
            <div>No following found.</div>
          ) : (
            <ul style={{ marginTop: 4 }}>
              {followingList.map((item: FollowingItem) => (
                <li key={item.following_id} style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 4 }}>
                  {item.profiles?.avatar_url && (
                    <img src={item.profiles.avatar_url} alt="avatar" style={{ width: 24, height: 24, borderRadius: '50%' }} />
                  )}
                  <span>{item.profiles?.full_name || item.following_id}</span>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  );
};

export default FollowersStats; 