# Feed

## Introduction
The Feed page displays the social feed, allowing users to create posts, like, comment, and interact with content in real time.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant User
    participant Feed
    participant API
    participant Database
    User->>Feed: Create/read post, like, comment
    Feed->>API: Send request
    API->>Database: Perform operation
    Database-->>API: Return result
    API-->>Feed: Response
    Feed-->>User: Update UI
```

## Use Cases Diagram Context
```mermaid
flowchart TD
  User([User]) --> Create((Create a Post))
  User --> Like((Like a Post))
  User --> Comment((Comment on a Post))
  User --> View((View Feed))
```


## Database Design
```mermaid
erDiagram
  posts ||--o{ comments : ""
  posts ||--o{ likes : ""
  posts }|..|{ profiles : ""
  comments }|..|{ profiles : ""
  likes }|..|{ profiles : ""
```

## Summary
The Feed page is the central hub for social interaction and content discovery. 