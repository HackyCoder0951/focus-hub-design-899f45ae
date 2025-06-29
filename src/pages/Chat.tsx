import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Send, Search, Plus, MoreVertical } from "lucide-react";
import { cn } from "@/lib/utils";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

const Chat = () => {
  const { user } = useAuth();
  const [chats, setChats] = useState<any[]>([]);
  const [selectedChat, setSelectedChat] = useState<string | null>(null);
  const [messages, setMessages] = useState<any[]>([]);
  const [newMessage, setNewMessage] = useState("");
  const [loadingChats, setLoadingChats] = useState(true);
  const [loadingMessages, setLoadingMessages] = useState(false);

  useEffect(() => {
    const fetchChats = async () => {
      setLoadingChats(true);
      const { data, error } = await supabase
        .from('chats')
        .select('*, chat_members(*, profiles: user_id (full_name, avatar_url))')
        .order('created_at', { ascending: false });
      if (!error && data) setChats(data);
      setLoadingChats(false);
    };
    fetchChats();
  }, []);

  useEffect(() => {
    if (!selectedChat) return;
    const fetchMessages = async () => {
      setLoadingMessages(true);
      const { data, error } = await supabase
        .from('chat_messages')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .eq('chat_id', selectedChat)
        .order('created_at', { ascending: true });
      if (!error && data) setMessages(data);
      setLoadingMessages(false);
    };
    fetchMessages();
  }, [selectedChat]);

  const handleSendMessage = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newMessage.trim() || !user || !selectedChat) return;
    const { error } = await supabase
      .from('chat_messages')
      .insert({
        chat_id: selectedChat,
        user_id: user.id,
        content: newMessage
      });
    if (!error) {
      setNewMessage("");
      // Refetch messages
      const { data } = await supabase
        .from('chat_messages')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .eq('chat_id', selectedChat)
        .order('created_at', { ascending: true });
      setMessages(data || []);
    }
  };

  const currentChat = chats.find((c) => c.id === selectedChat);

  return (
    <div className="max-w-7xl mx-auto h-[calc(100vh-12rem)]">
      <div className="grid grid-cols-1 lg:grid-cols-3 h-full gap-6">
        {/* Conversations List */}
        <Card className="lg:col-span-1">
          <CardHeader className="pb-3">
            <div className="flex items-center justify-between">
              <CardTitle>Messages</CardTitle>
              <Button size="icon" variant="ghost">
                <Plus className="h-4 w-4" />
              </Button>
            </div>
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input placeholder="Search conversations..." className="pl-10" />
            </div>
          </CardHeader>
          <CardContent className="p-0">
            <div className="space-y-1">
              {loadingChats ? (
                <div className="text-center py-10">Loading...</div>
              ) : chats.length === 0 ? (
                <div className="text-center py-10 text-muted-foreground">No conversations found.</div>
              ) : (
                chats.map((chat) => {
                  const member = chat.chat_members.find((m: any) => m.user_id !== user?.id);
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
                          <AvatarImage src={member?.profiles?.avatar_url} />
                          <AvatarFallback>{member?.profiles?.full_name?.charAt(0)}</AvatarFallback>
                        </Avatar>
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center justify-between">
                          <h4 className="font-semibold truncate">{member?.profiles?.full_name || "Group Chat"}</h4>
                          {/* Optionally show last message time */}
                        </div>
                        {/* Optionally show last message preview */}
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
                      <AvatarImage src={currentChat.chat_members[0]?.profiles?.avatar_url} />
                      <AvatarFallback>{currentChat.chat_members[0]?.profiles?.full_name?.charAt(0)}</AvatarFallback>
                    </Avatar>
                  </div>
                  <div>
                    <h3 className="font-semibold">{currentChat.chat_members[0]?.profiles?.full_name || "Group Chat"}</h3>
                  </div>
                </div>
                <div className="ml-auto">
                  <Button size="icon" variant="ghost">
                    <MoreVertical className="h-4 w-4" />
                  </Button>
                </div>
              </CardHeader>
              {/* Messages */}
              <CardContent className="flex-1 overflow-y-auto space-y-4">
                {loadingMessages ? (
                  <div className="text-center py-10">Loading...</div>
                ) : messages.length === 0 ? (
                  <div className="text-center py-10 text-muted-foreground">No messages yet.</div>
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
                        <p className="text-sm">{message.content}</p>
                        <p
                          className={cn(
                            "text-xs",
                            message.user_id === user?.id
                              ? "text-primary-foreground/70"
                              : "text-muted-foreground"
                          )}
                        >
                          {message.created_at ? new Date(message.created_at).toLocaleTimeString() : ""}
                        </p>
                      </div>
                    </div>
                  ))
                )}
              </CardContent>
              {/* Message Input */}
              <div className="p-4 border-t">
                <form onSubmit={handleSendMessage} className="flex gap-2">
                  <Input
                    placeholder="Type a message..."
                    value={newMessage}
                    onChange={(e) => setNewMessage(e.target.value)}
                    className="flex-1"
                  />
                  <Button type="submit" disabled={!newMessage.trim()}>
                    <Send className="h-4 w-4" />
                  </Button>
                </form>
              </div>
            </>
          ) : (
            <div className="flex-1 flex items-center justify-center">
              <div className="text-center space-y-2">
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
