# AI Integration Setup Guide

## Overview
This guide explains how to set up the AI-powered Q&A feature in Focus Hub, which automatically generates concise answers to questions using OpenAI's GPT model.

## Features
- **Auto-Generated AI Answers**: When a question is posted, an AI-generated answer is automatically created
- **User Answer Integration**: Users can still submit their own answers after the AI answer
- **Feedback System**: Users can rate AI answers as helpful or not helpful
- **Copy to Clipboard**: Easy copying of AI answers
- **Regeneration**: Ability to regenerate AI answers if needed

## Setup Instructions

### 1. Environment Variables
Add the following environment variables to your `.env` file:

```bash
# OpenAI Configuration
OPENAI_API_KEY=your_openai_api_key_here

# Existing Supabase Configuration
VITE_SUPABASE_URL=your_supabase_url_here
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key_here
```

### 2. Database Migration
Run the database migration to create the `ai_answers` table:

```bash
# Apply the migration
supabase db push
```

Or manually run the SQL in `supabase/migrations/20250703000000_ai_answers_table.sql`

### 3. Install Dependencies
The required dependencies are already installed:

```bash
npm install openai
```

### 4. API Setup
The AI answers API is already configured in:
- `src/api/ai-answers.js` - Main API endpoints
- `src/api/index.js` - API router registration

### 5. Frontend Integration
The AI Answer component is integrated into the Q&A page:
- `src/components/AIAnswer.tsx` - AI Answer component
- `src/pages/QandA.tsx` - Integration with Q&A page

## How It Works

### 1. Question Creation
When a user creates a question:
1. Question is saved to the database
2. AI Answer component automatically appears
3. User can click "Generate AI Answer" to get an instant response

### 2. AI Answer Generation
The AI answer generation process:
1. User clicks "Generate AI Answer"
2. Frontend calls `/api/ai-answers/generate`
3. Backend uses OpenAI API to generate a response
4. AI answer is stored in the `ai_answers` table
5. Answer is displayed with helpful feedback options

### 3. User Experience
- AI answers appear at the top of each question
- Users can still submit their own answers below
- AI answers are clearly marked with a sparkle icon
- Users can copy, rate, or regenerate AI answers

## API Endpoints

### POST /api/ai-answers/generate
Generates an AI answer for a question.

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
    "answer": "React is a JavaScript library...",
    "generated_by": "openai",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

### GET /api/ai-answers/question/:id
Retrieves the AI answer for a specific question.

**Response:**
```json
{
  "aiAnswer": {
    "id": "uuid",
    "question_id": "uuid",
    "answer": "React is a JavaScript library...",
    "generated_by": "openai",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

## Database Schema

### ai_answers Table
```sql
CREATE TABLE ai_answers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    question_id UUID NOT NULL REFERENCES questionanswers(id) ON DELETE CASCADE,
    answer TEXT NOT NULL,
    generated_by TEXT NOT NULL DEFAULT 'openai',
    user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Cost Considerations

### OpenAI API Costs
- **GPT-3.5-turbo**: ~$0.002 per 1K tokens
- **Typical AI answer**: ~100-200 tokens
- **Estimated cost per answer**: ~$0.0002-0.0004

### Monthly Estimates
- **100 questions/month**: ~$0.02-0.04
- **1,000 questions/month**: ~$0.20-0.40
- **10,000 questions/month**: ~$2.00-4.00

## Customization Options

### 1. AI Model
Change the model in `src/api/ai-answers.js`:
```javascript
model: "gpt-4", // or "gpt-3.5-turbo"
```

### 2. Answer Style
Modify the system prompt in `src/api/ai-answers.js`:
```javascript
content: `You are a helpful expert on a professional networking platform. 
Provide concise, accurate, and helpful answers to questions. 
Keep answers under 200 words and focus on being practical and actionable.
Format your response in a clear, professional manner.`
```

### 3. Answer Length
Adjust `max_tokens` in the API call:
```javascript
max_tokens: 500, // Increase for longer answers
```

## Troubleshooting

### Common Issues

1. **"Failed to generate AI answer"**
   - Check if `OPENAI_API_KEY` is set correctly
   - Verify OpenAI API key has sufficient credits
   - Check network connectivity

2. **"Unauthorized" error**
   - Ensure user is authenticated
   - Check RLS policies in Supabase

3. **AI answers not appearing**
   - Verify database migration was applied
   - Check browser console for errors
   - Ensure API endpoints are accessible

### Debug Mode
Enable debug logging by adding to your environment:
```bash
DEBUG=ai-answers:*
```

## Future Enhancements

1. **Answer Quality Scoring**: Implement ML-based answer quality assessment
2. **Multi-language Support**: Generate answers in different languages
3. **Answer Summarization**: Summarize long user answers
4. **Smart Categorization**: Auto-categorize questions using AI
5. **Personalized Answers**: Tailor AI answers based on user preferences

## Support

For issues or questions about the AI integration:
1. Check the troubleshooting section above
2. Review the API documentation
3. Check the browser console for error messages
4. Verify all environment variables are set correctly 