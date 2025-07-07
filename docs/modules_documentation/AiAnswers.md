# AI Answers Module

## Introduction
The AI Answers module provides backend API endpoints and logic for generating, storing, and managing AI-powered answers to user questions in the Q&A system. It integrates with the Groq API to deliver fast, high-quality, and cost-effective AI-generated responses.

---

## Purpose
- Enable instant, AI-generated answers for questions posted in the Q&A module
- Store, retrieve, and manage AI answers in the database
- Allow users to rate and provide feedback on AI answers
- Support regeneration, copying, and feedback workflows

---

## API Endpoints

### POST `/api/ai-answers/generate`
Generates an AI answer for a given question using the Groq API.

**Request Body:**
```json
{
  "question": "What is React?",
  "questionId": "uuid-of-question"
}
```
**Response:**
```json
{
  "success": true,
  "aiAnswer": {
    "id": "uuid",
    "question_id": "uuid",
    "answer_text": "React is a JavaScript library...",
    "generated_by": "groq",
    "user_id": "uuid",
    "model_used": "llama3-8b-8192",
    "tokens_used": 123,
    "processing_time_ms": 250,
    "user_feedback_rating": null,
    "generation_attempts": 1,
    "created_at": "2024-01-01T00:00:00Z"
  },
  "message": "AI answer generated successfully"
}
```

### GET `/api/ai-answers/question/:id`
Retrieves the AI answer for a specific question.

### PATCH `/api/ai-answers/:id/feedback`
Updates the user feedback rating for an AI answer.

**Request Body:**
```json
{
  "user_feedback_rating": 1
}
```

---

## Workflow
1. User requests an AI-generated answer for a question
2. Backend calls Groq API and generates the answer
3. Answer is stored in the `ai_answers` table with metadata
4. Answer is displayed in the Q&A UI, with options to copy, rate, or regenerate
5. User feedback is stored for future improvements

---

## Database Structure
**Table:** `ai_answers`
- `id` (UUID, PK)
- `question_id` (UUID, FK)
- `answer_text` (TEXT)
- `generated_by` (TEXT, e.g., 'groq')
- `user_id` (UUID, FK)
- `model_used` (TEXT)
- `tokens_used` (INTEGER)
- `processing_time_ms` (INTEGER)
- `user_feedback_rating` (INTEGER, nullable)
- `generation_attempts` (INTEGER)
- `created_at` (TIMESTAMP)

---

## Integration Points
- **Backend:** `src/api/ai-answers.js` (main logic and endpoints)
- **Frontend:** Q&A page and `AIAnswer` component for requesting and displaying answers
- **Database:** `ai_answers` table for storing results and feedback

---

## Customization
- **AI Model:** Change the model in the backend API call (e.g., `llama3-8b-8192`)
- **Prompt/Style:** Adjust the system prompt for different answer styles
- **Answer Length:** Modify `max_tokens` for longer or shorter answers
- **Feedback:** Extend feedback schema for more detailed analytics

---

## Related Documentation
- [AI Integration Setup](../AI_INTEGRATION_SETUP.md)
- [Groq AI Integration Setup](../GROQ_AI_INTEGRATION_SETUP.md)
- [QandA Module](./QandA.md)
- [API Layer](./ApiModules.md)
- [Components](./Components.md)

---

For further details, see the backend implementation in `src/api/ai-answers.js` and the Q&A UI integration. 