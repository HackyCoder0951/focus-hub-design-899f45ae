# Admin Dashboard System Flow Diagrams
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
        A[AdminDashboard Page] --> B[DashboardOverview Component]
        A --> C[UserManagement Component]
        A --> D[ContentModeration Component]
        A --> E[AnalyticsComponent Component]
        A --> F[SystemSettings Component]
    end
    
    subgraph "Admin Features"
        G[UserTable Component] --> H[User Actions]
        I[ContentTable Component] --> J[Moderation Actions]
        K[AnalyticsChart Component] --> L[Data Visualization]
        M[SettingsForm Component] --> N[System Configuration]
    end
    
    subgraph "Backend (Supabase)"
        O[Admin API] --> P[User Management]
        O --> Q[Content Moderation]
        O --> R[Analytics Engine]
        O --> S[System Configuration]
        O --> T[Permission Management]
    end
    
    subgraph "Database Layer"
        U[users Table]
        V[posts Table]
        W[questions Table]
        X[resources Table]
        Y[admin_logs Table]
        Z[system_settings Table]
    end
    
    subgraph "Analytics Layer"
        AA[Analytics Service] --> BB[User Metrics]
        AA --> CC[Content Metrics]
        AA --> DD[Engagement Metrics]
        AA --> EE[System Metrics]
    end
    
    subgraph "Monitoring"
        FF[System Monitor] --> GG[Performance Tracking]
        HH[Error Tracking] --> II[Error Logging]
        JJ[Security Monitor] --> KK[Security Alerts]
    end
    
    A --> O
    G --> P
    I --> Q
    K --> R
    M --> S
    O --> U
    O --> V
    O --> W
    O --> X
    O --> Y
    O --> Z
    R --> AA
    FF --> GG
    HH --> II
    JJ --> KK
    
    style A fill:#e1f5fe
    style C fill:#f3e5f5
    style O fill:#fff3e0
    style U fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[Admin User] -->|1. Access Dashboard| B[AdminDashboard]
    B -->|2. Check Permissions| C[Permission Check]
    C -->|3. Load Overview| D[Dashboard API]
    D -->|4. Query Statistics| E[Analytics Engine]
    E -->|5. Aggregate Data| F[Database Queries]
    F -->|6. Return Stats| G[Statistics Data]
    G -->|7. Render Dashboard| H[DashboardOverview]
    
    I[Admin] -->|8. Manage Users| J[UserManagement]
    J -->|9. Load Users| K[User API]
    K -->|10. Query Users| L[users Table]
    L -->|11. Return Users| M[User List]
    M -->|12. Render Table| N[UserTable]
    
    O[Admin] -->|13. Moderate Content| P[ContentModeration]
    P -->|14. Load Reports| Q[Moderation API]
    Q -->|15. Query Reports| R[reported_content Table]
    R -->|16. Return Reports| S[Report List]
    S -->|17. Render Reports| T[ContentTable]
    
    U[Admin] -->|18. View Analytics| V[AnalyticsComponent]
    V -->|19. Load Analytics| W[Analytics API]
    W -->|20. Process Metrics| X[Analytics Engine]
    X -->|21. Query Metrics| Y[Various Tables]
    Y -->|22. Return Metrics| Z[Analytics Data]
    Z -->|23. Render Charts| AA[AnalyticsChart]
    
    BB[Admin] -->|24. Configure System| CC[SystemSettings]
    CC -->|25. Load Settings| DD[Settings API]
    DD -->|26. Query Settings| EE[system_settings Table]
    EE -->|27. Return Settings| FF[Settings Data]
    FF -->|28. Render Form| GG[SettingsForm]
    
    HH[Admin] -->|29. Take Action| II[Admin Action]
    II -->|30. Execute Action| JJ[Action API]
    JJ -->|31. Update Database| KK[Database Update]
    KK -->|32. Log Action| LL[admin_logs Table]
    LL -->|33. Update UI| MM[UI Update]
    
    subgraph "Frontend Layer"
        A
        B
        H
        I
        J
        N
        O
        P
        T
        U
        V
        AA
        BB
        CC
        GG
        HH
        II
        MM
    end
    
    subgraph "API Layer"
        D
        K
        Q
        W
        DD
        JJ
    end
    
    subgraph "Analytics Layer"
        E
        X
    end
    
    subgraph "Database Layer"
        F
        L
        R
        Y
        EE
        KK
        LL
    end
    
    style A fill:#e3f2fd
    style J fill:#f3e5f5
    style E fill:#fff3e0
    style F fill:#e8f5e8
