# Q&A Module Implementation

## Overview

The Q&A module provides a comprehensive question-and-answer system with AI-powered answer generation, voting mechanisms, and reputation tracking.

## Core Components

### 1. Q&A Page Component

**File**: `src/pages/QandA.tsx`
```typescript
import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Plus, Search, Filter } from 'lucide-react';
import { QuestionCard } from '@/components/QuestionCard';
import { CreateQuestion } from '@/components/CreateQuestion';
import { useToast } from '@/hooks/use-toast';

interface Question {
  id: string;
  question: string;
  answer: string | null;
  is_answered: boolean;
  created_at: string;
  updated_at: string;
  user_id: string;
  profiles: {
    full_name: string;
    avatar_url: string | null;
  };
  question_votes: { vote_type: number }[];
  answers: { id: string }[];
  tags: { tag: string }[];
}

const QandA = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [filter, setFilter] = useState<'all' | 'unanswered' | 'answered'>('all');
  const [showCreateForm, setShowCreateForm] = useState(false);

  const fetchQuestions = async () => {
    try {
      let query = supabase
        .from('questionanswers')
        .select(`
          *,
          profiles (full_name, avatar_url),
          question_votes (vote_type),
          answers (id),
          tags (tag)
        `)
        .order('created_at', { ascending: false });

      // Apply filters
      if (filter === 'unanswered') {
        query = query.eq('is_answered', false);
      } else if (filter === 'answered') {
        query = query.eq('is_answered', true);
      }

      // Apply search
      if (searchQuery.trim()) {
        query = query.ilike('question', `%${searchQuery}%`);
      }

      const { data, error } = await query;

      if (error) throw error;
      setQuestions(data || []);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load questions",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchQuestions();

    // Set up real-time subscription
    const channel = supabase
      .channel('questions')
      .on('postgres_changes', 
        { event: '*', schema: 'public', table: 'questionanswers' },
        () => {
          fetchQuestions();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [filter, searchQuery]);

  const handleQuestionCreated = () => {
    setShowCreateForm(false);
    fetchQuestions();
  };

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">Q&A</h1>
        <Button onClick={() => setShowCreateForm(true)}>
          <Plus className="h-4 w-4 mr-2" />
          Ask Question
        </Button>
      </div>

      <div className="flex items-center space-x-4">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-muted-foreground h-4 w-4" />
          <Input
            placeholder="Search questions..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-10"
          />
        </div>
        <Button variant="outline">
          <Filter className="h-4 w-4 mr-2" />
          Filter
        </Button>
      </div>

      <Tabs value={filter} onValueChange={(value) => setFilter(value as any)}>
        <TabsList>
          <TabsTrigger value="all">All Questions</TabsTrigger>
          <TabsTrigger value="unanswered">Unanswered</TabsTrigger>
          <TabsTrigger value="answered">Answered</TabsTrigger>
        </TabsList>
      </Tabs>

      {showCreateForm && (
        <CreateQuestion onQuestionCreated={handleQuestionCreated} />
      )}

      <div className="space-y-4">
        {questions.map((question) => (
          <QuestionCard
            key={question.id}
            question={question}
            currentUserId={user?.id}
            onUpdate={fetchQuestions}
          />
        ))}
      </div>

      {questions.length === 0 && !loading && (
        <div className="text-center py-12">
          <p className="text-muted-foreground">No questions found.</p>
        </div>
      )}
    </div>
  );
};

export default QandA;
```

### 2. Question Card Component

