import { useState, useEffect } from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Plus, Search, Users, User } from "lucide-react";
import { cn } from "@/lib/utils";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

interface Profile {
  id: string;
  full_name: string;
  avatar_url: string;
  email: string;
}

interface CreateChatProps {
  onChatCreated: (chatId: string) => void;
}

const CreateChat = ({ onChatCreated }: CreateChatProps) => {
  const { user } = useAuth();
  const [open, setOpen] = useState(false);
  const [users, setUsers] = useState<Profile[]>([]);
  const [selectedUsers, setSelectedUsers] = useState<string[]>([]);
  const [searchQuery, setSearchQuery] = useState("");
  const [isGroup, setIsGroup] = useState(false);
  const [groupName, setGroupName] = useState("");
  const [loading, setLoading] = useState(false);
  const [loadingUsers, setLoadingUsers] = useState(false);

  useEffect(() => {
    if (open) {
      fetchUsers();
    }
  }, [open]);

  const fetchUsers = async () => {
    setLoadingUsers(true);
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('id, full_name, avatar_url, email')
        .neq('id', user?.id)
        .order('full_name');

      if (error) throw error;
      setUsers(data || []);
    } catch (error) {
      console.error('Error fetching users:', error);
    } finally {
      setLoadingUsers(false);
    }
  };

  const filteredUsers = users.filter(user =>
    user.full_name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    user.email.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const handleUserToggle = (userId: string) => {
    if (isGroup) {
      setSelectedUsers(prev =>
        prev.includes(userId)
          ? prev.filter(id => id !== userId)
          : [...prev, userId]
      );
    } else {
      // For direct messages, only allow one user
      setSelectedUsers([userId]);
    }
  };

  const handleCreateChat = async () => {
    if (!user || selectedUsers.length === 0) return;
    if (isGroup && !groupName.trim()) return;

    setLoading(true);
    try {
      // Create the chat
      const { data: chat, error: chatError } = await supabase
        .from('chats')
        .insert({
          is_group: isGroup,
          name: isGroup ? groupName.trim() : null
        })
        .select()
        .single();

      if (chatError) throw chatError;

      // Add current user to chat
      await supabase
        .from('chat_members')
        .insert({
          chat_id: chat.id,
          user_id: user.id
        });

      // Add selected users to chat
      const memberPromises = selectedUsers.map(userId =>
        supabase
          .from('chat_members')
          .insert({
            chat_id: chat.id,
            user_id: userId
          })
      );

      await Promise.all(memberPromises);

      // Reset form
      setSelectedUsers([]);
      setSearchQuery("");
      setGroupName("");
      setIsGroup(false);
      setOpen(false);

      // Notify parent component
      onChatCreated(chat.id);
    } catch (error) {
      console.error('Error creating chat:', error);
    } finally {
      setLoading(false);
    }
  };

  const canCreate = () => {
    if (selectedUsers.length === 0) return false;
    if (isGroup && !groupName.trim()) return false;
    return true;
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button size="icon" variant="ghost">
          <Plus className="h-4 w-4" />
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>New Conversation</DialogTitle>
        </DialogHeader>
        
        <div className="space-y-4">
          {/* Chat Type Toggle */}
          <div className="flex gap-2">
            <Button
              variant={!isGroup ? "default" : "outline"}
              size="sm"
              onClick={() => setIsGroup(false)}
              className="flex-1"
            >
              <User className="h-4 w-4 mr-2" />
              Direct Message
            </Button>
            <Button
              variant={isGroup ? "default" : "outline"}
              size="sm"
              onClick={() => setIsGroup(true)}
              className="flex-1"
            >
              <Users className="h-4 w-4 mr-2" />
              Group Chat
            </Button>
          </div>

          {/* Group Name Input */}
          {isGroup && (
            <div className="space-y-2">
              <label className="text-sm font-medium">Group Name</label>
              <Input
                placeholder="Enter group name..."
                value={groupName}
                onChange={(e) => setGroupName(e.target.value)}
              />
            </div>
          )}

          {/* User Search */}
          <div className="space-y-2">
            <label className="text-sm font-medium">
              {isGroup ? "Select Members" : "Select User"}
            </label>
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                placeholder="Search users..."
                className="pl-10"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
            </div>
          </div>

          {/* User List */}
          <div className="max-h-60 overflow-y-auto space-y-2">
            {loadingUsers ? (
              <div className="text-center py-4 text-muted-foreground">Loading users...</div>
            ) : filteredUsers.length === 0 ? (
              <div className="text-center py-4 text-muted-foreground">
                {searchQuery ? 'No users found.' : 'No users available.'}
              </div>
            ) : (
              filteredUsers.map((user) => (
                <div
                  key={user.id}
                  onClick={() => handleUserToggle(user.id)}
                  className={cn(
                    "flex items-center gap-3 p-2 rounded-lg cursor-pointer transition-colors hover:bg-muted/50",
                    selectedUsers.includes(user.id) && "bg-muted"
                  )}
                >
                  <Avatar className="h-8 w-8">
                    <AvatarImage src={user.avatar_url} />
                    <AvatarFallback>{user.full_name.charAt(0)}</AvatarFallback>
                  </Avatar>
                  <div className="flex-1 min-w-0">
                    <p className="font-medium truncate">{user.full_name}</p>
                    <p className="text-sm text-muted-foreground truncate">{user.email}</p>
                  </div>
                  {selectedUsers.includes(user.id) && (
                    <Badge variant="secondary" className="h-5 w-5 p-0">
                      ✓
                    </Badge>
                  )}
                </div>
              ))
            )}
          </div>

          {/* Selected Users Summary */}
          {selectedUsers.length > 0 && (
            <div className="space-y-2">
              <label className="text-sm font-medium">
                {isGroup ? "Selected Members" : "Selected User"}
              </label>
              <div className="flex flex-wrap gap-2">
                {selectedUsers.map(userId => {
                  const user = users.find(u => u.id === userId);
                  return (
                    <Badge key={userId} variant="outline" className="gap-1">
                      <Avatar className="h-4 w-4">
                        <AvatarImage src={user?.avatar_url} />
                        <AvatarFallback className="text-xs">{user?.full_name.charAt(0)}</AvatarFallback>
                      </Avatar>
                      {user?.full_name}
                      <button
                        onClick={() => handleUserToggle(userId)}
                        className="ml-1 hover:text-destructive"
                      >
                        ×
                      </button>
                    </Badge>
                  );
                })}
              </div>
            </div>
          )}

          {/* Create Button */}
          <Button
            onClick={handleCreateChat}
            disabled={!canCreate() || loading}
            className="w-full"
          >
            {loading ? "Creating..." : `Create ${isGroup ? "Group" : "Chat"}`}
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default CreateChat; 