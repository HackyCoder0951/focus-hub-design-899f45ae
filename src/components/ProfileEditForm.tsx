import { useState } from "react";
import {
  Dialog,
  DialogTrigger,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
  DialogClose,
  DialogDescription
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { supabase } from "@/integrations/supabase/client";

const ProfileEditForm = ({ profileData, onSave }: { profileData: any, onSave: () => void }) => {
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState({
    full_name: profileData.full_name || "",
    bio: profileData.bio || "",
    location: profileData.location || "",
    website: profileData.website || "",
    avatar_url: profileData.avatar_url || ""
  });
  const [loading, setLoading] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    await supabase
      .from('profiles')
      .update({
        full_name: form.full_name,
        bio: form.bio,
        location: form.location,
        website: form.website,
        avatar_url: form.avatar_url
      })
      .eq('id', profileData.id);
    setLoading(false);
    setOpen(false);
    onSave();
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="outline" size="sm">
          Edit Profile
        </Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Edit Profile</DialogTitle>
          <DialogDescription>Update your profile information below.</DialogDescription>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium mb-1">Full Name</label>
            <Input name="full_name" value={form.full_name} onChange={handleChange} required />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Bio</label>
            <Input name="bio" value={form.bio} onChange={handleChange} />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Location</label>
            <Input name="location" value={form.location} onChange={handleChange} />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Website</label>
            <Input name="website" value={form.website} onChange={handleChange} />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Avatar URL</label>
            <Input name="avatar_url" value={form.avatar_url} onChange={handleChange} />
          </div>
          <DialogFooter>
            <Button type="submit" disabled={loading}>{loading ? "Saving..." : "Save Changes"}</Button>
            <DialogClose asChild>
              <Button type="button" variant="outline">Cancel</Button>
            </DialogClose>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
};

export default ProfileEditForm; 