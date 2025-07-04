const express = require('express');
const router = express.Router();
const supabase = require('./supabaseClient');
const OpenAI = require('openai');

// Initialize OpenAI
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

// Middleware: require authentication
function requireAuth(req, res, next) {
  if (!req.user || !req.user.id) return res.status(401).json({ error: 'Unauthorized' });
  next();
}

// POST /api/ai-answers/generate - Generate AI answer for a question
router.post('/generate', requireAuth, async (req, res) => {
  const { question, questionId } = req.body;
  
  if (!question || !questionId) {
    return res.status(400).json({ error: 'Question and questionId are required' });
  }

  try {
    // Generate AI answer using OpenAI
    const completion = await openai.chat.completions.create({
      model: "gpt-3.5-turbo",
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

    // Store the AI answer in the database
    const { data, error } = await supabase
      .from('ai_answers')
      .insert([
        {
          question_id: questionId,
          answer: aiAnswer,
          generated_by: 'openai',
          user_id: req.user.id // The user who triggered the generation
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

module.exports = router; 