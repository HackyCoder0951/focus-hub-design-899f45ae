# Profile

## Introduction
The Profile page allows users to view and edit their personal information, manage privacy settings, and showcase their activity and achievements.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant User
    participant Profile
    participant API
    participant Database
    User->>Profile: View/edit profile, update settings
    Profile->>API: Send request
    API->>Database: Perform operation
    Database-->>API: Return result
    API-->>Profile: Response
    Profile-->>User: Update UI
```

## Use Cases Diagram Context
```mermaid
flowchart TD
  User([User]) --> View((View Profile))
  User --> Edit((Edit Profile))
  User --> Privacy((Change Privacy Settings))
  User --> Avatar((Upload Avatar))
```


## Database Design
```mermaid
erDiagram
  profiles ||--o{ user_roles : ""
  profiles ||--o{ followers : ""
  profiles }|..|{ users : ""
  followers }|..|{ profiles : ""
```

## Summary
The Profile page is the user's personal hub for managing their identity and presence on the platform. 