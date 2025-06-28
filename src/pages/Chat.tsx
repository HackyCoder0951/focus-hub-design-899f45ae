
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Send, Search, Plus, MoreVertical } from "lucide-react";
import { cn } from "@/lib/utils";

const Chat = () => {
  const [selectedChat, setSelectedChat] = useState(1);
  const [newMessage, setNewMessage] = useState("");
  
  const conversations = [
    {
      id: 1,
      name: "Sarah Johnson",
      avatar: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=40&h=40&fit=crop&crop=face",
      lastMessage: "Thanks for the help with the React component!",
      timestamp: "2m ago",
      online: true,
      unread: 2
    },
    {
      id: 2,
      name: "Alex Chen",
      avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=40&h=40&fit=crop&crop=face",
      lastMessage: "Let's schedule a meeting for tomorrow",
      timestamp: "1h ago",
      online: false,
      unread: 0
    },
    {
      id: 3,
      name: "Maria Garcia",
      avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=40&h=40&fit=crop&crop=face",
      lastMessage: "The design mockups look great!",
      timestamp: "3h ago",
      online: true,
      unread: 1
    },
    {
      id: 4,
      name: "John Smith",
      avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=40&h=40&fit=crop&crop=face",
      lastMessage: "Can you review the pull request?",
      timestamp: "1d ago",
      online: false,
      unread: 0
    }
  ];

  const messages = [
    {
      id: 1,
      sender: "Sarah Johnson",
      content: "Hey! I saw your post about React state management. Could you help me with something?",
      timestamp: "10:30 AM",
      isOwn: false
    },
    {
      id: 2,
      sender: "You",
      content: "Sure! What do you need help with?",
      timestamp: "10:32 AM",
      isOwn: true
    },
    {
      id: 3,
      sender: "Sarah Johnson",
      content: "I'm having trouble with useEffect dependencies. The effect keeps running on every render.",
      timestamp: "10:33 AM",
      isOwn: false
    },
    {
      id: 4,
      sender: "You",
      content: "That's a common issue! You probably need to add the dependencies to the dependency array or use useCallback for functions.",
      timestamp: "10:35 AM",
      isOwn: true
    },
    {
      id: 5,
      sender: "Sarah Johnson",
      content: "Thanks for the help with the React component! That fixed it perfectly. 🎉",
      timestamp: "10:45 AM",
      isOwn: false
    }
  ];

  const currentConversation = conversations.find(c => c.id === selectedChat);

  const handleSendMessage = (e: React.FormEvent) => {
    e.preventDefault();
    if (newMessage.trim()) {
      console.log("Sending message:", newMessage);
      setNewMessage("");
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
              {conversations.map((conversation) => (
                <div
                  key={conversation.id}
                  onClick={() => setSelectedChat(conversation.id)}
                  className={cn(
                    "flex items-center gap-3 p-4 cursor-pointer transition-colors hover:bg-muted/50",
                    selectedChat === conversation.id && "bg-muted"
                  )}
                >
                  <div className="relative">
                    <Avatar>
                      <AvatarImage src={conversation.avatar} />
                      <AvatarFallback>{conversation.name.charAt(0)}</AvatarFallback>
                    </Avatar>
                    {conversation.online && (
                      <div className="absolute bottom-0 right-0 w-3 h-3 bg-green-500 border-2 border-background rounded-full"></div>
                    )}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between">
                      <h4 className="font-semibold truncate">{conversation.name}</h4>
                      <span className="text-xs text-muted-foreground">{conversation.timestamp}</span>
                    </div>
                    <p className="text-sm text-muted-foreground truncate">{conversation.lastMessage}</p>
                  </div>
                  {conversation.unread > 0 && (
                    <Badge className="h-5 w-5 p-0 text-xs flex items-center justify-center">
                      {conversation.unread}
                    </Badge>
                  )}
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        {/* Chat Area */}
        <Card className="lg:col-span-2 flex flex-col">
          {currentConversation ? (
            <>
              {/* Chat Header */}
              <CardHeader className="flex-row items-center space-y-0 pb-3">
                <div className="flex items-center gap-3">
                  <div className="relative">
                    <Avatar>
                      <AvatarImage src={currentConversation.avatar} />
                      <AvatarFallback>{currentConversation.name.charAt(0)}</AvatarFallback>
                    </Avatar>
                    {currentConversation.online && (
                      <div className="absolute bottom-0 right-0 w-3 h-3 bg-green-500 border-2 border-background rounded-full"></div>
                    )}
                  </div>
                  <div>
                    <h3 className="font-semibold">{currentConversation.name}</h3>
                    <p className="text-sm text-muted-foreground">
                      {currentConversation.online ? "Online" : "Offline"}
                    </p>
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
                {messages.map((message) => (
                  <div
                    key={message.id}
                    className={cn(
                      "flex",
                      message.isOwn ? "justify-end" : "justify-start"
                    )}
                  >
                    <div
                      className={cn(
                        "max-w-[70%] rounded-lg p-3 space-y-1",
                        message.isOwn
                          ? "bg-primary text-primary-foreground ml-4"
                          : "bg-muted mr-4"
                      )}
                    >
                      <p className="text-sm">{message.content}</p>
                      <p
                        className={cn(
                          "text-xs",
                          message.isOwn
                            ? "text-primary-foreground/70"
                            : "text-muted-foreground"
                        )}
                      >
                        {message.timestamp}
                      </p>
                    </div>
                  </div>
                ))}
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
