# Settings & Preferences System Flow Diagrams
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
        A[Settings Page] --> B[AccountSettings Component]
        A --> C[PrivacySettings Component]
        A --> D[NotificationSettings Component]
        A --> E[ThemeSettings Component]
        A --> F[SecuritySettings Component]
    end
    
    subgraph "Settings Categories"
        G[ProfileSettings Component] --> H[Avatar Management]
        G --> I[Bio Management]
        G --> J[Social Links]
        K[PreferencesSettings Component] --> L[Language Settings]
        K --> M[Time Zone Settings]
        K --> N[Display Settings]
    end
    
    subgraph "Security Features"
        O[PasswordChange Component] --> P[Password Validation]
        Q[TwoFactorAuth Component] --> R[2FA Setup]
        S[SessionManagement Component] --> T[Active Sessions]
        U[DataExport Component] --> V[Data Export]
    end
    
    subgraph "Backend (Supabase)"
        W[Settings API] --> X[User Settings]
        W --> Y[Privacy Management]
        W --> Z[Notification Management]
        W --> AA[Theme Management]
        W --> BB[Security Management]
    end
    
    subgraph "Database Layer"
        CC[users Table]
        DD[user_settings Table]
        EE[user_preferences Table]
        FF[user_sessions Table]
        GG[user_security Table]
    end
    
    subgraph "Storage Layer"
        HH[Supabase Storage] --> II[Avatar Storage]
        HH --> JJ[Export Storage]
    end
    
    subgraph "External Services"
        KK[Email Service] --> LL[Email Notifications]
        MM[Push Service] --> NN[Push Notifications]
        OO[Analytics Service] --> PP[Usage Analytics]
    end
    
    A --> W
    G --> H
    H --> II
    O --> P
    Q --> R
    U --> V
    V --> JJ
    W --> CC
    W --> DD
    W --> EE
    W --> FF
    W --> GG
    Z --> KK
    Z --> MM
    AA --> OO
    
    style A fill:#e1f5fe
    style F fill:#f3e5f5
    style W fill:#fff3e0
    style CC fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[User] -->|1. Access Settings| B[Settings Page]
    B -->|2. Load Settings| C[Settings API]
    C -->|3. Query Database| D[user_settings Table]
    D -->|4. Return Settings| E[Settings Data]
    E -->|5. Render Settings| F[Settings Components]
    
    G[User] -->|6. Update Account| H[AccountSettings]
    H -->|7. Validate Changes| I[Form Validation]
    I -->|8. Save Changes| J[Settings API]
    J -->|9. Update Database| D
    D -->|10. Update UI| F
    
    K[User] -->|11. Change Privacy| L[PrivacySettings]
    L -->|12. Update Privacy| M[Privacy API]
    M -->|13. Update Settings| D
    D -->|14. Apply Privacy| N[Privacy Rules]
    N -->|15. Update Content| O[Content Visibility]
    
    P[User] -->|16. Configure Notifications| Q[NotificationSettings]
    Q -->|17. Update Preferences| R[Notification API]
    R -->|18. Update Settings| D
    R -->|19. Configure Services| S[External Services]
    S -->|20. Update Subscriptions| T[Notification Channels]
    
    U[User] -->|21. Change Theme| V[ThemeSettings]
    V -->|22. Update Theme| W[Theme API]
    W -->|23. Update Settings| D
    W -->|24. Apply Theme| X[Theme Application]
    X -->|25. Update UI| Y[UI Components]
    
    Z[User] -->|26. Security Settings| AA[SecuritySettings]
    AA -->|27. Update Security| BB[Security API]
    BB -->|28. Update Settings| D
    BB -->|29. Apply Security| CC[Security Rules]
    CC -->|30. Update Access| DD[Access Control]
    
    EE[User] -->|31. Export Data| FF[DataExport]
    FF -->|32. Generate Export| GG[Export API]
    GG -->|33. Process Data| HH[Data Processing]
    HH -->|34. Create File| II[File Generation]
    II -->|35. Store File| JJ[Export Storage]
    JJ -->|36. Return Download| KK[Download Link]
    
    subgraph "Frontend Layer"
        A
        B
        F
        G
        H
        K
        L
        P
        Q
        U
        V
        Z
        AA
        EE
        FF
    end
    
    subgraph "API Layer"
        C
        J
        M
        R
        W
        BB
        GG
    end
    
    subgraph "Database Layer"
        D
    end
    
    subgraph "External Services"
        S
        T
        X
        Y
        CC
        DD
        HH
        II
        JJ
    end
    
    style A fill:#e3f2fd
    style H fill:#f3e5f5
    style C fill:#fff3e0
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
    participant E as External Services
    
    U->>F: Access Settings Page
    F->>S: Load user settings
    S->>D: SELECT * FROM user_settings WHERE user_id
    D->>S: Return settings data
    S->>F: Return settings
    F->>F: Render Settings components
    F->>U: Display settings
    
    U->>F: Update account information
    F->>F: Validate form data
    F->>S: UPDATE users SET email, full_name
    S->>D: Update user record
    D->>S: Return success
    S->>F: Return updated user
    F->>F: Update account display
    F->>U: Show updated information
    
    U->>F: Change privacy settings
    F->>S: UPDATE user_settings SET privacy_level
    S->>D: Update settings
    D->>S: Return success
    S->>F: Return success
    F->>F: Update privacy controls
    F->>U: Show updated privacy
    
    U->>F: Configure notifications
    F->>S: UPDATE user_settings SET notification_preferences
    S->>D: Update settings
    D->>S: Return success
    S->>E: Update notification subscriptions
    E->>F: Confirm subscription update
    F->>F: Update notification UI
    F->>U: Show updated notifications
    
    U->>F: Change theme preference
    F->>S: UPDATE user_settings SET theme
    S->>D: Update settings
    D->>S: Return success
    S->>F: Return success
    F->>F: Apply new theme
    F->>U: Show new theme
    
    U->>F: Change password
    F->>F: Validate new password
    F->>S: UPDATE users SET password_hash
    S->>D: Update password
    D->>S: Return success
    S->>F: Return success
    F->>F: Update security status
    F->>U: Show password changed
    
    U->>F: Enable two-factor authentication
    F->>S: Generate 2FA secret
    S->>D: Store 2FA secret
    D->>S: Return secret
    S->>F: Return QR code
    F->>F: Display QR code
    F->>U: Show 2FA setup
    
    U->>F: Export personal data
    F->>S: Request data export
    S->>D: Query user data
    D->>S: Return user data
    S->>F: Return export data
    F->>F: Generate export file
    F->>E: Upload to storage
    E->>F: Return download link
    F->>U: Provide download link
    
    U->>F: Manage active sessions
    F->>S: Load active sessions
    S->>D: SELECT * FROM user_sessions WHERE user_id
    D->>S: Return sessions
    S->>F: Return sessions array
    F->>F: Render session list
    F->>U: Display sessions
    
    U->>F: Revoke session
    F->>S: DELETE FROM user_sessions WHERE session_id
    S->>D: Remove session
    D->>S: Return success
    S->>F: Return success
    F->>F: Update session list
    F->>U: Show session revoked
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Settings Page"
        A[Settings.tsx] --> B[AccountSettings Component]
        A --> C[PrivacySettings Component]
        A --> D[NotificationSettings Component]
        A --> E[ThemeSettings Component]
        A --> F[SecuritySettings Component]
        A --> G[DataExport Component]
    end
    
    subgraph "Account Settings"
        B --> H[ProfileForm Component]
        B --> I[EmailForm Component]
        B --> J[PasswordForm Component]
        B --> K[AvatarUpload Component]
    end
    
    subgraph "Privacy Settings"
        C --> L[ProfilePrivacy Component]
        C --> M[ContentPrivacy Component]
        C --> N[SearchPrivacy Component]
        C --> O[DataSharing Component]
    end
    
    subgraph "Notification Settings"
        D --> P[EmailNotifications Component]
        D --> Q[PushNotifications Component]
        D --> R[InAppNotifications Component]
        D --> S[NotificationSchedule Component]
    end
    
    subgraph "Theme Settings"
        E --> T[ThemeSelector Component]
        E --> U[ColorScheme Component]
        E --> V[FontSize Component]
        E --> W[LayoutPreferences Component]
    end
    
    subgraph "Security Settings"
        F --> X[TwoFactorAuth Component]
        F --> Y[SessionManagement Component]
        F --> Z[LoginHistory Component]
        F --> AA[SecurityAlerts Component]
    end
    
    subgraph "Data Management"
        G --> BB[DataExport Component]
        G --> CC[DataDeletion Component]
        G --> DD[PrivacyPolicy Component]
        G --> EE[TermsOfService Component]
    end
    
    subgraph "API Layer"
        FF[useSettings Hook] --> GG[Settings API]
        HH[useUser Hook] --> II[User API]
        JJ[useSecurity Hook] --> KK[Security API]
        LL[useExport Hook] --> MM[Export API]
    end
    
    subgraph "Storage"
        NN[useStorage Hook] --> OO[Storage API]
    end
    
    A --> FF
    B --> HH
    C --> FF
    D --> FF
    E --> FF
    F --> JJ
    G --> LL
    K --> NN
    
    style A fill:#f3e5f5
    style F fill:#fff3e0
    style FF fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    users ||--o{ user_settings : "has"
    users ||--o{ user_preferences : "has"
    users ||--o{ user_sessions : "has"
    users ||--o{ user_security : "has"
    
    users {
        UUID id PK
        VARCHAR email
        VARCHAR full_name
        VARCHAR username
        VARCHAR avatar_url
        VARCHAR password_hash
        VARCHAR role
        BOOLEAN is_verified
        BOOLEAN is_active
        TIMESTAMP last_login
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    user_settings {
        UUID id PK
        UUID user_id FK
        VARCHAR privacy_level
        BOOLEAN email_notifications
        BOOLEAN push_notifications
        BOOLEAN in_app_notifications
        VARCHAR theme_preference
        VARCHAR language_preference
        VARCHAR timezone
        JSONB notification_schedule
        JSONB privacy_settings
        JSONB display_settings
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    user_preferences {
        UUID id PK
        UUID user_id FK
        VARCHAR preference_key
        TEXT preference_value
        VARCHAR preference_type
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    
    user_sessions {
        UUID id PK
        UUID user_id FK
        VARCHAR session_token
        VARCHAR device_info
        VARCHAR ip_address
        VARCHAR user_agent
        BOOLEAN is_active
        TIMESTAMP created_at
        TIMESTAMP last_used
        TIMESTAMP expires_at
    }
    
    user_security {
        UUID id PK
        UUID user_id FK
        BOOLEAN two_factor_enabled
        VARCHAR two_factor_secret
        JSONB backup_codes
        INTEGER failed_login_attempts
        TIMESTAMP last_failed_login
        TIMESTAMP account_locked_until
        JSONB security_log
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
```

---

## 6. User Journey Flow

```mermaid
journey
    title Settings & Preferences User Journey
    section Settings Discovery
      User accesses settings page: 5: User
      User explores different settings categories: 4: User
      User understands available options: 4: User
    section Account Management
      User updates profile information: 4: User
      User changes email address: 3: User
      User updates password: 4: User
      User uploads new avatar: 3: User
      System validates changes: 4: System
      System saves updates: 4: System
    section Privacy Configuration
      User reviews privacy settings: 4: User
      User adjusts profile visibility: 4: User
      User sets content privacy levels: 3: User
      User configures data sharing preferences: 3: User
      System applies privacy rules: 4: System
    section Notification Setup
      User configures email notifications: 4: User
      User sets up push notifications: 3: User
      User adjusts notification frequency: 3: User
      User creates notification schedule: 2: User
      System updates notification channels: 4: System
    section Theme Customization
      User selects theme preference: 4: User
      User adjusts color scheme: 3: User
      User changes font size: 3: User
      User customizes layout: 2: User
      System applies visual changes: 4: System
    section Security Management
      User enables two-factor authentication: 4: User
      User reviews active sessions: 3: User
      User revokes suspicious sessions: 4: User
      User checks login history: 3: User
      System updates security settings: 4: System
    section Data Management
      User exports personal data: 3: User
      User reviews privacy policy: 3: User
      User requests data deletion: 2: User
      System processes data requests: 4: System
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
    
    subgraph "Account Management"
        E[Update Profile Information]
        F[Change Email Address]
        G[Change Password]
        H[Upload Avatar]
        I[Delete Account]
        J[Deactivate Account]
        K[Reactivate Account]
    end
    
    subgraph "Privacy Settings"
        L[Set Profile Privacy]
        M[Configure Content Privacy]
        N[Manage Search Visibility]
        O[Control Data Sharing]
        P[Set Location Privacy]
        Q[Manage Social Links]
    end
    
    subgraph "Notification Preferences"
        R[Configure Email Notifications]
        S[Set Up Push Notifications]
        T[Manage In-App Notifications]
        U[Create Notification Schedule]
        V[Set Notification Frequency]
        W[Choose Notification Types]
    end
    
    subgraph "Theme & Display"
        X[Select Theme]
        Y[Choose Color Scheme]
        Z[Adjust Font Size]
        AA[Customize Layout]
        BB[Set Language Preference]
        CC[Configure Time Zone]
    end
    
    subgraph "Security Settings"
        DD[Enable Two-Factor Authentication]
        EE[Manage Active Sessions]
        FF[View Login History]
        GG[Set Security Alerts]
        HH[Configure Backup Codes]
        II[Review Security Log]
    end
    
    subgraph "Data Management"
        JJ[Export Personal Data]
        KK[Request Data Deletion]
        LL[View Privacy Policy]
        MM[Accept Terms of Service]
        NN[Download Data Archive]
        OO[Manage Data Retention]
    end
    
    subgraph "System Features"
        PP[Settings Validation]
        QQ[Data Encryption]
        RR[Audit Logging]
        SS[Backup & Recovery]
        TT[Compliance Management]
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
    A --> U
    A --> V
    A --> W
    A --> X
    A --> Y
    A --> Z
    A --> AA
    A --> BB
    A --> CC
    A --> DD
    A --> EE
    A --> FF
    A --> GG
    A --> HH
    A --> II
    A --> JJ
    A --> KK
    A --> LL
    A --> MM
    A --> NN
    A --> OO
    
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
    B --> U
    B --> V
    B --> W
    B --> X
    B --> Y
    B --> Z
    B --> AA
    B --> BB
    B --> CC
    B --> DD
    B --> EE
    B --> FF
    B --> GG
    B --> HH
    B --> II
    B --> JJ
    B --> KK
    B --> LL
    B --> MM
    B --> NN
    B --> OO
    
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
    C --> Z
    C --> AA
    C --> BB
    C --> CC
    C --> DD
    C --> EE
    C --> FF
    C --> GG
    C --> HH
    C --> II
    C --> JJ
    C --> KK
    C --> LL
    C --> MM
    C --> NN
    C --> OO
    C --> PP
    C --> QQ
    C --> RR
    C --> SS
    C --> TT
    
    D --> LL
    D --> MM
    
    E --> PP
    F --> PP
    G --> QQ
    DD --> QQ
    JJ --> RR
    KK --> RR
    PP --> SS
    QQ --> TT
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[Settings Request] --> B{Authentication Valid?}
    B -->|No| C[Redirect to Login]
    B -->|Yes| D{Request Type}
    
    D -->|Update Profile| E[Validate Profile Data]
    D -->|Change Password| F[Validate Password]
    D -->|Update Privacy| G[Validate Privacy Settings]
    D -->|Export Data| H[Check Export Permissions]
    
    E --> I{Profile Data Valid?}
    I -->|No| J[Show Validation Errors]
    I -->|Yes| K{Save Success?}
    K -->|No| L[Show Save Error]
    K -->|Yes| M[Update Profile]
    
    F --> N{Password Valid?}
    N -->|No| O[Show Password Error]
    N -->|Yes| P{Current Password Correct?}
    P -->|No| Q[Show Current Password Error]
    P -->|Yes| R{Save Success?}
    R -->|No| S[Show Save Error]
    R -->|Yes| T[Update Password]
    
    G --> U{Privacy Settings Valid?}
    U -->|No| V[Show Privacy Error]
    U -->|Yes| W{Save Success?}
    W -->|No| X[Show Save Error]
    W -->|Yes| Y[Update Privacy]
    
    H --> Z{User Can Export?}
    Z -->|No| AA[Show Permission Error]
    Z -->|Yes| BB{Generate Export Success?}
    BB -->|No| CC[Show Export Error]
    BB -->|Yes| DD[Create Export File]
    DD --> EE{Upload Success?}
    EE -->|No| FF[Show Upload Error]
    EE -->|Yes| GG[Provide Download Link]
    
    subgraph "Error Recovery"
        J --> HH[Fix Validation]
        L --> II[Retry Save]
        O --> JJ[Fix Password]
        Q --> KK[Retry Current Password]
        S --> LL[Retry Save]
        V --> MM[Fix Privacy Settings]
        X --> NN[Retry Save]
        AA --> OO[Request Permission]
        CC --> PP[Retry Export]
        FF --> QQ[Retry Upload]
    end
    
    subgraph "User Feedback"
        C --> RR[Show Login Prompt]
        J --> SS[Highlight Errors]
        L --> TT[Show Save Status]
        O --> UU[Show Password Requirements]
        Q --> VV[Show Current Password Status]
        S --> WW[Show Save Status]
        V --> XX[Show Privacy Rules]
        X --> YY[Show Save Status]
        AA --> ZZ[Show Permission Info]
        CC --> AAA[Show Export Status]
        FF --> BBB[Show Upload Status]
    end
    
    subgraph "Security Measures"
        CCC[Log Settings Changes]
        DDD[Audit Trail]
        EEE[Data Validation]
        FFF[Permission Checks]
    end
    
    M --> CCC
    T --> CCC
    Y --> CCC
    GG --> CCC
    CCC --> DDD
    EEE --> E
    EEE --> F
    EEE --> G
    FFF --> H
    
    style C fill:#ffebee
    style J fill:#ffebee
    style L fill:#ffebee
    style O fill:#ffebee
    style Q fill:#ffebee
    style S fill:#ffebee
    style V fill:#ffebee
    style X fill:#ffebee
    style AA fill:#ffebee
    style CC fill:#ffebee
    style FF fill:#ffebee
    style M fill:#e8f5e8
    style T fill:#e8f5e8
    style Y fill:#e8f5e8
    style GG fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the Settings & Preferences system architecture, data flow, user interactions, and error handling in the Focus Hub platform.* 