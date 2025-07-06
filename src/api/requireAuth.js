import jwt from 'jsonwebtoken';

const SUPABASE_JWT_SECRET = process.env.SUPABASE_JWT_SECRET;

export function requireAuth(req, res, next) {
  const authHeader = req.headers.authorization;
  console.log('Auth header:', authHeader);
  if (!authHeader) return res.status(401).json({ error: 'Unauthorized' });

  const token = authHeader.split(' ')[1];
  try {
    const user = jwt.verify(token, SUPABASE_JWT_SECRET);
    console.log('Decoded user:', user);
    req.user = user;
    next();
  } catch (err) {
    console.error('JWT verify error:', err);
    return res.status(401).json({ error: 'Unauthorized' });
  }
}