# External Integrations

## Introduction
External Integrations connect the application to third-party services such as Supabase for database, authentication, and real-time features. They enable the app to leverage powerful backend capabilities without building everything from scratch.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant Frontend
    participant SupabaseClient
    participant SupabaseAPI
    participant Database
    Frontend->>SupabaseClient: Request data/action
    SupabaseClient->>SupabaseAPI: API call
    SupabaseAPI->>Database: Query/Mutation
    Database-->>SupabaseAPI: Result
    SupabaseAPI-->>SupabaseClient: Response
    SupabaseClient-->>Frontend: Data/Update
```

## Use Cases Diagram Context
```mermaid
flowchart TD
  Frontend([Frontend]) --> Auth((Authenticate User))
  Frontend --> Subscribe((Subscribe to Real-time Updates))
  Frontend --> Files((Store/Retrieve Files))
  Frontend --> Query((Query Database))
```


## Database Design
```mermaid
erDiagram
  supabase_client ||--o{ users : ""
  supabase_client ||--o{ posts : ""
  supabase_client ||--o{ files : ""
  supabase_client ||--o{ messages : ""
```

---
External Integrations are the foundation for scalable, secure, and feature-rich application development.

## AI Provider Integration (Groq)

Focus Hub integrates with the Groq API to provide AI-powered answer generation in the Q&A module. This integration enables:
- Real-time, high-quality AI answers to user questions
- Fast, cost-effective, and privacy-focused AI models

**Environment Variables:**
- `GROQ_API_KEY` – Your Groq API key

**Integration Points:**
- Backend API endpoints for AI answer generation
- Q&A frontend components for requesting and displaying AI answers

For setup and customization, see [AI Integration Setup](../AI_INTEGRATION_SETUP.md) and [Groq AI Integration Setup](../GROQ_AI_INTEGRATION_SETUP.md). 