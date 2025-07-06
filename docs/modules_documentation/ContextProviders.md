# Authentication Context

## Introduction
The Authentication Context manages user authentication state and provides user information and role-based access throughout the application. It ensures that only authenticated users can access protected resources and features.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant User
    participant AuthContext
    participant SupabaseAuth
    User->>AuthContext: Login/Logout/Register
    AuthContext->>SupabaseAuth: Perform auth action
    SupabaseAuth-->>AuthContext: Return user/session
    AuthContext-->>User: Update UI/state
```

## Use Cases Diagram Context
```mermaid
flowchart TD
  User([User]) --> Login((Login))
  User --> Register((Register))
  User --> Logout((Logout))
  User --> Session((Session Persistence))
  User --> RBAC((Role-based Access))
```


## Database Design
```mermaid
erDiagram
  users ||--o{ profiles : has
  users ||--o{ user_roles : assigned
  profiles }|..|{ user_roles : links
```


---
The Authentication Context is the backbone of secure and personalized user experiences in the application. 