# Social Feed System Flow Diagrams
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
        A[Feed Page] --> B[PostCard Component]
        B --> C[CreatePost Component]
        B --> D[CommentList Component]
        B --> E[LikeButton Component]
        B --> F[ShareButton Component]
    end
    
    subgraph "Backend (Supabase)"
        G[Supabase Client] --> H[Posts API]
        H --> I[Comments API]
        H --> J[Likes API]
        H --> K[Real-time Subscriptions]
    end
    
    subgraph "Database Layer"
        L[posts Table]
        M[comments Table]
        N[votes Table]
        O[users Table]
        P[followers Table]
    end
    
    subgraph "Real-time Features"
        Q[PostgreSQL Triggers] --> R[Real-time Updates]
        R --> S[WebSocket Connections]
        S --> T[Live Notifications]
    end
    
    subgraph "Storage"
        U[Supabase Storage] --> V[Image Uploads]
        U --> W[File Attachments]
    end
    
    A --> G
    C --> U
    K --> S
    L --> M
    L --> N
    O --> P
    
    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style K fill:#fff3e0
    style L fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[User] -->|1. View Feed| B[Feed Page]
    B -->|2. Load Posts| C[Posts API]
    C -->|3. Query Database| D[posts Table]
    D -->|4. Return Posts| E[Post Data]
    E -->|5. Render Posts| F[PostCard Components]
    
    G[User] -->|6. Create Post| H[CreatePost Form]
    H -->|7. Validate Input| I[Form Validation]
    I -->|8. Upload Media| J[Storage API]
    J -->|9. Store Files| K[Supabase Storage]
    H -->|10. Save Post| L[Posts API]
    L -->|11. Insert Post| D
    D -->|12. Real-time Update| M[Real-time Subscription]
    M -->|13. Update Feed| F
    
    N[User] -->|14. Like Post| O[LikeButton]
    O -->|15. Toggle Like| P[Votes API]
    P -->|16. Update Vote| Q[votes Table]
    Q -->|17. Update Count| D
    D -->|18. Real-time Update| M
    
    R[User] -->|19. Add Comment| S[CommentForm]
    S -->|20. Save Comment| T[Comments API]
    T -->|21. Insert Comment| U[comments Table]
    U -->|22. Update Count| D
    D -->|23. Real-time Update| M
    
    subgraph "Frontend Layer"
        A
        B
        F
        G
        H
        N
        O
        R
        S
    end
    
    subgraph "API Layer"
        C
        L
        P
        T
    end
    
    subgraph "Database Layer"
        D
        Q
        U
    end
    
    subgraph "Storage Layer"
        J
        K
    end
    
    subgraph "Real-time Layer"
        M
    end
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style D fill:#e8f5e8
    style M fill:#fff3e0
```

---

## 3. Sequence Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant F as Frontend
    participant S as Supabase
    participant D as Database
    participant R as Real-time
    
    U->>F: Load Feed Page
    F->>S: Query posts with pagination
    S->>D: SELECT * FROM posts ORDER BY created_at DESC
    D->>S: Return posts data
    S->>F: Return posts array
    F->>F: Render PostCard components
    F->>U: Display feed
    
    Note over U,F: Create Post Flow
    U->>F: Click "Create Post"
    F->>F: Show CreatePost modal
    U->>F: Fill post form
    U->>F: Upload image (optional)
    F->>S: Upload file to storage
    S->>F: Return file URL
    F->>S: INSERT INTO posts
    S->>D: Insert post record
    D->>S: Return new post
    S->>F: Return success
    S->>R: Trigger real-time update
    R->>F: Update feed in real-time
    F->>U: Show new post
    
    Note over U,F: Like Post Flow
    U->>F: Click like button
    F->>S: INSERT/UPDATE votes table
    S->>D: Update vote record
    D->>S: Return updated vote count
    S->>F: Return new like count
    S->>R: Trigger real-time update
    R->>F: Update like count in real-time
    F->>U: Update UI
    
    Note over U,F: Comment Flow
    U->>F: Click comment button
    F->>F: Show comment form
    U->>F: Type comment
    F->>S: INSERT INTO comments
    S->>D: Insert comment record
    D->>S: Return new comment
    S->>F: Return success
    S->>R: Trigger real-time update
    R->>F: Update comments in real-time
    F->>U: Show new comment
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Feed Page"
        A[Feed.tsx] --> B[PostList Component]
        A --> C[CreatePost Component]
        A --> D[FilterBar Component]
    end
    
    subgraph "Post Components"
        B --> E[PostCard Component]
        E --> F[PostHeader Component]
        E --> G[PostContent Component]
        E --> H[PostActions Component]
        E --> I[CommentList Component]
    end
    
    subgraph "Action Components"
        H --> J[LikeButton Component]
        H --> K[CommentButton Component]
        H --> L[ShareButton Component]
        H --> M[BookmarkButton Component]
    end
    
    subgraph "Comment Components"
        I --> N[CommentItem Component]
        I --> O[CommentForm Component]
        N --> P[ReplyButton Component]
    end
    
    subgraph "API Layer"
        Q[usePosts Hook] --> R[Posts API]
        S[useComments Hook] --> T[Comments API]
        U[useVotes Hook] --> V[Votes API]
    end
    
    subgraph "Real-time"
        W[useRealtime Hook] --> X[Real-time Subscriptions]
    end
    
    E --> Q
    I --> S
    J --> U
    W --> E
    W --> I
    
    style A fill:#f3e5f5
    style E fill:#fff3e0
    style Q fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    users ||--o{ posts : "author"
    users ||--o{ comments : "author"
    users ||--o{ votes : "voter"
    users ||--o{ followers : "follower"
    users ||--o{ followers : "following"
    
    posts ||--o{ comments : "has"
    posts ||--o{ votes : "receives"
    comments ||--o{ comments : "replies_to"
    comments ||--o{ votes : "receives"
    
    users {
        UUID id PK
        VARCHAR email
        VARCHAR full_name
        VARCHAR username
        VARCHAR avatar_url
        TEXT bio
        VARCHAR role
        BOOLEAN is_verified
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    posts {
        UUID id PK
        UUID author_id FK
        VARCHAR title
        TEXT content
        VARCHAR category
        TEXT[] tags
        VARCHAR image_url
        INTEGER likes_count
        INTEGER comments_count
        BOOLEAN is_published
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    comments {
        UUID id PK
        UUID post_id FK
        UUID author_id FK
        UUID parent_id FK
        TEXT content
        INTEGER likes_count
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    votes {
        UUID id PK
        UUID user_id FK
        VARCHAR votable_type
        UUID votable_id
        VARCHAR vote_type
        TIMESTAMP created_at
    }
    
    followers {
        UUID id PK
        UUID follower_id FK
        UUID following_id FK
        TIMESTAMP created_at
    }
```

