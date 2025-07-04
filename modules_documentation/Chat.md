# Chat

## Introduction
The Chat page enables real-time messaging between users, supporting both direct and group conversations, file sharing, and presence indicators.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant User
    participant Chat
    participant API
    participant Database
    User->>Chat: Send/receive message, share file
    Chat->>API: Send request
    API->>Database: Store/retrieve message
    Database-->>API: Return result
    API-->>Chat: Response/real-time update
    Chat-->>User: Update UI
```

## Use Cases Diagram Context
```mermaid
usecaseDiagram
  actor User
  User --> (Send Message)
  User --> (Receive Message)
  User --> (Share File)
  User --> (Join Group Chat)
```

## Database Design
```mermaid
erDiagram
  chats ||--o{ chat_members : ""
  chats ||--o{ chat_messages : ""
  chat_members }|..|{ profiles : ""
  chat_messages }|..|{ profiles : ""
```

## Summary
The Chat page powers private and group communication with real-time updates and file sharing. 