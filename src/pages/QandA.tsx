import { useEffect, useState, useRef } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search, Plus, TrendingUp, ChevronUp, ChevronDown, MessageCircle, Loader2, MoreVertical, CheckCircle } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";
import { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem } from "@/components/ui/dropdown-menu";
import AIAnswer from "@/components/AIAnswer";
import type { Database } from "@/integrations/supabase/types";

type Question = Database['public']['Tables']['questions']['Row'] & {
  profiles: { full_name: string | null; avatar_url: string | null } | null;
  answer_count?: number;
  vote_score?: number;
};

type Answer = Database['public']['Tables']['answers']['Row'] & {
  profiles: { full_name: string | null; avatar_url: string | null } | null;
  vote_score?: number;
};

type Comment = Database['public']['Tables']['answer_comments']['Row'] & {
  profiles: { full_name: string | null; avatar_url: string | null } | null;
  replies?: Comment[];
};

const QandA = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [searchQuery, setSearchQuery] = useState("");
  const [questions, setQuestions] = useState<Question[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreatingQuestion, setIsCreatingQuestion] = useState(false);
  const [newQuestionTitle, setNewQuestionTitle] = useState("");
  const [newQuestionBody, setNewQuestionBody] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("All");
  const [selectedQuestion, setSelectedQuestion] = useState<Question | null>(null);
  const [answers, setAnswers] = useState<Answer[]>([]);
  const [answerLoading, setAnswerLoading] = useState(false);
  const [newAnswer, setNewAnswer] = useState("");
  const [isSubmittingAnswer, setIsSubmittingAnswer] = useState(false);
  const [selectedAnswer, setSelectedAnswer] = useState<Answer | null>(null);
  const [answerComments, setAnswerComments] = useState<Comment[]>([]);
  const [commentInput, setCommentInput] = useState("");
  const [commentLoading, setCommentLoading] = useState(false);
  const [editMode, setEditMode] = useState(false);
  const [editContent, setEditContent] = useState("");
  const commentInputRef = useRef<HTMLInputElement>(null);
  const [answerVotes, setAnswerVotes] = useState<{ [answerId: number]: number }>({});
  const [userAnswerVotes, setUserAnswerVotes] = useState<{ [answerId: number]: number }>({});
  const [expandedAnswerId, setExpandedAnswerId] = useState<number | null>(null);
  const [questionVotes, setQuestionVotes] = useState<{ [questionId: number]: number }>({});
  const [userQuestionVotes, setUserQuestionVotes] = useState<{ [questionId: number]: number }>({});
  const [editQuestionMode, setEditQuestionMode] = useState<number | null>(null);
  const [editQuestionTitle, setEditQuestionTitle] = useState("");
  const [editQuestionBody, setEditQuestionBody] = useState("");
  const [replyTo, setReplyTo] = useState<number | null>(null);
  const [replyInput, setReplyInput] = useState("");

  const categories = ["All", "React", "JavaScript", "Python", "Design", "Career"];

  const fetchQuestions = async () => {
    setLoading(true);
    try {
      // Fetch questions with user profiles and answer counts
      const { data: questionsData, error: questionsError } = await supabase
        .from('questions')
        .select(`
          *,
          profiles:user_id(id, full_name, avatar_url),
          answers!inner(count)
        `)
        .order('created_at', { ascending: false });

      if (questionsError) throw questionsError;

      // Fetch vote counts for questions
      const { data: questionVotesData, error: votesError } = await supabase
        .from('question_votes')
        .select('*');

      if (votesError) throw votesError;

      // Process questions data
      const processedQuestions = (questionsData || []).map((q: any) => ({
        ...q,
        answer_count: q.answers?.[0]?.count || 0
      }));

      // Process vote data
      const voteCount: { [questionId: number]: number } = {};
      const userVoteMap: { [questionId: number]: number } = {};
      
      (questionVotesData || []).forEach((v: any) => {
        voteCount[v.question_id] = (voteCount[v.question_id] || 0) + v.vote_value;
        if (user && v.user_id === user.id) {
          userVoteMap[v.question_id] = v.vote_value;
        }
      });

      setQuestions(processedQuestions);
      setQuestionVotes(voteCount);
      setUserQuestionVotes(userVoteMap);
    } catch (error) {
      console.error('Error fetching questions:', error);
      toast({
        title: "Error loading questions",
        description: "Failed to load questions. Please try again.",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const fetchAnswers = async (questionId: number) => {
    setAnswerLoading(true);
    try {
      const { data: answersData, error: answersError } = await supabase
        .from('answers')
        .select(`
          *,
          profiles:user_id(id, full_name, avatar_url)
        `)
        .eq('question_id', questionId)
        .order('is_accepted', { ascending: false })
        .order('created_at', { ascending: true });

      if (answersError) throw answersError;

      // Fetch vote counts for answers
      const { data: answerVotesData, error: votesError } = await supabase
        .from('answer_votes')
        .select('*')
        .in('answer_id', answersData?.map(a => a.id) || []);

      if (votesError) throw votesError;

      // Process vote data
      const voteCount: { [answerId: number]: number } = {};
      const userVoteMap: { [answerId: number]: number } = {};
      
      (answerVotesData || []).forEach((v: any) => {
        voteCount[v.answer_id] = (voteCount[v.answer_id] || 0) + v.vote_value;
        if (user && v.user_id === user.id) {
          userVoteMap[v.answer_id] = v.vote_value;
        }
      });

      setAnswers(answersData || []);
      setAnswerVotes(voteCount);
      setUserAnswerVotes(userVoteMap);
    } catch (error) {
      console.error('Error fetching answers:', error);
      setAnswers([]);
    } finally {
      setAnswerLoading(false);
    }
  };

  useEffect(() => {
    fetchQuestions();
  }, []);

  const handleCreateQuestion = async () => {
    if (!user) {
      toast({
        title: "Authentication required",
        description: "Please sign in to ask a question.",
        variant: "destructive",
      });
      return;
    }

    if (!newQuestionTitle.trim() || !newQuestionBody.trim()) {
      toast({
        title: "Question required",
        description: "Please enter both title and body for your question.",
        variant: "destructive",
      });
      return;
    }

    setIsCreatingQuestion(true);

    try {
      const { error } = await supabase
        .from('questions')
        .insert({
          user_id: user.id,
          title: newQuestionTitle.trim(),
          body: newQuestionBody.trim(),
          category: selectedCategory === "All" ? null : selectedCategory,
        });

      if (error) throw error;

      toast({
        title: "Question posted!",
        description: "Your question has been published successfully.",
      });

      setNewQuestionTitle("");
      setNewQuestionBody("");
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
    return question.category === selectedCategory;
  });

  const unansweredQuestions = questions.filter(question => question.answer_count === 0);

  const handleOpenQuestion = (question: Question) => {
    setSelectedQuestion(question);
    fetchAnswers(question.id);
  };

  const handleCloseDialog = () => {
    setSelectedQuestion(null);
    setAnswers([]);
    setNewAnswer("");
  };

  const handleSubmitAnswer = async (questionId: number) => {
    if (!user) {
      toast({
        title: "Authentication required",
        description: "Please sign in to answer.",
        variant: "destructive",
      });
      return;
    }
    if (!newAnswer.trim()) {
      toast({
        title: "Answer required",
        description: "Please enter your answer.",
        variant: "destructive",
      });
      return;
    }
    setIsSubmittingAnswer(true);
    try {
      const { error } = await supabase
        .from('answers')
        .insert({
          user_id: user.id,
          question_id: questionId,
          body: newAnswer.trim(),
        });
      if (error) throw error;
      toast({
        title: "Answer posted!",
        description: "Your answer has been published.",
      });
      setNewAnswer("");
      fetchAnswers(questionId);
      fetchQuestions(); // Refresh question count
    } catch (error: any) {
      toast({
        title: "Error posting answer",
        description: error.message || "Something went wrong.",
        variant: "destructive",
      });
    } finally {
      setIsSubmittingAnswer(false);
    }
  };

  const handleVote = async (answerId: number, voteValue: 1 | -1) => {
    if (!user) return;
    
    try {
      const { error } = await supabase
        .from('answer_votes')
        .upsert({
          answer_id: answerId,
          user_id: user.id,
          vote_value: voteValue,
        });

      if (error) throw error;

      // Update local state
      setUserAnswerVotes(prev => ({ ...prev, [answerId]: voteValue }));
      setAnswerVotes(prev => ({
        ...prev,
        [answerId]: (prev[answerId] || 0) + voteValue
      }));
    } catch (error) {
      console.error('Error voting:', error);
    }
  };

  const handleQuestionVote = async (questionId: number, voteValue: 1 | -1) => {
    if (!user) return;
    
    try {
      const { error } = await supabase
        .from('question_votes')
        .upsert({
          question_id: questionId,
          user_id: user.id,
          vote_value: voteValue,
        });

      if (error) throw error;

      // Update local state
      setUserQuestionVotes(prev => ({ ...prev, [questionId]: voteValue }));
      setQuestionVotes(prev => ({
        ...prev,
        [questionId]: (prev[questionId] || 0) + voteValue
      }));
    } catch (error) {
      console.error('Error voting:', error);
    }
  };

  const handleAddComment = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user || !commentInput.trim() || !selectedAnswer) return;
    
    setCommentLoading(true);
    try {
      const { error } = await supabase
        .from('answer_comments')
        .insert({
          answer_id: selectedAnswer.id,
          user_id: user.id,
          body: commentInput.trim(),
          parent_comment_id: null,
        });

      if (error) throw error;

      setCommentInput("");
      await fetchAnswerComments(selectedAnswer.id);
    } catch (error) {
      console.error('Error adding comment:', error);
    } finally {
      setCommentLoading(false);
      if (commentInputRef.current) commentInputRef.current.focus();
    }
  };

  const fetchAnswerComments = async (answerId: number) => {
    setCommentLoading(true);
    try {
      const { data, error } = await supabase
        .from('answer_comments')
        .select(`
          *,
          profiles:user_id(id, full_name, avatar_url)
        `)
        .eq('answer_id', answerId)
        .order('created_at', { ascending: true });

      if (error) throw error;
      setAnswerComments(data || []);
    } catch (error) {
      console.error('Error fetching comments:', error);
      setAnswerComments([]);
    } finally {
      setCommentLoading(false);
    }
  };

  const handleEditAnswer = async (answerId: number, newContent: string) => {
    if (!user || !newContent.trim()) return;
    
    try {
      const { error } = await supabase
        .from('answers')
        .update({ body: newContent.trim() })
        .eq('id', answerId);

      if (error) throw error;

      setEditMode(false);
      setEditContent("");
      if (selectedQuestion) {
        fetchAnswers(selectedQuestion.id);
      }
    } catch (error) {
      console.error('Error editing answer:', error);
    }
  };

  const handleDeleteAnswer = async (answerId: number) => {
    if (!user) return;
    
    try {
      const { error } = await supabase
        .from('answers')
        .delete()
        .eq('id', answerId);

      if (error) throw error;

      if (selectedQuestion) {
        fetchAnswers(selectedQuestion.id);
        fetchQuestions(); // Refresh question count
      }
    } catch (error) {
      console.error('Error deleting answer:', error);
    }
  };

  const handleEditQuestion = async (questionId: number) => {
    if (!user || !editQuestionTitle.trim() || !editQuestionBody.trim()) return;
    
    try {
      const { error } = await supabase
        .from('questions')
        .update({ 
          title: editQuestionTitle.trim(),
          body: editQuestionBody.trim()
        })
        .eq('id', questionId);

      if (error) throw error;

      setEditQuestionMode(null);
      setEditQuestionTitle("");
      setEditQuestionBody("");
      fetchQuestions();
    } catch (error) {
      console.error('Error editing question:', error);
    }
  };

  const handleDeleteQuestion = async (questionId: number) => {
    if (!user) return;
    
    try {
      const { error } = await supabase
        .from('questions')
        .delete()
        .eq('id', questionId);

      if (error) throw error;

      fetchQuestions();
    } catch (error) {
      console.error('Error deleting question:', error);
    }
  };

  const handleDeleteComment = async (commentId: number, answerId: number) => {
    if (!user) return;
    
    setCommentLoading(true);
    try {
      const { error } = await supabase
        .from('answer_comments')
        .delete()
        .eq('id', commentId);

      if (error) throw error;

      await fetchAnswerComments(answerId);
    } catch (error) {
      console.error('Error deleting comment:', error);
      toast({
        title: "Error deleting comment",
        description: "Something went wrong.",
        variant: "destructive",
      });
    } finally {
      setCommentLoading(false);
    }
  };

  const handleAddReply = async (e: React.FormEvent, parentId: number) => {
    e.preventDefault();
    if (!user || !replyInput.trim() || !selectedAnswer) return;
    
    setCommentLoading(true);
    try {
      const { error } = await supabase
        .from('answer_comments')
        .insert({
          answer_id: selectedAnswer.id,
          user_id: user.id,
          body: replyInput.trim(),
          parent_comment_id: parentId,
        });

      if (error) throw error;

      setReplyInput("");
      setReplyTo(null);
      await fetchAnswerComments(selectedAnswer.id);
    } catch (error) {
      console.error('Error adding reply:', error);
    } finally {
      setCommentLoading(false);
    }
  };

  const handleAcceptAnswer = async (answerId: number) => {
    if (!user || !selectedQuestion) return;
    
    try {
      // First, unaccept all other answers for this question
      await supabase
        .from('answers')
        .update({ is_accepted: false })
        .eq('question_id', selectedQuestion.id);

      // Then accept the selected answer
      const { error } = await supabase
        .from('answers')
        .update({ is_accepted: true })
        .eq('id', answerId);

      if (error) throw error;

      fetchAnswers(selectedQuestion.id);
    } catch (error) {
      console.error('Error accepting answer:', error);
    }
  };

  function buildCommentTree(comments: Comment[]): Comment[] {
    const map: { [key: number]: Comment } = {};
    const roots: Comment[] = [];
    
    comments.forEach(c => { 
      map[c.id] = { ...c, replies: [] }; 
    });
    
    comments.forEach(c => {
      if (c.parent_comment_id) {
        map[c.parent_comment_id]?.replies?.push(map[c.id]);
      } else {
        roots.push(map[c.id]);
      }
    });
    
    return roots;
  }

  function CommentThread({ comments }: { comments: Comment[] }) {
    return comments.map((c) => (
      <div key={c.id} className="flex gap-2 items-start mt-2 ml-0" style={{ marginLeft: c.parent_comment_id ? 24 : 0 }}>
        <Avatar className="h-6 w-6">
          <AvatarImage src={c.profiles?.avatar_url || undefined} />
          <AvatarFallback>{c.profiles?.full_name?.charAt(0) || "U"}</AvatarFallback>
        </Avatar>
        <div className="bg-muted rounded-lg px-3 py-2 flex-1">
          <div className="flex items-center gap-2">
            <span className="font-medium text-xs">{c.profiles?.full_name || "Unknown User"}</span>
            <span className="text-xs text-muted-foreground">{new Date(c.created_at).toLocaleString()}</span>
            {user && c.user_id === user.id && (
              <Button
                size="sm"
                variant="ghost"
                className="text-red-500 ml-2 px-2 py-0 h-6"
                onClick={() => handleDeleteComment(c.id, selectedAnswer?.id || 0)}
                disabled={commentLoading}
              >
                Delete
              </Button>
            )}
            <Button
              size="sm"
              variant="ghost"
              className="ml-2 px-2 py-0 h-6"
              onClick={() => setReplyTo(c.id)}
              disabled={commentLoading}
            >
              Reply
            </Button>
          </div>
          <div className="text-sm mt-1">{c.body}</div>
          {replyTo === c.id && (
            <form onSubmit={e => handleAddReply(e, c.id)} className="flex gap-2 items-center mt-2">
              <input
                type="text"
                className="flex-1 rounded-full border px-3 py-2 text-sm bg-background focus:outline-none focus:ring-2 focus:ring-primary"
                placeholder="Write a reply..."
                value={replyInput}
                onChange={e => setReplyInput(e.target.value)}
                disabled={commentLoading}
                maxLength={500}
                autoFocus
              />
              <Button type="submit" size="sm" disabled={commentLoading || !replyInput.trim()}>
                Post
              </Button>
              <Button type="button" size="sm" variant="outline" onClick={() => setReplyTo(null)}>
                Cancel
              </Button>
            </form>
          )}
          {c.replies && c.replies.length > 0 && (
            <div className="ml-6 border-l border-muted-foreground/20 pl-4 mt-2">
              <CommentThread comments={c.replies} />
            </div>
          )}
        </div>
      </div>
    ));
  }

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
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader>
              <DialogTitle>Ask a Question</DialogTitle>
            </DialogHeader>
            <div className="space-y-4">
              <div>
                <label className="text-sm font-medium">Title</label>
                <Input
                  placeholder="What's your question? Be specific."
                  value={newQuestionTitle}
                  onChange={(e) => setNewQuestionTitle(e.target.value)}
                  className="mt-1"
                  disabled={isCreatingQuestion}
                />
              </div>
              <div>
                <label className="text-sm font-medium">Details</label>
                <Textarea
                  placeholder="Provide more context about your question..."
                  value={newQuestionBody}
                  onChange={(e) => setNewQuestionBody(e.target.value)}
                  className="min-h-[120px] mt-1"
                  disabled={isCreatingQuestion}
                />
              </div>
              <div>
                <label className="text-sm font-medium">Category</label>
                <select
                  value={selectedCategory}
                  onChange={(e) => setSelectedCategory(e.target.value)}
                  className="w-full mt-1 p-2 border rounded-md"
                  disabled={isCreatingQuestion}
                >
                  {categories.map((category) => (
                    <option key={category} value={category}>
                      {category}
                    </option>
                  ))}
                </select>
              </div>
              <div className="flex justify-end gap-2">
                <Button
                  onClick={handleCreateQuestion}
                  disabled={!newQuestionTitle.trim() || !newQuestionBody.trim() || isCreatingQuestion}
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
                      <Button
                        variant={userQuestionVotes[question.id] === 1 ? "default" : "ghost"}
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleQuestionVote(question.id, 1)}
                        disabled={userQuestionVotes[question.id] !== undefined && userQuestionVotes[question.id] !== 0}
                      >
                        <ChevronUp className="h-4 w-4" />
                      </Button>
                      <span className="font-semibold text-lg">{questionVotes[question.id] || 0}</span>
                      <Button
                        variant={userQuestionVotes[question.id] === -1 ? "default" : "ghost"}
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleQuestionVote(question.id, -1)}
                        disabled={userQuestionVotes[question.id] !== undefined && userQuestionVotes[question.id] !== 0}
                      >
                        <ChevronDown className="h-4 w-4" />
                      </Button>
                    </div>
                    {/* Question Content */}
                    <div className="flex-1 space-y-3">
                      <div className="flex items-center gap-2">
                        <h3 
                          className="font-semibold text-lg hover:text-primary cursor-pointer"
                          onClick={() => handleOpenQuestion(question)}
                        >
                          {question.title}
                        </h3>
                        {question.answer_count === 0 && (
                          <Badge variant="secondary" className="text-xs">Unanswered</Badge>
                        )}
                        {question.best_answer_id && (
                          <Badge variant="default" className="text-xs">
                            <CheckCircle className="h-3 w-3 mr-1" />
                            Answered
                          </Badge>
                        )}
                        {user && question.user_id === user.id && editQuestionMode !== question.id && (
                          <div className="ml-auto">
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" size="icon">
                                  <MoreVertical className="h-5 w-5" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent>
                                <DropdownMenuItem
                                  onClick={() => {
                                    setEditQuestionMode(question.id);
                                    setEditQuestionTitle(question.title);
                                    setEditQuestionBody(question.body);
                                  }}
                                >
                                  Edit
                                </DropdownMenuItem>
                                <DropdownMenuItem
                                  onClick={() => {
                                    if (window.confirm('Are you sure you want to delete this question?')) {
                                      handleDeleteQuestion(question.id);
                                    }
                                  }}
                                  className="text-red-600"
                                >
                                  Delete
                                </DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </div>
                        )}
                      </div>
                      
                      {editQuestionMode === question.id ? (
                        <div className="space-y-2">
                          <Input
                            value={editQuestionTitle}
                            onChange={(e) => setEditQuestionTitle(e.target.value)}
                            placeholder="Question title"
                          />
                          <Textarea
                            value={editQuestionBody}
                            onChange={(e) => setEditQuestionBody(e.target.value)}
                            placeholder="Question details"
                            className="min-h-[80px]"
                          />
                          <div className="flex gap-2 justify-end">
                            <Button 
                              size="sm" 
                              onClick={() => handleEditQuestion(question.id)}
                              disabled={!editQuestionTitle.trim() || !editQuestionBody.trim()}
                            >
                              Save
                            </Button>
                            <Button 
                              size="sm" 
                              variant="outline" 
                              onClick={() => setEditQuestionMode(null)}
                            >
                              Cancel
                            </Button>
                          </div>
                        </div>
                      ) : (
                        <p className="text-muted-foreground text-sm line-clamp-2">
                          {question.body}
                        </p>
                      )}
                      
                      <div className="flex items-center justify-between text-sm text-muted-foreground">
                        <div className="flex items-center gap-4">
                          <div className="flex items-center gap-2">
                            <Avatar className="h-6 w-6">
                              <AvatarImage src={question.profiles?.avatar_url || undefined} />
                              <AvatarFallback>{question.profiles?.full_name?.charAt(0) || "U"}</AvatarFallback>
                            </Avatar>
                            <span>{question.profiles?.full_name || "Unknown User"}</span>
                          </div>
                          <span>{new Date(question.created_at).toLocaleDateString()}</span>
                          {question.category && (
                            <Badge variant="outline" className="text-xs">{question.category}</Badge>
                          )}
                        </div>
                        <div className="flex items-center gap-1">
                          <MessageCircle className="h-4 w-4" />
                          <span>{question.answer_count} answers</span>
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
                      <Button
                        variant={userQuestionVotes[question.id] === 1 ? "default" : "ghost"}
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleQuestionVote(question.id, 1)}
                        disabled={userQuestionVotes[question.id] !== undefined && userQuestionVotes[question.id] !== 0}
                      >
                        <ChevronUp className="h-4 w-4" />
                      </Button>
                      <span className="font-semibold text-lg">{questionVotes[question.id] || 0}</span>
                      <Button
                        variant={userQuestionVotes[question.id] === -1 ? "default" : "ghost"}
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleQuestionVote(question.id, -1)}
                        disabled={userQuestionVotes[question.id] !== undefined && userQuestionVotes[question.id] !== 0}
                      >
                        <ChevronDown className="h-4 w-4" />
                      </Button>
                    </div>
                    <div className="flex-1 space-y-3">
                      <div className="flex items-center gap-2">
                        <h3 
                          className="font-semibold text-lg hover:text-primary cursor-pointer"
                          onClick={() => handleOpenQuestion(question)}
                        >
                          {question.title}
                        </h3>
                        <Badge variant="secondary" className="text-xs">Unanswered</Badge>
                      </div>
                      <p className="text-muted-foreground text-sm line-clamp-2">
                        {question.body}
                      </p>
                      <div className="flex items-center justify-between text-sm text-muted-foreground">
                        <div className="flex items-center gap-4">
                          <div className="flex items-center gap-2">
                            <Avatar className="h-6 w-6">
                              <AvatarImage src={question.profiles?.avatar_url || undefined} />
                              <AvatarFallback>{question.profiles?.full_name?.charAt(0) || "U"}</AvatarFallback>
                            </Avatar>
                            <span>{question.profiles?.full_name || "Unknown User"}</span>
                          </div>
                          <span>{new Date(question.created_at).toLocaleDateString()}</span>
                          {question.category && (
                            <Badge variant="outline" className="text-xs">{question.category}</Badge>
                          )}
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

      {/* Question Detail Dialog */}
      {selectedQuestion && (
        <Dialog open={!!selectedQuestion} onOpenChange={handleCloseDialog}>
          <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>{selectedQuestion.title}</DialogTitle>
            </DialogHeader>
            
            <div className="space-y-6">
              {/* Question Details */}
              <div className="bg-muted p-4 rounded-lg">
                <p className="text-sm">{selectedQuestion.body}</p>
                <div className="flex items-center gap-4 mt-3 text-sm text-muted-foreground">
                  <div className="flex items-center gap-2">
                    <Avatar className="h-6 w-6">
                      <AvatarImage src={selectedQuestion.profiles?.avatar_url || undefined} />
                      <AvatarFallback>{selectedQuestion.profiles?.full_name?.charAt(0) || "U"}</AvatarFallback>
                    </Avatar>
                    <span>{selectedQuestion.profiles?.full_name || "Unknown User"}</span>
                  </div>
                  <span>{new Date(selectedQuestion.created_at).toLocaleDateString()}</span>
                  {selectedQuestion.category && (
                    <Badge variant="outline">{selectedQuestion.category}</Badge>
                  )}
                </div>
              </div>

              {/* AI Answer Section */}
              <AIAnswer 
                questionId={selectedQuestion.id.toString()}
                question={selectedQuestion.title + "\n\n" + selectedQuestion.body}
                onAnswerGenerated={(answer) => {
                  // Refresh the answers list to show the AI answer
                  fetchAnswers(selectedQuestion.id);
                }}
              />
              
              {/* User Answers Section */}
              <div className="space-y-4">
                <h3 className="text-lg font-semibold">User Answers</h3>
                {answerLoading ? (
                  <div className="text-center py-4">
                    <Loader2 className="h-5 w-5 animate-spin mx-auto" />
                  </div>
                ) : answers.length === 0 ? (
                  <div className="text-muted-foreground">No user answers yet. Be the first to answer!</div>
                ) : (
                  <div className="space-y-4">
                    {answers.map((answer) => (
                      <div key={answer.id} className="border rounded-lg p-4">
                        <div className="flex gap-3 items-start">
                          <Avatar className="h-8 w-8">
                            <AvatarImage src={answer.profiles?.avatar_url || undefined} />
                            <AvatarFallback>{answer.profiles?.full_name?.charAt(0) || "U"}</AvatarFallback>
                          </Avatar>
                          <div className="flex-1">
                            <div className="flex items-center gap-2 mb-2">
                              <div className="font-medium">{answer.profiles?.full_name || "Unknown User"}</div>
                              <span className="text-xs text-muted-foreground">
                                {new Date(answer.created_at).toLocaleString()}
                              </span>
                              {answer.is_accepted && (
                                <Badge variant="default" className="text-xs">
                                  <CheckCircle className="h-3 w-3 mr-1" />
                                  Accepted
                                </Badge>
                              )}
                            </div>
                            
                            {editMode && expandedAnswerId === answer.id ? (
                              <form onSubmit={e => { 
                                e.preventDefault(); 
                                handleEditAnswer(answer.id, editContent); 
                              }} className="space-y-2">
                                <Textarea 
                                  value={editContent} 
                                  onChange={e => setEditContent(e.target.value)} 
                                  className="min-h-[80px]" 
                                />
                                <div className="flex gap-2 justify-end">
                                  <Button type="submit" size="sm" disabled={!editContent.trim()}>
                                    Save
                                  </Button>
                                  <Button 
                                    type="button" 
                                    size="sm" 
                                    variant="outline" 
                                    onClick={() => setEditMode(false)}
                                  >
                                    Cancel
                                  </Button>
                                </div>
                              </form>
                            ) : (
                              <div className="text-base mb-3">{answer.body}</div>
                            )}
                            
                            <div className="flex items-center gap-2">
                              <Button
                                variant={userAnswerVotes[answer.id] === 1 ? "default" : "ghost"}
                                size="icon"
                                className="h-8 w-8"
                                onClick={() => handleVote(answer.id, 1)}
                                disabled={userAnswerVotes[answer.id] !== undefined && userAnswerVotes[answer.id] !== 0}
                              >
                                <ChevronUp className="h-4 w-4" />
                              </Button>
                              <span className="font-semibold text-lg">{answerVotes[answer.id] || 0}</span>
                              <Button
                                variant={userAnswerVotes[answer.id] === -1 ? "default" : "ghost"}
                                size="icon"
                                className="h-8 w-8"
                                onClick={() => handleVote(answer.id, -1)}
                                disabled={userAnswerVotes[answer.id] !== undefined && userAnswerVotes[answer.id] !== 0}
                              >
                                <ChevronDown className="h-4 w-4" />
                              </Button>
                            </div>
                            
                            {/* Answer Actions */}
                            <div className="flex items-center gap-2 mt-3">
                              {user && answer.user_id === user.id && (
                                <>
                                  <Button
                                    size="sm"
                                    variant="ghost"
                                    onClick={() => {
                                      setEditMode(true);
                                      setExpandedAnswerId(answer.id);
                                      setEditContent(answer.body);
                                    }}
                                  >
                                    Edit
                                  </Button>
                                  <Button
                                    size="sm"
                                    variant="ghost"
                                    className="text-red-500"
                                    onClick={() => {
                                      if (window.confirm('Are you sure you want to delete this answer?')) {
                                        handleDeleteAnswer(answer.id);
                                      }
                                    }}
                                  >
                                    Delete
                                  </Button>
                                </>
                              )}
                              {user && selectedQuestion && selectedQuestion.user_id === user.id && !answer.is_accepted && (
                                <Button
                                  size="sm"
                                  variant="outline"
                                  onClick={() => handleAcceptAnswer(answer.id)}
                                >
                                  Accept Answer
                                </Button>
                              )}
                              <Button
                                size="sm"
                                variant="ghost"
                                onClick={() => {
                                  setSelectedAnswer(answer);
                                  fetchAnswerComments(answer.id);
                                  setExpandedAnswerId(expandedAnswerId === answer.id ? null : answer.id);
                                }}
                              >
                                <MessageCircle className="h-4 w-4 mr-1" />
                                Comments
                              </Button>
                            </div>
                            
                            {/* Comments Section */}
                            {expandedAnswerId === answer.id && selectedAnswer?.id === answer.id && (
                              <div className="mt-4 border-t pt-4">
                                <h4 className="font-medium mb-3">Comments</h4>
                                {commentLoading ? (
                                  <div className="text-center py-2">
                                    <Loader2 className="h-4 w-4 animate-spin mx-auto" />
                                  </div>
                                ) : (
                                  <>
                                    <CommentThread comments={buildCommentTree(answerComments)} />
                                    <form onSubmit={handleAddComment} className="flex gap-2 items-center mt-3">
                                      <input
                                        ref={commentInputRef}
                                        type="text"
                                        className="flex-1 rounded-full border px-3 py-2 text-sm bg-background focus:outline-none focus:ring-2 focus:ring-primary"
                                        placeholder="Add a comment..."
                                        value={commentInput}
                                        onChange={e => setCommentInput(e.target.value)}
                                        disabled={commentLoading}
                                        maxLength={500}
                                      />
                                      <Button type="submit" size="sm" disabled={commentLoading || !commentInput.trim()}>
                                        Post
                                      </Button>
                                    </form>
                                  </>
                                )}
                              </div>
                            )}
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
              
              {/* Add Answer Section */}
              <div className="border-t pt-6">
                <h3 className="text-lg font-semibold mb-4">Your Answer</h3>
                <div className="space-y-4">
                  <Textarea
                    placeholder="Write your answer..."
                    value={newAnswer}
                    onChange={(e) => setNewAnswer(e.target.value)}
                    className="min-h-[120px]"
                    disabled={isSubmittingAnswer}
                  />
                  <div className="flex justify-end">
                    <Button
                      onClick={() => handleSubmitAnswer(selectedQuestion.id)}
                      disabled={!newAnswer.trim() || isSubmittingAnswer}
                    >
                      {isSubmittingAnswer ? (
                        <>
                          <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                          Posting...
                        </>
                      ) : (
                        'Post Answer'
                      )}
                    </Button>
                  </div>
                </div>
              </div>
            </div>
          </DialogContent>
        </Dialog>
      )}
    </div>
  );
};

export default QandA;