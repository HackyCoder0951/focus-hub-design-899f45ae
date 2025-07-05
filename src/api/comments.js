import express from 'express';
import { supabase } from './supabaseClient.js';
const router = express.Router();

// Middleware: require authentication
function requireAuth(req, res, next) {
  if (!req.user || !req.user.id) return res.status(401).json({ error: 'Unauthorized' });
  next();
}

// GET /api/answers/:id/comments - List comments for an answer (threaded)
router.get('/answer/:id', async (req, res) => {
  const { id } = req.params;
  const { data, error } = await supabase
    .from('comments')
    .select('*')
    .eq('answer_id', id)
    .order('created_at', { ascending: true });
  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

// POST /api/answers/:id/comments - Create comment for an answer
router.post('/answer/:id', requireAuth, async (req, res) => {
  const { id } = req.params;
  const { body, parent_comment_id } = req.body;
  const user_id = req.user.id;
  if (!body) return res.status(400).json({ error: 'Body is required' });
  const { data, error } = await supabase.from('comments').insert([
    { answer_id: id, user_id, body, parent_comment_id: parent_comment_id || null }
  ]).select().single();
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
});

// PUT /api/comments/:id - Update comment
router.put('/:id', requireAuth, async (req, res) => {
  const { id } = req.params;
  const { body } = req.body;
  // Check ownership
  const { data: comment, error: findError } = await supabase.from('comments').select('user_id').eq('id', id).single();
  if (findError || !comment) return res.status(404).json({ error: 'Comment not found' });
  if (comment.user_id !== req.user.id) return res.status(403).json({ error: 'Forbidden' });

  const { data, error } = await supabase.from('comments').update({
    body
  }).eq('id', id).select().single();
  if (error) return res.status(400).json({ error: error.message });
  res.json(data);
});

// DELETE /api/comments/:id - Delete comment
router.delete('/:id', requireAuth, async (req, res) => {
  const { id } = req.params;
  // Check ownership
  const { data: comment, error: findError } = await supabase.from('comments').select('user_id').eq('id', id).single();
  if (findError || !comment) return res.status(404).json({ error: 'Comment not found' });
  if (comment.user_id !== req.user.id) return res.status(403).json({ error: 'Forbidden' });

  const { error } = await supabase.from('comments').delete().eq('id', id);
  if (error) return res.status(400).json({ error: error.message });
  res.status(204).send();
});

export default router; 