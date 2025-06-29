import { useEffect, useState, useRef } from "react";
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
            profiles: user_id (full_name, avatar_url)
          `)
          .eq('chat_id', chat.id);

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
          chat_members: members || [],
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
                      <div className="relative">
                        <Avatar>
                          <AvatarImage src={chat.chat_members[0]?.profiles?.avatar_url} />
                          <AvatarFallback>
                            {isGroup ? <Users className="h-4 w-4" /> : displayName.charAt(0)}
                          </AvatarFallback>
                        </Avatar>
                        {isGroup && (
                          <Badge variant="secondary" className="absolute -top-1 -right-1 h-5 w-5 p-0 text-xs">
                            {chat.chat_members.length}
                          </Badge>
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
                <div className="flex items-center gap-3">
                  <div className="relative">
                    <Avatar>
                      <AvatarImage src={otherMembers[0]?.profiles?.avatar_url} />
                      <AvatarFallback>
                        {currentChat.is_group ? <Users className="h-4 w-4" /> : getChatDisplayName(currentChat).charAt(0)}
                      </AvatarFallback>
                    </Avatar>
                    {currentChat.is_group && (
                      <Badge variant="secondary" className="absolute -top-1 -right-1 h-5 w-5 p-0 text-xs">
                        {currentChat.chat_members.length}
                      </Badge>
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
                </div>
                <div className="ml-auto">
                  <Button size="icon" variant="ghost">
                    <MoreVertical className="h-4 w-4" />
                  </Button>
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
    </div>
  );
};

export default Chat;
