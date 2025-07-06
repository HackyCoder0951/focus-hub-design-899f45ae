import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";

interface FlaggedContentItem {
  id: string;
  type: string;
  content: string | null;
  author: string;
  reports: number;
  date: string;
  reason: string | null;
  status: string;
  postId: string | null;
}

const FlaggedContentAdmin = () => {
  const [flaggedContent, setFlaggedContent] = useState<FlaggedContentItem[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchFlagged = async () => {
      setLoading(true);
      const { data: flagsData } = await supabase
        .from("content_flags")
        .select("id, flagged_by_user_id, post_id, comment_id, reason, created_at, status")
        .order("created_at", { ascending: false })
        .limit(20);
      const flagged = await Promise.all(
        (flagsData || []).map(async (flag) => {
          let content = null;
          let type = "";
          let author = "";
          if (flag.post_id) {
            const { data: postData } = await supabase
              .from("posts")
              .select("content, user_id")
              .eq("id", flag.post_id)
              .single();
            content = postData?.content;
            type = "post";
            if (postData?.user_id) {
              const { data: userData } = await supabase
                .from("profiles")
                .select("full_name, email")
                .eq("id", postData.user_id)
                .single();
              author = userData?.full_name || userData?.email || "Unknown";
            }
          } else if (flag.comment_id) {
            const { data: commentData } = await supabase
              .from("comments")
              .select("content, user_id")
              .eq("id", flag.comment_id)
              .single();
            content = commentData?.content;
            type = "comment";
            if (commentData?.user_id) {
              const { data: userData } = await supabase
                .from("profiles")
                .select("full_name, email")
                .eq("id", commentData.user_id)
                .single();
              author = userData?.full_name || userData?.email || "Unknown";
            }
          }
          return {
            id: flag.id,
            type,
            content,
            author,
            reports: 1,
            date: new Date(flag.created_at).toLocaleString(),
            reason: flag.reason,
            status: flag.status || 'pending',
            postId: flag.post_id
          };
        })
      );
      setFlaggedContent(flagged);
      setLoading(false);
    };
    fetchFlagged();
  }, []);

  const handleFlagAction = async (flagId: string, action: string, postId: string | null) => {
    if (action === 'delete' && postId) {
      await supabase.from('posts').update({ is_deleted: true }).eq('id', postId);
    } else {
      await supabase.from('content_flags').update({ status: action }).eq('id', flagId);
      if ((action === 'resolved' || action === 'dismissed') && postId) {
        await supabase.from('posts').update({ flag_status: 'reviewed' }).eq('id', postId);
      }
    }
    // Refresh flagged content
    const { data: flagsData } = await supabase
      .from("content_flags")
      .select("id, flagged_by_user_id, post_id, comment_id, reason, created_at, status")
      .order("created_at", { ascending: false })
      .limit(20);
    const flagged = await Promise.all(
      (flagsData || []).map(async (flag) => {
        let content = null;
        let type = "";
        let author = "";
        if (flag.post_id) {
          const { data: postData } = await supabase
            .from("posts")
            .select("content, user_id")
            .eq("id", flag.post_id)
            .single();
          content = postData?.content;
          type = "post";
          if (postData?.user_id) {
            const { data: userData } = await supabase
              .from("profiles")
              .select("full_name, email")
              .eq("id", postData.user_id)
              .single();
            author = userData?.full_name || userData?.email || "Unknown";
          }
        } else if (flag.comment_id) {
          const { data: commentData } = await supabase
            .from("comments")
            .select("content, user_id")
            .eq("id", flag.comment_id)
            .single();
          content = commentData?.content;
          type = "comment";
          if (commentData?.user_id) {
            const { data: userData } = await supabase
              .from("profiles")
              .select("full_name, email")
              .eq("id", commentData.user_id)
              .single();
            author = userData?.full_name || userData?.email || "Unknown";
          }
        }
        return {
          id: flag.id,
          type,
          content,
          author,
          reports: 1,
          date: new Date(flag.created_at).toLocaleString(),
          reason: flag.reason,
          status: flag.status || 'pending',
          postId: flag.post_id
        };
      })
    );
    setFlaggedContent(flagged);
  };

  if (loading) {
    return <div className="p-8 text-center">Loading flagged content...</div>;
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Flagged Content</CardTitle>
        <CardDescription>Content flagged by users for review</CardDescription>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {flaggedContent.length === 0 ? (
            <div className="text-muted-foreground">No flagged content.</div>
          ) : (
            flaggedContent.map((item) => (
              <div key={item.id} className="p-4 border rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-semibold capitalize">{item.type}</span>
                  <span className="text-xs text-muted-foreground">{item.date}</span>
                </div>
                <div className="mb-2 text-sm">{item.content}</div>
                <div className="flex items-center gap-2 text-xs text-muted-foreground mb-2">
                  <span>By: {item.author}</span>
                  {item.reason && <span>• Reason: {item.reason}</span>}
                  <Badge variant={item.status === 'pending' ? 'secondary' : item.status === 'resolved' ? 'default' : 'outline'}>{item.status}</Badge>
                </div>
                <div className="flex gap-2 mt-2">
                  {item.status === 'pending' && (
                    <>
                      <Button size="sm" variant="default" onClick={() => handleFlagAction(item.id, 'resolved', item.postId)}>Resolve</Button>
                      <Button size="sm" variant="secondary" onClick={() => handleFlagAction(item.id, 'dismissed', item.postId)}>Dismiss</Button>
                      {item.type === 'post' && <Button size="sm" variant="destructive" onClick={() => handleFlagAction(item.id, 'delete', item.postId)}>Delete Post</Button>}
                    </>
                  )}
                </div>
              </div>
            ))
          )}
        </div>
      </CardContent>
    </Card>
  );
};

export default FlaggedContentAdmin; 