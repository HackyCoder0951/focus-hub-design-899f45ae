# Chat System Implementation

## Overview

The Chat System provides real-time messaging capabilities with support for both direct messages and group chats, including file sharing and typing indicators.

## Core Components

### 1. Chat Page Component

**File**: `src/pages/Chat.tsx`
```typescript
import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Plus, Users, MoreHorizontal } from 'lucide-react';
import { CreateChat } from '@/components/CreateChat';
import { ChatMessages } from '@/components/ChatMessages';
import { useToast } from '@/hooks/use-toast';

interface Chat {
  id: string;
  name: string | null;
  is_group: boolean;
  created_by: string;
  created_at: string;
  chat_members: {
    user_id: string;
    is_admin: boolean;
    profiles: {
      full_name: string;
      avatar_url: string | null;
    };
  }[];
  last_message?: {
    content: string;
    created_at: string;
    profiles: {
      full_name: string;
    };
  };
}

const Chat = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [chats, setChats] = useState<Chat[]>([]);
  const [selectedChat, setSelectedChat] = useState<Chat | null>(null);
  const [loading, setLoading] = useState(true);
  const [showCreateChat, setShowCreateChat] = useState(false);

  const fetchChats = async () => {
    try {
      const { data, error } = await supabase
        .from('chats')
        .select(`
          *,
          chat_members (
            user_id,
            is_admin,
            profiles (full_name, avatar_url)
          ),
          chat_messages (
            content,
            created_at,
            profiles (full_name)
          )
        `)
        .order('created_at', { ascending: false });

      if (error) throw error;

      // Process chats to get last message
      const processedChats = (data || []).map(chat => {
        const messages = chat.chat_messages || [];
        const lastMessage = messages.length > 0 ? messages[messages.length - 1] : null;
        
        return {
          ...chat,
          last_message: lastMessage
        };
      });

      setChats(processedChats);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load chats",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchChats();

    // Set up real-time subscription for new chats
    const channel = supabase
      .channel('chats')
      .on('postgres_changes', 
        { event: '*', schema: 'public', table: 'chats' },
        () => {
          fetchChats();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, []);

  const handleChatCreated = (newChat: Chat) => {
    setShowCreateChat(false);
    setSelectedChat(newChat);
    fetchChats();
  };

  const handleChatSelected = (chat: Chat) => {
    setSelectedChat(chat);
  };

  return (
    <div className="flex h-full">
      {/* Chat List Sidebar */}
      <div className="w-80 border-r bg-muted/50">
        <div className="p-4 border-b">
          <div className="flex items-center justify-between">
            <h2 className="text-lg font-semibold">Messages</h2>
            <Dialog open={showCreateChat} onOpenChange={setShowCreateChat}>
              <DialogTrigger asChild>
                <Button size="sm">
                  <Plus className="h-4 w-4" />
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>Create New Chat</DialogTitle>
                </DialogHeader>
                <CreateChat onChatCreated={handleChatCreated} />
              </DialogContent>
            </Dialog>
          </div>
        </div>

        <div className="overflow-y-auto h-[calc(100vh-120px)]">
          {chats.map((chat) => (
            <div
              key={chat.id}
              className={`p-4 border-b cursor-pointer hover:bg-muted/50 transition-colors ${
                selectedChat?.id === chat.id ? 'bg-muted' : ''
              }`}
              onClick={() => handleChatSelected(chat)}
            >
              <div className="flex items-center space-x-3">
                <Avatar>
                  <AvatarImage src={chat.chat_members[0]?.profiles?.avatar_url} />
                  <AvatarFallback>
                    {chat.is_group ? (
                      <Users className="h-4 w-4" />
                    ) : (
                      chat.chat_members[0]?.profiles?.full_name?.charAt(0) || 'U'
                    )}
                  </AvatarFallback>
                </Avatar>
                
                <div className="flex-1 min-w-0">
                  <div className="flex items-center space-x-2">
                    <p className="font-medium truncate">
                      {chat.is_group ? chat.name : chat.chat_members[0]?.profiles?.full_name}
                    </p>
                    {chat.is_group && (
                      <Badge variant="secondary" className="text-xs">
                        Group
                      </Badge>
                    )}
                  </div>
                  
                  {chat.last_message && (
                    <p className="text-sm text-muted-foreground truncate">
                      <span className="font-medium">
                        {chat.last_message.profiles?.full_name}:
                      </span>{' '}
                      {chat.last_message.content}
                    </p>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Chat Messages */}
      <div className="flex-1">
        {selectedChat ? (
          <ChatMessages chat={selectedChat} />
        ) : (
          <div className="flex items-center justify-center h-full">
            <div className="text-center">
              <Users className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
              <p className="text-muted-foreground">Select a chat to start messaging</p>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default Chat;
```

