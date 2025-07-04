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
usecaseDiagram
  actor User
  User --> (Login)
  User --> (Register)
  User --> (Logout)
  User --> (Session Persistence)
  User --> (Role-based Access)
```

## Database Design
```mermaid
erDiagram
  users ||--o{ profiles : ""
  users ||--o{ user_roles : ""
  profiles }|..|{ user_roles : ""
```

---
The Authentication Context is the backbone of secure and personalized user experiences in the application. 