import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search, Plus, TrendingUp, ChevronUp, ChevronDown, MessageCircle, Loader2 } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";

const QandA = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [searchQuery, setSearchQuery] = useState("");
  const [questions, setQuestions] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreatingQuestion, setIsCreatingQuestion] = useState(false);
  const [newQuestion, setNewQuestion] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("All");

  const categories = ["All", "React", "JavaScript", "Python", "Design", "Career"];

    const fetchQuestions = async () => {
    setLoading(true);
    try {
      let query = supabase
        .from('questionanswers')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .order('created_at', { ascending: false });

      // Apply search filter
      if (searchQuery.trim()) {
        query = query.ilike('question', `%${searchQuery}%`);
      }

      const { data, error } = await query;
      
      if (error) {
        console.error('Error fetching questions:', error);
        return;
      }

      setQuestions(data || []);
    } catch (error) {
      console.error('Error fetching questions:', error);
    } finally {
      setLoading(false);
    }
    };

  useEffect(() => {
    fetchQuestions();
  }, [searchQuery]);

  const handleCreateQuestion = async () => {
    if (!user) {
      toast({
        title: "Authentication required",
        description: "Please sign in to ask a question.",
        variant: "destructive",
      });
      return;
    }

    if (!newQuestion.trim()) {
      toast({
        title: "Question required",
        description: "Please enter your question.",
        variant: "destructive",
      });
      return;
    }

    setIsCreatingQuestion(true);

    try {
      const { error } = await supabase
        .from('questionanswers')
        .insert({
          user_id: user.id,
          question: newQuestion.trim(),
        });

      if (error) throw error;

      toast({
        title: "Question posted!",
        description: "Your question has been published successfully.",
      });

      setNewQuestion("");
      fetchQuestions(); // Refresh the questions list
    } catch (error: any) {
      console.error('Error creating question:', error);
      toast({
        title: "Error creating question",
        description: error.message || "Something went wrong. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsCreatingQuestion(false);
    }
  };

  const filteredQuestions = questions.filter(question => {
    if (selectedCategory === "All") return true;
    // For now, we'll just show all questions since we don't have category field
    // In a real app, you'd filter by category
    return true;
  });

  const unansweredQuestions = questions.filter(question => !question.is_answered);

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex flex-col md:flex-row gap-4 items-start md:items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Q&A Community</h1>
          <p className="text-muted-foreground">Ask questions, share knowledge, learn together</p>
        </div>
        <Dialog>
          <DialogTrigger asChild>
        <Button className="flex items-center gap-2">
          <Plus className="h-4 w-4" />
          Ask Question
        </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[500px]">
            <DialogHeader>
              <DialogTitle>Ask a Question</DialogTitle>
            </DialogHeader>
            <div className="space-y-4">
              <Textarea
                placeholder="What would you like to ask?"
                value={newQuestion}
                onChange={(e) => setNewQuestion(e.target.value)}
                className="min-h-[120px]"
                disabled={isCreatingQuestion}
              />
              <div className="flex justify-end gap-2">
                <Button
                  onClick={handleCreateQuestion}
                  disabled={!newQuestion.trim() || isCreatingQuestion}
                >
                  {isCreatingQuestion ? (
                    <>
                      <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                      Posting...
                    </>
                  ) : (
                    'Post Question'
                  )}
                </Button>
              </div>
            </div>
          </DialogContent>
        </Dialog>
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
                  variant={category === selectedCategory ? "default" : "outline"}
                  className="cursor-pointer hover:bg-primary hover:text-primary-foreground"
                  onClick={() => setSelectedCategory(category)}
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
            <div className="text-center py-10">
              <Loader2 className="h-8 w-8 animate-spin mx-auto" />
              <p className="mt-2 text-muted-foreground">Loading questions...</p>
            </div>
          ) : filteredQuestions.length === 0 ? (
            <div className="text-center py-10 text-muted-foreground">No questions found.</div>
          ) : (
            filteredQuestions.map((question) => (
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
                        {!question.is_answered && (
                          <Badge variant="secondary" className="text-xs">Unanswered</Badge>
                        )}
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
        
        <TabsContent value="unanswered" className="space-y-4">
          {loading ? (
            <div className="text-center py-10">
              <Loader2 className="h-8 w-8 animate-spin mx-auto" />
              <p className="mt-2 text-muted-foreground">Loading questions...</p>
            </div>
          ) : unansweredQuestions.length === 0 ? (
            <div className="text-center py-10 text-muted-foreground">No unanswered questions found.</div>
          ) : (
            unansweredQuestions.map((question) => (
              <Card key={question.id} className="hover:shadow-md transition-shadow cursor-pointer">
                <CardContent className="p-6">
                  <div className="flex gap-4">
                    <div className="flex flex-col items-center space-y-1 min-w-[60px]">
                      <Button variant="ghost" size="icon" className="h-8 w-8">
                        <ChevronUp className="h-4 w-4" />
                      </Button>
                      <span className="font-semibold text-lg">{question.votes ?? 0}</span>
                      <Button variant="ghost" size="icon" className="h-8 w-8">
                        <ChevronDown className="h-4 w-4" />
                      </Button>
                    </div>
                    <div className="flex-1 space-y-3">
                      <div className="flex items-center gap-2">
                        <h3 className="font-semibold text-lg hover:text-primary">
                          {question.question}
                        </h3>
                        <Badge variant="secondary" className="text-xs">Unanswered</Badge>
                      </div>
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
                      </div>
                    </div>
          </div>
                </CardContent>
              </Card>
            ))
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default QandA;