**File**: `src/components/QuestionCard.tsx`
```typescript
import { useState } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Textarea } from '@/components/ui/textarea';
import { ThumbsUp, ThumbsDown, MessageSquare, Brain, CheckCircle } from 'lucide-react';
import { formatDistanceToNow } from 'date-fns';
import { useToast } from '@/hooks/use-toast';
import { AIAnswer } from './AIAnswer';

interface QuestionCardProps {
  question: any;
  currentUserId?: string;
  onUpdate: () => void;
}

export const QuestionCard = ({ question, currentUserId, onUpdate }: QuestionCardProps) => {
  const { profile } = useAuth();
  const { toast } = useToast();
  const [showAnswerForm, setShowAnswerForm] = useState(false);
  const [newAnswer, setNewAnswer] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [userVote, setUserVote] = useState(0);
  const [voteCount, setVoteCount] = useState(0);

  // Calculate vote count and user vote
  useState(() => {
    const votes = question.question_votes || [];
    setVoteCount(votes.reduce((sum: number, vote: any) => sum + vote.vote_type, 0));
    
    const userVoteData = votes.find((vote: any) => vote.user_id === currentUserId);
    setUserVote(userVoteData?.vote_type || 0);
  });

  const handleVote = async (voteType: number) => {
    if (!currentUserId) return;

    try {
      if (userVote === voteType) {
        // Remove vote
        await supabase
          .from('question_votes')
          .delete()
          .eq('question_id', question.id)
          .eq('user_id', currentUserId);
        
        setVoteCount(prev => prev - voteType);
        setUserVote(0);
      } else {
        // Update or create vote
        await supabase
          .from('question_votes')
          .upsert({
            question_id: question.id,
            user_id: currentUserId,
            vote_type: voteType
          });

        setVoteCount(prev => prev - userVote + voteType);
        setUserVote(voteType);
      }
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to update vote",
        variant: "destructive",
      });
    }
  };

  const handleAnswer = async () => {
    if (!currentUserId || !newAnswer.trim()) return;

    setIsSubmitting(true);
    try {
      const { error } = await supabase
        .from('answers')
        .insert({
          question_id: question.id,
          user_id: currentUserId,
          answer: newAnswer.trim()
        });

      if (error) throw error;

      // Mark question as answered
      await supabase
        .from('questionanswers')
        .update({ is_answered: true })
        .eq('id', question.id);

      setNewAnswer('');
      setShowAnswerForm(false);
      onUpdate();

      toast({
        title: "Success",
        description: "Answer posted successfully",
      });
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to post answer",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <Card>
      <CardHeader>
        <div className="flex items-start justify-between">
          <div className="flex items-center space-x-3">
            <Avatar>
              <AvatarImage src={question.profiles?.avatar_url} />
              <AvatarFallback>
                {question.profiles?.full_name?.charAt(0) || 'U'}
              </AvatarFallback>
            </Avatar>
            <div>
              <p className="font-medium">{question.profiles?.full_name}</p>
              <p className="text-sm text-muted-foreground">
                {formatDistanceToNow(new Date(question.created_at), { addSuffix: true })}
              </p>
            </div>
          </div>
          
          <div className="flex items-center space-x-2">
            {question.is_answered && (
              <Badge variant="secondary" className="bg-green-100 text-green-800">
                <CheckCircle className="h-3 w-3 mr-1" />
                Answered
              </Badge>
            )}
            {question.tags?.map((tag: any) => (
              <Badge key={tag.tag} variant="outline">
                {tag.tag}
              </Badge>
            ))}
          </div>
        </div>
      </CardHeader>

      <CardContent className="space-y-4">
        <CardTitle className="text-lg">{question.question}</CardTitle>

        {question.answer && (
          <div className="bg-muted p-4 rounded-lg">
            <p className="whitespace-pre-wrap">{question.answer}</p>
          </div>
        )}

        <div className="flex items-center justify-between pt-4 border-t">
          <div className="flex items-center space-x-4">
            <div className="flex items-center space-x-2">
              <Button
                variant="ghost"
                size="sm"
                onClick={() => handleVote(1)}
                className={userVote === 1 ? 'text-green-600' : ''}
              >
                <ThumbsUp className={`h-4 w-4 ${userVote === 1 ? 'fill-current' : ''}`} />
              </Button>
              <span className="text-sm font-medium">{voteCount}</span>
              <Button
                variant="ghost"
                size="sm"
                onClick={() => handleVote(-1)}
                className={userVote === -1 ? 'text-red-600' : ''}
              >
                <ThumbsDown className={`h-4 w-4 ${userVote === -1 ? 'fill-current' : ''}`} />
              </Button>
            </div>

            <div className="flex items-center space-x-2 text-sm text-muted-foreground">
              <MessageSquare className="h-4 w-4" />
              <span>{question.answers?.length || 0} answers</span>
            </div>
          </div>

          <div className="flex items-center space-x-2">
            <Dialog>
              <DialogTrigger asChild>
                <Button variant="outline" size="sm">
                  <Brain className="h-4 w-4 mr-2" />
                  AI Answer
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>AI-Generated Answer</DialogTitle>
                </DialogHeader>
                <AIAnswer questionId={question.id} question={question.question} />
              </DialogContent>
            </Dialog>

            {!question.is_answered && (
              <Button
                variant="outline"
                size="sm"
                onClick={() => setShowAnswerForm(true)}
              >
                Answer
              </Button>
            )}
          </div>
        </div>

        {showAnswerForm && (
          <div className="space-y-3 pt-4 border-t">
            <Textarea
              placeholder="Write your answer..."
              value={newAnswer}
              onChange={(e) => setNewAnswer(e.target.value)}
              rows={4}
            />
            <div className="flex space-x-2">
              <Button onClick={handleAnswer} disabled={isSubmitting}>
                {isSubmitting ? 'Posting...' : 'Post Answer'}
              </Button>
              <Button
                variant="outline"
                onClick={() => setShowAnswerForm(false)}
              >
                Cancel
              </Button>
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
};
```

