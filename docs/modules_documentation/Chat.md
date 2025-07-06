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
    Chat->>API: Send request (message/file)
    API->>Database: Store/retrieve message or file
    Database-->>API: Return result
    API-->>Chat: Response / real-time update
    Chat-->>User: Update UI (display message, file)
```


## Use Cases Diagram Context
```mermaid
flowchart TD
  User([User]) --> UC1((Send Message))
  User --> UC2((Receive Message))
  User --> UC3((Share File))
  User --> UC4((Join Group Chat))
  User --> UC5((Leave Group Chat))
  User --> UC6((See Online Status))
```



## Database Design
```mermaid
erDiagram
  profiles {
    INT id
    STRING username
    STRING avatar_url
  }

  chats {
    INT id
    STRING type "direct/group"
    STRING name
    DATETIME created_at
  }

  chat_members {
    INT chat_id
    INT profile_id
    BOOLEAN is_admin
  }

  chat_messages {
    INT id
    INT chat_id
    INT sender_id
    TEXT message
    STRING file_url
    DATETIME timestamp
  }

  chats ||--o{ chat_members : "has"
  chats ||--o{ chat_messages : "contains"
  chat_members }|..|{ profiles : "belongs to"
  chat_messages }|..|| profiles : "sent by"
```


## Summary
The Chat page powers private and group communication with real-time updates and file sharing. 