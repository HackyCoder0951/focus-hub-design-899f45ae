# User Profiles System Flow Diagrams
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
        A[Profile Page] --> B[ProfileHeader Component]
        A --> C[ProfileContent Component]
        A --> D[ProfileEditForm Component]
        A --> E[ActivityFeed Component]
        E --> F[PostHistory Component]
        E --> G[QuestionHistory Component]
        E --> H[ResourceHistory Component]
    end
    
    subgraph "Profile Management"
        I[AvatarUpload Component] --> J[Image Processing]
        J --> K[Avatar Storage]
        L[ProfileSettings Component] --> M[Privacy Controls]
        L --> N[Notification Settings]
        L --> O[Theme Preferences]
    end
    
    subgraph "Social Features"
        P[FollowButton Component] --> Q[Follow System]
        R[FollowersList Component] --> S[Follower Management]
        T[FollowingList Component] --> U[Following Management]
        V[ProfileStats Component] --> W[Statistics Tracking]
    end
    
    subgraph "Backend (Supabase)"
        X[Profile API] --> Y[User Management]
        X --> Z[Activity Tracking]
        X --> AA[Social Connections]
        X --> BB[Privacy Management]
    end
    
    subgraph "Database Layer"
        CC[users Table]
        DD[profiles Table]
        EE[followers Table]
        FF[user_activities Table]
        GG[user_settings Table]
    end
    
    subgraph "Storage Layer"
        HH[Supabase Storage] --> II[Avatar Bucket]
        HH --> JJ[Cover Image Bucket]
    end
    
    subgraph "Analytics"
        KK[User Analytics] --> LL[Activity Metrics]
        MM[Engagement Tracking] --> NN[Social Metrics]
    end
    
    A --> X
    D --> I
    I --> HH
    P --> Q
    Q --> EE
    X --> CC
    X --> DD
    X --> EE
    X --> FF
    X --> GG
    
    style A fill:#e1f5fe
    style D fill:#f3e5f5
    style X fill:#fff3e0
    style CC fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[User] -->|1. View Profile| B[Profile Page]
    B -->|2. Load Profile| C[Profile API]
    C -->|3. Query Database| D[users Table]
    D -->|4. Return User Data| E[User Data]
    C -->|5. Query Profile| F[profiles Table]
    F -->|6. Return Profile| G[Profile Data]
    E --> H[Profile Header]
    G --> H
    H -->|7. Render Profile| I[ProfileHeader Component]
    
    J[User] -->|8. Edit Profile| K[ProfileEditForm]
    K -->|9. Update Information| L[Form Validation]
    L -->|10. Save Changes| M[Profile API]
    M -->|11. Update Database| F
    F -->|12. Update UI| I
    
    N[User] -->|13. Upload Avatar| O[AvatarUpload]
    O -->|14. Process Image| P[Image Processing]
    P -->|15. Upload to Storage| Q[Storage API]
    Q -->|16. Store Image| R[Avatar Bucket]
    R -->|17. Return URL| S[Avatar URL]
    S -->|18. Update Profile| M
    M -->|19. Update Avatar| I
    
    T[User] -->|20. View Activity| U[ActivityFeed]
    U -->|21. Load Activities| V[Activity API]
    V -->|22. Query Activities| W[user_activities Table]
    W -->|23. Return Activities| X[Activity Data]
    X -->|24. Render Activities| Y[Activity Components]
    
    Z[User] -->|25. Follow User| AA[FollowButton]
    AA -->|26. Toggle Follow| BB[Follow API]
    BB -->|27. Update Followers| CC[followers Table]
    CC -->|28. Update Counts| D
    D -->|29. Update UI| AA
    
    DD[User] -->|30. View Followers| EE[FollowersList]
    EE -->|31. Load Followers| FF[Followers API]
    FF -->|32. Query Followers| CC
    CC -->|33. Return Followers| GG[Followers Data]
    GG -->|34. Render List| HH[FollowersList Component]
    
    subgraph "Frontend Layer"
        A
        B
        I
        J
        K
        N
        O
        T
        U
        Y
        Z
        AA
        DD
        EE
        HH
    end
    
    subgraph "API Layer"
        C
        M
        V
        BB
        FF
    end
    
    subgraph "Storage Layer"
        Q
        R
    end
    
    subgraph "Database Layer"
        D
        F
        W
        CC
    end
    
    style A fill:#e3f2fd
    style K fill:#f3e5f5
    style Q fill:#fff3e0
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
    participant ST as Storage
    
    U->>F: Visit Profile Page
    F->>S: Load user profile
    S->>D: SELECT * FROM users WHERE id
    D->>S: Return user data
    S->>D: SELECT * FROM profiles WHERE user_id
    D->>S: Return profile data
    S->>F: Return combined profile data
    F->>F: Render ProfileHeader
    F->>U: Display profile
    
    F->>S: Load user activities
    S->>D: SELECT * FROM user_activities WHERE user_id
    D->>S: Return activities
    S->>F: Return activities array
    F->>F: Render ActivityFeed
    F->>U: Display activities
    
    F->>S: Load followers count
    S->>D: SELECT COUNT(*) FROM followers WHERE following_id
    D->>S: Return followers count
    S->>F: Return count
    F->>F: Update followers display
    F->>U: Show followers count
    
    U->>F: Click "Edit Profile"
    F->>F: Show ProfileEditForm
    U->>F: Update profile information
    F->>F: Validate form data
    F->>S: UPDATE profiles SET ...
    S->>D: Update profile record
    D->>S: Return success
    S->>F: Return updated profile
    F->>F: Update profile display
    F->>U: Show updated profile
    
    U->>F: Upload new avatar
    F->>F: Process image (resize, compress)
    F->>ST: Upload image to storage
    ST->>F: Return image URL
    F->>S: UPDATE profiles SET avatar_url
    S->>D: Update avatar URL
    D->>S: Return success
    S->>F: Return updated profile
    F->>F: Update avatar display
    F->>U: Show new avatar
    
    U->>F: Click "Follow" on another profile
    F->>S: INSERT INTO followers
    S->>D: Insert follow relationship
    D->>S: Return success
    S->>F: Return success
    F->>F: Update follow button state
    F->>U: Show "Following" status
    
    U->>F: View followers list
    F->>S: Load followers
    S->>D: SELECT * FROM followers WHERE following_id
    D->>S: Return followers data
    S->>F: Return followers array
    F->>F: Render FollowersList
    F->>U: Display followers
    
    U->>F: Update privacy settings
    F->>S: UPDATE user_settings SET privacy_level
    S->>D: Update settings
    D->>S: Return success
    S->>F: Return success
    F->>F: Update privacy controls
    F->>U: Show updated settings
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Profile Page"
        A[Profile.tsx] --> B[ProfileHeader Component]
        A --> C[ProfileContent Component]
        A --> D[ProfileEditForm Component]
        A --> E[ActivityFeed Component]
    end
    
    subgraph "Profile Header"
        B --> F[Avatar Component]
        B --> G[ProfileInfo Component]
        B --> H[ProfileStats Component]
        B --> I[FollowButton Component]
        B --> J[ProfileActions Component]
    end
    
    subgraph "Profile Content"
        C --> K[Bio Section]
        C --> L[Social Links]
        C --> M[Skills Section]
        C --> N[Education Section]
        C --> O[Experience Section]
    end
    
    subgraph "Activity Feed"
        E --> P[PostHistory Component]
        E --> Q[QuestionHistory Component]
        E --> R[ResourceHistory Component]
        E --> S[CommentHistory Component]
    end
    
    subgraph "Edit Form"
        D --> T[BasicInfoForm Component]
        D --> U[AvatarUpload Component]
        D --> V[PrivacySettings Component]
        D --> W[NotificationSettings Component]
    end
    
    subgraph "Social Components"
        X[FollowersList Component] --> Y[FollowerItem Component]
        Z[FollowingList Component] --> AA[FollowingItem Component]
        BB[ProfileStats Component] --> CC[StatItem Component]
    end
    
    subgraph "API Layer"
        DD[useProfile Hook] --> EE[Profile API]
        FF[useActivities Hook] --> GG[Activities API]
        HH[useFollowers Hook] --> II[Followers API]
        JJ[useSettings Hook] --> KK[Settings API]
    end
    
    subgraph "Storage"
        LL[useStorage Hook] --> MM[Storage API]
    end
    
    A --> DD
    E --> FF
    X --> HH
    Z --> HH
    D --> JJ
    U --> LL
    
    style A fill:#f3e5f5
    style D fill:#fff3e0
    style DD fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    users ||--o{ profiles : "has"
    users ||--o{ followers : "follower"
    users ||--o{ followers : "following"
    users ||--o{ user_activities : "performs"
    users ||--o{ user_settings : "has"
    
    users {
        id PK
    }
    
    profiles {
        id PK, FK
    }
    
    followers {
        id PK
        follower_id FK
        following_id FK
    }
    
    user_activities {
        id PK
        user_id FK
    }
    
    user_settings {
        id PK
        user_id FK
    }
```
```

---

## 6. User Journey Flow

```mermaid
journey
    title User Profile Journey
    section Profile Creation
      User registers account: 5: User
      System creates basic profile: 4: System
      User completes profile setup: 4: User
      User uploads avatar: 3: User
      User adds bio and details: 4: User
    section Profile Customization
      User edits profile information: 4: User
      User updates avatar: 3: User
      User adds social links: 3: User
      User sets privacy preferences: 4: User
      User configures notifications: 3: User
    section Social Interaction
      User views other profiles: 4: User
      User follows interesting users: 4: User
      User receives follower notifications: 4: System
      User manages followers list: 3: User
      User blocks unwanted users: 2: User
    section Activity Tracking
      User's activities are tracked: 4: System
      User views activity history: 4: User
      User shares achievements: 3: User
      User receives activity insights: 4: System
    section Privacy Management
      User adjusts privacy settings: 4: User
      User controls profile visibility: 4: User
      User manages data sharing: 3: User
      User reviews profile analytics: 3: User
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
    
    subgraph "Profile Management"
        E[View Profile]
        F[Edit Profile]
        G[Upload Avatar]
        H[Update Bio]
        I[Add Social Links]
        J[Set Privacy Level]
        K[Delete Profile]
        L[Deactivate Account]
    end
    
    subgraph "Social Features"
        M[Follow User]
        N[Unfollow User]
        O[View Followers]
        P[View Following]
        Q[Block User]
        R[Report User]
        S[Send Message]
        T[View Mutual Connections]
    end
    
    subgraph "Activity Management"
        U[View Activity Feed]
        V[Track Activities]
        W[Share Achievements]
        X[View Statistics]
        Y[Export Activity Data]
        Z[Set Activity Privacy]
    end
    
    subgraph "Settings & Preferences"
        AA[Update Email]
        BB[Change Password]
        CC[Configure Notifications]
        DD[Set Theme Preference]
        EE[Manage Data Sharing]
        FF[Download Personal Data]
        GG[Request Data Deletion]
    end
    
    subgraph "Analytics & Insights"
        HH[View Profile Views]
        II[View Engagement Metrics]
        JJ[View Popular Content]
        KK[View Growth Statistics]
        LL[Generate Reports]
        MM[View Recommendations]
    end
    
    subgraph "System Features"
        NN[Content Moderation]
        OO[Spam Detection]
        PP[Account Verification]
        QQ[Data Backup]
        RR[Privacy Compliance]
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
    
    D --> E
    
    E --> NN
    R --> OO
    PP --> QQ
    QQ --> RR
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[Profile Request] --> B{Authentication Valid?}
    B -->|No| C[Redirect to Login]
    B -->|Yes| D{Request Type}
    
    D -->|View Profile| E[Load Profile]
    D -->|Edit Profile| F[Validate Changes]
    D -->|Upload Avatar| G[Validate Image]
    D -->|Follow User| H[Check Follow Status]
    
    E --> I{Profile Exists?}
    I -->|No| J[Show Not Found Error]
    I -->|Yes| K{User Can View?}
    K -->|No| L[Show Permission Error]
    K -->|Yes| M[Display Profile]
    
    F --> N{Changes Valid?}
    N -->|No| O[Show Validation Errors]
    N -->|Yes| P{Save Success?}
    P -->|No| Q[Show Save Error]
    P -->|Yes| R[Update Profile]
    
    G --> S{Image Valid?}
    S -->|No| T[Show Image Error]
    S -->|Yes| U{Image Size OK?}
    U -->|No| V[Show Size Error]
    U -->|Yes| W[Upload Image]
    W --> X{Upload Success?}
    X -->|No| Y[Show Upload Error]
    X -->|Yes| Z[Update Avatar]
    Z --> AA{Update Success?}
    AA -->|No| BB[Show Update Error]
    AA -->|Yes| CC[Update UI]
    
    H --> DD{Already Following?}
    DD -->|Yes| EE[Unfollow User]
    DD -->|No| FF[Follow User]
    EE --> GG{Update Success?}
    FF --> GG
    GG -->|No| HH[Show Follow Error]
    GG -->|Yes| II[Update Follow Status]
    
    subgraph "Error Recovery"
        J --> JJ[Redirect to Home]
        L --> KK[Request Access]
        O --> LL[Fix Validation]
        Q --> MM[Retry Save]
        T --> NN[Select Different Image]
        V --> OO[Compress Image]
        Y --> PP[Retry Upload]
        BB --> QQ[Retry Update]
        HH --> RR[Retry Follow]
    end
    
    subgraph "User Feedback"
        C --> SS[Show Login Prompt]
        J --> TT[Show Not Found Message]
        L --> UU[Show Permission Info]
        O --> VV[Highlight Errors]
        Q --> WW[Show Save Status]
        T --> XX[Show Image Requirements]
        V --> YY[Show Size Limits]
        Y --> ZZ[Show Upload Progress]
        BB --> AAA[Show Update Status]
        HH --> BBB[Show Follow Status]
    end
    
    style C fill:#ffebee
    style J fill:#ffebee
    style L fill:#ffebee
    style O fill:#ffebee
    style Q fill:#ffebee
    style T fill:#ffebee
    style V fill:#ffebee
    style Y fill:#ffebee
    style BB fill:#ffebee
    style HH fill:#ffebee
    style M fill:#e8f5e8
    style R fill:#e8f5e8
    style CC fill:#e8f5e8
    style II fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the User Profiles system architecture, data flow, user interactions, and error handling in the Focus Hub platform.* 