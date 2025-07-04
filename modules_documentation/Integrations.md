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
usecaseDiagram
  actor Frontend
  Frontend --> (Authenticate User)
  Frontend --> (Subscribe to Real-time Updates)
  Frontend --> (Store/Retrieve Files)
  Frontend --> (Query Database)
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