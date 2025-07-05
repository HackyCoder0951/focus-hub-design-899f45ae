# Admin Dashboard

## Introduction
The Admin Dashboard provides administrators with tools to manage users, roles, content moderation, analytics, and system health for the platform.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant Admin
    participant AdminDashboard
    participant API
    participant Database
    Admin->>AdminDashboard: View/manage users, roles, content
    AdminDashboard->>API: Send admin request
    API->>Database: Perform admin operation
    Database-->>API: Return result
    API-->>AdminDashboard: Response
    AdminDashboard-->>Admin: Update UI
```

## Use Cases Diagram Context
```mermaid
graph TD
  Admin[Admin] --> UC1(View User Accounts)
  Admin --> UC2(Assign/Modify Roles)
  Admin --> UC3(Moderate Content)
  Admin --> UC4(View Analytics)
  Admin --> UC5(Monitor System Health)
  Admin --> UC6(Review Audit Logs)
```

## Database Design
```mermaid
erDiagram
  users ||--o{ user_roles : ""
  users ||--o{ profiles : ""
  users ||--o{ audit_logs : ""
  posts ||--o{ flagged_content : ""
  flagged_content }|..|{ users : ""
```

## Summary
The Admin Dashboard is the control center for platform administrators, supporting user management, moderation, analytics, and system monitoring. 