### 3. AI Answer Component

**File**: `src/components/AIAnswer.tsx`
```typescript
import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Brain, Loader2, Copy, Check } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

interface AIAnswerProps {
  questionId: string;
  question: string;
}

export const AIAnswer = ({ questionId, question }: AIAnswerProps) => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [aiAnswer, setAiAnswer] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [copied, setCopied] = useState(false);

  const generateAIAnswer = async () => {
    if (!user) return;

    setLoading(true);
    try {
      const response = await fetch('/api/ai-answers/generate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${user.access_token}`
        },
        body: JSON.stringify({
          question,
          questionId
        })
      });

      const data = await response.json();

      if (data.success) {
        setAiAnswer(data.aiAnswer.answer);
        toast({
          title: "Success",
          description: "AI answer generated successfully",
        });
      } else {
        throw new Error(data.error);
      }
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "Failed to generate AI answer",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const copyToClipboard = async () => {
    if (!aiAnswer) return;

    try {
      await navigator.clipboard.writeText(aiAnswer);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
      toast({
        title: "Copied",
        description: "Answer copied to clipboard",
      });
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to copy to clipboard",
        variant: "destructive",
      });
    }
  };

  useEffect(() => {
    // Check if AI answer already exists
    const checkExistingAnswer = async () => {
      try {
        const { data, error } = await supabase
          .from('ai_answers')
          .select('answer')
          .eq('question_id', questionId)
          .single();

        if (!error && data) {
          setAiAnswer(data.answer);
        }
      } catch (error) {
        // No existing answer found
      }
    };

    checkExistingAnswer();
  }, [questionId]);

  return (
    <div className="space-y-4">
      {!aiAnswer && !loading && (
        <div className="text-center py-8">
          <Brain className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
          <p className="text-muted-foreground mb-4">
            Generate an AI-powered answer to this question
          </p>
          <Button onClick={generateAIAnswer}>
            <Brain className="h-4 w-4 mr-2" />
            Generate AI Answer
          </Button>
        </div>
      )}

      {loading && (
        <div className="text-center py-8">
          <Loader2 className="h-8 w-8 mx-auto animate-spin mb-4" />
          <p className="text-muted-foreground">
            Generating AI answer...
          </p>
        </div>
      )}

      {aiAnswer && (
        <Card>
          <CardContent className="p-4">
            <div className="flex items-start justify-between mb-4">
              <div className="flex items-center space-x-2">
                <Brain className="h-4 w-4 text-blue-600" />
                <span className="font-medium text-sm">AI Answer</span>
              </div>
              <Button
                variant="ghost"
                size="sm"
                onClick={copyToClipboard}
              >
                {copied ? (
                  <Check className="h-4 w-4 text-green-600" />
                ) : (
                  <Copy className="h-4 w-4" />
                )}
              </Button>
            </div>
            <p className="whitespace-pre-wrap text-sm">{aiAnswer}</p>
          </CardContent>
        </Card>
      )}
    </div>
  );
};
```

## AI Integration

### 1. AI Answer API

**File**: `src/api/ai-answers.js`
```javascript
import express from 'express';
import { supabase } from './supabaseClient.js';
import Groq from 'groq-sdk';
import { requireAuth } from './requireAuth.js';

