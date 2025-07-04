const express = require('express');
const router = express.Router();
const supabase = require('./supabaseClient');

// Middleware: require authentication
function requireAuth(req, res, next) {
  if (!req.user || !req.user.id) return res.status(401).json({ error: 'Unauthorized' });
  next();
}

// GET /api/questions/:id/answers - List answers for a question
router.get('/question/:id', async (req, res) => {
  const { id } = req.params;
  const { data, error } = await supabase
    .from('answers')
    .select('*')
    .eq('question_id', id)
    .order('created_at', { ascending: true });
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// POST /api/questions/:id/answers - Create answer for a question
router.post('/question/:id', requireAuth, async (req, res) => {
  const { id } = req.params;
  const { body } = req.body;
  const user_id = req.user.id;
  if (!body) return res.status(400).json({ error: 'Body is required' });
  const { data, error } = await supabase.from('answers').insert([
    { question_id: id, user_id, body }
  ]).select().single();
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
});

// PUT /api/answers/:id - Update answer
router.put('/:id', requireAuth, async (req, res) => {
  const { id } = req.params;
  const { body } = req.body;
  // Check ownership
  const { data: answer, error: findError } = await supabase.from('answers').select('user_id').eq('id', id).single();
  if (findError || !answer) return res.status(404).json({ error: 'Answer not found' });
  if (answer.user_id !== req.user.id) return res.status(403).json({ error: 'Forbidden' });

  const { data, error } = await supabase.from('answers').update({
    body, updated_at: new Date().toISOString()
  }).eq('id', id).select().single();
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
});

// DELETE /api/answers/:id - Delete answer
router.delete('/:id', requireAuth, async (req, res) => {
  const { id } = req.params;
  // Check ownership
  const { data: answer, error: findError } = await supabase.from('answers').select('user_id').eq('id', id).single();
  if (findError || !answer) return res.status(404).json({ error: 'Answer not found' });
  if (answer.user_id !== req.user.id) return res.status(403).json({ error: 'Forbidden' });

  const { error } = await supabase.from('answers').delete().eq('id', id);
  if (error) return res.status(400).json({ error: error.message });
  res.status(204).send();
});

module.exports = router; 