import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Dialog, DialogTrigger, DialogContent, DialogTitle } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { Loader2, Flag } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";

interface FlagFeatureProps {
  postId: string;
  postOwnerId: string;
  disabled?: boolean;
}

const FlagFeature = ({ postId, postOwnerId, disabled }: FlagFeatureProps) => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [flagDialogOpen, setFlagDialogOpen] = useState(false);
  const [flagReason, setFlagReason] = useState("");
  const [flagLoading, setFlagLoading] = useState(false);
  const [hasFlagged, setHasFlagged] = useState(false);

  // Check if user has already flagged this post (optional: can be added with useEffect)

  const handleFlagPost = async () => {
    if (!user) {
      toast({
        title: "Authentication required",
        description: "Please sign in to flag posts.",
        variant: "destructive",
      });
      return;
    }
    setFlagLoading(true);
    // Prevent duplicate flags
    const { data: existing } = await supabase
      .from("content_flags")
      .select("id")
      .eq("post_id", postId)
      .eq("flagged_by_user_id", user.id)
      .single();
    if (existing) {
      toast({
        title: "Already flagged",
        description: "You have already flagged this post.",
        variant: "default",
      });
      setFlagLoading(false);
      setFlagDialogOpen(false);
      setHasFlagged(true);
      return;
    }
    // Insert flag
    const { error } = await supabase.from("content_flags").insert({
      post_id: postId,
      flagged_by_user_id: user.id,
      reason: flagReason,
    });
    // Notify all admins and post owner (except flagger)
    const { data: admins } = await supabase
      .from("user_roles")
      .select("user_id")
      .eq("role", "admin");
    const recipients = [
      ...(admins?.map(a => a.user_id) || []),
      postOwnerId
    ].filter(uid => uid && uid !== user.id);
    const notifications = recipients.map((uid) => ({
      user_id: uid,
      type: "flagged_post",
      data: {
        post_id: postId,
        flagged_by: user.id,
        reason: flagReason,
        text: `A post you own or moderate was flagged by a user.`
      },
      is_read: false
    }));
    if (notifications.length > 0) {
      await supabase.from("notifications").insert(notifications);
    }
    setFlagLoading(false);
    setFlagDialogOpen(false);
    setFlagReason("");
    if (error) {
      toast({
        title: "Error",
        description: "Failed to flag post. Please try again.",
        variant: "destructive",
      });
    } else {
      toast({
        title: "Post flagged",
        description: "Thank you for reporting. Our team will review this post.",
      });
      setHasFlagged(true);
    }
  };

  return (
    <Dialog open={flagDialogOpen} onOpenChange={setFlagDialogOpen}>
      <DialogTrigger asChild>
        <Button variant="ghost" size="sm" className="flex items-center gap-2 text-yellow-600" onClick={() => setFlagDialogOpen(true)} disabled={disabled || hasFlagged}>
          <Flag className="h-4 w-4" />
          Flag
        </Button>
      </DialogTrigger>
      <DialogContent>
        <DialogTitle>Report this post</DialogTitle>
        <p className="text-sm text-muted-foreground mb-2">Please let us know why you are flagging this post (optional):</p>
        <Textarea
          value={flagReason}
          onChange={e => setFlagReason(e.target.value)}
          placeholder="Reason (optional)"
          rows={3}
        />
        <div className="flex gap-2 mt-4">
          <Button onClick={handleFlagPost} disabled={flagLoading}>
            {flagLoading ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : null}
            Submit
          </Button>
          <Button variant="outline" onClick={() => setFlagDialogOpen(false)} disabled={flagLoading}>Cancel</Button>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default FlagFeature; 