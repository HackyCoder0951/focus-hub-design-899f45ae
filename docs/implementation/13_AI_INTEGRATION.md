# AI Integration Implementation

## Overview
This document details the implementation of AI-powered answer generation in Focus Hub, covering backend and frontend integration, API flow, database schema, environment setup, customization, and troubleshooting.

---

## Architecture
- **Backend:** Node.js/Express API endpoints in `src/api/ai-answers.js` integrate with the Groq API for answer generation.
- **Frontend:** Q&A page and `AIAnswer` component interact with the backend to request, display, and manage AI-generated answers.
- **Database:** AI answers and feedback are stored in the `ai_answers` table in Supabase.

**High-Level Flow:**
1. User requests an AI answer from the Q&A UI
2. Frontend sends a request to `/api/ai-answers/generate`
3. Backend calls Groq API, processes the response, and stores the answer
4. Answer is returned to the frontend and displayed in the UI
5. Users can rate, copy, or regenerate the answer

---

## Backend Integration
- **File:** `src/api/ai-answers.js`
- **Endpoints:**
  - `POST /api/ai-answers/generate` – Generate and store AI answer
  - `GET /api/ai-answers/question/:id` – Retrieve AI answer for a question
  - `PATCH /api/ai-answers/:id/feedback` – Update feedback rating
- **Groq API:** Used for fast, cost-effective, and privacy-focused answer generation
- **Authentication:** Requires user authentication for answer generation and feedback

### Example: Backend Endpoint Implementation
```js
// src/api/ai-answers.js (excerpt)
import express from 'express';
import { supabase } from './supabaseClient.js';
import Groq from 'groq-sdk';
import { requireAuth } from './requireAuth.js';
const router = express.Router();

const groq = new Groq({ apiKey: process.env.GROQ_API_KEY });

router.post('/generate', requireAuth, async (req, res) => {
  const { question, questionId } = req.body;
  const userId = req.user?.sub;
  if (!userId) return res.status(401).json({ error: 'Authentication required' });
  if (!question || !questionId) return res.status(400).json({ error: 'Question and questionId are required' });
  try {
    const completion = await groq.chat.completions.create({
      model: 'llama3-8b-8192',
      messages: [
        { role: 'system', content: 'You are a helpful expert...' },
        { role: 'user', content: question }
      ],
      max_tokens: 300,
      temperature: 0.7,
    });
    const aiAnswer = completion.choices[0].message.content;
    const { data, error } = await supabase
      .from('ai_answers')
      .insert([{ question_id: questionId, answer_text: aiAnswer, generated_by: 'groq', user_id: userId }])
      .select()
      .single();
    if (error) return res.status(500).json({ error: 'Failed to store AI answer', details: error.message });
    res.json({ success: true, aiAnswer: data, message: 'AI answer generated successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to generate AI answer', details: error.message });
  }
});
```

---

## Frontend Integration
- **Q&A Page:** Integrates the `AIAnswer` component for requesting and displaying AI answers
- **Component:** `src/components/AIAnswer.tsx`
- **User Actions:**
  - Generate AI answer
  - Copy answer to clipboard
  - Rate answer (feedback)
  - Regenerate answer
- **UX:** Loading, error, and success states are handled in the UI

### Example: Fetching an AI Answer (Frontend)
```ts
// Example function to generate an AI answer from the frontend
async function generateAIAnswer(question: string, questionId: string, token: string) {
  const response = await fetch('/api/ai-answers/generate', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify({ question, questionId })
  });
  const data = await response.json();
  if (data.success) {
    return data.aiAnswer;
  } else {
    throw new Error(data.error || 'Failed to generate AI answer');
  }
}
```

### Example: Using the AIAnswer Component
```tsx
// src/components/AIAnswer.tsx (excerpt)
import React, { useState } from 'react';

interface AIAnswerProps {
  questionId: string;
  question: string;
}

export const AIAnswer: React.FC<AIAnswerProps> = ({ questionId, question }) => {
  const [aiAnswer, setAiAnswer] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const handleGenerate = async () => {
    setLoading(true);
    try {
      const response = await fetch('/api/ai-answers/generate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ question, questionId })
      });
      const data = await response.json();
      if (data.success) setAiAnswer(data.aiAnswer.answer_text);
    } catch (e) {
      // handle error
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      {aiAnswer ? (
        <div>{aiAnswer}</div>
      ) : (
        <button onClick={handleGenerate} disabled={loading}>
          {loading ? 'Generating...' : 'Generate AI Answer'}
        </button>
      )}
    </div>
  );
};
```

---

## API Flow
1. **Generate Answer:**
   - Frontend sends POST to `/api/ai-answers/generate` with question and questionId
   - Backend calls Groq API, stores answer in `ai_answers`, returns answer
2. **Retrieve Answer:**
   - Frontend fetches answer via GET `/api/ai-answers/question/:id`
3. **Feedback:**
   - Frontend sends PATCH to `/api/ai-answers/:id/feedback` with rating

---

## Database Schema
**Table:** `ai_answers`
- `id` (UUID, PK)
- `question_id` (UUID, FK)
- `answer_text` (TEXT)
- `generated_by` (TEXT)
- `user_id` (UUID, FK)
- `model_used` (TEXT)
- `tokens_used` (INTEGER)
- `processing_time_ms` (INTEGER)
- `user_feedback_rating` (INTEGER, nullable)
- `generation_attempts` (INTEGER)
- `created_at` (TIMESTAMP)

---

## Environment Setup
- **Groq API Key:** Set `GROQ_API_KEY` in your environment
- **Supabase:** Ensure database and `ai_answers` table are migrated
- **Dependencies:** Install `groq-sdk` and required backend packages

---

## Customization
- **Model Selection:** Change model in backend API call (e.g., `llama3-8b-8192`)
- **Prompt/Style:** Adjust system prompt for different answer styles
- **Answer Length:** Modify `max_tokens` for answer size
- **Feedback:** Extend schema for more detailed analytics

---

## Troubleshooting
- **No AI Answer Generated:**
  - Check `GROQ_API_KEY` and API credits
  - Ensure backend and database are running
  - Review logs for errors
- **Slow Responses:**
  - Use a faster model
  - Check network and Groq API status
- **Feedback Not Saved:**
  - Confirm PATCH endpoint is called with valid data

---

## Related Documentation
- [AI Integration Setup](../AI_INTEGRATION_SETUP.md)
- [Groq AI Integration Setup](../GROQ_AI_INTEGRATION_SETUP.md)
- [AI Answers Module](../modules_documentation/AiAnswers.md)
- [QandA Module](../modules_documentation/QandA.md)
- [API Layer](../modules_documentation/ApiModules.md)
- [Components](../modules_documentation/Components.md)

---

For further details, see the backend implementation in `src/api/ai-answers.js` and the Q&A UI integration. 