# Resource Sharing System Flow Diagrams
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
        A[Resources Page] --> B[ResourceList Component]
        A --> C[ResourceUpload Component]
        A --> D[ResourceDetail Component]
        D --> E[DownloadButton Component]
        D --> F[PreviewComponent Component]
        D --> G[ResourceActions Component]
    end
    
    subgraph "File Management"
        H[FileUpload Component] --> I[File Validation]
        I --> J[File Processing]
        J --> K[File Storage]
        L[FilePreview Component] --> M[Document Viewer]
        L --> N[Image Viewer]
        L --> O[Video Player]
    end
    
    subgraph "Backend (Supabase)"
        P[Resource API] --> Q[File Storage API]
        P --> R[Resource Management]
        P --> S[Download Tracking]
        P --> T[Search & Filter]
        P --> U[Permission Management]
    end
    
    subgraph "Storage Layer"
        V[Supabase Storage] --> W[Resource Bucket]
        W --> X[Public Files]
        W --> Y[Private Files]
        W --> Z[Temporary Files]
    end
    
    subgraph "Database Layer"
        AA[resources Table]
        BB[resource_downloads Table]
        CC[resource_ratings Table]
        DD[resource_categories Table]
        EE[users Table]
    end
    
    subgraph "Search & Analytics"
        FF[Full-text Search] --> GG[Elasticsearch]
        HH[Download Analytics] --> II[Usage Reports]
        JJ[Resource Recommendations] --> KK[ML Algorithm]
    end
    
    A --> P
    C --> H
    D --> L
    Q --> V
    AA --> BB
    AA --> CC
    AA --> DD
    
    style A fill:#e1f5fe
    style C fill:#f3e5f5
    style V fill:#fff3e0
    style AA fill:#e8f5e8
```

---

## 2. Data Flow Diagram

```mermaid
flowchart TD
    A[User] -->|1. Browse Resources| B[Resources Page]
    B -->|2. Load Resources| C[Resource API]
    C -->|3. Query Database| D[resources Table]
    D -->|4. Return Resources| E[Resource List]
    E -->|5. Render Resources| F[ResourceList Component]
    
    G[User] -->|6. Upload Resource| H[ResourceUpload]
    H -->|7. Select File| I[File Selection]
    I -->|8. Validate File| J[File Validation]
    J -->|9. Upload to Storage| K[Storage API]
    K -->|10. Store File| L[Supabase Storage]
    L -->|11. Return File URL| M[File URL]
    M -->|12. Save Resource| N[Resource API]
    N -->|13. Insert Resource| D
    D -->|14. Update List| F
    
    O[User] -->|15. View Resource| P[ResourceDetail]
    P -->|16. Load Details| Q[Resource API]
    Q -->|17. Query Resource| D
    D -->|18. Return Details| R[Resource Data]
    R -->|19. Render Details| S[ResourceDetail Component]
    
    T[User] -->|20. Download Resource| U[DownloadButton]
    U -->|21. Track Download| V[Download API]
    V -->|22. Update Count| W[resource_downloads Table]
    W -->|23. Increment Count| D
    D -->|24. Update Display| S
    U -->|25. Start Download| X[File Download]
    X -->|26. Download File| L
    
    Y[User] -->|27. Rate Resource| Z[RatingComponent]
    Z -->|28. Save Rating| AA[Rating API]
    AA -->|29. Update Rating| BB[resource_ratings Table]
    BB -->|30. Update Average| D
    D -->|31. Update Display| S
    
    CC[User] -->|32. Search Resources| DD[SearchBar]
    DD -->|33. Search Query| EE[Search API]
    EE -->|34. Full-text Search| FF[Search Index]
    FF -->|35. Return Results| GG[Search Results]
    GG -->|36. Update List| F
    
    subgraph "Frontend Layer"
        A
        B
        F
        G
        H
        O
        P
        S
        T
        U
        Y
        Z
        CC
        DD
    end
    
    subgraph "API Layer"
        C
        N
        Q
        V
        AA
        EE
    end
    
    subgraph "Storage Layer"
        K
        L
        X
    end
    
    subgraph "Database Layer"
        D
        W
        BB
    end
    
    subgraph "Search Layer"
        FF
        GG
    end
    
    style A fill:#e3f2fd
    style H fill:#f3e5f5
    style L fill:#fff3e0
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
    
    U->>F: Browse Resources
    F->>S: Query resources with filters
    S->>D: SELECT * FROM resources ORDER BY created_at DESC
    D->>S: Return resources data
    S->>F: Return resources array
    F->>F: Render ResourceList
    F->>U: Display resources
    
    U->>F: Click "Upload Resource"
    F->>F: Show upload form
    U->>F: Select file
    F->>F: Validate file (size, type)
    F->>ST: Upload file to storage
    ST->>F: Return file URL
    F->>S: INSERT INTO resources
    S->>D: Insert resource record
    D->>S: Return new resource
    S->>F: Return success
    F->>F: Update resource list
    F->>U: Show uploaded resource
    
    U->>F: Click on resource
    F->>S: Load resource details
    S->>D: SELECT * FROM resources WHERE id
    D->>S: Return resource data
    S->>F: Return resource
    F->>F: Render ResourceDetail
    F->>U: Display resource details
    
    U->>F: Click "Download"
    F->>S: Track download
    S->>D: INSERT INTO resource_downloads
    D->>S: Return success
    S->>D: UPDATE resources SET downloads_count
    D->>S: Return updated count
    S->>F: Return download URL
    F->>ST: Start file download
    ST->>U: Download file
    F->>F: Update download count
    F->>U: Show download progress
    
    U->>F: Rate resource
    F->>F: Show rating form
    U->>F: Select rating
    F->>S: INSERT/UPDATE resource_ratings
    S->>D: Save rating record
    D->>S: Calculate average rating
    S->>D: UPDATE resources SET rating
    D->>S: Return updated rating
    S->>F: Return success
    F->>F: Update rating display
    F->>U: Show updated rating
    
    U->>F: Search resources
    F->>S: Full-text search query
    S->>D: Search in resources table
    D->>S: Return matching resources
    S->>F: Return search results
    F->>F: Update resource list
    F->>U: Display search results
