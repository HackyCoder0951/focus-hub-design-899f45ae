# Database Design & ERD

## Introduction
The database design defines the structure, relationships, and security policies for all data stored in the application. A well-designed schema ensures data integrity, efficient queries, and robust access control.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant App
    participant Database
    App->>Database: Query/Mutation
    Database-->>App: Result
```

## Use Cases Diagram Context
```mermaid
graph TB

  %% Actors
  designer([<<actor>> DB Designer])
  developer([<<actor>> Developer])
  admin([<<actor>> DBA])

  %% Use Cases
  designSchema((Design Schema))
  createTables((Create Tables))
  defineRelationships((Define Relationships))
  writeQueries((Write SQL Queries))
  optimizeQueries((Optimize Queries))
  backupDatabase((Backup Database))
  restoreDatabase((Restore Database))
  manageUsers((Manage DB Users))

  %% Relationships
  designer --> designSchema
  designer --> defineRelationships
  designer --> createTables

  developer --> writeQueries
  developer --> optimizeQueries
  developer --> defineRelationships

  admin --> backupDatabase
  admin --> restoreDatabase
  admin --> manageUsers
  admin --> optimizeQueries
```


## Entity-Relationship Diagram (ERD)

```mermaid
erDiagram
  users ||--o{ posts : "has"
  users ||--o{ comments : "writes"
  users ||--o{ votes : "casts"
  users ||--o{ questions : "asks"
  users ||--o{ answers : "answers"
  users ||--o{ resources : "uploads"
  users ||--o{ messages : "sends"

  posts ||--o{ comments : "receives"
  posts ||--o{ votes : "receives"

  questions ||--o{ answers : "receives"
  questions ||--o{ comments : "receives"

  answers ||--o{ votes : "receives"
  answers ||--o{ comments : "receives"

  followers {
    INT follower_id
    INT followed_id
  }
  users ||--o{ followers : "follows"
  followers }o--|| users : "followed by"

  chats ||--o{ messages : "contains"

  resources ||--|| users : "belongs to"
```


## Table Descriptions
- **users:** Stores user account information.
- **posts:** Social feed posts linked to users.
- **comments:** Comments on posts and Q&A.
- **votes:** Upvotes/downvotes on posts and answers.
- **questions:** Q&A module questions.
- **answers:** Q&A module answers.
- **followers:** User follow relationships.
- **resources:** Shared files and resources.
- **chats:** Chat conversations.
- **messages:** Individual chat messages.

## Summary
The database schema is the backbone of the application, supporting all features and enforcing security through well-defined relationships and RLS policies. 