### 2. Chat Messages Component

**File**: `src/components/ChatMessages.tsx`
```typescript
import { useState, useEffect, useRef } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Send, Paperclip, Users, MoreHorizontal } from 'lucide-react';
import { formatDistanceToNow } from 'date-fns';
import { useToast } from '@/hooks/use-toast';

interface ChatMessagesProps {
  chat: any;
}

export const ChatMessages = ({ chat }: ChatMessagesProps) => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [messages, setMessages] = useState<any[]>([]);
  const [newMessage, setNewMessage] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const [typingUsers, setTypingUsers] = useState<string[]>([]);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  const fetchMessages = async () => {
    try {
      const { data, error } = await supabase
        .from('chat_messages')
        .select(`
          *,
          profiles (full_name, avatar_url)
        `)
        .eq('chat_id', chat.id)
        .order('created_at', { ascending: true });

      if (error) throw error;
      setMessages(data || []);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load messages",
        variant: "destructive",
      });
    }
  };

  const sendMessage = async (content: string, mediaUrl?: string) => {
    if (!content.trim() && !mediaUrl) return;

    try {
      const { error } = await supabase
        .from('chat_messages')
        .insert({
          chat_id: chat.id,
          user_id: user?.id,
          content: content.trim(),
          media_url: mediaUrl
        });

      if (error) throw error;

      setNewMessage('');
      fetchMessages();
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to send message",
        variant: "destructive",
      });
    }
  };

  const handleFileUpload = async (file: File) => {
    try {
      const fileExt = file.name.split('.').pop();
      const fileName = `${Date.now()}-${Math.random().toString(36).substring(2)}.${fileExt}`;
      const filePath = `chat-files/${fileName}`;

      const { error: uploadError } = await supabase.storage
        .from('uploads')
        .upload(filePath, file);

      if (uploadError) throw uploadError;

      const { data: { publicUrl } } = supabase.storage
        .from('uploads')
        .getPublicUrl(filePath);

      await sendMessage('', publicUrl);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to upload file",
        variant: "destructive",
      });
    }
  };

  const handleTyping = async (isTyping: boolean) => {
    try {
      await supabase
        .from('chat_members')
        .update({ typing: isTyping })
        .eq('chat_id', chat.id)
        .eq('user_id', user?.id);
    } catch (error) {
      console.error('Error updating typing status:', error);
    }
  };

  useEffect(() => {
    fetchMessages();

    // Set up real-time subscription for messages
    const messagesChannel = supabase
      .channel(`chat:${chat.id}`)
      .on('postgres_changes', 
        { 
          event: '*', 
          schema: 'public', 
          table: 'chat_messages',
          filter: `chat_id=eq.${chat.id}`
        },
        () => {
          fetchMessages();
        }
      )
      .subscribe();

    // Set up real-time subscription for typing indicators
    const typingChannel = supabase
      .channel(`typing:${chat.id}`)
      .on('postgres_changes', 
        { 
          event: '*', 
          schema: 'public', 
          table: 'chat_members',
          filter: `chat_id=eq.${chat.id}`
        },
        (payload) => {
          if (payload.eventType === 'UPDATE' && payload.new.typing) {
            setTypingUsers(prev => [...prev, payload.new.user_id]);
          } else if (payload.eventType === 'UPDATE' && !payload.new.typing) {
            setTypingUsers(prev => prev.filter(id => id !== payload.new.user_id));
          }
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(messagesChannel);
      supabase.removeChannel(typingChannel);
    };
  }, [chat.id]);

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const isCurrentUser = (messageUserId: string) => messageUserId === user?.id;

  return (
    <div className="flex flex-col h-full">
      {/* Chat Header */}
      <div className="p-4 border-b bg-background">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <Avatar>
              <AvatarImage src={chat.chat_members[0]?.profiles?.avatar_url} />
              <AvatarFallback>
                {chat.is_group ? (
                  <Users className="h-4 w-4" />
                ) : (
                  chat.chat_members[0]?.profiles?.full_name?.charAt(0) || 'U'
                )}
              </AvatarFallback>
            </Avatar>
            
            <div>
              <h3 className="font-medium">
                {chat.is_group ? chat.name : chat.chat_members[0]?.profiles?.full_name}
              </h3>
              {chat.is_group && (
                <p className="text-sm text-muted-foreground">
                  {chat.chat_members.length} members
                </p>
              )}
            </div>
          </div>

          <Button variant="ghost" size="sm">
            <MoreHorizontal className="h-4 w-4" />
          </Button>
        </div>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto p-4 space-y-4">
        {messages.map((message) => (
          <div
            key={message.id}
            className={`flex ${isCurrentUser(message.user_id) ? 'justify-end' : 'justify-start'}`}
          >
            <div className={`flex items-end space-x-2 max-w-xs lg:max-w-md ${
              isCurrentUser(message.user_id) ? 'flex-row-reverse space-x-reverse' : ''
            }`}>
              {!isCurrentUser(message.user_id) && (
                <Avatar className="h-6 w-6">
                  <AvatarImage src={message.profiles?.avatar_url} />
                  <AvatarFallback>
                    {message.profiles?.full_name?.charAt(0)}
                  </AvatarFallback>
                </Avatar>
              )}
              
              <div className={`rounded-lg px-3 py-2 ${
                isCurrentUser(message.user_id)
                  ? 'bg-primary text-primary-foreground'
                  : 'bg-muted'
              }`}>
                {message.content && (
                  <p className="text-sm">{message.content}</p>
                )}
                
                {message.media_url && (
                  <div className="mt-2">
                    {message.media_url.match(/\.(jpg|jpeg|png|gif|webp)$/i) ? (
                      <img
                        src={message.media_url}
                        alt="Media"
                        className="rounded max-w-full h-auto"
                      />
                    ) : (
                      <a
                        href={message.media_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-sm underline"
                      >
                        View File
                      </a>
                    )}
                  </div>
                )}
                
                <p className={`text-xs mt-1 ${
                  isCurrentUser(message.user_id)
                    ? 'text-primary-foreground/70'
                    : 'text-muted-foreground'
                }`}>
                  {formatDistanceToNow(new Date(message.created_at), { addSuffix: true })}
                </p>
              </div>
            </div>
          </div>
        ))}

        {typingUsers.length > 0 && (
          <div className="flex justify-start">
            <div className="bg-muted rounded-lg px-3 py-2">
              <p className="text-sm text-muted-foreground">
                {typingUsers.length === 1 ? 'Someone is typing...' : 'Multiple people are typing...'}
              </p>
            </div>
          </div>
        )}

        <div ref={messagesEndRef} />
      </div>

      {/* Message Input */}
      <div className="p-4 border-t bg-background">
        <div className="flex items-center space-x-2">
          <input
            ref={fileInputRef}
            type="file"
            className="hidden"
            onChange={(e) => {
              const file = e.target.files?.[0];
              if (file) {
                handleFileUpload(file);
              }
            }}
          />
          
          <Button
            variant="ghost"
            size="sm"
            onClick={() => fileInputRef.current?.click()}
          >
            <Paperclip className="h-4 w-4" />
          </Button>
          
          <Input
            placeholder="Type a message..."
            value={newMessage}
            onChange={(e) => {
              setNewMessage(e.target.value);
              if (!isTyping) {
                setIsTyping(true);
                handleTyping(true);
              }
            }}
            onKeyPress={(e) => {
              if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage(newMessage);
                setIsTyping(false);
                handleTyping(false);
              }
            }}
            onBlur={() => {
              setIsTyping(false);
              handleTyping(false);
            }}
          />
          
          <Button
            size="sm"
            onClick={() => {
              sendMessage(newMessage);
              setIsTyping(false);
              handleTyping(false);
            }}
          >
            <Send className="h-4 w-4" />
          </Button>
        </div>
      </div>
    </div>
  );
};
```

