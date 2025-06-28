
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search, Plus, TrendingUp, ChevronUp, ChevronDown, MessageCircle } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";

const QandA = () => {
  const [searchQuery, setSearchQuery] = useState("");
  
  const categories = ["All", "React", "JavaScript", "Python", "Design", "Career"];
  
  const questions = [
    {
      id: 1,
      title: "How to handle state management in large React applications?",
      content: "I'm working on a large React app and struggling with state management. What are the best practices?",
      author: {
        name: "Alex Thompson",
        avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=40&h=40&fit=crop&crop=face"
      },
      votes: 15,
      answers: 8,
      tags: ["React", "State Management"],
      timestamp: "2 hours ago",
      trending: true
    },
    {
      id: 2,
      title: "Best practices for API design in Node.js?",
      content: "Looking for recommendations on structuring RESTful APIs with Node.js and Express.",
      author: {
        name: "Maria Garcia",
        avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=40&h=40&fit=crop&crop=face"
      },
      votes: 23,
      answers: 12,
      tags: ["Node.js", "API", "Backend"],
      timestamp: "4 hours ago",
      trending: false
    },
    {
      id: 3,
      title: "How to transition from design to frontend development?",
      content: "I'm a UI/UX designer wanting to learn frontend development. Where should I start?",
      author: {
        name: "Sarah Chen",
        avatar: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=40&h=40&fit=crop&crop=face"
      },
      votes: 8,
      answers: 15,
      tags: ["Career", "Frontend", "Design"],
      timestamp: "1 day ago",
      trending: false
    }
  ];

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex flex-col md:flex-row gap-4 items-start md:items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Q&A Community</h1>
          <p className="text-muted-foreground">Ask questions, share knowledge, learn together</p>
        </div>
        <Button className="flex items-center gap-2">
          <Plus className="h-4 w-4" />
          Ask Question
        </Button>
      </div>

      {/* Search and Filters */}
      <Card>
        <CardContent className="p-6">
          <div className="space-y-4">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                placeholder="Search questions..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="pl-10"
              />
            </div>
            <div className="flex flex-wrap gap-2">
              {categories.map((category) => (
                <Badge
                  key={category}
                  variant={category === "All" ? "default" : "outline"}
                  className="cursor-pointer hover:bg-primary hover:text-primary-foreground"
                >
                  {category}
                </Badge>
              ))}
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Questions List */}
      <Tabs defaultValue="recent" className="space-y-6">
        <TabsList>
          <TabsTrigger value="recent">Recent</TabsTrigger>
          <TabsTrigger value="trending">
            <TrendingUp className="h-4 w-4 mr-2" />
            Trending
          </TabsTrigger>
          <TabsTrigger value="unanswered">Unanswered</TabsTrigger>
        </TabsList>

        <TabsContent value="recent" className="space-y-4">
          {questions.map((question) => (
            <Card key={question.id} className="hover:shadow-md transition-shadow cursor-pointer">
              <CardContent className="p-6">
                <div className="flex gap-4">
                  {/* Vote Section */}
                  <div className="flex flex-col items-center space-y-1 min-w-[60px]">
                    <Button variant="ghost" size="icon" className="h-8 w-8">
                      <ChevronUp className="h-4 w-4" />
                    </Button>
                    <span className="font-semibold text-lg">{question.votes}</span>
                    <Button variant="ghost" size="icon" className="h-8 w-8">
                      <ChevronDown className="h-4 w-4" />
                    </Button>
                  </div>

                  {/* Question Content */}
                  <div className="flex-1 space-y-3">
                    <div className="flex items-start justify-between">
                      <div className="space-y-2">
                        <div className="flex items-center gap-2">
                          <h3 className="font-semibold text-lg hover:text-primary">
                            {question.title}
                          </h3>
                          {question.trending && (
                            <Badge variant="destructive" className="text-xs">
                              <TrendingUp className="h-3 w-3 mr-1" />
                              Trending
                            </Badge>
                          )}
                        </div>
                        <p className="text-muted-foreground text-sm line-clamp-2">
                          {question.content}
                        </p>
                      </div>
                    </div>

                    <div className="flex flex-wrap gap-2">
                      {question.tags.map((tag) => (
                        <Badge key={tag} variant="secondary" className="text-xs">
                          {tag}
                        </Badge>
                      ))}
                    </div>

                    <div className="flex items-center justify-between text-sm text-muted-foreground">
                      <div className="flex items-center gap-4">
                        <div className="flex items-center gap-2">
                          <Avatar className="h-6 w-6">
                            <AvatarImage src={question.author.avatar} />
                            <AvatarFallback>{question.author.name.charAt(0)}</AvatarFallback>
                          </Avatar>
                          <span>{question.author.name}</span>
                        </div>
                        <span>{question.timestamp}</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <MessageCircle className="h-4 w-4" />
                        <span>{question.answers} answers</span>
                      </div>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </TabsContent>

        <TabsContent value="trending">
          <div className="text-center py-8">
            <p className="text-muted-foreground">Trending questions will appear here</p>
          </div>
        </TabsContent>

        <TabsContent value="unanswered">
          <div className="text-center py-8">
            <p className="text-muted-foreground">Unanswered questions will appear here</p>
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default QandA;
