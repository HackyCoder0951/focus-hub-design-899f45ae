import React, { useState, useEffect } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Loader2, Sparkles, ThumbsUp, ThumbsDown, Copy, Check } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';
import { supabase } from '@/integrations/supabase/client';

interface AIAnswerProps {
  questionId: string;
  question: string;
  onAnswerGenerated?: (answer: any) => void;
}

const AIAnswer: React.FC<AIAnswerProps> = ({ questionId, question, onAnswerGenerated }) => {
  const [aiAnswer, setAiAnswer] = useState<any>(null);
  const [loading, setLoading] = useState(false);
  const [generating, setGenerating] = useState(false);
  const [copied, setCopied] = useState(false);
  const [helpful, setHelpful] = useState<'helpful' | 'not-helpful' | null>(null);
  const { toast } = useToast();

  // Fetch existing AI answer
  useEffect(() => {
    const fetchAIAnswer = async () => {
      setLoading(true);
      try {
        const supabaseAny = supabase as any;
        const { data, error } = await supabaseAny
          .from('ai_answers')
          .select('*')
          .eq('question_id', questionId)
          .single();

        if (error && error.code !== 'PGRST116') {
          console.error('Error fetching AI answer:', error);
        } else if (data) {
          setAiAnswer(data);
        }
      } catch (error) {
        console.error('Error fetching AI answer:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchAIAnswer();
  }, [questionId]);

  // Generate AI answer
  const generateAIAnswer = async () => {
    setGenerating(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      const accessToken = session?.access_token;

      console.log('Token:', accessToken);

      const response = await fetch('/api/ai-answers/generate', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${accessToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          question,
          questionId,
        }),
      });

      const result = await response.json();

      if (response.ok) {
        setAiAnswer(result.aiAnswer);
        toast({
          title: "AI Answer Generated!",
          description: "An AI-generated answer has been created for this question.",
        });
        if (onAnswerGenerated) {
          onAnswerGenerated(result.aiAnswer);
        }
      } else {
        throw new Error(result.error || 'Failed to generate AI answer');
      }
    } catch (error: any) {
      console.error('Error generating AI answer:', error);
      toast({
        title: "Error",
        description: error.message || "Failed to generate AI answer. Please try again.",
        variant: "destructive",
      });
    } finally {
      setGenerating(false);
    }
  };

  // Copy answer to clipboard
  const copyToClipboard = async () => {
    if (aiAnswer?.answer_text) {
      try {
        await navigator.clipboard.writeText(aiAnswer.answer_text);
        setCopied(true);
        toast({
          title: "Copied!",
          description: "AI answer copied to clipboard.",
        });
        setTimeout(() => setCopied(false), 2000);
      } catch (error) {
        console.error('Failed to copy:', error);
      }
    }
  };

  // Mark as helpful/not helpful
  const handleFeedback = async (isHelpful: boolean) => {
    try {
      const { data: { session } } = await supabase.auth.getSession();
      const accessToken = session?.access_token;

      // PATCH feedback
      await fetch(`/api/ai-answers/${aiAnswer.id}/feedback`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${accessToken}`
        },
        body: JSON.stringify({ user_feedback_rating: isHelpful ? 1 : 0 })
      });

      // Re-fetch updated AI answer
      const response = await fetch(`/api/ai-answers/${aiAnswer.id}`, {
        headers: { 'Authorization': `Bearer ${accessToken}` }
      });
      const result = await response.json();

      if (response.ok) {
        setAiAnswer(result.aiAnswer);
        toast({
          title: "AI Answer Updated!",
          description: "AI answer updated based on your feedback.",
        });
      } else {
        throw new Error(result.error || 'Failed to update AI answer');
      }
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "Failed to update AI answer. Please try again.",
        variant: "destructive",
      });
    }
  };

  if (loading) {
    return (
      <Card className="mb-4 border-dashed border-2">
        <CardContent className="p-4">
          <div className="flex items-center justify-center space-x-2">
            <Loader2 className="h-4 w-4 animate-spin" />
            <span className="text-sm text-muted-foreground">Loading AI answer...</span>
          </div>
        </CardContent>
      </Card>
    );
  }

  if (!aiAnswer) {
    return (
      <Card className="mb-4 border-dashed border-2">
        <CardContent className="p-4">
          <div className="text-center space-y-3">
            <div className="flex items-center justify-center space-x-2">
              <Sparkles className="h-5 w-5 text-primary" />
              <span className="text-sm font-medium">AI Answer</span>
            </div>
            <p className="text-sm text-muted-foreground">
              Get an instant AI-generated answer to this question
            </p>
            <Button
              onClick={generateAIAnswer}
              disabled={generating}
              size="sm"
              className="w-full"
            >
              {generating ? (
                <>
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  Generating...
                </>
              ) : (
                <>
                  <Sparkles className="h-4 w-4 mr-2" />
                  Generate AI Answer
                </>
              )}
            </Button>
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="mb-4 border-primary/20 bg-primary/5">
      <CardContent className="p-4">
        <div className="space-y-3">
          {/* Header */}
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <Sparkles className="h-4 w-4 text-primary" />
              <Badge variant="secondary" className="text-xs">
                AI Answer
              </Badge>
              <span className="text-xs text-muted-foreground">
                Generated {new Date(aiAnswer.created_at).toLocaleDateString()}
              </span>
            </div>
            <Button
              variant="ghost"
              size="sm"
              onClick={copyToClipboard}
              className="h-8 w-8 p-0"
            >
              {copied ? (
                <Check className="h-4 w-4 text-green-500" />
              ) : (
                <Copy className="h-4 w-4" />
              )}
            </Button>
          </div>

          {/* Answer Content */}
          <div className="prose prose-sm max-w-none">
            <p className="text-sm leading-relaxed">{aiAnswer.answer_text}</p>
          </div>

          {/* Feedback */}
          <div className="flex items-center justify-between pt-2 border-t">
            <div className="flex items-center space-x-2">
              <span className="text-xs text-muted-foreground">Was this helpful?</span>
              <Button
                variant={helpful === 'helpful' ? 'default' : 'ghost'}
                size="sm"
                onClick={() => handleFeedback(true)}
                className="h-6 px-2"
              >
                <ThumbsUp className="h-3 w-3 mr-1" />
                Yes
              </Button>
              <Button
                variant={helpful === 'not-helpful' ? 'default' : 'ghost'}
                size="sm"
                onClick={() => handleFeedback(false)}
                className="h-6 px-2"
              >
                <ThumbsDown className="h-3 w-3 mr-1" />
                No
              </Button>
            </div>
            <Button
              variant="outline"
              size="sm"
              onClick={generateAIAnswer}
              disabled={generating}
              className="h-6 px-2 text-xs"
            >
              {generating ? (
                <Loader2 className="h-3 w-3 animate-spin" />
              ) : (
                'Regenerate'
              )}
            </Button>
          </div>
        </div>
      </CardContent>
    </Card>
  );
};

export default AIAnswer; 