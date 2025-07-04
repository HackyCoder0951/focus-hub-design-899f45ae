import { useEffect, useState, useRef } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search, Plus, TrendingUp, ChevronUp, ChevronDown, MessageCircle, Loader2, MoreVertical } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";
import { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem } from "@/components/ui/dropdown-menu";

const QandA = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [searchQuery, setSearchQuery] = useState("");
  const [questions, setQuestions] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreatingQuestion, setIsCreatingQuestion] = useState(false);
  const [newQuestion, setNewQuestion] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("All");
  const [selectedQuestion, setSelectedQuestion] = useState<any | null>(null);
  const [allAnswers, setAllAnswers] = useState<any[]>([]);
  const [answerLoading, setAnswerLoading] = useState(false);
  const [newAnswer, setNewAnswer] = useState("");
  const [isSubmittingAnswer, setIsSubmittingAnswer] = useState(false);
  const [selectedAnswer, setSelectedAnswer] = useState<any | null>(null);
  const [answerComments, setAnswerComments] = useState<any[]>([]);
  const [commentInput, setCommentInput] = useState("");
  const [commentLoading, setCommentLoading] = useState(false);
  const [editMode, setEditMode] = useState(false);
  const [editContent, setEditContent] = useState("");
  const commentInputRef = useRef<HTMLInputElement>(null);
  const [answerVotes, setAnswerVotes] = useState<{ [answerId: string]: number }>({});
  const [userVotes, setUserVotes] = useState<{ [answerId: string]: number }>({});
  const [expandedAnswerId, setExpandedAnswerId] = useState<string | null>(null);
  const [questionVotes, setQuestionVotes] = useState<{ [questionId: string]: number }>({});
  const [userQuestionVotes, setUserQuestionVotes] = useState<{ [questionId: string]: number }>({});
  const [editQuestionMode, setEditQuestionMode] = useState<string | null>(null);
  const [editQuestionContent, setEditQuestionContent] = useState("");
  const [replyTo, setReplyTo] = useState<string | null>(null);
  const [replyInput, setReplyInput] = useState("");

  const categories = ["All", "React", "JavaScript", "Python", "Design", "Career"];

  const fetchQuestionsAndAnswers = async () => {
    setLoading(true);
    try {
      // Fetch questions (is_answered: false)
      let qQuery = supabase
        .from('questionanswers')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .eq('is_answered', false)
        .order('created_at', { ascending: false });

      // Fetch answers (is_answered: true)
      let aQuery = supabase
        .from('questionanswers')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .eq('is_answered', true)
        .order('created_at', { ascending: true });

      // Fetch all votes for answers
      let vQuery = (supabase.from as any)('answer_votes')
        .select('*');

      // Fetch all votes for questions
      let qvQuery = (supabase.from as any)('question_votes')
        .select('*');

      const [
        { data: questions },
        { data: answers },
        { data: votes },
        { data: qVotes }
      ] = await Promise.all([qQuery, aQuery, vQuery, qvQuery]);
      setQuestions(questions || []);
      setAllAnswers(answers || []);
      // Group votes by answerId
      const voteCount: { [answerId: string]: number } = {};
      const userVoteMap: { [answerId: string]: number } = {};
      (votes || []).forEach((v: any) => {
        voteCount[v.answer_id] = (voteCount[v.answer_id] || 0) + v.vote_type;
        if (user && v.user_id === user.id) {
          userVoteMap[v.answer_id] = v.vote_type;
        }
      });
      setAnswerVotes(voteCount);
      setUserVotes(userVoteMap);
      // Group question votes by questionId
      const qVoteCount: { [questionId: string]: number } = {};
      const userQVoteMap: { [questionId: string]: number } = {};
      (qVotes || []).forEach((v: any) => {
        qVoteCount[v.question_id] = (qVoteCount[v.question_id] || 0) + v.vote_type;
        if (user && v.user_id === user.id) {
          userQVoteMap[v.question_id] = v.vote_type;
        }
      });
      setQuestionVotes(qVoteCount);
      setUserQuestionVotes(userQVoteMap);
    } catch (error) {
      // handle error
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchQuestionsAndAnswers();
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
      fetchQuestionsAndAnswers(); // Refresh the questions list
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

  const fetchAnswers = async (questionText: string) => {
    setAnswerLoading(true);
    try {
      const { data, error } = await supabase
        .from('questionanswers')
        .select('*, profiles: user_id (full_name, avatar_url)')
        .eq('question', questionText)
        .not('answer', 'is', null)
        .eq('is_answered', true)
        .order('created_at', { ascending: true });
      if (error) throw error;
      setAllAnswers(data || []);
    } catch (error) {
      setAllAnswers([]);
    } finally {
      setAnswerLoading(false);
    }
  };

  const handleOpenQuestion = (question: any) => {
    setSelectedQuestion(question);
    fetchAnswers(question.question);
  };

  const handleCloseDialog = () => {
    setSelectedQuestion(null);
    setAllAnswers([]);
    setNewAnswer("");
  };

  const handleSubmitAnswer = async (questionObj) => {
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
        .from('questionanswers')
        .insert({
          user_id: user.id,
          question: questionObj.question,
          answer: newAnswer.trim(),
          is_answered: true,
        });
      if (error) throw error;
      toast({
        title: "Answer posted!",
        description: "Your answer has been published.",
      });
      setNewAnswer("");
      fetchAnswers(questionObj.question);
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

  const handleVote = async (answerId: string, type: 1 | -1) => {
    if (!user) return;
    const currentUserVote = userVotes[answerId] || 0;
    if (currentUserVote !== 0) return; // Prevent multiple votes

    await (supabase.from as any)('answer_votes').upsert({
      answer_id: answerId,
      user_id: user.id,
      vote_type: type,
    });

    // Update local state instantly
    setUserVotes(prev => ({ ...prev, [answerId]: type }));
    setAnswerVotes(prev => ({
      ...prev,
      [answerId]: (prev[answerId] || 0) + type
    }));
  };

  const handleAddComment = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user || !commentInput.trim() || !selectedAnswer) return;
    setCommentLoading(true);
    await (supabase.from as any)("answer_comments").insert({
      answer_id: selectedAnswer.id,
      user_id: user.id,
      comment: commentInput.trim(),
      parent_comment_id: null,
    });
    setCommentInput("");
    await fetchAnswerComments(selectedAnswer.id);
    setCommentLoading(false);
    if (commentInputRef.current) commentInputRef.current.focus();
  };

  const handleEditAnswer = async (answerId: string, questionText: string, newContent: string) => {
    if (!user || !newContent.trim()) return;
    await supabase.from('questionanswers').update({ answer: newContent.trim() }).eq('id', answerId);
    setEditMode(false);
    setEditContent("");
    fetchAnswers(questionText);
  };

  const handleDeleteAnswer = async (answerId: string, questionText: string) => {
    if (!user) return;
    await supabase.from('questionanswers').delete().eq('id', answerId);
    fetchAnswers(questionText);
  };

  const fetchAnswerComments = async (answerId: string) => {
    setCommentLoading(true);
    try {
      const { data, error } = await (supabase.from as any)("answer_comments")
        .select("*, profiles: user_id (full_name, avatar_url)")
        .eq("answer_id", answerId)
        .order("created_at", { ascending: true });
      if (error) throw error;
      setAnswerComments(data || []);
    } catch {
      setAnswerComments([]);
    } finally {
      setCommentLoading(false);
    }
  };

  const fetchAnswerVotes = async (answerId: string) => {
    const { data: votes, error } = await (supabase.from as any)('answer_votes')
      .select('*')
      .eq('answer_id', answerId);
    if (!error && votes) {
      setAnswerVotes(votes.reduce((sum: number, v: any) => sum + v.vote_type, 0));
      if (user) {
        const myVote = votes.find((v: any) => v.user_id === user.id);
        setUserVotes(myVote ? { [answerId]: myVote.vote_type } : {});
      }
    }
  };

  const handleQuestionVote = async (questionId: string, type: 1 | -1) => {
    if (!user) return;
    const currentUserVote = userQuestionVotes[questionId] || 0;
    if (currentUserVote !== 0) return;

    await (supabase.from as any)('question_votes').upsert({
      question_id: questionId,
      user_id: user.id,
      vote_type: type,
    });

    setUserQuestionVotes(prev => ({ ...prev, [questionId]: type }));
    setQuestionVotes(prev => ({
      ...prev,
      [questionId]: (prev[questionId] || 0) + type
    }));
  };

  const handleEditQuestion = async (questionId: string) => {
    if (!user || !editQuestionContent.trim()) return;
    await supabase.from('questionanswers').update({ question: editQuestionContent.trim() }).eq('id', questionId);
    setEditQuestionMode(null);
    setEditQuestionContent("");
    fetchQuestionsAndAnswers();
  };

  const handleDeleteQuestion = async (questionId: string) => {
    if (!user) return;
    await supabase.from('questionanswers').delete().eq('id', questionId);
    fetchQuestionsAndAnswers();
  };

  const handleDeleteComment = async (commentId: string, answerId: string) => {
    if (!user) return;
    setCommentLoading(true);
    try {
      await (supabase.from as any)("answer_comments").delete().eq("id", commentId);
      await fetchAnswerComments(answerId);
    } catch (error) {
      toast({
        title: "Error deleting comment",
        description: (error as any)?.message || "Something went wrong.",
        variant: "destructive",
      });
    } finally {
      setCommentLoading(false);
    }
  };

  function buildCommentTree(comments) {
    const map = {};
    const roots = [];
    comments.forEach(c => { map[c.id] = { ...c, replies: [] }; });
    comments.forEach(c => {
      if (c.parent_comment_id) {
        map[c.parent_comment_id]?.replies.push(map[c.id]);
      } else {
        roots.push(map[c.id]);
      }
    });
    return roots;
  }

  function CommentThread({ comments }) {
    return comments.map((c) => (
      <div key={c.id} className="flex gap-2 items-start mt-2 ml-0" style={{ marginLeft: c.parent_comment_id ? 24 : 0 }}>
        <Avatar className="h-6 w-6">
          <AvatarImage src={c.profiles?.avatar_url} />
          <AvatarFallback>{c.profiles?.full_name?.charAt(0)}</AvatarFallback>
        </Avatar>
        <div className="bg-muted rounded-lg px-3 py-2 flex-1">
          <div className="flex items-center gap-2">
            <span className="font-medium text-xs">{c.profiles?.full_name || "Unknown User"}</span>
            <span className="text-xs text-muted-foreground">{c.created_at ? new Date(c.created_at).toLocaleString() : ''}</span>
            {user && c.user_id === user.id && (
              <Button
                size="sm"
                variant="ghost"
                className="text-red-500 ml-2 px-2 py-0 h-6"
                onClick={() => handleDeleteComment(c.id, selectedAnswer?.id)}
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
          <div className="text-sm mt-1">{c.comment}</div>
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

  const handleAddReply = async (e: React.FormEvent, parentId: string) => {
    e.preventDefault();
    if (!user || !replyInput.trim() || !selectedAnswer) return;
    setCommentLoading(true);
    await (supabase.from as any)("answer_comments").insert({
      answer_id: selectedAnswer.id,
      user_id: user.id,
      comment: replyInput.trim(),
      parent_comment_id: parentId,
    });
    setReplyInput("");
    setReplyTo(null);
    await fetchAnswerComments(selectedAnswer.id);
    setCommentLoading(false);
  };

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
            filteredQuestions.map((question) => {
              const answersForThisQuestion = allAnswers.filter(ans => ans.question === question.question);
              return (
                <Card key={question.id} className="hover:shadow-md transition-shadow cursor-pointer mb-6">
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
                        <h3 className="font-semibold text-lg hover:text-primary">
                          {question.question}
                        </h3>
                        {!question.is_answered && (
                          <Badge variant="secondary" className="text-xs">Unanswered</Badge>
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
                                    setEditQuestionContent(question.question);
                                  }}
                                >
                                  Edit
                                </DropdownMenuItem>
                                <DropdownMenuItem
                                  onClick={() => {
                                    if (window.confirm('Are you sure you want to delete this question?')) handleDeleteQuestion(question.id);
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
                            <span>{answersForThisQuestion.length} answers</span>
                          </div>
                        </div>
                        {/* Answers Section (in-page, not in dialog) */}
                        <div className="font-semibold mt-4">Answers</div>
                        {answerLoading ? (
                          <div className="text-center py-4"><Loader2 className="h-5 w-5 animate-spin mx-auto" /></div>
                        ) : answersForThisQuestion.length === 0 ? (
                          <div className="text-muted-foreground">No answers yet. Be the first to answer!</div>
                        ) : (
                          <div className="space-y-3 max-h-60 overflow-y-auto">
                            {answersForThisQuestion.map((ans) => (
                              <div key={ans.id} className="border rounded p-3 flex gap-3 items-start">
                                <Avatar className="h-7 w-7">
                                  <AvatarImage src={ans.profiles?.avatar_url} />
                                  <AvatarFallback>{ans.profiles?.full_name?.charAt(0)}</AvatarFallback>
                                </Avatar>
                                <div className="flex-1">
                                  <div className="flex items-center gap-2">
                                    <div className="font-medium">{ans.profiles?.full_name}</div>
                                    <span className="text-xs text-muted-foreground">{ans.created_at ? new Date(ans.created_at).toLocaleString() : ''}</span>
                                  </div>
                                  {editMode && expandedAnswerId === ans.id ? (
                                    <form onSubmit={e => { e.preventDefault(); handleEditAnswer(ans.id, ans.question, editContent); }} className="flex flex-col gap-2 mt-2">
                                      <Textarea value={editContent} onChange={e => setEditContent(e.target.value)} className="min-h-[60px]" />
                                      <div className="flex gap-2 justify-end">
                                        <Button type="submit" size="sm" disabled={!editContent.trim()}>Save</Button>
                                        <Button type="button" size="sm" variant="outline" onClick={() => setEditMode(false)}>Cancel</Button>
                                      </div>
                                    </form>
                                  ) : (
                                    <div className="text-base">{ans.answer}</div>
                                  )}
                                  <div className="flex items-center gap-2 pt-2">
                                    <Button
                                      variant={userVotes[ans.id] === 1 ? "default" : "ghost"}
                                      size="icon"
                                      className="h-8 w-8"
                                      onClick={() => handleVote(ans.id, 1)}
                                      disabled={userVotes[ans.id] !== undefined && userVotes[ans.id] !== 0}
                                    >
                                      <ChevronUp className="h-4 w-4" />
                                    </Button>
                                    <span className="font-semibold text-lg">{answerVotes[ans.id] || 0}</span>
                                    <Button
                                      variant={userVotes[ans.id] === -1 ? "default" : "ghost"}
                                      size="icon"
                                      className="h-8 w-8"
                                      onClick={() => handleVote(ans.id, -1)}
                                      disabled={userVotes[ans.id] !== undefined && userVotes[ans.id] !== 0}
                                    >
                                      <ChevronDown className="h-4 w-4" />
                                    </Button>
                                    {user && ans.user_id === user.id && (
                                      <>
                                        <Button size="sm" variant="outline" onClick={() => { setEditMode(true); setEditContent(ans.answer); setExpandedAnswerId(ans.id); }}>Edit</Button>
                                        <Button size="sm" variant="destructive" onClick={() => handleDeleteAnswer(ans.id, ans.question)}>Delete</Button>
                                      </>
                                    )}
                                    <Button size="sm" variant="ghost" onClick={() => setExpandedAnswerId(expandedAnswerId === ans.id ? null : ans.id)}>
                                      {expandedAnswerId === ans.id ? "Hide Comments" : "Show Comments"}
                                    </Button>
                                  </div>
                                  {expandedAnswerId === ans.id && (
                                    <div className="pt-4">
                                      <div className="font-semibold mb-2">Comments</div>
                                      {commentLoading ? (
                                        <div className="text-center py-2"><Loader2 className="h-4 w-4 animate-spin mx-auto" /></div>
                                      ) : answerComments.length === 0 ? (
                                        <div className="text-muted-foreground">No comments yet.</div>
                                      ) : (
                                        <div className="space-y-2 max-h-40 overflow-y-auto">
                                          {CommentThread({ comments: buildCommentTree(answerComments) })}
                                        </div>
                                      )}
                                      {user && (
                                        <form onSubmit={handleAddComment} className="flex gap-2 items-center mt-3">
                                          <Avatar className="h-6 w-6">
                                            <AvatarImage src={user?.user_metadata?.avatar_url} />
                                            <AvatarFallback>{user?.user_metadata?.full_name?.charAt(0) || "U"}</AvatarFallback>
                                          </Avatar>
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
                                      )}
                                    </div>
                                  )}
                                </div>
                              </div>
                            ))}
                          </div>
                        )}
                        <div className="pt-2">
                          <Textarea
                            placeholder="Write your answer..."
                            value={newAnswer}
                            onChange={e => setNewAnswer(e.target.value)}
                            disabled={isSubmittingAnswer}
                            className="min-h-[80px]"
                          />
                          <div className="flex justify-end pt-2">
                            <Button onClick={() => handleSubmitAnswer(question)} disabled={!newAnswer.trim() || isSubmittingAnswer}>
                              {isSubmittingAnswer ? <Loader2 className="h-4 w-4 mr-2 animate-spin" /> : null}
                              {isSubmittingAnswer ? "Posting..." : "Post Answer"}
                            </Button>
                          </div>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
              );
            })
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
