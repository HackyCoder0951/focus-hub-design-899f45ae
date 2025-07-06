import express from 'express';
import { supabase } from './supabaseClient.js';
import Groq from 'groq-sdk';
const router = express.Router();

// Initialize Groq
const groq = new Groq({
  apiKey: process.env.GROQ_API_KEY,
});

// POST /api/ai-answers/generate - Generate AI answer for a question
router.post('/generate', async (req, res) => {
  const { question, questionId } = req.body;
  
  if (!question || !questionId) {
    return res.status(400).json({ error: 'Question and questionId are required' });
  }

  try {
    // Generate AI answer using Groq
    const completion = await groq.chat.completions.create({
      model: "llama3-8b-8192", // Fast and cost-effective model
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

    // Store the AI answer in the database (no user_id required)
    const { data, error } = await supabase
      .from('ai_answers')
      .insert([
        {
          question_id: questionId,
          answer: aiAnswer,
          generated_by: 'groq',
          user_id: null // No user authentication required
        }
      ])
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

// GET /api/ai-answers/question/:id - Get AI answer for a specific question
router.get('/question/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const { data, error } = await supabase
      .from('ai_answers')
      .select('*')
      .eq('question_id', id)
      .single();

    if (error && error.code !== 'PGRST116') { // PGRST116 is "not found"
      return res.status(500).json({ error: error.message });
    }

    res.json({ aiAnswer: data || null });

  } catch (error) {
    console.error('Error fetching AI answer:', error);
    res.status(500).json({ error: 'Failed to fetch AI answer' });
  }
});

// Add a test route for GET /api/ai-answers
router.get('/', (req, res) => {
  res.json({ message: 'AI Answers API is working! Use POST /generate or GET /question/:id.' });
});

export default router; 