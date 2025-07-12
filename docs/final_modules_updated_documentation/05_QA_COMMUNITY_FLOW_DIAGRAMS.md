# Q&A Community System Flow Diagrams
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
8. [Error Handling Flow](#8-error-handling-flow)

---

## 1. System Architecture Diagram

```mermaid
graph TB
    subgraph "Frontend (React + TypeScript)"
        A[Q&A Page] --> B[QuestionList Component]
        A --> C[QuestionDetail Component]
        C --> D[AnswerList Component]
        C --> E[AnswerForm Component]
        C --> F[VoteButtons Component]
        C --> G[TagSystem Component]
    end
    
    subgraph "AI Integration"
        H[AIAnswer Component] --> I[Groq API Client]
        I --> J[Llama3-8b-8192 Model]
        K[AI Feedback System] --> L[Answer Quality Metrics]
    end
    
    subgraph "Backend (Supabase)"
        M[Q&A API] --> N[Question Management]
        M --> O[Answer Management]
        M --> P[Vote Management]
        M --> Q[Tag Management]
        M --> R[Search & Filter]
    end
    
    subgraph "Database Layer"
        S[questions Table]
        T[answers Table]
        U[ai_answers Table]
        V[votes Table]
        W[tags Table]
        X[users Table]
    end
    
    subgraph "Real-time Features"
        Y[Real-time Updates] --> Z[Live Vote Counts]
        Y --> AA[New Answer Notifications]
        Y --> BB[Question Status Updates]
    end
    
    A --> M
    H --> I
    C --> Y
    S --> T
    S --> U
    S --> V
    T --> V
    
    style A fill:#e1f5fe
    style C fill:#f3e5f5
    style H fill:#fff3e0
    style S fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[User] -->|1. Browse Questions| B[Q&A Page]
    B -->|2. Load Questions| C[Question API]
    C -->|3. Query Database| D[questions Table]
    D -->|4. Return Questions| E[Question List]
    E -->|5. Render Questions| F[QuestionList Component]
    
    G[User] -->|6. Ask Question| H[QuestionForm]
    H -->|7. Validate Question| I[Form Validation]
    I -->|8. Save Question| J[Question API]
    J -->|9. Insert Question| D
    D -->|10. Generate AI Answer| K[AI Answer API]
    K -->|11. Call Groq API| L[Groq Service]
    L -->|12. Process with Llama3| M[AI Model]
    M -->|13. Return AI Answer| N[AI Response]
    N -->|14. Store AI Answer| O[ai_answers Table]
    O -->|15. Update Question| D
    D -->|16. Real-time Update| P[Real-time Channel]
    P -->|17. Update UI| F
    
    Q[User] -->|18. View Question| R[QuestionDetail]
    R -->|19. Load Question| S[Question API]
    S -->|20. Load Answers| T[Answer API]
    T -->|21. Query Answers| U[answers Table]
    U -->|22. Return Answers| V[Answer List]
    V -->|23. Render Answers| W[AnswerList Component]
    
    X[User] -->|24. Add Answer| Y[AnswerForm]
    Y -->|25. Validate Answer| Z[Answer Validation]
    Z -->|26. Save Answer| AA[Answer API]
    AA -->|27. Insert Answer| U
    U -->|28. Update Count| D
    D -->|29. Real-time Update| P
    P -->|30. Update UI| W
    
    BB[User] -->|31. Vote| CC[VoteButtons]
    CC -->|32. Toggle Vote| DD[Vote API]
    DD -->|33. Update Vote| EE[votes Table]
    EE -->|34. Update Count| D
    D -->|35. Real-time Update| P
    P -->|36. Update UI| CC
    
    subgraph "Frontend Layer"
        A
        B
        F
        G
        H
        Q
        R
        W
        X
        Y
        BB
        CC
    end
    
    subgraph "API Layer"
        C
        J
        S
        T
        AA
        DD
    end
    
    subgraph "AI Layer"
        K
        L
        M
        N
    end
    
    subgraph "Database Layer"
        D
        O
        U
        EE
    end
    
    subgraph "Real-time Layer"
        P
    end
    
    style A fill:#e3f2fd
    style R fill:#f3e5f5
    style K fill:#fff3e0
    style D fill:#e8f5e8
```

---

## 3. Sequence Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant F as Frontend
    participant S as Supabase
    participant D as Database
    participant G as Groq API
    participant R as Real-time
    
    U->>F: Browse Q&A Page
    F->>S: Query questions with filters
    S->>D: SELECT * FROM questions ORDER BY created_at DESC
    D->>S: Return questions data
    S->>F: Return questions array
    F->>F: Render QuestionList
    F->>U: Display questions
    
    U->>F: Click "Ask Question"
    F->>F: Show QuestionForm
    U->>F: Fill question form
    F->>F: Validate form data
    F->>S: INSERT INTO questions
    S->>D: Insert question record
    D->>S: Return new question
    S->>F: Return success
    
    Note over F,G: AI Answer Generation
    F->>S: Generate AI answer
    S->>G: POST /chat/completions
    G->>G: Process with Llama3 model
    G->>S: Return AI response
    S->>D: INSERT INTO ai_answers
    D->>S: Return AI answer
    S->>F: Return AI answer
    S->>R: Trigger real-time update
    R->>F: Update question display
    F->>U: Show AI answer
    
    U->>F: Click on question
    F->>S: Load question details
    S->>D: SELECT * FROM questions WHERE id
    D->>S: Return question data
    S->>F: Return question
    F->>S: Load answers for question
    S->>D: SELECT * FROM answers WHERE question_id
    D->>D: SELECT * FROM ai_answers WHERE question_id
    D->>S: Return answers data
    S->>F: Return answers array
    F->>F: Render QuestionDetail
    F->>U: Display question and answers
    
    U->>F: Add answer
    F->>F: Validate answer content
    F->>S: INSERT INTO answers
    S->>D: Insert answer record
    D->>S: Return new answer
    S->>F: Return success
    S->>R: Broadcast new answer
    R->>F: Update answer list
    F->>U: Display new answer
    
    U->>F: Vote on question/answer
    F->>S: INSERT/UPDATE votes table
    S->>D: Update vote record
    D->>S: Return updated vote count
    S->>F: Return new vote count
    S->>R: Broadcast vote update
    R->>F: Update vote display
    F->>U: Update UI
    
    U->>F: Accept answer
    F->>S: UPDATE answers SET is_accepted
    S->>D: Update answer status
    D->>S: Return success
    S->>R: Broadcast acceptance
    R->>F: Update question status
    F->>U: Show accepted answer
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Q&A Page"
        A[QandA.tsx] --> B[QuestionList Component]
        A --> C[QuestionDetail Component]
        A --> D[AskQuestion Component]
        A --> E[SearchFilter Component]
    end
    
    subgraph "Question Components"
        B --> F[QuestionCard Component]
        F --> G[QuestionHeader Component]
        F --> H[QuestionContent Component]
        F --> I[QuestionTags Component]
        F --> J[QuestionStats Component]
    end
    
    subgraph "Answer Components"
        C --> K[AnswerList Component]
        K --> L[AnswerItem Component]
        L --> M[AnswerContent Component]
        L --> N[AnswerAuthor Component]
        L --> O[AnswerVotes Component]
        L --> P[AcceptAnswer Component]
    end
    
    subgraph "AI Components"
        C --> Q[AIAnswer Component]
        Q --> R[GenerateButton Component]
        Q --> S[AIAnswerDisplay Component]
        Q --> T[FeedbackButtons Component]
        Q --> U[CopyButton Component]
    end
    
    subgraph "Form Components"
        D --> V[QuestionForm Component]
        C --> W[AnswerForm Component]
        V --> X[TagInput Component]
        V --> Y[CategorySelect Component]
    end
    
    subgraph "API Layer"
        Z[useQuestions Hook] --> AA[Questions API]
        BB[useAnswers Hook] --> CC[Answers API]
        DD[useVotes Hook] --> EE[Votes API]
        FF[useAI Hook] --> GG[AI API]
    end
    
    subgraph "Real-time"
        HH[useRealtime Hook] --> II[Real-time Subscriptions]
    end
    
    B --> Z
    C --> BB
    K --> BB
    O --> DD
    Q --> FF
    HH --> B
    HH --> C
    
    style A fill:#f3e5f5
    style C fill:#fff3e0
    style Q fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    users ||--o{ questions : "asks"
    users ||--o{ answers : "provides"
    users ||--o{ votes : "casts"
    users ||--o{ ai_answers : "generates"
    
    questions ||--o{ answers : "has"
    questions ||--o{ ai_answers : "has"
    questions ||--o{ votes : "receives"
    answers ||--o{ votes : "receives"
    
    questions {
        string id PK
        string author_id FK
        string accepted_answer_id FK
    }
    
    answers {
        string id PK
        string question_id FK
        string author_id FK
    }
    
    ai_answers {
        string id PK
        string question_id FK
    }
    
    votes {
        string id PK
        string user_id FK
        string votable_id FK
    }
    
    tags {
        string id PK
    }

```

---

## 6. User Journey Flow

```mermaid
journey
    title Q&A Community User Journey
    section Question Discovery
      User opens Q&A section: 5: User
      User browses questions: 4: User
      User filters by category: 3: User
      User searches for topics: 4: User
    section Question Creation
      User clicks "Ask Question": 5: User
      User writes question title: 4: User
      User adds detailed content: 4: User
      User selects category: 3: User
      User adds relevant tags: 3: User
      User publishes question: 5: User
      AI generates instant answer: 5: System
    section Answer Interaction
      User reads AI answer: 4: User
      User provides feedback: 3: User
      User reads community answers: 4: User
      User votes on answers: 4: User
      User accepts best answer: 3: User
    section Community Engagement
      User adds their own answer: 4: User
      User comments on answers: 3: User
      User follows interesting topics: 3: User
      User receives notifications: 4: System
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
    end
    
    subgraph "Question Management"
        E[Ask Question]
        F[Edit Question]
        G[Delete Question]
        H[Close Question]
        I[Reopen Question]
        J[Search Questions]
        K[Filter Questions]
        L[Bookmark Question]
    end
    
    subgraph "Answer Management"
        M[Provide Answer]
        N[Edit Answer]
        O[Delete Answer]
        P[Accept Answer]
        Q[Reject Answer]
        R[Comment on Answer]
        S[Report Answer]
    end
    
    subgraph "Voting System"
        T[Upvote Question]
        U[Downvote Question]
        V[Upvote Answer]
        W[Downvote Answer]
        X[Remove Vote]
    end
    
    subgraph "AI Integration"
        Y[Generate AI Answer]
        Z[Rate AI Answer]
        AA[Regenerate AI Answer]
        BB[Copy AI Answer]
    end
    
    subgraph "Community Features"
        CC[Follow Topics]
        DD[Follow Users]
        EE[Receive Notifications]
        FF[View User Profiles]
        GG[View Question History]
    end
    
    subgraph "System Features"
        HH[Content Moderation]
        II[Spam Detection]
        JJ[Quality Scoring]
        KK[Analytics Tracking]
    end
    
    A --> E
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
    A --> R
    A --> T
    A --> U
    A --> V
    A --> W
    A --> X
    A --> Y
    A --> Z
    A --> AA
    A --> BB
    A --> CC
    A --> DD
    A --> EE
    A --> FF
    A --> GG
    
    B --> E
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
    B --> W
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
    
    C --> E
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
    
    D --> J
    D --> K
    D --> FF
    
    E --> HH
    M --> HH
    S --> II
    Y --> JJ
    E --> KK
    M --> KK
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[Q&A Request] --> B{Authentication Valid?}
    B -->|No| C[Redirect to Login]
    B -->|Yes| D{Request Type}
    
    D -->|Ask Question| E[Validate Question]
    D -->|Provide Answer| F[Validate Answer]
    D -->|Vote| G[Check Vote Status]
    D -->|Generate AI Answer| H[Check AI Service]
    
    E --> I{Question Valid?}
    I -->|No| J[Show Validation Errors]
    I -->|Yes| K{Save Success?}
    K -->|No| L[Show Save Error]
    K -->|Yes| M[Generate AI Answer]
    M --> N{AI Service Available?}
    N -->|No| O[Show AI Error]
    N -->|Yes| P{AI Generation Success?}
    P -->|No| Q[Show Generation Error]
    P -->|Yes| R[Save AI Answer]
    R --> S{Save Success?}
    S -->|No| T[Show Save Error]
    S -->|Yes| U[Update UI]
    
    F --> V{Answer Valid?}
    V -->|No| W[Show Validation Errors]
    V -->|Yes| X{Save Success?}
    X -->|No| Y[Show Save Error]
    X -->|Yes| Z[Update UI]
    
    G --> AA{Already Voted?}
    AA -->|Yes| BB[Toggle Vote]
    AA -->|No| CC[Add Vote]
    BB --> DD{Update Success?}
    CC --> DD
    DD -->|No| EE[Show Vote Error]
    DD -->|Yes| FF[Update UI]
    
    H --> GG{AI Service Status?}
    GG -->|Offline| HH[Show Service Error]
    GG -->|Online| II{Generation Success?}
    II -->|No| JJ[Show Generation Error]
    II -->|Yes| KK[Display AI Answer]
    
    subgraph "Error Recovery"
        J --> LL[Fix Validation]
        L --> MM[Retry Save]
        O --> NN[Retry AI Service]
        Q --> OO[Retry Generation]
        T --> PP[Retry Save]
        W --> QQ[Fix Validation]
        Y --> RR[Retry Save]
        EE --> SS[Retry Vote]
        HH --> TT[Retry Connection]
        JJ --> UU[Retry Generation]
    end
    
    subgraph "User Feedback"
        C --> VV[Show Login Prompt]
        J --> WW[Highlight Errors]
        L --> XX[Show Database Error]
        O --> YY[Show Service Status]
        Q --> ZZ[Show Generation Status]
        T --> AAA[Show Save Status]
        W --> BBB[Highlight Errors]
        Y --> CCC[Show Save Status]
        EE --> DDD[Show Vote Status]
        HH --> EEE[Show Service Status]
        JJ --> FFF[Show Generation Status]
    end
    
    style C fill:#ffebee
    style J fill:#ffebee
    style L fill:#ffebee
    style O fill:#ffebee
    style Q fill:#ffebee
    style T fill:#ffebee
    style W fill:#ffebee
    style Y fill:#ffebee
    style EE fill:#ffebee
    style HH fill:#ffebee
    style JJ fill:#ffebee
    style U fill:#e8f5e8
    style Z fill:#e8f5e8
    style FF fill:#e8f5e8
    style KK fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the Q&A Community system architecture, data flow, user interactions, and error handling in the Focus Hub platform.* 