import express from 'express';
import answersRouter from './answers.js';
import votesRouter from './votes.js';
import commentsRouter from './comments.js';
import aiAnswersRouter from './ai-answers.js';

const app = express();

// Middleware - must be applied before routes
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api/answers', answersRouter);
app.use('/api/votes', votesRouter);
app.use('/api/comments', commentsRouter);
app.use('/api/ai-answers', aiAnswersRouter);

export default app; 