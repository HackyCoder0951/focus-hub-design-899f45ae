import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Heart, MessageCircle, Share, Image as ImageIcon } from "lucide-react";
import PostCard from "@/components/PostCard";
import CreatePost from "@/components/CreatePost";
import { supabase } from "@/integrations/supabase/client";

const Feed = () => {
  const [posts, setPosts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchPosts = async () => {
      const { data, error } = await supabase
        .from('posts')
        .select('*, profiles: user_id (full_name, avatar_url, email)')
        .order('created_at', { ascending: false });
      if (!error && data) setPosts(data);
      setLoading(false);
    };
    fetchPosts();
  }, []);

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      <CreatePost />
      <div className="space-y-6">
        {loading ? (
          <div className="text-center py-10">Loading...</div>
        ) : posts.length === 0 ? (
          <div className="text-center py-10 text-muted-foreground">No posts yet.</div>
        ) : (
          posts.map((post) => (
            <PostCard key={post.id} post={post} />
          ))
        )}
      </div>
      <div className="text-center py-8">
        <p className="text-muted-foreground">You're all caught up! 🎉</p>
      </div>
    </div>
  );
};

export default Feed;
