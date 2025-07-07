# API Layer

## Introduction
The API Layer acts as the bridge between the frontend application and the backend database, handling all data operations such as creating, reading, updating, and deleting resources. It abstracts the complexity of direct database access and enforces business logic and security.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant Frontend
    participant API
    participant Database
    Frontend->>API: Send request (e.g., create post)
    API->>Database: Execute operation (insert/update/delete)
    Database-->>API: Return result
    API-->>Frontend: Respond with data or status
```


## Use Cases Diagram Context
```mermaid
flowchart TD
  A[Frontend] --> B((Create Resource))
  A --> C((Read Resource))
  A --> D((Update Resource))
  A --> E((Delete Resource))
  A --> F((Integrate with External Service))

  G[External Service] --> H((Send Webhook))
  G --> I((Receive Callback))
```


## Database Design
```mermaid
erDiagram
  chats {
    uuid id PK "Primary Key"
    boolean is_group "Is Group Chat"
    text name "Chat name"
    timestamptz created_at "Created Timestamp"
    uuid created_by FK "Creator (user_id)"
  }

  chat_members {
    uuid id PK
    uuid chat_id FK
    uuid user_id FK
    timestamptz joined_at
    boolean is_admin
    boolean typing
  }

  chat_messages {
    uuid id PK
    uuid chat_id FK
    uuid user_id FK
    text content
    text media_url
    timestamptz created_at
  }

  profiles {
    uuid id PK
    text email
    text full_name
    text avatar_url
    text bio
    text location
    text website
    jsonb settings
    member_type_enum member_type
    text status
    timestamptz created_at
    timestamptz updated_at
    timestamptz last_seen
  }

  chats ||--o{ chat_members : "has"
  chats ||--o{ chat_messages : "includes"
  chat_members }o--|| profiles : "has user"
  chat_messages }o--|| profiles : "sent by"
  chats }o--|| profiles : "created by"
```


---
The API Layer ensures all data operations are secure, validated, and consistent across the application. 

## AI Answer Generation API

The API layer exposes endpoints for AI-powered answer generation in the Q&A module, using the Groq API backend integration.

### POST /api/ai-answers/generate
Generates an AI answer for a question.

**Request Body:**
```json
{
  "question": "What is React?",
  "questionId": "uuid-of-question"
}
```

**Response:**
```json
{
  "success": true,
  "aiAnswer": {
    "id": "uuid",
    "question_id": "uuid",
    "answer": "React is a JavaScript library...",
    "generated_by": "groq",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

### GET /api/ai-answers/question/:id
Retrieves the AI answer for a specific question.

**Response:**
```json
{
  "aiAnswer": {
    "id": "uuid",
    "question_id": "uuid",
    "answer": "React is a JavaScript library...",
    "generated_by": "groq",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

For setup and customization, see [AI Integration Setup](../AI_INTEGRATION_SETUP.md). 