const router = express.Router();

// Initialize Groq
const groq = new Groq({
  apiKey: process.env.GROQ_API_KEY,
});

// Generate AI answer
router.post('/generate', requireAuth, async (req, res) => {
  const { question, questionId } = req.body;
  
  if (!question || !questionId) {
    return res.status(400).json({ error: 'Question and questionId are required' });
  }

  try {
    // Generate AI answer using Groq
    const completion = await groq.chat.completions.create({
      model: "llama3-8b-8192",
      messages: [
        {
          role: "system",
          content: `You are a helpful expert on a professional networking platform. 
          Provide concise, accurate, and helpful answers to questions. 
          Keep answers under 200 words and focus on being practical and actionable.
          Format your response in a clear, professional manner.`
        },
        {
          role: "user",
          content: question
        }
      ],
      max_tokens: 300,
      temperature: 0.7,
    });

    const aiAnswer = completion.choices[0].message.content;

    // Store the AI answer
    const { data, error } = await supabase
      .from('ai_answers')
      .insert([{
        question_id: questionId,
        answer: aiAnswer,
        generated_by: 'groq',
        user_id: req.user.id
      }])
      .select()
      .single();

    if (error) {
      console.error('Error storing AI answer:', error);
      return res.status(500).json({ error: 'Failed to store AI answer' });
    }

    res.json({
      success: true,
      aiAnswer: data,
      message: 'AI answer generated successfully'
    });

  } catch (error) {
    console.error('Error generating AI answer:', error);
    res.status(500).json({ 
      error: 'Failed to generate AI answer',
      details: error.message 
    });
  }
});

// Get AI answer for a question
router.get('/question/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const { data, error } = await supabase
      .from('ai_answers')
      .select('*')
      .eq('question_id', id)
      .single();

    if (error && error.code !== 'PGRST116') {
      return res.status(500).json({ error: error.message });
    }

    res.json({ aiAnswer: data || null });

  } catch (error) {
    console.error('Error fetching AI answer:', error);
    res.status(500).json({ error: 'Failed to fetch AI answer' });
  }
});

export default router;
```

## Database Schema

### Questions Table
```sql
CREATE TABLE questionanswers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  answer TEXT,
  is_answered BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Answers Table
```sql
CREATE TABLE answers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question_id UUID REFERENCES questionanswers(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  answer TEXT NOT NULL,
  is_accepted BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Voting Tables
```sql
CREATE TABLE question_votes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question_id UUID REFERENCES questionanswers(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  vote_type INTEGER CHECK (vote_type IN (-1, 0, 1)),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(question_id, user_id)
);

CREATE TABLE answer_votes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  answer_id UUID REFERENCES answers(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  vote_type INTEGER CHECK (vote_type IN (-1, 0, 1)),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(answer_id, user_id)
);
```

### AI Answers Table
```sql
CREATE TABLE ai_answers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question_id UUID REFERENCES questionanswers(id) ON DELETE CASCADE,
  answer TEXT NOT NULL,
  generated_by TEXT NOT NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

This Q&A module provides a comprehensive question-and-answer system with AI integration, voting mechanisms, and real-time updates. 