```

---

## 4. Component Interaction Diagram

```mermaid
graph LR
    subgraph "Resources Page"
        A[Resources.tsx] --> B[ResourceList Component]
        A --> C[ResourceUpload Component]
        A --> D[SearchFilter Component]
        A --> E[CategoryFilter Component]
    end
    
    subgraph "Resource Components"
        B --> F[ResourceCard Component]
        F --> G[ResourceThumbnail Component]
        F --> H[ResourceInfo Component]
        F --> I[ResourceActions Component]
        F --> J[DownloadButton Component]
    end
    
    subgraph "Upload Components"
        C --> K[FileUpload Component]
        K --> L[DragDropZone Component]
        K --> M[FileProgress Component]
        K --> N[UploadForm Component]
        N --> O[CategorySelect Component]
        N --> P[TagInput Component]
    end
    
    subgraph "Detail Components"
        Q[ResourceDetail Component] --> R[ResourceHeader Component]
        Q --> S[ResourceContent Component]
        Q --> T[ResourceMetadata Component]
        Q --> U[ResourceActions Component]
        Q --> V[RatingComponent Component]
        Q --> W[CommentSection Component]
    end
    
    subgraph "Preview Components"
        S --> X[DocumentPreview Component]
        S --> Y[ImagePreview Component]
        S --> Z[VideoPreview Component]
        S --> AA[FileInfo Component]
    end
    
    subgraph "API Layer"
        BB[useResources Hook] --> CC[Resources API]
        DD[useUpload Hook] --> EE[Upload API]
        FF[useDownload Hook] --> GG[Download API]
        HH[useRating Hook] --> II[Rating API]
    end
    
    subgraph "Storage"
        JJ[useStorage Hook] --> KK[Storage API]
    end
    
    B --> BB
    C --> DD
    Q --> BB
    J --> FF
    V --> HH
    K --> JJ
    
    style A fill:#f3e5f5
    style C fill:#fff3e0
    style Q fill:#e8f5e8
