# API Modules Documentation

This document provides an overview of all API modules in the project, including data flow and use case diagrams, and database design where relevant.

## Index
- [index.js](#indexjs)
- [comments.js](#commentsjs)
- [votes.js](#votesjs)
- [answers.js](#answersjs)

---

## index.js

### Data Flow Diagram Context
- Handles API routing and aggregation for Q&A, comments, and votes.

### Use Cases Diagram Context
- Entry point for API requests related to Q&A features.

---

## comments.js

### Data Flow Diagram Context
- Manages comment creation, retrieval, and association with Q&A posts.

### Use Cases Diagram Context
- Users can add, view, and manage comments on Q&A posts.

### Database Design
- Table: `comments`
  - id (PK)
  - post_id (FK)
  - user_id (FK)
  - content
  - created_at

---

## votes.js

### Data Flow Diagram Context
- Handles voting logic for Q&A posts and answers.

### Use Cases Diagram Context
- Users can upvote or downvote posts and answers.

### Database Design
- Table: `votes`
  - id (PK)
  - user_id (FK)
  - post_id (FK)
  - vote_type
  - created_at

---

## answers.js

### Data Flow Diagram Context
- Manages answer creation, retrieval, and association with Q&A posts.

### Use Cases Diagram Context
- Users can submit and view answers to Q&A posts.

### Database Design
- Table: `answers`
  - id (PK)
  - post_id (FK)
  - user_id (FK)
  - content
  - created_at 