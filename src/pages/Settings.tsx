import { useState, useRef, useEffect } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Textarea } from "@/components/ui/textarea";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
// import { Badge } from "@/components/ui/badge";
import { Bell, Shield, User, Palette, Globe, Eye, EyeOff } from "lucide-react";
import { useTheme } from "@/components/theme-provider";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";

const Settings = () => {
  const [showCurrentPassword, setShowCurrentPassword] = useState(false);
  const [showNewPassword, setShowNewPassword] = useState(false);
  const { theme, setTheme } = useTheme();
  const { user, profile } = useAuth();
  const { toast } = useToast();
  const [avatarUploading, setAvatarUploading] = useState(false);
  const fileInputRef = useRef(null);

  const [profileData, setProfileData] = useState({
    name: "",
    email: "",
    bio: "",
    website: "",
    location: ""
  });

  // When profile loads, update the form fields
  useEffect(() => {
    if (profile) {
      setProfileData({
        name: profile.full_name || "",
        email: profile.email || user?.email || "",
        bio: profile.bio || "",
        website: profile.website || "",
        location: profile.location || ""
      });
    }
  }, [profile, user]);

  const [notifications, setNotifications] = useState({
    email: true,
    push: true,
    mentions: true,
    comments: true,
    follows: false,
    messages: true
  });

  const [privacy, setPrivacy] = useState({
    profilePublic: true,
    showEmail: false,
    showLocation: true,
    allowMessages: true
  });

  const handleSaveProfile = async () => {
    if (!user) return;
    const { error } = await supabase
      .from('profiles')
      .update({
        full_name: profileData.name,
        email: profileData.email,
        bio: profileData.bio,
        website: profileData.website,
        location: profileData.location,
        settings: {
          notifications,
          privacy
        }
      })
      .eq('id', user.id);
    if (error) {
      toast({ title: 'Profile update failed', description: error.message, variant: 'destructive' });
    } else {
      toast({ title: 'Profile updated', description: 'Your profile has been updated.' });
    }
  };

  const handleAvatarChange = async (e) => {
    const file = e.target.files?.[0];
    if (!file || !user) return;
    setAvatarUploading(true);
    try {
      const fileExt = file.name.split('.').pop();
      const fileName = `${user.id}/${Date.now()}.${fileExt}`;
      const { error: uploadError } = await supabase.storage
        .from('avatars')
        .upload(fileName, file, { upsert: true });
      if (uploadError) throw uploadError;
      const { data: urlData } = supabase.storage
        .from('avatars')
        .getPublicUrl(fileName);
      const { error: updateError } = await supabase
        .from('profiles')
        .update({ avatar_url: urlData.publicUrl })
        .eq('id', user.id);
      if (updateError) throw updateError;
      toast({ title: "Avatar updated!" });
      // Optionally update local profile state here
    } catch (err) {
      toast({ title: "Avatar upload failed", description: err.message, variant: "destructive" });
    } finally {
      setAvatarUploading(false);
    }
  };

  const handleRemoveAvatar = async () => {
    if (!user) return;
    const { error } = await supabase
      .from('profiles')
      .update({ avatar_url: null })
      .eq('id', user.id);
    if (error) {
      toast({ title: "Failed to remove avatar", description: error.message, variant: "destructive" });
    } else {
      toast({ title: "Avatar removed" });
      // Optionally update local profile state here
    }
  };

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div>
        <h1 className="text-3xl font-bold">Settings</h1>
        <p className="text-muted-foreground">Manage your account settings and preferences</p>
      </div>

      <Tabs defaultValue="profile" className="space-y-6">
        <TabsList className="grid w-full grid-cols-5">
          <TabsTrigger value="profile" className="flex items-center gap-2">
            <User className="h-4 w-4" />
            Profile
          </TabsTrigger>
          <TabsTrigger value="security" className="flex items-center gap-2">
            <Shield className="h-4 w-4" />
            Security
          </TabsTrigger>
          <TabsTrigger value="notifications" className="flex items-center gap-2">
            <Bell className="h-4 w-4" />
            Notifications
          </TabsTrigger>
          <TabsTrigger value="privacy" className="flex items-center gap-2">
            <Eye className="h-4 w-4" />
            Privacy
          </TabsTrigger>
          <TabsTrigger value="appearance" className="flex items-center gap-2">
            <Palette className="h-4 w-4" />
            Appearance
          </TabsTrigger>
        </TabsList>

        {/* Profile Settings */}
        <TabsContent value="profile">
          <Card>
            <CardHeader>
              <CardTitle>Profile Information</CardTitle>
              <CardDescription>Update your profile details and public information</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="flex items-center gap-6">
                <Avatar className="h-20 w-20">
                  <AvatarImage src={profile?.avatar_url || undefined} />
                  <AvatarFallback className="text-lg">{profile?.full_name ? profile.full_name[0] : 'U'}</AvatarFallback>
                </Avatar>
                <div className="space-y-2">
                  <h3 className="font-semibold">Profile Picture</h3>
                  <div className="flex gap-2 items-center">
                    <Button variant="outline" size="sm" asChild disabled={avatarUploading}>
                      <label>
                        {avatarUploading ? "Uploading..." : "Change Avatar"}
                        <input
                          type="file"
                          accept="image/*"
                          onChange={handleAvatarChange}
                          style={{ display: "none" }}
                          ref={fileInputRef}
                        />
                      </label>
                    </Button>
                    <Button variant="ghost" size="sm" onClick={handleRemoveAvatar} disabled={avatarUploading}>Remove</Button>
                  </div>
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="name">Full Name</Label>
                  <Input
                    id="name"
                    value={profileData.name}
                    onChange={(e) => setProfileData({...profileData, name: e.target.value})}
                    placeholder="Enter your full name"
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="email">Email</Label>
                  <Input
                    id="email"
                    type="email"
                    value={profileData.email}
                    onChange={(e) => setProfileData({...profileData, email: e.target.value})}
                    placeholder="Enter your email"
                  />
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="bio">Bio</Label>
                <Textarea
                  id="bio"
                  value={profileData.bio}
                  onChange={(e) => setProfileData({...profileData, bio: e.target.value})}
                  rows={3}
                  placeholder="Enter your bio"
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="website">Website</Label>
                  <Input
                    id="website"
                    value={profileData.website}
                    onChange={(e) => setProfileData({...profileData, website: e.target.value})}
                    placeholder="Enter your website"
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="location">Location</Label>
                  <Input
                    id="location"
                    value={profileData.location}
                    onChange={(e) => setProfileData({...profileData, location: e.target.value})}
                    placeholder="Enter your location"
                  />
                </div>
              </div>

              <Button onClick={handleSaveProfile}>Save Changes</Button>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Security Settings */}
        <TabsContent value="security">
          <div className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Change Password</CardTitle>
                <CardDescription>Update your password to keep your account secure</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="currentPassword">Current Password</Label>
                  <div className="relative">
                    <Input
                      id="currentPassword"
                      type={showCurrentPassword ? "text" : "password"}
                      placeholder="Enter your current password"
                    />
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="absolute right-2 top-1/2 -translate-y-1/2 h-8 w-8"
                      onClick={() => setShowCurrentPassword(!showCurrentPassword)}
                    >
                      {showCurrentPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                    </Button>
                  </div>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="newPassword">New Password</Label>
                  <div className="relative">
                    <Input
                      id="newPassword"
                      type={showNewPassword ? "text" : "password"}
                      placeholder="Enter your new password"
                    />
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="absolute right-2 top-1/2 -translate-y-1/2 h-8 w-8"
                      onClick={() => setShowNewPassword(!showNewPassword)}
                    >
                      {showNewPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                    </Button>
                  </div>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="confirmPassword">Confirm New Password</Label>
                  <Input
                    id="confirmPassword"
                    type="password"
                    placeholder="Confirm your new password"
                  />
                </div>
                <Button>Update Password</Button>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>Two-Factor Authentication</CardTitle>
                <CardDescription>Add an extra layer of security to your account</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Enable 2FA</h4>
                    <p className="text-sm text-muted-foreground">
                      Secure your account with two-factor authentication
                    </p>
                  </div>
                  <Switch />
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        {/* Notifications Settings */}
        <TabsContent value="notifications">
          <Card>
            <CardHeader>
              <CardTitle>Notification Preferences</CardTitle>
              <CardDescription>Choose what notifications you want to receive</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Email Notifications</h4>
                    <p className="text-sm text-muted-foreground">Receive notifications via email</p>
                  </div>
                  <Switch
                    checked={notifications.email}
                    onCheckedChange={(checked) => setNotifications({...notifications, email: checked})}
                  />
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Push Notifications</h4>
                    <p className="text-sm text-muted-foreground">Receive push notifications in your browser</p>
                  </div>
                  <Switch
                    checked={notifications.push}
                    onCheckedChange={(checked) => setNotifications({...notifications, push: checked})}
                  />
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Mentions</h4>
                    <p className="text-sm text-muted-foreground">When someone mentions you in a post</p>
                  </div>
                  <Switch
                    checked={notifications.mentions}
                    onCheckedChange={(checked) => setNotifications({...notifications, mentions: checked})}
                  />
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Comments</h4>
                    <p className="text-sm text-muted-foreground">When someone comments on your posts</p>
                  </div>
                  <Switch
                    checked={notifications.comments}
                    onCheckedChange={(checked) => setNotifications({...notifications, comments: checked})}
                  />
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">New Followers</h4>
                    <p className="text-sm text-muted-foreground">When someone starts following you</p>
                  </div>
                  <Switch
                    checked={notifications.follows}
                    onCheckedChange={(checked) => setNotifications({...notifications, follows: checked})}
                  />
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Messages</h4>
                    <p className="text-sm text-muted-foreground">When you receive a new message</p>
                  </div>
                  <Switch
                    checked={notifications.messages}
                    onCheckedChange={(checked) => setNotifications({...notifications, messages: checked})}
                  />
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Privacy Settings */}
        <TabsContent value="privacy">
          <Card>
            <CardHeader>
              <CardTitle>Privacy Settings</CardTitle>
              <CardDescription>Control who can see your information and interact with you</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Public Profile</h4>
                    <p className="text-sm text-muted-foreground">Make your profile visible to everyone</p>
                  </div>
                  <Switch
                    checked={privacy.profilePublic}
                    onCheckedChange={(checked) => setPrivacy({...privacy, profilePublic: checked})}
                  />
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Show Email</h4>
                    <p className="text-sm text-muted-foreground">Display your email address on your profile</p>
                  </div>
                  <Switch
                    checked={privacy.showEmail}
                    onCheckedChange={(checked) => setPrivacy({...privacy, showEmail: checked})}
                  />
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Show Location</h4>
                    <p className="text-sm text-muted-foreground">Display your location on your profile</p>
                  </div>
                  <Switch
                    checked={privacy.showLocation}
                    onCheckedChange={(checked) => setPrivacy({...privacy, showLocation: checked})}
                  />
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <h4 className="font-medium">Allow Messages</h4>
                    <p className="text-sm text-muted-foreground">Let other users send you messages</p>
                  </div>
                  <Switch
                    checked={privacy.allowMessages}
                    onCheckedChange={(checked) => setPrivacy({...privacy, allowMessages: checked})}
                  />
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Appearance Settings */}
        <TabsContent value="appearance">
          <Card>
            <CardHeader>
              <CardTitle>Appearance</CardTitle>
              <CardDescription>Customize how Focus looks and feels</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="space-y-4">
                <div>
                  <h4 className="font-medium mb-3">Theme</h4>
                  <div className="grid grid-cols-3 gap-3">
                    <button
                      onClick={() => setTheme("light")}
                      className={`p-4 rounded-lg border text-center space-y-2 transition-colors ${
                        theme === "light" ? "border-primary bg-primary/5" : "border-border"
                      }`}
                    >
                      <div className="w-full h-8 bg-white border rounded"></div>
                      <span className="text-sm font-medium">Light</span>
                    </button>
                    <button
                      onClick={() => setTheme("dark")}
                      className={`p-4 rounded-lg border text-center space-y-2 transition-colors ${
                        theme === "dark" ? "border-primary bg-primary/5" : "border-border"
                      }`}
                    >
                      <div className="w-full h-8 bg-gray-900 border rounded"></div>
                      <span className="text-sm font-medium">Dark</span>
                    </button>
                    <button
                      onClick={() => setTheme("system")}
                      className={`p-4 rounded-lg border text-center space-y-2 transition-colors ${
                        theme === "system" ? "border-primary bg-primary/5" : "border-border"
                      }`}
                    >
                      <div className="w-full h-8 bg-gradient-to-r from-white to-gray-900 border rounded"></div>
                      <span className="text-sm font-medium">System</span>
                    </button>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default Settings;
