# Groq AI Integration Setup Guide

## Overview
This guide explains how to set up the AI-powered Q&A feature in Focus Hub using **Groq API** instead of OpenAI. Groq offers faster response times and more cost-effective pricing.

## Why Groq?
- **🚀 Faster**: Up to 10x faster than traditional APIs
- **💰 Cost-Effective**: More affordable than OpenAI
- **🔒 Privacy**: Better data handling policies
- **⚡ Real-time**: Optimized for real-time applications

## Features
- **Auto-Generated AI Answers**: When a question is posted, an AI-generated answer is automatically created
- **User Answer Integration**: Users can still submit their own answers after the AI answer
- **Feedback System**: Users can rate AI answers as helpful or not helpful
- **Copy to Clipboard**: Easy copying of AI answers
- **Regeneration**: Ability to regenerate AI answers if needed

## Setup Instructions

### 1. Get Groq API Key
1. Visit [Groq Console](https://console.groq.com/)
2. Sign up for a free account
3. Navigate to API Keys section
4. Create a new API key
5. Copy the API key (starts with `gsk_`)

### 2. Environment Variables
Add the following environment variables to your `.env` file:

```bash
# Groq Configuration
GROQ_API_KEY=gsk_your_groq_api_key

# Existing Supabase Configuration
VITE_SUPABASE_URL=your_supabase_url_here
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key_here
```

### 3. Install Dependencies
The required dependencies are already installed:

```bash
npm install groq-sdk
```

### 4. Database Migration
Run the database migration to create the `ai_answers` table:

```bash
# Apply the migration
supabase db push
```

Or manually run the SQL in `supabase/migrations/20250703000000_ai_answers_table.sql`

### 5. API Setup
The AI answers API is configured in:
- `src/api/ai-answers.js` - Main API endpoints (updated for Groq)
- `src/api/index.js` - API router registration

### 6. Frontend Integration
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
3. Backend uses Groq API to generate a response
4. AI answer is stored in the `ai_answers` table
5. Answer is displayed with helpful feedback options

### 3. User Experience
- AI answers appear at the top of each question
- Users can still submit their own answers below
- AI answers are clearly marked with a sparkle icon
- Users can copy, rate, or regenerate AI answers

## API Endpoints

### POST /api/ai-answers/generate
Generates an AI answer for a question using Groq.

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
    "generated_by": "groq",
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
    "generated_by": "groq",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

## Groq Models Available

### Recommended Models for Q&A:

1. **llama3-8b-8192** (Current)
   - **Speed**: Very Fast
   - **Cost**: $0.05 per 1M tokens
   - **Best for**: General Q&A, quick responses

2. **llama3-70b-8192**
   - **Speed**: Fast
   - **Cost**: $0.59 per 1M tokens
   - **Best for**: Complex questions, detailed answers

3. **mixtral-8x7b-32768**
   - **Speed**: Fast
   - **Cost**: $0.24 per 1M tokens
   - **Best for**: Technical questions, code explanations

4. **gemma2-9b-it**
   - **Speed**: Very Fast
   - **Cost**: $0.10 per 1M tokens
   - **Best for**: General purpose, good balance

### Changing Models
To change the model, update the `model` parameter in `src/api/ai-answers.js`:

```javascript
model: "llama3-70b-8192", // Change to your preferred model
```

## Cost Considerations

### Groq API Costs (per 1M tokens)
- **llama3-8b-8192**: $0.05 (Current)
- **llama3-70b-8192**: $0.59
- **mixtral-8x7b-32768**: $0.24
- **gemma2-9b-it**: $0.10

### Cost Comparison with OpenAI
| Service | Model | Cost per 1M tokens | Speed |
|---------|-------|-------------------|-------|
| **Groq** | llama3-8b-8192 | $0.05 | Very Fast |
| OpenAI | gpt-3.5-turbo | $0.50 | Medium |
| OpenAI | gpt-4 | $3.00 | Slow |

### Monthly Estimates (using llama3-8b-8192)
- **100 questions/month**: ~$0.005
- **1,000 questions/month**: ~$0.05
- **10,000 questions/month**: ~$0.50

## Customization Options

### 1. AI Model
Change the model in `src/api/ai-answers.js`:
```javascript
model: "llama3-70b-8192", // or any other Groq model
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

### 4. Response Speed vs Quality
For faster responses, use smaller models:
```javascript
model: "llama3-8b-8192", // Fastest
model: "gemma2-9b-it",   // Fast
model: "mixtral-8x7b-32768", // Balanced
model: "llama3-70b-8192",    // Highest quality
```

## Performance Optimization

### 1. Caching
Consider implementing caching for frequently asked questions:

```javascript
// Check if answer exists in cache first
const cachedAnswer = await checkCache(question);
if (cachedAnswer) {
  return cachedAnswer;
}
```

### 2. Batch Processing
For multiple questions, consider batch processing:

```javascript
// Process multiple questions at once
const batchQuestions = questions.map(q => ({
  role: "user",
  content: q.question
}));
```

### 3. Streaming Responses
For better UX, implement streaming:

```javascript
// Stream the response for real-time display
const stream = await groq.chat.completions.create({
  model: "llama3-8b-8192",
  messages: messages,
  stream: true,
});
```

## Troubleshooting

### Common Issues

1. **"Failed to generate AI answer"**
   - Check if `GROQ_API_KEY` is set correctly
   - Verify Groq API key has sufficient credits
   - Check network connectivity

2. **"Unauthorized" error**
   - Ensure user is authenticated
   - Check RLS policies in Supabase

3. **AI answers not appearing**
   - Verify database migration was applied
   - Check browser console for errors
   - Ensure API endpoints are accessible

4. **Slow response times**
   - Try a faster model (llama3-8b-8192)
   - Check your internet connection
   - Consider implementing caching

### Debug Mode
Enable debug logging by adding to your environment:
```bash
DEBUG=groq-ai:*
```

## Migration from OpenAI

If you're migrating from OpenAI to Groq:

1. **Update environment variables**:
   ```bash
   # Remove OpenAI
   # OPENAI_API_KEY=your_openai_key
   
   # Add Groq
   GROQ_API_KEY=gsk_your_groq_key
   ```

2. **Update dependencies**:
   ```bash
   npm uninstall openai
   npm install groq-sdk
   ```

3. **Test the integration** using the `AITest` component

## Future Enhancements

1. **Model Selection**: Allow users to choose different models
2. **Response Streaming**: Real-time answer generation
3. **Answer Quality Scoring**: Implement ML-based assessment
4. **Multi-language Support**: Generate answers in different languages
5. **Smart Categorization**: Auto-categorize questions using AI
6. **Personalized Answers**: Tailor AI answers based on user preferences

## Support

For issues or questions about the Groq AI integration:
1. Check the troubleshooting section above
2. Review the [Groq Documentation](https://console.groq.com/docs)
3. Check the browser console for error messages
4. Verify all environment variables are set correctly
5. Test with the `AITest` component

## API Reference

- **Groq Console**: https://console.groq.com/
- **Groq Documentation**: https://console.groq.com/docs
- **Available Models**: https://console.groq.com/docs/models
- **Pricing**: https://console.groq.com/docs/pricing 