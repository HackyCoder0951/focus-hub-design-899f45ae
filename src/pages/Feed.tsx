
import { useState } from "react";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Heart, MessageCircle, Share, Image as ImageIcon } from "lucide-react";
import PostCard from "@/components/PostCard";
import CreatePost from "@/components/CreatePost";

const Feed = () => {
  const [posts] = useState([
    {
      id: 1,
      author: {
        name: "Sarah Johnson",
        username: "@sarah_j",
        avatar: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=40&h=40&fit=crop&crop=face"
      },
      content: "Just finished working on an amazing new project! The team collaboration was incredible. 🚀",
      image: "https://images.unsplash.com/photo-1649972904349-6e44c42644a7?w=600&h=400&fit=crop",
      timestamp: "2 hours ago",
      likes: 24,
      comments: 8,
      shares: 3
    },
    {
      id: 2,
      author: {
        name: "Alex Chen",
        username: "@alexc",
        avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=40&h=40&fit=crop&crop=face"
      },
      content: "Beautiful sunset from my office window today. Sometimes you need to pause and appreciate the small moments. 🌅",
      image: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&h=400&fit=crop",
      timestamp: "4 hours ago",
      likes: 156,
      comments: 23,
      shares: 12
    },
    {
      id: 3,
      author: {
        name: "Maria Garcia",
        username: "@maria_g",
        avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=40&h=40&fit=crop&crop=face"
      },
      content: "Excited to share my latest blog post about sustainable living practices. Link in bio! 🌱 #sustainability #greenliving",
      timestamp: "6 hours ago",
      likes: 89,
      comments: 15,
      shares: 7
    }
  ]);

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      <CreatePost />
      
      <div className="space-y-6">
        {posts.map((post) => (
          <PostCard key={post.id} post={post} />
        ))}
      </div>
      
      <div className="text-center py-8">
        <p className="text-muted-foreground">You're all caught up! 🎉</p>
      </div>
    </div>
  );
};

export default Feed;
