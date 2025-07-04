const answersRouter = require('./answers');
const votesRouter = require('./votes');
const commentsRouter = require('./comments');
const aiAnswersRouter = require('./ai-answers');

app.use('/api/answers', answersRouter);
app.use('/api/votes', votesRouter);
app.use('/api/comments', commentsRouter);
app.use('/api/ai-answers', aiAnswersRouter); 