```

---

## 3. Sequence Diagram

```mermaid
sequenceDiagram
    participant A as Admin
    participant F as Frontend
    participant S as Supabase
    participant D as Database
    participant L as Logger
    
    A->>F: Access Admin Dashboard
    F->>S: Check admin permissions
    S->>D: SELECT role FROM users WHERE id
    D->>S: Return user role
    S->>F: Return permission status
    
    alt Has Admin Access
        F->>S: Load dashboard statistics
        S->>D: Multiple queries for metrics
        D->>S: Return aggregated data
        S->>F: Return dashboard data
        F->>F: Render DashboardOverview
        F->>A: Display dashboard
        
        A->>F: Click "User Management"
        F->>S: Load user list with pagination
        S->>D: SELECT * FROM users ORDER BY created_at
        D->>S: Return users data
        S->>F: Return users array
        F->>F: Render UserTable
        F->>A: Display user management
        
        A->>F: Select user action (suspend/ban)
        F->>S: Execute user action
        S->>D: UPDATE users SET status
        D->>S: Return success
        S->>L: Log admin action
        L->>D: INSERT INTO admin_logs
        D->>L: Return success
        S->>F: Return success
        F->>F: Update user table
        F->>A: Show action confirmation
        
        A->>F: Click "Content Moderation"
        F->>S: Load reported content
        S->>D: SELECT * FROM reported_content
        D->>S: Return reports
        S->>F: Return reports array
        F->>F: Render ContentTable
        F->>A: Display moderation panel
        
        A->>F: Take moderation action
        F->>S: Execute moderation action
        S->>D: UPDATE content status
        D->>S: Return success
        S->>L: Log moderation action
        L->>D: INSERT INTO admin_logs
        D->>L: Return success
        S->>F: Return success
        F->>F: Update content table
        F->>A: Show action confirmation
        
        A->>F: Click "Analytics"
        F->>S: Load analytics data
        S->>D: Complex queries for metrics
        D->>S: Return analytics data
        S->>F: Return analytics
        F->>F: Render AnalyticsChart
        F->>A: Display analytics
        
        A->>F: Update system settings
        F->>S: Save settings
        S->>D: UPDATE system_settings
        D->>S: Return success
        S->>L: Log settings change
        L->>D: INSERT INTO admin_logs
        D->>L: Return success
        S->>F: Return success
        F->>A: Show settings saved
    else No Admin Access
        S->>F: Return access denied
        F->>A: Show access denied message
    end
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Admin Dashboard"
        A[AdminDashboard.tsx] --> B[DashboardOverview Component]
        A --> C[UserManagement Component]
        A --> D[ContentModeration Component]
        A --> E[AnalyticsComponent Component]
        A --> F[SystemSettings Component]
    end
    
    subgraph "Dashboard Overview"
        B --> G[StatsCards Component]
        B --> H[RecentActivity Component]
        B --> I[QuickActions Component]
        B --> J[SystemStatus Component]
    end
    
    subgraph "User Management"
        C --> K[UserTable Component]
        K --> L[UserActions Component]
        K --> M[UserFilters Component]
        K --> N[UserSearch Component]
        L --> O[SuspendUser Component]
        L --> P[BanUser Component]
        L --> Q[ChangeRole Component]
    end
    
    subgraph "Content Moderation"
        D --> R[ContentTable Component]
        R --> S[ModerationActions Component]
        R --> T[ReportDetails Component]
        R --> U[ContentFilters Component]
        S --> V[RemoveContent Component]
        S --> W[WarnUser Component]
        S --> X[ApproveContent Component]
    end
    
    subgraph "Analytics"
        E --> Y[AnalyticsChart Component]
        Y --> Z[UserMetrics Component]
        Y --> AA[ContentMetrics Component]
        Y --> BB[EngagementMetrics Component]
        Y --> CC[SystemMetrics Component]
    end
    
    subgraph "System Settings"
        F --> DD[SettingsForm Component]
        DD --> EE[GeneralSettings Component]
        DD --> FF[SecuritySettings Component]
        DD --> GG[NotificationSettings Component]
        DD --> HH[FeatureFlags Component]
    end
    
    subgraph "API Layer"
        II[useAdmin Hook] --> JJ[Admin API]
        KK[useUsers Hook] --> LL[Users API]
        MM[useModeration Hook] --> NN[Moderation API]
        OO[useAnalytics Hook] --> PP[Analytics API]
        QQ[useSettings Hook] --> RR[Settings API]
    end
    
    A --> II
    C --> KK
    D --> MM
    E --> OO
    F --> QQ
    
    style A fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    users ||--o{ admin_logs : "performs"
    users ||--o{ reported_content : "reports"
    users ||--o{ system_settings : "manages"
    
    posts ||--o{ reported_content : "reported"
    questions ||--o{ reported_content : "reported"
    resources ||--o{ reported_content : "reported"
    
    users {
        id PK
    }
    
    admin_logs {
        id PK
        admin_id FK
        target_id FK
    }
    
    reported_content {
        id PK
        reporter_id FK
        content_id FK
        moderator_id FK
    }
    
    system_settings {
        id PK
        updated_by FK
    }
    
    posts {
        id PK
        author_id FK
    }
    
    questions {
        id PK
        author_id FK
    }
    
    resources {
        id PK
        author_id FK
    }
```

---

## 6. User Journey Flow

```mermaid
journey
    title Admin Dashboard User Journey
    section Dashboard Access
      Admin logs into platform: 5: Admin
      Admin navigates to dashboard: 4: Admin
      System verifies admin permissions: 4: System
      Dashboard loads with overview: 5: System
    section User Management
      Admin views user list: 4: Admin
      Admin filters users by criteria: 3: Admin
      Admin selects user for action: 4: Admin
      Admin performs user action: 5: Admin
      System logs admin action: 4: System
      User status is updated: 4: System
    section Content Moderation
      Admin reviews reported content: 4: Admin
      Admin examines content details: 4: Admin
      Admin takes moderation action: 5: Admin
      System applies moderation: 4: System
      Content status is updated: 4: System
      Users are notified of action: 3: System
    section Analytics Review
      Admin views platform metrics: 4: Admin
      Admin analyzes user engagement: 4: Admin
      Admin reviews content statistics: 4: Admin
      Admin identifies trends: 5: Admin
      Admin makes data-driven decisions: 5: Admin
    section System Configuration
      Admin updates system settings: 4: Admin
      Admin configures feature flags: 3: Admin
      Admin manages security settings: 4: Admin
      System applies configuration: 4: System
      Changes take effect: 4: System
```

---

## 7. Use Case Diagram

```mermaid
graph TB
    subgraph "Actors"
        A[Super Admin]
        B[Content Moderator]
        C[User Manager]
        D[Analytics Admin]
        E[System Admin]
    end
    
    subgraph "User Management"
        F[View All Users]
        G[Search Users]
        H[Filter Users]
        I[Suspend User]
        J[Ban User]
        K[Delete User]
        L[Change User Role]
        M[View User Details]
        N[Export User Data]
    end
    
    subgraph "Content Moderation"
        O[View Reported Content]
        P[Review Content]
        Q[Remove Content]
        R[Warn User]
        S[Approve Content]
        T[Set Content Status]
        U[View Moderation History]
        V[Manage Content Filters]
    end
    
    subgraph "Analytics & Reporting"
        W[View Platform Analytics]
        X[Generate Reports]
        Y[Export Analytics Data]
        Z[View User Engagement]
        AA[View Content Statistics]
        BB[View System Performance]
        CC[Create Custom Reports]
        DD[Schedule Reports]
    end
    
    subgraph "System Administration"
        EE[Manage System Settings]
        FF[Configure Feature Flags]
        GG[Manage Security Settings]
        HH[View System Logs]
        II[Monitor System Health]
        JJ[Manage Backups]
        KK[Configure Integrations]
        LL[Manage API Keys]
    end
    
    subgraph "Audit & Compliance"
        MM[View Admin Logs]
        NN[Audit User Actions]
        OO[Generate Compliance Reports]
        PP[Manage Data Retention]
        QQ[Export Audit Trails]
        RR[Monitor Security Events]
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
    A --> PP
    A --> QQ
    A --> RR
    
    B --> O
    B --> P
    B --> Q
    B --> R
    B --> S
    B --> T
    B --> U
    B --> V
    
    C --> F
    C --> G
    C --> H
    C --> I
    C --> J
    C --> K
    C --> L
    C --> M
    C --> N
    
    D --> W
    D --> X
    D --> Y
    D --> Z
    D --> AA
    D --> BB
    D --> CC
    D --> DD
    
    E --> EE
    E --> FF
    E --> GG
    E --> HH
    E --> II
    E --> JJ
    E --> KK
    E --> LL
    E --> MM
    E --> NN
    E --> OO
    E --> PP
    E --> QQ
    E --> RR
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
    style E fill:#fce4ec
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[Admin Request] --> B{Authentication Valid?}
    B -->|No| C[Redirect to Login]
    B -->|Yes| D{Admin Role Valid?}
    D -->|No| E[Show Access Denied]
    D -->|Yes| F{Request Type}
    
    F -->|View Dashboard| G[Load Dashboard]
    F -->|Manage Users| H[User Management]
    F -->|Moderate Content| I[Content Moderation]
    F -->|View Analytics| J[Analytics]
    F -->|System Settings| K[Settings Management]
    
    G --> L{Dashboard Load Success?}
    L -->|No| M[Show Dashboard Error]
    L -->|Yes| N[Display Dashboard]
    
    H --> O{Users Load Success?}
    O -->|No| P[Show User Load Error]
    O -->|Yes| Q[Display User Management]
    Q --> R{User Action Success?}
    R -->|No| S[Show Action Error]
    R -->|Yes| T[Update User Status]
    
    I --> U{Content Load Success?}
    U -->|No| V[Show Content Load Error]
    U -->|Yes| W[Display Moderation Panel]
    W --> X{Moderation Action Success?}
    X -->|No| Y[Show Moderation Error]
    X -->|Yes| Z[Update Content Status]
    
    J --> AA{Analytics Load Success?}
    AA -->|No| BB[Show Analytics Error]
    AA -->|Yes| CC[Display Analytics]
    
    K --> DD{Settings Load Success?}
    DD -->|No| EE[Show Settings Error]
    DD -->|Yes| FF[Display Settings]
    FF --> GG{Settings Save Success?}
    GG -->|No| HH[Show Save Error]
    GG -->|Yes| II[Update Settings]
    
    subgraph "Error Recovery"
        M --> JJ[Retry Dashboard Load]
        P --> KK[Retry User Load]
        S --> LL[Retry User Action]
        V --> MM[Retry Content Load]
        Y --> NN[Retry Moderation Action]
        BB --> OO[Retry Analytics Load]
        EE --> PP[Retry Settings Load]
        HH --> QQ[Retry Settings Save]
    end
    
    subgraph "User Feedback"
        C --> RR[Show Login Prompt]
        E --> SS[Show Access Info]
        M --> TT[Show Dashboard Status]
        P --> UU[Show User Load Status]
        S --> VV[Show Action Status]
        V --> WW[Show Content Load Status]
        Y --> XX[Show Moderation Status]
        BB --> YY[Show Analytics Status]
        EE --> ZZ[Show Settings Status]
        HH --> AAA[Show Save Status]
    end
    
    subgraph "Security Measures"
        BBB[Log Admin Actions]
        CCC[Audit Trail]
        DDD[Permission Checks]
        EEE[Rate Limiting]
    end
    
    T --> BBB
    Z --> BBB
    II --> BBB
    BBB --> CCC
    DDD --> B
    EEE --> A
    
    style C fill:#ffebee
    style E fill:#ffebee
    style M fill:#ffebee
    style P fill:#ffebee
    style S fill:#ffebee
    style V fill:#ffebee
    style Y fill:#ffebee
    style BB fill:#ffebee
    style EE fill:#ffebee
    style HH fill:#ffebee
    style N fill:#e8f5e8
    style Q fill:#e8f5e8
    style T fill:#e8f5e8
    style W fill:#e8f5e8
    style Z fill:#e8f5e8
    style CC fill:#e8f5e8
    style FF fill:#e8f5e8
    style II fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the Admin Dashboard system architecture, data flow, user interactions, and error handling in the Focus Hub platform.* 