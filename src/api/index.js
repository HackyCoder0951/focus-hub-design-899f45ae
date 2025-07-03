const answersRouter = require('./answers');
const votesRouter = require('./votes');
const commentsRouter = require('./comments');

app.use('/api/answers', answersRouter);
app.use('/api/votes', votesRouter);
app.use('/api/comments', commentsRouter); 