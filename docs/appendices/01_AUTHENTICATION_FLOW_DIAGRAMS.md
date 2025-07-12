# Authentication System Flow Diagrams
## Focus Hub Social Learning Platform

---

## Table of Contents

1. [System Architecture Diagram](#1-system-architecture-diagram)
2. [Data Flow Diagram](#2-data-flow-diagram)
3. [Sequence Diagram](#3-sequence-diagram)
4. [Component Interaction Diagram](#4-component-interaction-diagram)
5. [Database Schema Diagram](#5-database-schema-diagram)
6. [User Journey Flow](#6-user-journey-flow)
7. [Security Flow Diagram](#7-security-flow-diagram)
8. [Error Handling Flow](#8-error-handling-flow)

---

## 1. System Architecture Diagram

```mermaid
graph TB
    subgraph "Frontend (React + TypeScript)"
        A[Login Page] --> B[Register Page]
        A --> C[Forgot Password Page]
        B --> D[Email Confirmation]
        C --> E[Reset Password Page]
        F[Protected Routes] --> G[Auth Context]
        G --> H[User Profile]
    end
    
    subgraph "Backend (Supabase)"
        I[Supabase Auth] --> J[Email Service]
        I --> K[Session Management]
        I --> L[Password Hashing]
        M[Database] --> N[Profiles Table]
        M --> O[User Roles Table]
    end
    
    subgraph "External Services"
        P[Email Provider] --> Q[SMTP Service]
        R[Storage] --> S[Avatar Uploads]
    end
    
    subgraph "Security Layer"
        T[JWT Tokens] --> U[Access Control]
        V[Row Level Security] --> W[Database Policies]
        X[Rate Limiting] --> Y[Brute Force Protection]
    end
    
    A --> I
    B --> I
    C --> I
    G --> M
    I --> P
    S --> R
    
    style A fill:#e1f5fe
    style I fill:#f3e5f5
    style T fill:#fff3e0
    style N fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[User] -->|1. Enter Credentials| B[Login Form]
    B -->|2. Validate Input| C[Form Validation]
    C -->|3. Valid Data| D[Supabase Auth Client]
    D -->|4. Send Request| E[Supabase Auth Service]
    E -->|5. Check Credentials| F[Database Query]
    F -->|6. Verify Password| G[Password Verification]
    G -->|7. Generate Session| H[JWT Token Generation]
    H -->|8. Store Session| I[Session Storage]
    I -->|9. Update Profile| J[Profile Data Fetch]
    J -->|10. Load User Role| K[Role Verification]
    K -->|11. Set Auth State| L[React Context Update]
    L -->|12. Redirect User| M[Protected Route]
    M -->|13. Access Granted| N[Application Dashboard]
    
    subgraph "Frontend Layer"
        A
        B
        C
        L
        M
        N
    end
    
    subgraph "API Layer"
        D
        E
        F
        G
        H
        I
        J
        K
    end
    
    subgraph "Database Layer"
        O[Users Table]
        P[Profiles Table]
        Q[Roles Table]
    end
    
    F --> O
    J --> P
    K --> Q
    
    style A fill:#e3f2fd
    style E fill:#f3e5f5
    style H fill:#fff3e0
    style O fill:#e8f5e8
```

---

## 3. Sequence Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant F as Frontend
    participant A as Supabase Auth
    participant D as Database
    participant E as Email Service
    
    U->>F: Enter email/password
    F->>F: Validate form data
    F->>A: signInWithPassword(email, password)
    
    A->>A: Hash password
    A->>D: Query users table
    D->>A: Return user data
    
    alt Valid credentials
        A->>A: Generate JWT token
        A->>A: Create session
        A->>F: Return session data
        F->>F: Store session in localStorage
        F->>D: Fetch user profile
        D->>F: Return profile data
        F->>F: Update AuthContext
        F->>U: Redirect to dashboard
    else Invalid credentials
        A->>F: Return error
        F->>U: Show error message
    end
    
    Note over U,F: Registration Flow
    U->>F: Fill registration form
    F->>F: Validate form data
    F->>A: signUp(email, password, metadata)
    A->>A: Hash password
    A->>D: Create user record
    A->>E: Send confirmation email
    E->>U: Email confirmation link
    U->>F: Click confirmation link
    F->>A: Confirm email
    A->>D: Update user status
    A->>F: Return success
    F->>U: Show confirmation message
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Authentication Pages"
        A[Login.tsx] --> B[Register.tsx]
        A --> C[ForgotPassword.tsx]
        C --> D[ResetPassword.tsx]
    end
    
    subgraph "Auth Context"
        E[AuthContext.tsx] --> F[useAuth Hook]
        E --> G[ProtectedRoute.tsx]
    end
    
    subgraph "Profile Management"
        H[ProfileEditForm.tsx] --> I[Avatar Upload]
        H --> J[Settings.tsx]
    end
    
    subgraph "Supabase Integration"
        K[supabaseClient.ts] --> L[Auth Service]
        K --> M[Database Client]
        K --> N[Storage Client]
    end
    
    subgraph "UI Components"
        O[Button.tsx] --> P[Input.tsx]
        O --> Q[Card.tsx]
        R[Avatar.tsx] --> S[Dropdown.tsx]
    end
    
    A --> E
    B --> E
    C --> E
    G --> E
    H --> K
    I --> N
    
    style E fill:#f3e5f5
    style K fill:#fff3e0
    style L fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    auth_users ||--o{ profiles : "has"
    profiles ||--o{ user_roles : "has"
    
    auth_users {
        UUID id PK
        VARCHAR email
        VARCHAR encrypted_password
        BOOLEAN email_confirmed_at
        VARCHAR confirmation_token
        VARCHAR recovery_token
        TIMESTAMP created_at
        TIMESTAMP updated_at
        TIMESTAMP last_sign_in_at
    }
    
    profiles {
        UUID id PK, FK
        TEXT email
        TEXT full_name
        TEXT avatar_url
        TEXT bio
        TEXT location
        TEXT website
        JSONB settings
        TEXT member_type
        TEXT status
        TIMESTAMP last_seen
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    user_roles {
        UUID id PK
        UUID user_id FK
        app_role role
        TIMESTAMP created_at
    }
    
    auth_sessions {
        UUID id PK
        UUID user_id FK
        TEXT access_token
        TEXT refresh_token
        TIMESTAMP expires_at
        TIMESTAMP created_at
    }
```

---

## 6. User Journey Flow

```mermaid
journey
    title Authentication User Journey
    section Registration
      User visits registration page: 5: User
      User fills registration form: 4: User
      System validates form data: 4: System
      User submits registration: 5: User
      System sends confirmation email: 4: System
      User receives email: 3: User
      User clicks confirmation link: 5: User
      System confirms email: 4: System
      User is redirected to login: 3: System
    section Login
      User enters credentials: 4: User
      System validates credentials: 4: System
      System creates session: 5: System
      User is redirected to dashboard: 4: System
      User accesses protected content: 5: User
    section Password Reset
      User clicks forgot password: 3: User
      User enters email address: 4: User
      System sends reset email: 4: System
      User receives reset email: 3: User
      User clicks reset link: 5: User
      User enters new password: 4: User
      System updates password: 5: System
      User is redirected to login: 3: System
    section Profile Management
      User updates profile: 4: User
      User uploads avatar: 3: User
      System saves changes: 4: System
      User views updated profile: 5: User
```

---

## 7. Security Flow Diagram

```mermaid
flowchart TD
    A[Request] --> B{Valid JWT Token?}
    B -->|No| C[Redirect to Login]
    B -->|Yes| D{Token Expired?}
    D -->|Yes| E[Refresh Token]
    E --> F{Valid Refresh Token?}
    F -->|No| C
    F -->|Yes| G[Generate New JWT]
    D -->|No| H{User Status Active?}
    H -->|No| I[Account Suspended]
    H -->|Yes| J{Has Required Role?}
    J -->|No| K[Access Denied]
    J -->|Yes| L[Access Granted]
    
    subgraph "Security Checks"
        M[Rate Limiting]
        N[IP Whitelist]
        O[Device Fingerprinting]
        P[2FA Verification]
    end
    
    A --> M
    M --> N
    N --> O
    O --> P
    P --> B
    
    subgraph "Account Protection"
        Q[Failed Login Attempts]
        R[Account Lockout]
        S[Password Strength]
        T[Session Management]
    end
    
    Q --> R
    S --> T
    
    style C fill:#ffebee
    style I fill:#ffebee
    style K fill:#ffebee
    style L fill:#e8f5e8
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[Authentication Request] --> B{Network Available?}
    B -->|No| C[Show Network Error]
    B -->|Yes| D{Valid Email Format?}
    D -->|No| E[Show Email Error]
    D -->|Yes| F{Password Meets Requirements?}
    F -->|No| G[Show Password Error]
    F -->|Yes| H[Send to Supabase]
    H --> I{Supabase Response}
    I -->|Success| J[Proceed to Dashboard]
    I -->|Invalid Credentials| K[Show Invalid Credentials]
    I -->|Email Not Confirmed| L[Show Email Confirmation Required]
    I -->|Account Locked| M[Show Account Locked]
    I -->|Rate Limited| N[Show Rate Limit Error]
    I -->|Server Error| O[Show Server Error]
    
    subgraph "Error Recovery"
        P[Retry Mechanism]
        Q[Fallback Options]
        R[User Support]
    end
    
    K --> P
    L --> Q
    M --> R
    N --> P
    O --> Q
    
    subgraph "User Feedback"
        S[Toast Notifications]
        T[Form Validation]
        U[Loading States]
    end
    
    C --> S
    E --> T
    G --> T
    K --> S
    L --> S
    M --> S
    N --> S
    O --> S
    
    style C fill:#ffebee
    style E fill:#ffebee
    style G fill:#ffebee
    style K fill:#ffebee
    style L fill:#ffebee
    style M fill:#ffebee
    style N fill:#ffebee
    style O fill:#ffebee
    style J fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the authentication system architecture, data flow, security measures, and user interactions in the Focus Hub platform.* 