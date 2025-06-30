import { useEffect, useState, useRef, useMemo } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Send, Search, Plus, MoreVertical, Users, MessageCircle } from "lucide-react";
import { cn } from "@/lib/utils";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import CreateChat from "@/components/CreateChat";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { saveAs } from "file-saver";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";

interface ChatMessage {
  id: string;
  chat_id: string;
  user_id: string;
  content: string;
  created_at: string;
  profiles: {
    full_name: string;
    avatar_url: string;
  };
}

interface ChatMember {
  id: string;
  chat_id: string;
  user_id: string;
  joined_at: string;
  is_admin?: boolean;
  profiles: {
    full_name: string;
    avatar_url: string;
  };
}

interface Chat {
  id: string;
  is_group: boolean;
  name: string | null;
  created_at: string;
  chat_members: ChatMember[];
  last_message?: {
    content: string;
    created_at: string;
    user_id: string;
  };
}

interface Profile {
  id: string;
  full_name: string;
  avatar_url: string;
  email: string;
}

const Chat = () => {
  const { user } = useAuth();
  const [chats, setChats] = useState<Chat[]>([]);
  const [selectedChat, setSelectedChat] = useState<string | null>(null);
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [newMessage, setNewMessage] = useState("");
  const [loadingChats, setLoadingChats] = useState(true);
  const [loadingMessages, setLoadingMessages] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const [isTyping, setIsTyping] = useState(false);
  const [groupInfoOpen, setGroupInfoOpen] = useState(false);
  const [editingGroupName, setEditingGroupName] = useState(false);
  const [groupNameInput, setGroupNameInput] = useState("");
  const { toast } = useToast();
  const [addMemberOpen, setAddMemberOpen] = useState(false);
  const [addMemberSearch, setAddMemberSearch] = useState("");
  const [addMemberLoading, setAddMemberLoading] = useState(false);
  const [allUsers, setAllUsers] = useState<Profile[]>([]);

  // Scroll to bottom when new messages arrive
  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  // Fetch chats with last message
    const fetchChats = async () => {
      setLoadingChats(true);
    try {
      // First get all chats where user is a member
      const { data: userChats, error: chatsError } = await supabase
        .from('chat_members')
        .select(`
          chat_id,
          chats (
            id,
            is_group,
            name,
            created_at
          )
        `)
        .eq('user_id', user?.id);

      if (chatsError) throw chatsError;

      // Get chat details with members and last message
      const chatPromises = userChats?.map(async (userChat) => {
        const chat = userChat.chats;
        
        // Get chat members
        const { data: members } = await supabase
          .from('chat_members')
          .select(`
            id,
            chat_id,
            user_id,
            joined_at,
            is_admin,
            profiles: user_id (full_name, avatar_url)
          `)
          .eq('chat_id', chat.id);
        console.log('Fetched members:', members);

        // Get last message
        const { data: lastMessage } = await supabase
          .from('chat_messages')
          .select('content, created_at, user_id')
          .eq('chat_id', chat.id)
          .order('created_at', { ascending: false })
          .limit(1)
          .single();

        return {
          ...chat,
          chat_members: (members || []) as any,
          last_message: lastMessage
        };
      });

      const chatData = await Promise.all(chatPromises || []);
      setChats(chatData.sort((a, b) => 
        new Date(b.last_message?.created_at || b.created_at).getTime() - 
        new Date(a.last_message?.created_at || a.created_at).getTime()
      ));
    } catch (error) {
      console.error('Error fetching chats:', error);
    } finally {
      setLoadingChats(false);
    }
    };

  useEffect(() => {
    if (user) {
    fetchChats();
    }
  }, [user]);

  // Real-time subscription for new messages
  useEffect(() => {
    if (!user) return;

    const channel = supabase
      .channel('chat_messages')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'chat_messages'
        },
        (payload) => {
          const newMessage = payload.new as ChatMessage;
          
          // Update messages if it's for the current chat
          if (selectedChat && newMessage.chat_id === selectedChat) {
            setMessages(prev => [...prev, newMessage]);
          }
          
          // Update chat list with new last message
          fetchChats();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [user, selectedChat]);

  // Fetch messages for selected chat
  useEffect(() => {
    if (!selectedChat) return;
    
    const fetchMessages = async () => {
      setLoadingMessages(true);
      try {
      const { data, error } = await supabase
        .from('chat_messages')
          .select(`
            id,
            chat_id,
            user_id,
            content,
            created_at,
            profiles: user_id (full_name, avatar_url)
          `)
        .eq('chat_id', selectedChat)
        .order('created_at', { ascending: true });
        
        if (error) throw error;
        setMessages(data || []);
      } catch (error) {
        console.error('Error fetching messages:', error);
      } finally {
      setLoadingMessages(false);
      }
    };
    
    fetchMessages();
  }, [selectedChat]);

  const handleSendMessage = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newMessage.trim() || !user || !selectedChat) return;

    setIsTyping(true);
    try {
    const { error } = await supabase
      .from('chat_messages')
      .insert({
        chat_id: selectedChat,
        user_id: user.id,
          content: newMessage.trim()
      });

      if (error) throw error;
      setNewMessage("");
    } catch (error) {
      console.error('Error sending message:', error);
    } finally {
      setIsTyping(false);
    }
  };

  const filteredChats = chats.filter(chat => {
    if (!searchQuery) return true;
    
    const otherMembers = chat.chat_members.filter(member => member.user_id !== user?.id);
    const memberNames = otherMembers.map(member => member.profiles.full_name).join(' ');
    const chatName = chat.name || '';
    const lastMessage = chat.last_message?.content || '';
    
    return (
      memberNames.toLowerCase().includes(searchQuery.toLowerCase()) ||
      chatName.toLowerCase().includes(searchQuery.toLowerCase()) ||
      lastMessage.toLowerCase().includes(searchQuery.toLowerCase())
    );
  });

  const currentChat = chats.find((c) => c.id === selectedChat);
  const otherMembers = currentChat?.chat_members.filter(member => member.user_id !== user?.id) || [];

  const formatTime = (dateString: string) => {
    const date = new Date(dateString);
    const now = new Date();
    const diffInHours = (now.getTime() - date.getTime()) / (1000 * 60 * 60);
    
    if (diffInHours < 24) {
      return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    } else if (diffInHours < 48) {
      return 'Yesterday';
    } else {
      return date.toLocaleDateString();
    }
  };

  const getChatDisplayName = (chat: Chat) => {
    if (chat.is_group && chat.name) {
      return chat.name;
    }
    
    const otherMember = chat.chat_members.find(member => member.user_id !== user?.id);
    return otherMember?.profiles.full_name || 'Unknown User';
  };

  const handleChatCreated = (chatId: string) => {
    // Refresh chats and select the new chat
    fetchChats().then(() => {
      setSelectedChat(chatId);
    });
  };

  const handleDeleteChat = async () => {
    if (!currentChat) return;
    
    try {
      if (currentChat.is_group) {
        // Remove the user from chat_members
        const { error: deleteError } = await supabase
          .from('chat_members')
          .delete()
          .eq('chat_id', currentChat.id)
          .eq('user_id', user.id);
        
        if (deleteError) throw deleteError;

        // Check if any members remain
        const { data: remainingMembers } = await supabase
          .from('chat_members')
          .select('user_id')
          .eq('chat_id', currentChat.id);

        // If no members remain, delete the group and messages
        if (!remainingMembers || remainingMembers.length === 0) {
          await supabase
            .from('chat_messages')
            .delete()
            .eq('chat_id', currentChat.id);
          
          await supabase
            .from('chats')
            .delete()
            .eq('id', currentChat.id);
        }
      } else {
        // For direct: remove self from chat_members
        await supabase.from('chat_members').delete().eq('chat_id', currentChat.id).eq('user_id', user.id);
      }

      setSelectedChat(null);
      fetchChats();
      toast({ title: currentChat.is_group ? 'You left the group.' : 'Chat deleted.' });
    } catch (error) {
      console.error('Error:', error);
      toast({ title: 'Error', description: 'Please try again.', variant: 'destructive' });
    }
  };

  const handleExportChat = () => {
    if (!currentChat) return;
    let text = `Chat: ${getChatDisplayName(currentChat)}\n`;
    messages.forEach(msg => {
      const name = msg.profiles?.full_name || 'Unknown';
      const time = msg.created_at ? new Date(msg.created_at).toLocaleString() : '';
      text += `[${time}] ${name}: ${msg.content}\n`;
    });
    const blob = new Blob([text], { type: 'text/plain;charset=utf-8' });
    saveAs(blob, `${getChatDisplayName(currentChat)}-chat.txt`);
  };

  // Handler to update group name (UI only for now)
  const handleGroupNameSave = async () => {
    if (!currentChat || !groupNameInput.trim()) return;
    const { error } = await supabase
      .from('chats')
      .update({ name: groupNameInput.trim() })
      .eq('id', currentChat.id);
    if (!error) {
      setEditingGroupName(false);
      setGroupInfoOpen(false);
      fetchChats();
      toast({ title: 'Group name updated!' });
    } else {
      toast({ title: 'Error updating group name', description: error.message, variant: 'destructive' });
    }
  };

  // Fetch all users for add member
  useEffect(() => {
    if (groupInfoOpen && currentChat?.is_group) {
      supabase.from('profiles').select('id, full_name, avatar_url, email').then(({ data }) => {
        setAllUsers(data || []);
      });
    }
  }, [groupInfoOpen, currentChat]);

  const isCurrentUserAdmin = currentChat?.chat_members.some(
    (m) => m.user_id === user?.id && m.is_admin
  );

  console.log("isCurrentUserAdmin", isCurrentUserAdmin, user?.id, currentChat?.chat_members);

  const handleAddMember = async (userId: string) => {
    setAddMemberLoading(true);
    const { error } = await supabase.from('chat_members').insert({
      chat_id: currentChat?.id,
      user_id: userId,
      is_admin: false
    });
    setAddMemberLoading(false);
    if (!error) {
      fetchChats();
      setAddMemberOpen(false);
      toast({ title: 'Member added!' });
    } else {
      toast({ title: 'Error adding member', description: error.message, variant: 'destructive' });
    }
  };

  const handleRemoveMember = async (userId: string) => {
    if (!currentChat) return;
    const { error } = await supabase.from('chat_members').delete().eq('chat_id', currentChat.id).eq('user_id', userId);
    if (!error) {
      fetchChats();
      toast({ title: 'Member removed!' });
    } else {
      toast({ title: 'Error removing member', description: error.message, variant: 'destructive' });
    }
  };

  const handleToggleAdmin = async (userId: string, makeAdmin: boolean) => {
    if (!currentChat) return;
    const { error } = await supabase.from('chat_members')
      .update({ is_admin: makeAdmin } as any)
      .eq('chat_id', currentChat.id)
      .eq('user_id', userId);
    if (!error) {
      fetchChats();
      toast({ title: makeAdmin ? 'Admin assigned!' : 'Admin removed!' });
    } else {
      toast({ title: 'Error updating admin status', description: error.message, variant: 'destructive' });
    }
  };

  return (
    <div className="max-w-7xl mx-auto h-[calc(100vh-12rem)]">
      <div className="grid grid-cols-1 lg:grid-cols-3 h-full gap-6">
        {/* Conversations List */}
        <Card className="lg:col-span-1">
          <CardHeader className="pb-3">
            <div className="flex items-center justify-between">
              <CardTitle>Messages</CardTitle>
              <CreateChat onChatCreated={handleChatCreated} />
            </div>
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input 
                placeholder="Search conversations..." 
                className="pl-10"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
            </div>
          </CardHeader>
          <CardContent className="p-0">
            <div className="space-y-1 max-h-[calc(100vh-16rem)] overflow-y-auto">
              {loadingChats ? (
                <div className="text-center py-10">Loading...</div>
              ) : filteredChats.length === 0 ? (
                <div className="text-center py-10 text-muted-foreground">
                  {searchQuery ? 'No conversations found.' : 'No conversations yet.'}
                </div>
              ) : (
                filteredChats.map((chat) => {
                  const displayName = getChatDisplayName(chat);
                  const isGroup = chat.is_group;
                  
                  return (
                    <div
                      key={chat.id}
                      onClick={() => setSelectedChat(chat.id)}
                      className={cn(
                        "flex items-center gap-3 p-4 cursor-pointer transition-colors hover:bg-muted/50",
                        selectedChat === chat.id && "bg-muted"
                      )}
                    >
                      <div className="relative flex items-center">
                        {chat.is_group ? (
                          <>
                            <Users className="h-7 w-7 text-muted-foreground" />
                            <Badge variant="secondary" className="absolute -top-1 -right-1 h-5 w-5 p-0 text-xs">
                              {chat.chat_members.length}
                            </Badge>
                          </>
                        ) : (
                        <Avatar>
                            <AvatarImage src={chat.chat_members.find(m => m.user_id !== user?.id)?.profiles?.avatar_url} />
                            <AvatarFallback className="text-xs">
                              {chat.chat_members.find(m => m.user_id !== user?.id)?.profiles?.full_name?.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2)}
                            </AvatarFallback>
                        </Avatar>
                        )}
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center justify-between">
                          <h4 className="font-semibold truncate">{displayName}</h4>
                          {chat.last_message && (
                            <span className="text-xs text-muted-foreground">
                              {formatTime(chat.last_message.created_at)}
                            </span>
                          )}
                        </div>
                        {chat.last_message && (
                          <p className="text-sm text-muted-foreground truncate">
                            {chat.last_message.user_id === user?.id ? 'You: ' : ''}
                            {chat.last_message.content}
                          </p>
                        )}
                      </div>
                    </div>
                  );
                })
              )}
            </div>
          </CardContent>
        </Card>

        {/* Chat Area */}
        <Card className="lg:col-span-2 flex flex-col">
          {currentChat ? (
            <>
              {/* Chat Header */}
              <CardHeader className="flex-row items-center space-y-0 pb-3">
                <div className="relative flex items-center">
                  {currentChat.is_group ? (
                    <>
                      <Users className="h-10 w-10 text-muted-foreground" />
                      {/* <Badge variant="secondary" className="absolute -top-1 -right-1 h-5 w-5 p-0 text-xs">
                        {currentChat.chat_members.length}
                      </Badge> */}
                    </>
                  ) : (
                    <Avatar>
                      <AvatarImage src={otherMembers[0]?.profiles?.avatar_url} />
                      <AvatarFallback className="text-lg">
                        {otherMembers[0]?.profiles?.full_name?.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2)}
                      </AvatarFallback>
                    </Avatar>
                  )}
                  </div>
                  <div>
                  <h3 className="font-semibold">{getChatDisplayName(currentChat)}</h3>
                  {currentChat.is_group && (
                    <p className="text-sm text-muted-foreground">
                      {currentChat.chat_members.length} members
                    </p>
                  )}
                </div>
                <div className="ml-auto flex items-center gap-2">
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                  <Button size="icon" variant="ghost">
                    <MoreVertical className="h-4 w-4" />
                  </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      <DropdownMenuItem onClick={handleExportChat}>Export Chat to Text</DropdownMenuItem>
                      <DropdownMenuItem onClick={handleDeleteChat} className="text-destructive">{currentChat.is_group ? 'Leave Group' : 'Delete Chat'}</DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                  {currentChat.is_group && (
                    <Button size="sm" variant="outline" className="ml-2" onClick={() => { setGroupInfoOpen(true); setGroupNameInput(currentChat.name || ""); }}>
                      Group Info
                    </Button>
                  )}
                </div>
              </CardHeader>

              {/* Messages */}
              <CardContent className="flex-1 overflow-y-auto space-y-4 p-4">
                {loadingMessages ? (
                  <div className="text-center py-10">Loading...</div>
                ) : messages.length === 0 ? (
                  <div className="text-center py-10 text-muted-foreground">
                    <MessageCircle className="h-12 w-12 mx-auto mb-4 text-muted-foreground/50" />
                    <h3 className="text-lg font-semibold">No messages yet</h3>
                    <p>Start the conversation by sending a message!</p>
                  </div>
                ) : (
                  messages.map((message) => (
                    <div
                      key={message.id}
                      className={cn(
                        "flex",
                        message.user_id === user?.id ? "justify-end" : "justify-start"
                      )}
                    >
                      <div
                        className={cn(
                          "max-w-[70%] rounded-lg p-3 space-y-1",
                          message.user_id === user?.id
                            ? "bg-primary text-primary-foreground ml-4"
                            : "bg-muted mr-4"
                        )}
                      >
                        {message.user_id !== user?.id && (
                          <p className="text-xs font-medium opacity-70">
                            {message.profiles?.full_name}
                          </p>
                        )}
                        <p className="text-sm">{message.content}</p>
                        <p
                          className={cn(
                            "text-xs",
                            message.user_id === user?.id
                              ? "text-primary-foreground/70"
                              : "text-muted-foreground"
                          )}
                        >
                          {formatTime(message.created_at)}
                        </p>
                      </div>
                    </div>
                  ))
                )}
                <div ref={messagesEndRef} />
              </CardContent>

              {/* Message Input */}
              <div className="p-4 border-t">
                <form onSubmit={handleSendMessage} className="flex gap-2">
                  <Input
                    placeholder="Type a message..."
                    value={newMessage}
                    onChange={(e) => setNewMessage(e.target.value)}
                    className="flex-1"
                    disabled={isTyping}
                  />
                  <Button type="submit" disabled={!newMessage.trim() || isTyping}>
                    <Send className="h-4 w-4" />
                  </Button>
                </form>
              </div>
            </>
          ) : (
            <div className="flex-1 flex items-center justify-center">
              <div className="text-center space-y-2">
                <MessageCircle className="h-16 w-16 mx-auto text-muted-foreground/50" />
                <h3 className="text-lg font-semibold">Select a conversation</h3>
                <p className="text-muted-foreground">Choose a conversation from the sidebar to start messaging</p>
              </div>
            </div>
          )}
        </Card>
      </div>
      <Dialog open={groupInfoOpen} onOpenChange={setGroupInfoOpen}>
        <DialogContent className="sm:max-w-lg">
          <DialogHeader>
            <DialogTitle>Group Info</DialogTitle>
          </DialogHeader>
          {currentChat && (
            <div className="space-y-4">
              {/* Group Name Edit */}
              <div className="flex items-center gap-2">
                {editingGroupName ? (
                  <>
                    <Input value={groupNameInput} onChange={e => setGroupNameInput(e.target.value)} className="flex-1" />
                    <Button size="sm" onClick={handleGroupNameSave}>Save</Button>
                    <Button size="sm" variant="ghost" onClick={() => setEditingGroupName(false)}>Cancel</Button>
                  </>
                ) : (
                  <>
                    <h2 className="text-lg font-semibold flex-1">{currentChat.name}</h2>
                    <Button size="sm" variant="ghost" onClick={() => setEditingGroupName(true)}>Edit</Button>
                  </>
                )}
              </div>
              {/* Member List */}
              <div>
                <h3 className="font-semibold mb-2">Members ({currentChat.chat_members.length})</h3>
                <ul className="space-y-1">
                  {currentChat.chat_members.map(member => (
                    <li key={member.user_id} className="flex items-center gap-2">
                      <Avatar className="h-6 w-6">
                        <AvatarImage src={member.profiles?.avatar_url} />
                        <AvatarFallback className="text-xs">
                          {member.profiles?.full_name?.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2)}
                        </AvatarFallback>
                      </Avatar>
                      <span>{member.profiles?.full_name}</span>
                      {member.is_admin && <Badge variant="secondary">Admin</Badge>}
                      {isCurrentUserAdmin && user?.id !== member.user_id && (
                        <>
                          {member.is_admin ? (
                            <Button size="sm" variant="outline" onClick={() => handleToggleAdmin(member.user_id, false)}>
                              Remove Admin
                            </Button>
                          ) : (
                            <Button size="sm" variant="secondary" onClick={() => handleToggleAdmin(member.user_id, true)}>
                              Make Admin
                            </Button>
                          )}
                          <Button size="sm" variant="destructive" onClick={() => handleRemoveMember(member.user_id)}>
                            Remove
                          </Button>
                        </>
                      )}
                    </li>
                  ))}
                </ul>
              </div>
              {isCurrentUserAdmin && (
                <div className="mt-4">
                  <Button size="sm" onClick={() => setAddMemberOpen(true)}>Add Member</Button>
                  <Dialog open={addMemberOpen} onOpenChange={setAddMemberOpen}>
                    <DialogContent className="sm:max-w-md">
                      <DialogHeader>
                        <DialogTitle>Add Member</DialogTitle>
                      </DialogHeader>
                      <Input
                        placeholder="Search users..."
                        value={addMemberSearch}
                        onChange={e => setAddMemberSearch(e.target.value)}
                      />
                      <div className="max-h-60 overflow-y-auto space-y-2 mt-2">
                        {allUsers
                          .filter(u =>
                            !currentChat.chat_members.some(m => m.user_id === u.id) &&
                            (u.full_name.toLowerCase().includes(addMemberSearch.toLowerCase()) ||
                              u.email.toLowerCase().includes(addMemberSearch.toLowerCase()))
                          )
                          .map(u => (
                            <div key={u.id} className="flex items-center gap-2 p-2 rounded hover:bg-muted cursor-pointer" onClick={() => handleAddMember(u.id)}>
                              <Avatar className="h-6 w-6">
                                <AvatarImage src={u.avatar_url} />
                                <AvatarFallback className="text-xs">{u.full_name.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2)}</AvatarFallback>
                              </Avatar>
                              <span className="flex-1">{u.full_name}</span>
                              <span className="text-xs text-muted-foreground">{u.email}</span>
                              <Button size="sm" disabled={addMemberLoading}>Add</Button>
                            </div>
                          ))}
                      </div>
                    </DialogContent>
                  </Dialog>
                </div>
              )}
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default Chat;
