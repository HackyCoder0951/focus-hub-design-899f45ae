# Settings

## Introduction
The Settings page allows users to manage their account preferences, notification settings, privacy controls, and security options.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant User
    participant Settings
    participant API
    participant Database
    User->>Settings: Update preferences, change password, set privacy
    Settings->>API: Send request
    API->>Database: Update user/profile/settings
    Database-->>API: Return result
    API-->>Settings: Response
    Settings-->>User: Update UI
```

## Use Cases Diagram Context
```mermaid
usecaseDiagram
  actor User
  User --> (Update Account Info)
  User --> (Change Password)
  User --> (Set Notification Preferences)
  User --> (Manage Privacy Settings)
  User --> (Enable 2FA)
```

## Database Design
```mermaid
erDiagram
  users ||--o{ profiles : ""
  profiles ||--o{ user_roles : ""
```

## Summary
The Settings page empowers users to personalize and secure their account experience. 