### 3. Create Chat Component

**File**: `src/components/CreateChat.tsx`
```typescript
import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Checkbox } from '@/components/ui/checkbox';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { useToast } from '@/hooks/use-toast';

interface CreateChatProps {
  onChatCreated: (chat: any) => void;
}

export const CreateChat = ({ onChatCreated }: CreateChatProps) => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [chatName, setChatName] = useState('');
  const [isGroup, setIsGroup] = useState(false);
  const [selectedUsers, setSelectedUsers] = useState<string[]>([]);
  const [users, setUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  const fetchUsers = async () => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('id, full_name, avatar_url')
        .neq('id', user?.id)
        .order('full_name');

      if (error) throw error;
      setUsers(data || []);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load users",
        variant: "destructive",
      });
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleUserToggle = (userId: string) => {
    setSelectedUsers(prev => 
      prev.includes(userId)
        ? prev.filter(id => id !== userId)
        : [...prev, userId]
    );
  };

  const handleCreateChat = async () => {
    if (isGroup && !chatName.trim()) {
      toast({
        title: "Error",
        description: "Please enter a group name",
        variant: "destructive",
      });
      return;
    }

    if (!isGroup && selectedUsers.length !== 1) {
      toast({
        title: "Error",
        description: "Please select exactly one user for direct message",
        variant: "destructive",
      });
      return;
    }

    setLoading(true);

    try {
      // Create chat
      const { data: chat, error: chatError } = await supabase
        .from('chats')
        .insert([{
          name: isGroup ? chatName.trim() : null,
          is_group: isGroup,
          created_by: user?.id
        }])
        .select()
        .single();

      if (chatError) throw chatError;

      // Add members
      const members = [
        { chat_id: chat.id, user_id: user?.id, is_admin: true }, // Creator is admin
        ...selectedUsers.map(userId => ({
          chat_id: chat.id,
          user_id: userId,
          is_admin: false
        }))
      ];

      const { error: membersError } = await supabase
        .from('chat_members')
        .insert(members);

      if (membersError) throw membersError;

      onChatCreated(chat);
      toast({
        title: "Success",
        description: "Chat created successfully",
      });

    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to create chat",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="space-y-4">
      <div className="space-y-2">
        <div className="flex items-center space-x-2">
          <Checkbox
            id="isGroup"
            checked={isGroup}
            onCheckedChange={(checked) => setIsGroup(checked as boolean)}
          />
          <Label htmlFor="isGroup">Create group chat</Label>
        </div>
      </div>

      {isGroup && (
        <div className="space-y-2">
          <Label htmlFor="chatName">Group Name</Label>
          <Input
            id="chatName"
            value={chatName}
            onChange={(e) => setChatName(e.target.value)}
            placeholder="Enter group name"
          />
        </div>
      )}

      <div className="space-y-2">
        <Label>Select Members</Label>
        <div className="max-h-48 overflow-y-auto space-y-2">
          {users.map((user) => (
            <div
              key={user.id}
              className="flex items-center space-x-2 p-2 rounded border cursor-pointer hover:bg-muted"
              onClick={() => handleUserToggle(user.id)}
            >
              <Checkbox
                checked={selectedUsers.includes(user.id)}
                onCheckedChange={() => handleUserToggle(user.id)}
              />
              <Avatar className="h-6 w-6">
                <AvatarImage src={user.avatar_url} />
                <AvatarFallback>
                  {user.full_name?.charAt(0) || 'U'}
                </AvatarFallback>
              </Avatar>
              <span className="text-sm">{user.full_name}</span>
            </div>
          ))}
        </div>
      </div>

      <Button
        onClick={handleCreateChat}
        disabled={loading || (isGroup && !chatName.trim()) || selectedUsers.length === 0}
        className="w-full"
      >
        {loading ? 'Creating...' : 'Create Chat'}
      </Button>
    </div>
  );
};
```

