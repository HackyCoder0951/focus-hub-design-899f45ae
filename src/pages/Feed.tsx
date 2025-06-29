import { useEffect, useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Heart, MessageCircle, Share, Image as ImageIcon } from "lucide-react";
import PostCard from "@/components/PostCard";
import CreatePost from "@/components/CreatePost";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

const Feed = () => {
  const [posts, setPosts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const { user } = useAuth();

  const fetchPosts = async () => {
    setLoading(true);
    try {
      // Fetch posts with user profiles and like counts
      const { data, error } = await supabase
        .from('posts')
        .select(`
          *,
          profiles: user_id (
            full_name,
            avatar_url,
            email
          ),
          likes_count:likes(count)
        `)
        .eq('is_deleted', false)
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Error fetching posts:', error);
        return;
      }

      // Transform the data to include likes count
      const transformedPosts = data?.map(post => ({
        ...post,
        likes_count: post.likes_count?.[0]?.count || 0
      })) || [];

      setPosts(transformedPosts);
    } catch (error) {
      console.error('Error fetching posts:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchPosts();

    // Set up real-time subscriptions
    const postsSubscription = supabase
      .channel('posts_changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'posts',
          filter: 'is_deleted=eq.false'
        },
        (payload) => {
          console.log('Posts change:', payload);
          fetchPosts(); // Refresh posts when there are changes
        }
      )
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'likes'
        },
        (payload) => {
          console.log('Likes change:', payload);
          fetchPosts(); // Refresh posts when likes change
        }
      )
      .subscribe();

    // Cleanup subscription on unmount
    return () => {
      supabase.removeChannel(postsSubscription);
    };
  }, []);

  const handlePostCreated = () => {
    fetchPosts();
  };

  const handlePostUpdated = () => {
    fetchPosts();
  };

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      {user && <CreatePost onPostCreated={handlePostCreated} />}
      <div className="space-y-6">
        {loading ? (
          <div className="text-center py-10">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary mx-auto"></div>
            <p className="mt-2 text-muted-foreground">Loading posts...</p>
          </div>
        ) : posts.length === 0 ? (
          <Card>
            <CardContent className="text-center py-10">
              <div className="text-muted-foreground">
                {user ? "No posts yet. Be the first to share something!" : "Sign in to see posts and share your thoughts."}
              </div>
            </CardContent>
          </Card>
        ) : (
          posts.map((post) => (
            <PostCard 
              key={post.id} 
              post={post} 
              onPostUpdated={handlePostUpdated}
            />
          ))
        )}
      </div>
      {posts.length > 0 && (
        <div className="text-center py-8">
          <p className="text-muted-foreground">You're all caught up! 🎉</p>
        </div>
      )}
    </div>
  );
};

export default Feed;