```

---

## 5. Database Schema Diagram

```mermaid
erDiagram
    users ||--o{ resources : "uploads"
    users ||--o{ resource_downloads : "downloads"
    users ||--o{ resource_ratings : "rates"
    users ||--o{ resource_comments : "comments"
    
    resources ||--o{ resource_downloads : "has"
    resources ||--o{ resource_ratings : "has"
    resources ||--o{ resource_comments : "has"
    resources ||--o{ resource_categories : "belongs_to"
    
    resources {
        id PK
        author_id FK
        category_id FK
    }
    
    resource_downloads {
        id PK
        resource_id FK
        user_id FK
    }
    
    resource_ratings {
        id PK
        resource_id FK
        user_id FK
    }
    
    resource_comments {
        id PK
        resource_id FK
        user_id FK
        parent_id FK
    }
    
    resource_categories {
        id PK
    }
    
    users {
        id PK
    }
```

---

## 6. User Journey Flow

```mermaid
journey
    title Resource Sharing User Journey
    section Resource Discovery
      User opens resources section: 5: User
      User browses available resources: 4: User
      User filters by category: 3: User
      User searches for specific content: 4: User
    section Resource Upload
      User clicks "Upload Resource": 5: User
      User selects file from device: 4: User
      User fills resource details: 4: User
      User selects category and tags: 3: User
      User uploads resource: 5: User
      System processes and stores file: 4: System
      Resource appears in library: 4: System
    section Resource Interaction
      User views resource details: 4: User
      User previews resource content: 4: User
      User downloads resource: 5: User
      User rates resource quality: 3: User
      User adds comments: 3: User
    section Community Engagement
      User shares resource with others: 3: User
      User receives download notifications: 4: System
      User discovers related resources: 4: System
      User follows resource authors: 3: User
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
    
    subgraph "Resource Management"
        E[Upload Resource]
        F[Edit Resource]
        G[Delete Resource]
        H[View Resource]
        I[Download Resource]
        J[Preview Resource]
        K[Share Resource]
        L[Bookmark Resource]
    end
    
    subgraph "Content Organization"
        M[Create Category]
        N[Edit Category]
        O[Delete Category]
        P[Add Tags]
        Q[Remove Tags]
        R[Search Resources]
        S[Filter Resources]
        T[Sort Resources]
    end
    
    subgraph "Community Features"
        U[Rate Resource]
        V[Add Comment]
        W[Edit Comment]
        X[Delete Comment]
        Y[Report Resource]
        Z[Follow Author]
        AA[View Download History]
        BB[View Rating History]
    end
    
    subgraph "Analytics & Insights"
        CC[View Download Stats]
        DD[View Rating Stats]
        EE[View Popular Resources]
        FF[View Recent Uploads]
        GG[View Trending Resources]
        HH[Generate Reports]
    end
    
    subgraph "System Features"
        II[File Validation]
        JJ[Virus Scanning]
        KK[Content Moderation]
        LL[Storage Management]
        MM[Backup & Recovery]
    end
    
    A --> E
    A --> F
    A --> G
    A --> H
    A --> I
    A --> J
    A --> K
    A --> L
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
    
    D --> H
    D --> J
    D --> R
    D --> S
    D --> T
    
    E --> II
    E --> JJ
    Y --> KK
    E --> LL
    E --> MM
    
    style A fill:#e3f2fd
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
```

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    A[Resource Request] --> B{Authentication Valid?}
    B -->|No| C[Redirect to Login]
    B -->|Yes| D{Request Type}
    
    D -->|Upload Resource| E[Validate File]
    D -->|Download Resource| F[Check Permissions]
    D -->|View Resource| G[Load Resource]
    D -->|Rate Resource| H[Validate Rating]
    
    E --> I{File Valid?}
    I -->|No| J[Show File Error]
    I -->|Yes| K{File Size OK?}
    K -->|No| L[Show Size Error]
    K -->|Yes| M{File Type Supported?}
    M -->|No| N[Show Type Error]
    M -->|Yes| O[Upload File]
    O --> P{Upload Success?}
    P -->|No| Q[Show Upload Error]
    P -->|Yes| R[Save Resource]
    R --> S{Save Success?}
    S -->|No| T[Show Save Error]
    S -->|Yes| U[Update UI]
    
    F --> V{User Can Download?}
    V -->|No| W[Show Permission Error]
    V -->|Yes| X{File Exists?}
    X -->|No| Y[Show File Not Found]
    X -->|Yes| Z[Start Download]
    Z --> AA{Download Success?}
    AA -->|No| BB[Show Download Error]
    AA -->|Yes| CC[Track Download]
    CC --> DD{Track Success?}
    DD -->|No| EE[Show Track Error]
    DD -->|Yes| FF[Update Count]
    
    G --> GG{Resource Exists?}
    GG -->|No| HH[Show Not Found Error]
    GG -->|Yes| II{User Can View?}
    II -->|No| JJ[Show Permission Error]
    II -->|Yes| KK[Display Resource]
    
    H --> LL{Rating Valid?}
    LL -->|No| MM[Show Rating Error]
    LL -->|Yes| NN{Save Success?}
    NN -->|No| OO[Show Save Error]
    NN -->|Yes| PP[Update Rating]
    
    subgraph "Error Recovery"
        J --> QQ[Retry Upload]
        L --> RR[Compress File]
        N --> SS[Convert Format]
        Q --> TT[Retry Upload]
        T --> UU[Retry Save]
        BB --> VV[Retry Download]
        EE --> WW[Retry Tracking]
        HH --> XX[Redirect to List]
        JJ --> YY[Request Access]
        MM --> ZZ[Fix Rating]
        OO --> AAA[Retry Save]
    end
    
    subgraph "User Feedback"
        C --> BBB[Show Login Prompt]
        J --> CCC[Show File Requirements]
        L --> DDD[Show Size Limits]
        N --> EEE[Show Supported Types]
        Q --> FFF[Show Upload Progress]
        T --> GGG[Show Save Status]
        W --> HHH[Show Permission Info]
        Y --> III[Show File Status]
        BB --> JJJ[Show Download Status]
        EE --> KKK[Show Track Status]
        HH --> LLL[Show Not Found Message]
        JJ --> MMM[Show Access Info]
        MM --> NNN[Show Rating Rules]
        OO --> OOO[Show Save Status]
    end
    
    style C fill:#ffebee
    style J fill:#ffebee
    style L fill:#ffebee
    style N fill:#ffebee
    style Q fill:#ffebee
    style T fill:#ffebee
    style W fill:#ffebee
    style Y fill:#ffebee
    style BB fill:#ffebee
    style EE fill:#ffebee
    style HH fill:#ffebee
    style JJ fill:#ffebee
    style MM fill:#ffebee
    style OO fill:#ffebee
    style U fill:#e8f5e8
    style FF fill:#e8f5e8
    style KK fill:#e8f5e8
    style PP fill:#e8f5e8
```

---

*These diagrams provide comprehensive visualization of the Resource Sharing system architecture, data flow, user interactions, and error handling in the Focus Hub platform.* 