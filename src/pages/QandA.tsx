import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search, Plus, TrendingUp, ChevronUp, ChevronDown, MessageCircle } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { supabase } from "@/integrations/supabase/client";

const QandA = () => {
  const [searchQuery, setSearchQuery] = useState("");
  const [questions, setQuestions] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchQuestions = async () => {
      const { data, error } = await supabase
        .from('questionanswers')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .order('created_at', { ascending: false });
      if (!error && data) setQuestions(data);
      setLoading(false);
    };
    fetchQuestions();
  }, []);

  const categories = ["All", "React", "JavaScript", "Python", "Design", "Career"];

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
          {loading ? (
            <div className="text-center py-10">Loading...</div>
          ) : questions.length === 0 ? (
            <div className="text-center py-10 text-muted-foreground">No questions found.</div>
          ) : (
            questions.map((question) => (
              <Card key={question.id} className="hover:shadow-md transition-shadow cursor-pointer">
                <CardContent className="p-6">
                  <div className="flex gap-4">
                    {/* Vote Section */}
                    <div className="flex flex-col items-center space-y-1 min-w-[60px]">
                      <Button variant="ghost" size="icon" className="h-8 w-8">
                        <ChevronUp className="h-4 w-4" />
                      </Button>
                      <span className="font-semibold text-lg">{question.votes ?? 0}</span>
                      <Button variant="ghost" size="icon" className="h-8 w-8">
                        <ChevronDown className="h-4 w-4" />
                      </Button>
                    </div>
                    {/* Question Content */}
                    <div className="flex-1 space-y-3">
                      <div className="flex items-center gap-2">
                        <h3 className="font-semibold text-lg hover:text-primary">
                          {question.question}
                        </h3>
                      </div>
                      <p className="text-muted-foreground text-sm line-clamp-2">
                        {question.answer || "No answer yet."}
                      </p>
                      <div className="flex items-center justify-between text-sm text-muted-foreground">
                        <div className="flex items-center gap-4">
                          <div className="flex items-center gap-2">
                            <Avatar className="h-6 w-6">
                              <AvatarImage src={question.profiles?.avatar_url} />
                              <AvatarFallback>{question.profiles?.full_name?.charAt(0)}</AvatarFallback>
                            </Avatar>
                            <span>{question.profiles?.full_name}</span>
                          </div>
                          <span>{question.created_at ? new Date(question.created_at).toLocaleDateString() : ''}</span>
                        </div>
                        <div className="flex items-center gap-1">
                          <MessageCircle className="h-4 w-4" />
                          <span>{question.answers_count ?? 0} answers</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
          )}
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