---

## 6. User Journey Flow

```mermaid
journey
    title Social Feed User Journey
    section Feed Discovery
      User opens platform: 5: User
      User sees personalized feed: 4: System
      User scrolls through posts: 4: User
      User reads interesting post: 5: User
    section Content Interaction
      User likes a post: 4: User
      User adds a comment: 4: User
      User shares a post: 3: User
      User bookmarks a post: 3: User
    section Content Creation
      User clicks create post: 5: User
      User writes post content: 4: User
      User uploads image: 3: User
      User publishes post: 5: User
      Post appears in feed: 4: System
    section Social Engagement
      User receives notifications: 4: System
      User responds to comments: 4: User
      User follows other users: 3: User
      User discovers new content: 5: User
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
    
    subgraph "Social Feed Use Cases"
        E[View Feed]
        F[Create Post]
        G[Edit Post]
        H[Delete Post]
        I[Like Post]
        J[Unlike Post]
        K[Add Comment]
        L[Edit Comment]
        M[Delete Comment]
        N[Share Post]
        O[Bookmark Post]
        P[Follow User]
        Q[Unfollow User]
        R[Report Post]
        S[Filter Posts]
        T[Search Posts]
    end
    
    subgraph "System Use Cases"
        U[Real-time Updates]
        V[Content Moderation]
        W[Notification System]
        X[Analytics Tracking]
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
    A --> Q
    A --> R
    A --> S
    A --> T
    
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
    C --> V
    C --> X
    
    D --> E
    D --> S
    D --> T
    
    E --> U
    F --> U
    I --> U
    K --> U
    R --> V
    F --> W
    I --> W
    K --> W
    E --> X
    F --> X
    I --> X
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[Social Feed Request] --> B{Authentication Valid?}
    B -->|No| C[Redirect to Login]
    B -->|Yes| D{Request Type}
    
    D -->|View Feed| E[Load Posts]
    D -->|Create Post| F[Validate Post Data]
    D -->|Like Post| G[Check Vote Status]
    D -->|Add Comment| H[Validate Comment]
    
    E --> I{Posts Load Success?}
    I -->|No| J[Show Error Message]
    I -->|Yes| K[Display Posts]
    
    F --> L{Post Data Valid?}
    L -->|No| M[Show Validation Errors]
    L -->|Yes| N{File Upload Success?}
    N -->|No| O[Show Upload Error]
    N -->|Yes| P[Save Post]
    P --> Q{Save Success?}
    Q -->|No| R[Show Save Error]
    Q -->|Yes| S[Update Feed]
    
    G --> T{Already Voted?}
    T -->|Yes| U[Toggle Vote]
    T -->|No| V[Add Vote]
    U --> W{Update Success?}
    V --> W
    W -->|No| X[Show Vote Error]
    W -->|Yes| Y[Update UI]
    
    H --> Z{Comment Valid?}
    Z -->|No| AA[Show Comment Error]
    Z -->|Yes| BB[Save Comment]
    BB --> CC{Save Success?}
    CC -->|No| DD[Show Save Error]
    CC -->|Yes| EE[Update Comments]
    
    subgraph "Error Recovery"
        J --> FF[Retry Loading]
        M --> GG[Fix Validation]
        O --> HH[Retry Upload]
        R --> II[Retry Save]
        X --> JJ[Retry Vote]
        AA --> KK[Fix Comment]
        DD --> LL[Retry Save]
    end
    
    subgraph "User Feedback"
        C --> MM[Show Login Prompt]
        J --> NN[Show Network Error]
        M --> OO[Highlight Errors]
        O --> PP[Show File Error]
        R --> QQ[Show Database Error]
        X --> RR[Show Vote Error]
        AA --> SS[Show Comment Error]
    end
    
    style C fill:#ffebee
    style J fill:#ffebee
    style M fill:#ffebee
    style O fill:#ffebee
    style R fill:#ffebee
    style X fill:#ffebee
    style AA fill:#ffebee
    style DD fill:#ffebee
    style K fill:#e8f5e8
    style S fill:#e8f5e8
    style Y fill:#e8f5e8
    style EE fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the Social Feed system architecture, data flow, user interactions, and error handling in the Focus Hub platform.* 