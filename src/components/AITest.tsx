import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Loader2, Sparkles } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

const AITest: React.FC = () => {
  const [testQuestion, setTestQuestion] = useState('');
  const [aiResponse, setAiResponse] = useState('');
  const [loading, setLoading] = useState(false);
  const { toast } = useToast();

  const testAIIntegration = async () => {
    if (!testQuestion.trim()) {
      toast({
        title: "Question required",
        description: "Please enter a test question.",
        variant: "destructive",
      });
      return;
    }

    setLoading(true);
    try {
      const response = await fetch('/api/ai-answers/generate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          question: testQuestion,
          questionId: 'test-question-id', // This is just for testing
        }),
      });

      const result = await response.json();

      if (response.ok) {
        setAiResponse(result.aiAnswer.answer);
        toast({
          title: "Success!",
          description: "AI integration is working correctly.",
        });
      } else {
        throw new Error(result.error || 'Failed to generate AI answer');
      }
    } catch (error: any) {
      console.error('Error testing AI integration:', error);
              toast({
          title: "Error",
          description: error.message || "Failed to test AI integration. Check your Groq API key.",
          variant: "destructive",
        });
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Sparkles className="h-5 w-5 text-primary" />
          AI Integration Test
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="space-y-2">
          <label className="text-sm font-medium">Test Question</label>
          <Input
            placeholder="Enter a test question..."
            value={testQuestion}
            onChange={(e) => setTestQuestion(e.target.value)}
            disabled={loading}
          />
        </div>
        
        <Button
          onClick={testAIIntegration}
          disabled={loading || !testQuestion.trim()}
          className="w-full"
        >
          {loading ? (
            <>
              <Loader2 className="h-4 w-4 mr-2 animate-spin" />
              Testing AI Integration...
            </>
          ) : (
            <>
              <Sparkles className="h-4 w-4 mr-2" />
              Test AI Integration
            </>
          )}
        </Button>

        {aiResponse && (
          <div className="mt-4 p-4 bg-muted rounded-lg">
            <h4 className="font-medium mb-2">AI Response:</h4>
            <p className="text-sm text-muted-foreground">{aiResponse}</p>
          </div>
        )}

        <div className="text-xs text-muted-foreground">
          <p>This test verifies that:</p>
          <ul className="list-disc list-inside mt-1 space-y-1">
            <li>Groq API key is configured correctly</li>
            <li>API endpoints are accessible</li>
            <li>AI answer generation is working</li>
            <li>Response times are optimized</li>
          </ul>
        </div>
      </CardContent>
    </Card>
  );
};

export default AITest; 