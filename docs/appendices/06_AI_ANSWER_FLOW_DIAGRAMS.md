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
7. [Use Case Diagram](#7-use-case-diagram)
8. [Performance Metrics Flow](#8-performance-metrics-flow)
9. [Error Handling Flow](#9-error-handling-flow)

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
    users ||--o{ questions : "asks"
    
    questions {
        id INT PK
        user_id INT FK
    }
    
    ai_answers {
        id INT PK
        question_id INT FK
    }
    
    users {
        id INT PK
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

## 7. Use Case Diagram

```mermaid
graph TB
    subgraph "Actors"
        A[Student User]
        B[Educator User]
        C[Admin User]
        D[Guest User]
        E[AI System]
    end
    
    subgraph "AI Answer Generation"
        F[Generate AI Answer]
        G[Regenerate AI Answer]
        H[View AI Answer]
        I[Copy AI Answer]
        J[Rate AI Answer]
        K[Report AI Answer]
        L[Save AI Answer]
    end
    
    subgraph "Question Management"
        M[Ask Question]
        N[Edit Question]
        O[Delete Question]
        P[View Question]
        Q[Search Questions]
        R[Filter Questions]
    end
    
    subgraph "Feedback System"
        S[Provide Positive Feedback]
        T[Provide Negative Feedback]
        U[Submit Detailed Feedback]
        V[View Feedback History]
        W[Analyze Feedback Trends]
    end
    
    subgraph "Content Moderation"
        X[Flag Inappropriate Content]
        Y[Review Flagged Content]
        Z[Approve AI Answer]
        AA[Reject AI Answer]
        BB[Edit AI Answer]
    end
    
    subgraph "Analytics & Monitoring"
        CC[View Generation Statistics]
        DD[Monitor AI Performance]
        EE[Track User Engagement]
        FF[Analyze Answer Quality]
        GG[Generate Reports]
    end
    
    subgraph "System Features"
        HH[Content Filtering]
        II[Quality Assessment]
        JJ[Rate Limiting]
        KK[Model Selection]
        LL[Token Management]
        MM[Error Handling]
    end
    
    A --> F
    A --> G
    A --> H
    A --> I
    A --> J
    A --> K
    A --> L
    A --> M
    A --> N
    A --> O
    A --> P
    A --> Q
    A --> R
    A --> S
    A --> T
    A --> U
    A --> V
    A --> X
    
    B --> F
    B --> G
    B --> H
    B --> I
    B --> J
    B --> K
    B --> L
    B --> M
    B --> N
    B --> O
    B --> P
    B --> Q
    B --> R
    B --> S
    B --> T
    B --> U
    B --> V
    B --> X
    B --> Y
    B --> Z
    B --> AA
    B --> BB
    B --> CC
    B --> DD
    B --> EE
    B --> FF
    B --> GG
    
    C --> F
    C --> G
    C --> H
    C --> I
    C --> J
    C --> K
    C --> L
    C --> M
    C --> N
    C --> O
    C --> P
    C --> Q
    C --> R
    C --> S
    C --> T
    C --> U
    C --> V
    C --> W
    C --> X
    C --> Y
    C --> Z
    C --> AA
    C --> BB
    C --> CC
    C --> DD
    C --> EE
    C --> FF
    C --> GG
    C --> HH
    C --> II
    C --> JJ
    C --> KK
    C --> LL
    C --> MM
    
    D --> P
    D --> Q
    D --> R
    
    E --> F
    E --> G
    E --> HH
    E --> II
    E --> JJ
    E --> KK
    E --> LL
    E --> MM
    
    F --> HH
    F --> II
    F --> JJ
    F --> KK
    F --> LL
    G --> HH
    G --> II
    G --> JJ
    G --> KK
    G --> LL
    K --> Y
    S --> FF
    T --> FF
    U --> FF
    V --> GG
    W --> GG
    X --> Y
    Y --> Z
    Y --> AA
    Y --> BB
    CC --> GG
    DD --> GG
    EE --> GG
    FF --> GG
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
    style E fill:#fce4ec
```

---

## 8. Performance Metrics Flow

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

## 9. Error Handling Flow

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