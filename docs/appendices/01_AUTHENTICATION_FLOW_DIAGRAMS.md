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
7. [Use Case Diagram](#7-use-case-diagram)
8. [Security Flow Diagram](#8-security-flow-diagram)
9. [Error Handling Flow](#9-error-handling-flow)

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
    auth_users ||--o{ auth_sessions : "has"
    
    auth_users {
        id string PK
    }
    
    profiles {
        id string PK
    }
    
    user_roles {
        id string PK
        user_id string FK
    }
    
    auth_sessions {
        id string PK
        user_id string FK
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

## 7. Use Case Diagram

```mermaid
graph TB
    subgraph "Actors"
        A[Student User]
        B[Educator User]
        C[Admin User]
        D[Guest User]
        E[System Administrator]
    end
    
    subgraph "Authentication Use Cases"
        F[Register Account]
        G[Login to Platform]
        H[Logout from Platform]
        I[Reset Password]
        J[Change Password]
        K[Verify Email]
        L[Enable Two-Factor Auth]
        M[Disable Two-Factor Auth]
        N[Manage Sessions]
        O[Delete Account]
    end
    
    subgraph "Profile Management"
        P[Update Profile Information]
        Q[Upload Avatar]
        R[Update Email Address]
        S[View Profile]
        T[Set Privacy Settings]
        U[Export Personal Data]
    end
    
    subgraph "Security Features"
        V[View Login History]
        W[Revoke Active Sessions]
        X[Set Security Alerts]
        Y[Configure Backup Codes]
        Z[Review Security Log]
        AA[Set Account Recovery]
    end
    
    subgraph "System Features"
        BB[Account Verification]
        CC[Session Management]
        DD[Password Policy Enforcement]
        EE[Rate Limiting]
        FF[Account Lockout]
        GG[Audit Logging]
    end
    
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
    A --> U
    A --> V
    A --> W
    A --> X
    A --> Y
    A --> Z
    A --> AA
    
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
    
    D --> F
    D --> G
    D --> S
    
    E --> BB
    E --> CC
    E --> DD
    E --> EE
    E --> FF
    E --> GG
    E --> V
    E --> W
    E --> X
    E --> Y
    E --> Z
    E --> AA
    
    F --> BB
    G --> CC
    J --> DD
    G --> EE
    G --> FF
    G --> GG
    N --> CC
    V --> GG
    W --> CC
    X --> GG
    Y --> GG
    Z --> GG
    AA --> GG
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
    style E fill:#fce4ec
```

---

## 8. Security Flow Diagram

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

## 9. Error Handling Flow

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