## Real-time Features

### 1. Message Subscriptions

```typescript
// Subscribe to new messages
const messagesChannel = supabase
  .channel(`chat:${chatId}`)
  .on('postgres_changes', 
    { 
      event: '*', 
      schema: 'public', 
      table: 'chat_messages',
      filter: `chat_id=eq.${chatId}`
    },
    (payload) => {
      if (payload.eventType === 'INSERT') {
        // Add new message
        setMessages(prev => [...prev, payload.new]);
      }
    }
  )
  .subscribe();
```

### 2. Typing Indicators

```typescript
// Subscribe to typing status
const typingChannel = supabase
  .channel(`typing:${chatId}`)
  .on('postgres_changes', 
    { 
      event: '*', 
      schema: 'public', 
      table: 'chat_members',
      filter: `chat_id=eq.${chatId}`
    },
    (payload) => {
      if (payload.eventType === 'UPDATE') {
        if (payload.new.typing) {
          setTypingUsers(prev => [...prev, payload.new.user_id]);
        } else {
          setTypingUsers(prev => prev.filter(id => id !== payload.new.user_id));
        }
      }
    }
  )
  .subscribe();
```

## Database Schema

### Chats Table
```sql
CREATE TABLE chats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT,
  is_group BOOLEAN DEFAULT FALSE,
  created_by UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Chat Members Table
```sql
CREATE TABLE chat_members (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  chat_id UUID REFERENCES chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  is_admin BOOLEAN DEFAULT FALSE,
  typing BOOLEAN DEFAULT FALSE,
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(chat_id, user_id)
);
```

### Chat Messages Table
```sql
CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  chat_id UUID REFERENCES chats(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  content TEXT,
  media_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Group Chat Management

### 1. Leave Group Function

```sql
CREATE OR REPLACE FUNCTION leave_group(p_chat_id UUID, p_user_id UUID)
RETURNS VOID AS $$
DECLARE
  admin_count INTEGER;
  member_count INTEGER;
  new_admin_id UUID;
BEGIN
  -- Remove user from chat_members
  DELETE FROM chat_members WHERE chat_id = p_chat_id AND user_id = p_user_id;

  -- Check remaining admins
  SELECT COUNT(*) INTO admin_count FROM chat_members WHERE chat_id = p_chat_id AND is_admin = true;
  
  IF admin_count = 0 THEN
    -- Promote earliest member to admin
    SELECT user_id INTO new_admin_id FROM chat_members WHERE chat_id = p_chat_id ORDER BY joined_at ASC LIMIT 1;
    IF new_admin_id IS NOT NULL THEN
      UPDATE chat_members SET is_admin = true WHERE chat_id = p_chat_id AND user_id = new_admin_id;
    END IF;
  END IF;

  -- Check remaining members
  SELECT COUNT(*) INTO member_count FROM chat_members WHERE chat_id = p_chat_id;
  IF member_count = 0 THEN
    -- Delete chat if no members remain
    DELETE FROM chat_messages WHERE chat_id = p_chat_id;
    DELETE FROM chats WHERE id = p_chat_id;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

This chat system provides comprehensive real-time messaging capabilities with support for both direct messages and group chats, including file sharing and typing indicators. 