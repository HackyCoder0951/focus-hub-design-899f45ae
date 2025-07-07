# Main Application Pages

## Introduction
The Main Application Pages represent the core user-facing screens of the platform, such as the feed, chat, profile, settings, and authentication flows. Each page is designed to provide a seamless and interactive experience, leveraging modular components and real-time data.

## Data Flow Diagram Context
```mermaid
sequenceDiagram
    participant User
    participant Router
    participant Page
    User->>Router: Navigate (e.g., /feed, /chat)
    Router->>Page: Render corresponding page component
    Page-->>User: Display content and UI
```

## Use Cases Diagram Context
```mermaid
flowchart TD
  User([User]) --> Feed((Browse Feed))
  User --> Chat((Chat))
  User --> Profile((Update Profile))
  User --> Settings((Change Settings))
  User --> Auth((Login/Register))
```


## Database Design
```mermaid
erDiagram
  users ||--o{ posts : ""
  users ||--o{ chats : ""
  users ||--o{ profiles : ""
  users ||--o{ settings : ""
  posts ||--o{ comments : ""
  chats ||--o{ messages : ""
```

---
Main Application Pages are the entry points for all user interactions and workflows in the platform.

## Q&A Page – AI Answer Integration

The Q&A page features integrated AI-powered answer generation. Users can:
- Instantly generate AI answers for posted questions
- Regenerate, copy, and rate AI answers
- Benefit from fast, cost-effective, and privacy-focused AI models (Groq)

**Workflow:**
- Users request an AI-generated answer for any question
- The backend calls Groq API, stores the answer, and displays it in the Q&A interface
- Users can provide feedback, copy, or regenerate the AI answer

For setup and customization, see [AI Integration Setup](../AI_INTEGRATION_SETUP.md). 