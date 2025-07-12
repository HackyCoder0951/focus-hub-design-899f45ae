# AI Answer Generation Flow Diagrams
## Focus Hub Social Learning Platform

---

## Table of Contents

1. [System Architecture Diagram](#1-system-architecture-diagram)
2. [Data Flow Diagram](#2-data-flow-diagram)
3. [Sequence Diagram](#3-sequence-diagram)
4. [Component Interaction Diagram](#4-component-interaction-diagram)
5. [Database Schema Diagram](#5-database-schema-diagram)
6. [User Journey Flow](#6-user-journey-flow)

---

## 1. System Architecture Diagram

```mermaid
graph TB
    subgraph "Frontend (React + TypeScript)"
        A[Q&A Page] --> B[AIAnswer Component]
        B --> C[Generate Button]
        B --> D[Feedback System]
        B --> E[Copy Functionality]
    end
    
    subgraph "Backend (Node.js + Express)"
        F[API Router] --> G[AI Answer Controller]
        G --> H[Authentication Middleware]
        G --> I[Groq API Integration]
        G --> J[Database Operations]
    end
    
    subgraph "External Services"
        K[Groq API] --> L[Llama3-8b-8192 Model]
        M[Supabase] --> N[PostgreSQL Database]
    end
    
    subgraph "Database"
        O[ai_answers Table]
        P[questions Table]
        Q[users Table]
    end
    
    A --> F
    I --> K
    J --> M
    O --> P
    O --> Q
    
    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style K fill:#fff3e0
    style O fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[User] -->|1. Clicks Generate AI Answer| B[AIAnswer Component]
    B -->|2. Authentication Check| C[Supabase Auth]
    C -->|3. Valid Token| D[Frontend API Call]
    D -->|4. POST /api/ai-answers/generate| E[Backend API]
    E -->|5. Validate Request| F[Request Validation]
    F -->|6. Extract Question Data| G[Question Processing]
    G -->|7. Call Groq API| H[Groq API Client]
    H -->|8. Send to Llama3 Model| I[Llama3-8b-8192]
    I -->|9. Generate Response| J[AI Response]
    J -->|10. Process Response| K[Response Processing]
    K -->|11. Store in Database| L[Supabase Database]
    L -->|12. Insert ai_answers| M[ai_answers Table]
    M -->|13. Return Success| N[API Response]
    N -->|14. Update UI| O[Display AI Answer]
    O -->|15. User Interaction| P[Copy/Feedback]
    P -->|16. Update Feedback| Q[Feedback API]
    Q -->|17. Update Database| M
    
    subgraph "Frontend Layer"
        A
        B
        O
        P
    end
    
    subgraph "API Layer"
        D
        E
        F
        G
        K
        N
        Q
    end
    
    subgraph "External Services"
        H
        I
        J
    end
    
    subgraph "Database Layer"
        L
        M
    end
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style I fill:#fff3e0
    style M fill:#e8f5e8
```

---

## 3. Sequence Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant F as Frontend
    participant A as API
    participant G as Groq API
    participant D as Database
    
    U->>F: Click "Generate AI Answer"
    F->>F: Check Authentication
    F->>A: POST /api/ai-answers/generate
    Note over F,A: {question, questionId}
    
    A->>A: Validate Request
    A->>A: Extract User ID
    
    A->>G: POST /chat/completions
    Note over A,G: {model: "llama3-8b-8192", messages: [...]}
    
    G->>G: Process with Llama3 Model
    G->>A: Return AI Response
    Note over A,G: {choices: [{message: {content: "..."}}]}
    
    A->>A: Process Response
    A->>A: Calculate Processing Time
    
    A->>D: INSERT INTO ai_answers
    Note over A,D: {question_id, answer_text, model_used, tokens_used, processing_time_ms}
    
    D->>A: Return Stored Answer
    A->>F: Return Success Response
    Note over A,F: {success: true, aiAnswer: {...}}
    
    F->>F: Update UI State
    F->>U: Display AI Answer
    
    U->>F: Click "Copy" or "Feedback"
    F->>A: PATCH /api/ai-answers/{id}/feedback
    A->>D: UPDATE ai_answers SET user_feedback_rating
    D->>A: Return Updated Answer
    A->>F: Return Success Response
    F->>U: Update UI
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Q&A Page"
        A[QandA.tsx] --> B[Question List]
        A --> C[Question Detail]
        C --> D[AIAnswer Component]
    end
    
    subgraph "AIAnswer Component"
        D --> E[Generate Button]
        D --> F[Answer Display]
        D --> G[Copy Button]
        D --> H[Feedback Buttons]
        D --> I[Loading State]
    end
    
    subgraph "API Layer"
        J[ai-answers.js] --> K[Generate Endpoint]
        J --> L[Feedback Endpoint]
        J --> M[Get Answer Endpoint]
    end
    
    subgraph "External Integration"
        N[Groq SDK] --> O[Llama3 Model]
        P[Supabase Client] --> Q[Database]
    end
    
    E --> K
    H --> L
    F --> M
    K --> N
    K --> P
    
    style D fill:#f3e5f5
    style K fill:#fff3e0
    style O fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    questions ||--o{ ai_answers : "has"
    users ||--o{ ai_answers : "generates"
    
    questions {
        UUID id PK
        UUID user_id FK
        TEXT title
        TEXT body
        VARCHAR category
        TEXT[] tags
        VARCHAR status
        INTEGER view_count
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    ai_answers {
        UUID id PK
        UUID question_id FK
        TEXT answer_text
        DECIMAL confidence_score
        TEXT model_used
        INTEGER tokens_used
        INTEGER processing_time_ms
        DECIMAL relevance_score
        DECIMAL completeness_score
        INTEGER user_feedback_rating
        INTEGER generation_attempts
        TIMESTAMP created_at
    }
    
    users {
        UUID id PK
        VARCHAR email
        VARCHAR full_name
        VARCHAR username
        VARCHAR role
        BOOLEAN is_verified
        TIMESTAMP created_at
    }
```

---

## 6. User Journey Flow

```mermaid
journey
    title AI Answer Generation User Journey
    section Question Creation
      User creates question: 5: User
      Question appears in feed: 4: System
      AI Answer component loads: 4: System
    section AI Generation
      User clicks "Generate AI Answer": 5: User
      Loading state appears: 3: System
      AI processes question: 4: System
      Answer is generated: 5: System
      Answer is displayed: 4: System
    section User Interaction
      User reads AI answer: 4: User
      User copies answer: 3: User
      User provides feedback: 4: User
      Feedback is saved: 3: System
    section Alternative Paths
      User regenerates answer: 3: User
      User ignores AI answer: 2: User
      System error occurs: 1: System
```

---

## 7. Performance Metrics Flow

```mermaid
graph TD
    A[AI Answer Request] --> B[Start Timer]
    B --> C[Call Groq API]
    C --> D[Model Processing]
    D --> E[Response Received]
    E --> F[End Timer]
    F --> G[Calculate Processing Time]
    G --> H[Extract Token Count]
    H --> I[Store Metrics]
    I --> J[Return to User]
    
    subgraph "Metrics Collected"
        K[Processing Time (ms)]
        L[Token Usage]
        M[Model Used]
        N[User Feedback]
        O[Generation Attempts]
    end
    
    G --> K
    H --> L
    C --> M
    J --> N
    I --> O
    
    style K fill:#e3f2fd
    style L fill:#f3e5f5
    style M fill:#fff3e0
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[AI Answer Request] --> B{Authentication Valid?}
    B -->|No| C[Return 401 Error]
    B -->|Yes| D{Question Data Valid?}
    D -->|No| E[Return 400 Error]
    D -->|Yes| F[Call Groq API]
    F --> G{Groq API Success?}
    G -->|No| H[Return 500 Error]
    G -->|Yes| I[Process Response]
    I --> J{Database Insert Success?}
    J -->|No| K[Return 500 Error]
    J -->|Yes| L[Return Success]
    
    subgraph "Error Handling"
        C --> M[Show Auth Error]
        E --> N[Show Validation Error]
        H --> O[Show API Error]
        K --> P[Show Database Error]
    end
    
    style C fill:#ffebee
    style E fill:#ffebee
    style H fill:#ffebee
    style K fill:#ffebee
    style L fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the AI answer generation system architecture, data flow, and user interactions in the Focus Hub platform.* 