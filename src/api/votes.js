import express from 'express';
import { supabase } from './supabaseClient.js';
const router = express.Router();

// Middleware: require authentication
function requireAuth(req, res, next) {
  if (!req.user || !req.user.id) return res.status(401).json({ error: 'Unauthorized' });
  next();
}

// POST /api/votes - Cast or update a vote
// Body: { target_id, target_type, value }
router.post('/', requireAuth, async (req, res) => {
  const { target_id, target_type, value } = req.body;
  const user_id = req.user.id;
  if (!['question', 'answer'].includes(target_type)) return res.status(400).json({ error: 'Invalid target_type' });
  if (![1, -1].includes(value)) return res.status(400).json({ error: 'Invalid value' });

  // Upsert vote
  const { data, error } = await supabase.from('votes').upsert([
    { user_id, target_id, target_type, value }
  ], { onConflict: ['user_id', 'target_id', 'target_type'] }).select().single();
  if (error) return res.status(400).json({ error: error.message });
  res.status(201).json(data);
});

// DELETE /api/votes - Remove a vote
// Body: { target_id, target_type }
router.delete('/', requireAuth, async (req, res) => {
  const { target_id, target_type } = req.body;
  const user_id = req.user.id;
  if (!['question', 'answer'].includes(target_type)) return res.status(400).json({ error: 'Invalid target_type' });

  const { error } = await supabase.from('votes').delete().eq('user_id', user_id).eq('target_id', target_id).eq('target_type', target_type);
  if (error) return res.status(400).json({ error: error.message });
  res.status(204).send();
});

export default router; 