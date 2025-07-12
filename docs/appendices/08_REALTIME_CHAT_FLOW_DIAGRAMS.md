# Real-time Chat System Flow Diagrams
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
        A[Chat Page] --> B[ChatRoomList Component]
        A --> C[ChatWindow Component]
        C --> D[MessageList Component]
        C --> E[MessageInput Component]
        C --> F[TypingIndicator Component]
        C --> G[FileUpload Component]
    end
    
    subgraph "Real-time Layer (Supabase)"
        H[Supabase Realtime] --> I[WebSocket Connections]
        I --> J[Channel Subscriptions]
        J --> K[Message Broadcasting]
        K --> L[Presence Tracking]
    end
    
    subgraph "Backend (Supabase)"
        M[Chat API] --> N[Room Management]
        M --> O[Message Storage]
        M --> P[File Storage]
        M --> Q[User Presence]
    end
    
    subgraph "Database Layer"
        R[chat_rooms Table]
        S[chat_messages Table]
        T[chat_room_participants Table]
        U[users Table]
    end
    
    subgraph "Storage Layer"
        V[Supabase Storage] --> W[Chat Files]
        V --> X[User Avatars]
    end
    
    A --> H
    E --> M
    G --> P
    P --> V
    R --> S
    R --> T
    U --> T
    
    style A fill:#e1f5fe
    style C fill:#f3e5f5
    style H fill:#fff3e0
    style R fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[User] -->|1. Open Chat| B[Chat Page]
    B -->|2. Load Rooms| C[Room API]
    C -->|3. Query Database| D[chat_rooms Table]
    D -->|4. Return Rooms| E[Room List]
    E -->|5. Render Rooms| F[ChatRoomList]
    
    G[User] -->|6. Select Room| H[ChatWindow]
    H -->|7. Load Messages| I[Message API]
    I -->|8. Query Messages| J[chat_messages Table]
    J -->|9. Return Messages| K[Message List]
    K -->|10. Render Messages| L[MessageList]
    
    M[User] -->|11. Send Message| N[MessageInput]
    N -->|12. Validate Message| O[Message Validation]
    O -->|13. Upload File| P[File Storage]
    P -->|14. Store File| Q[Supabase Storage]
    N -->|15. Save Message| R[Message API]
    R -->|16. Insert Message| J
    J -->|17. Broadcast| S[Real-time Channel]
    S -->|18. Update All Clients| T[Real-time Update]
    T -->|19. Update UI| L
    
    U[User] -->|20. Typing| V[TypingIndicator]
    V -->|21. Send Typing Signal| S
    S -->|22. Broadcast Typing| W[Show Typing]
    W -->|23. Update UI| F
    
    subgraph "Frontend Layer"
        A
        B
        F
        G
        H
        L
        M
        N
        U
        V
    end
    
    subgraph "API Layer"
        C
        I
        R
    end
    
    subgraph "Database Layer"
        D
        J
    end
    
    subgraph "Storage Layer"
        P
        Q
    end
    
    subgraph "Real-time Layer"
        S
        T
        W
    end
    
    style A fill:#e3f2fd
    style H fill:#f3e5f5
    style S fill:#fff3e0
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
    participant R as Real-time
    
    U->>F: Open Chat Page
    F->>S: Query user's chat rooms
    S->>D: SELECT * FROM chat_rooms WHERE user_id IN participants
    D->>S: Return rooms data
    S->>F: Return rooms array
    F->>F: Render ChatRoomList
    F->>U: Display chat rooms
    
    U->>F: Select chat room
    F->>S: Subscribe to room channel
    S->>R: Create WebSocket connection
    R->>F: Confirm subscription
    F->>S: Load room messages
    S->>D: SELECT * FROM chat_messages WHERE room_id ORDER BY created_at
    D->>S: Return messages
    S->>F: Return messages array
    F->>F: Render MessageList
    F->>U: Display messages
    
    U->>F: Type message
    F->>R: Send typing indicator
    R->>F: Broadcast typing to other users
    F->>U: Show typing indicator
    
    U->>F: Send message
    F->>F: Validate message content
    F->>S: INSERT INTO chat_messages
    S->>D: Insert message record
    D->>S: Return new message
    S->>F: Return success
    S->>R: Broadcast message to room
    R->>F: Update message list in real-time
    F->>U: Display new message
    
    U->>F: Upload file
    F->>S: Upload file to storage
    S->>F: Return file URL
    F->>S: INSERT INTO chat_messages (file_url)
    S->>D: Insert file message
    D->>S: Return file message
    S->>R: Broadcast file message
    R->>F: Update message list
    F->>U: Display file message
    
    U->>F: Leave room
    F->>S: Unsubscribe from channel
    S->>R: Close WebSocket connection
    R->>F: Confirm unsubscription
    F->>U: Return to room list
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Chat Page"
        A[Chat.tsx] --> B[ChatRoomList Component]
        A --> C[ChatWindow Component]
        A --> D[CreateChat Component]
    end
    
    subgraph "Chat Window"
        C --> E[MessageList Component]
        C --> F[MessageInput Component]
        C --> G[TypingIndicator Component]
        C --> H[FileUpload Component]
        C --> I[ChatHeader Component]
    end
    
    subgraph "Message Components"
        E --> J[MessageItem Component]
        J --> K[MessageBubble Component]
        J --> L[MessageTime Component]
        J --> M[MessageStatus Component]
    end
    
    subgraph "Room Components"
        B --> N[RoomItem Component]
        N --> O[RoomAvatar Component]
        N --> P[RoomInfo Component]
        N --> Q[UnreadBadge Component]
    end
    
    subgraph "API Layer"
        R[useChat Hook] --> S[Chat API]
        T[useMessages Hook] --> U[Messages API]
        V[useRooms Hook] --> W[Rooms API]
    end
    
    subgraph "Real-time"
        X[useRealtime Hook] --> Y[Real-time Subscriptions]
        Z[usePresence Hook] --> AA[Presence Tracking]
    end
    
    C --> R
    E --> T
    B --> V
    X --> E
    Z --> I
    
    style A fill:#f3e5f5
    style C fill:#fff3e0
    style R fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    users ||--o{ chat_rooms : "creates"
    users ||--o{ chat_messages : "sends"
    users ||--o{ chat_room_participants : "participates"
    
    chat_rooms ||--o{ chat_messages : "contains"
    chat_rooms ||--o{ chat_room_participants : "has"
    
    users {
        UUID id PK
        VARCHAR email
        VARCHAR full_name
        VARCHAR username
        VARCHAR avatar_url
        VARCHAR role
        BOOLEAN is_online
        TIMESTAMP last_seen
        TIMESTAMP created_at
    }
    
    chat_rooms {
        UUID id PK
        VARCHAR name
        TEXT description
        VARCHAR type
        UUID created_by FK
        BOOLEAN is_active
        INTEGER max_participants
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    chat_messages {
        UUID id PK
        UUID room_id FK
        UUID sender_id FK
        TEXT content
        VARCHAR message_type
        VARCHAR file_url
        VARCHAR file_name
        INTEGER file_size
        BOOLEAN is_read
        TIMESTAMP created_at
    }
    
    chat_room_participants {
        UUID id PK
        UUID room_id FK
        UUID user_id FK
        VARCHAR role
        BOOLEAN is_active
        TIMESTAMP joined_at
        TIMESTAMP last_read_at
    }
```

---

## 6. User Journey Flow

```mermaid
journey
    title Real-time Chat User Journey
    section Chat Discovery
      User opens chat section: 5: User
      User sees available rooms: 4: System
      User browses room list: 4: User
      User selects a room: 5: User
    section Message Exchange
      User reads existing messages: 4: User
      User types a message: 4: User
      User sends message: 5: User
      Message appears instantly: 5: System
      User sees typing indicators: 3: System
    section File Sharing
      User uploads a file: 4: User
      File uploads in background: 4: System
      File appears in chat: 4: System
      Other users can download: 3: System
    section Room Management
      User creates new room: 3: User
      User invites participants: 4: User
      User leaves room: 2: User
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
    
    subgraph "Chat Room Use Cases"
        E[View Chat Rooms]
        F[Create Chat Room]
        G[Join Chat Room]
        H[Leave Chat Room]
        I[Invite Users]
        J[Remove Users]
        K[Edit Room Settings]
        L[Delete Room]
    end
    
    subgraph "Messaging Use Cases"
        M[Send Text Message]
        N[Send File Message]
        O[Edit Message]
        P[Delete Message]
        Q[React to Message]
        R[Reply to Message]
        S[Forward Message]
        T[Search Messages]
    end
    
    subgraph "Real-time Use Cases"
        U[See Typing Indicators]
        V[See Online Status]
        W[Receive Notifications]
        X[Mark Messages Read]
        Y[Set Do Not Disturb]
    end
    
    subgraph "System Use Cases"
        Z[Message Encryption]
        AA[File Storage]
        BB[Message History]
        CC[Presence Tracking]
        DD[Content Moderation]
    end
    
    A --> E
    A --> F
    A --> G
    A --> H
    A --> I
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
    A --> W
    A --> X
    A --> Y
    
    B --> E
    B --> F
    B --> G
    B --> H
    B --> I
    B --> J
    B --> K
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
    C --> DD
    
    D --> E
    
    M --> Z
    N --> AA
    M --> BB
    V --> CC
    M --> DD
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[Chat Request] --> B{Authentication Valid?}
    B -->|No| C[Redirect to Login]
    B -->|Yes| D{Request Type}
    
    D -->|Load Rooms| E[Query Rooms]
    D -->|Send Message| F[Validate Message]
    D -->|Upload File| G[Validate File]
    D -->|Join Room| H[Check Permissions]
    
    E --> I{Rooms Load Success?}
    I -->|No| J[Show Error Message]
    I -->|Yes| K[Display Rooms]
    
    F --> L{Message Valid?}
    L -->|No| M[Show Validation Error]
    L -->|Yes| N{Real-time Connected?}
    N -->|No| O[Reconnect Real-time]
    O --> P{Reconnect Success?}
    P -->|No| Q[Show Connection Error]
    P -->|Yes| R[Send Message]
    N -->|Yes| R
    R --> S{Message Sent?}
    S -->|No| T[Show Send Error]
    S -->|Yes| U[Update UI]
    
    G --> V{File Valid?}
    V -->|No| W[Show File Error]
    V -->|Yes| X{File Size OK?}
    X -->|No| Y[Show Size Error]
    X -->|Yes| Z[Upload File]
    Z --> AA{Upload Success?}
    AA -->|No| BB[Show Upload Error]
    AA -->|Yes| CC[Send File Message]
    CC --> DD{Message Sent?}
    DD -->|No| EE[Show Send Error]
    DD -->|Yes| FF[Update UI]
    
    H --> GG{User Can Join?}
    GG -->|No| HH[Show Permission Error]
    GG -->|Yes| II[Join Room]
    II --> JJ{Join Success?}
    JJ -->|No| KK[Show Join Error]
    JJ -->|Yes| LL[Load Messages]
    
    subgraph "Error Recovery"
        J --> MM[Retry Loading]
        Q --> NN[Retry Connection]
        T --> OO[Retry Send]
        BB --> PP[Retry Upload]
        KK --> QQ[Retry Join]
    end
    
    subgraph "User Feedback"
        C --> RR[Show Login Prompt]
        J --> SS[Show Network Error]
        M --> TT[Highlight Errors]
        Q --> UU[Show Connection Status]
        T --> VV[Show Send Status]
        W --> WW[Show File Requirements]
        Y --> XX[Show Size Limits]
        BB --> YY[Show Upload Progress]
        HH --> ZZ[Show Permission Info]
    end
    
    style C fill:#ffebee
    style J fill:#ffebee
    style M fill:#ffebee
    style Q fill:#ffebee
    style T fill:#ffebee
    style W fill:#ffebee
    style Y fill:#ffebee
    style BB fill:#ffebee
    style EE fill:#ffebee
    style HH fill:#ffebee
    style KK fill:#ffebee
    style K fill:#e8f5e8
    style U fill:#e8f5e8
    style FF fill:#e8f5e8
    style LL fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the Real-time Chat system architecture, data flow, user interactions, and error handling in the Focus Hub platform.* 