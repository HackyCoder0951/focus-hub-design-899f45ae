# Focus Hub - Technical Documentation

## Project Overview

**Focus Hub** is a modern, full-stack social platform that brings together communication, knowledge sharing, and collaboration in one beautiful interface. The platform features real-time messaging, social feeds, Q&A communities, and resource sharing capabilities.

## Technology Stack

### Frontend Framework
- **React 18.3.1** with TypeScript 5.5.3
- **Vite 5.4.1** as the build tool and development server
- **React Router DOM 6.26.2** for client-side routing
- **SWC** for fast compilation

### UI/UX Framework
- **shadcn/ui** - Modern component library built on Radix UI primitives
- **Tailwind CSS 3.4.11** with custom design system
- **Radix UI** components for accessible, unstyled UI primitives
- **Lucide React** for iconography
- **Framer Motion** for animations
- **Next Themes** for dark/light mode support

### Backend & Database
- **Supabase** as the backend-as-a-service
  - PostgreSQL database with Row Level Security (RLS)
  - Real-time subscriptions
  - Authentication with email/password
  - File storage capabilities

### State Management & Data Fetching
- **TanStack React Query 5.56.2** for server state management
- **React Context API** for authentication state
- **React Hook Form 7.53.0** with Zod validation

### Development Tools
- **ESLint 9.9.0** with React-specific rules
- **TypeScript** with strict configuration
- **PostCSS** with Autoprefixer
- **Lovable Tagger** for component tagging in development

## Available Features

### 1. Authentication System
- **User Registration**: Email/password signup with email verification
- **User Login**: Secure email/password authentication
- **Password Recovery**: Forgot password functionality with email reset
- **Session Management**: Automatic session handling and persistence
- **Role-based Access**: Admin and user role management
- **Protected Routes**: Automatic redirects for unauthenticated users

### 2. Social Feed
- **Post Creation**: Rich text posts with media support
- **Social Interactions**: Like, comment, and share functionality
- **Real-time Updates**: Live feed updates using Supabase subscriptions
- **Infinite Scroll**: Efficient pagination for large feeds
- **Post Categories**: Organized content by topics and interests
- **User Mentions**: Tag other users in posts and comments
- **Content Flagging**: Users can flag posts for review; admins are notified and can review, resolve, dismiss, or delete flagged content

### 3. Real-time Chat System
- **Instant Messaging**: Real-time message delivery
- **Online Indicators**: User presence and status display
- **Message History**: Persistent chat history and search
- **File Sharing**: Media and document sharing in chats, with file-type icons and download links
- **Group Chats**: Multi-user conversation support
- **Message Reactions**: Emoji reactions to messages
- **Typing Indicators**: Real-time typing status

### 4. Q&A Community
- **Question Posting**: Structured question format with categories (UI-based, not DB-enforced)
- **Answer System**: Community-driven answers with voting
- **Voting System**: Upvote/downvote for both questions and answers, with per-user vote tracking
- **Answer Comments**: Threaded comments on answers
- **Search & Filter**: Advanced search and filtering capabilities, including trending and unanswered tabs
- **Best Answer Selection**: Mark best answers for questions
- **Question Tags**: Categorize questions with tags
- **Reputation System**: User reputation based on contributions
- **Editing/Deleting**: Users can edit or delete their own questions/answers

### 5. Resource Sharing
- **File Upload**: Drag-and-drop file uploads with progress
- **Document Management**: Organize and categorize resources
- **Access Control**: Public and private resource sharing
- **Preview System**: File previews for images, videos, PDFs, and text files
- **Version Control**: Track file versions and updates
- **Download Tracking**: Monitor resource usage and popularity
- **File Categories**: Organize resources by type and topic
- **File Metadata**: Add/edit descriptions and visibility for files
- **Filtering & Sorting**: Search, filter by type/visibility, and sort files
- **Grid/List Views**: Toggle between grid and list views for resources
- **Edit & Delete**: Users can edit metadata or delete their own files

### 6. User Profiles
- **Profile Management**: Edit personal information and bio
- **Avatar Upload**: Profile picture management with cropping
- **Activity History**: User activity and contributions timeline
- **Privacy Settings**: Control profile visibility and data sharing
- **Social Connections**: Follow other users and build networks
- **Achievement System**: Badges and milestones for engagement
- **Profile Customization**: Custom themes and layouts

### 7. Admin Dashboard
- **User Management**: View and manage all user accounts
- **Role Management**: Assign and modify user roles and permissions
- **System Statistics**: Platform usage analytics and metrics
- **Content Moderation**: Moderate posts, comments, and resources; review flagged content with action options
- **System Health**: Monitor platform performance and errors
- **Bulk Operations**: Manage multiple users and content items
- **Audit Logs**: Track administrative actions and changes

### 8. Settings & Preferences
- **Account Settings**: Manage email, password, and account details
- **Notification Preferences**: Customize notification settings
- **Privacy Controls**: Manage data sharing and visibility
- **Theme Customization**: Choose between light and dark themes
- **Language Settings**: Multi-language support
- **Security Settings**: Two-factor authentication and security options
- **Data Export**: Export user data and activity history

### 9. UI/UX Enhancements (New)
- **Role-based Navigation**: Sidebar and navigation adapt to user/admin roles
- **Toast Notifications**: Consistent feedback for all user actions
- **Modern UI**: Consistent use of shadcn/ui, Radix, and Tailwind for accessible, responsive design
- **Advanced Filtering/Sorting**: Robust filtering and sorting in resources and Q&A

## Technical Architecture

### Project Structure
The application follows a modular component architecture with clear separation of concerns:
- **Layout Components**: Handle overall page structure and navigation
- **UI Components**: Reusable, accessible components from shadcn/ui
- **Page Components**: Route-specific components for different views
- **Context Providers**: Global state management for authentication and theming

### Database Schema
- **Profiles Table**: User profile information linked to Supabase Auth
- **User Roles Table**: Role-based access control for admin and user permissions
- **App Role Enum**: Defines available user roles in the system
- **Row Level Security**: Database-level access control policies
- **Automatic Triggers**: Profile and role creation on user signup

### Security Features
- **Authentication Security**: Enterprise-grade authentication via Supabase
- **Data Security**: Row Level Security with role-based permissions
- **Frontend Security**: Protected routes and input validation
- **Content Security**: XSS prevention and CSRF protection

### Routing Structure
- **Public Routes**: Landing page, authentication, and registration
- **Protected Routes**: Main application with authentication required
- **Admin Routes**: Administrative functions with role-based access
- **Route Protection**: Automatic redirects and loading states

### Content Moderation Workflow (New)
- **Flagging:** Users can flag posts for review, specifying a reason. Duplicate flagging is prevented.
- **Admin Review:** Admins have a dedicated interface to review flagged content, see reasons, and take actions (resolve, dismiss, or delete posts).
- **Notifications:** When a post is flagged, all admins and the post owner (except the flagger) are notified.

### Resource Sharing & File Management (Expanded)
- **File Upload & Storage:** Files are uploaded to Supabase Storage, with metadata stored in the `filemodels` table.
- **Preview & Download:** Users can preview images, videos, PDFs, and text files in-app, and download any file.
- **Edit & Delete:** Users can edit file metadata or delete their own files.
- **Filtering & Sorting:** Resource library supports search, type/visibility filters, and multiple sort options.
- **Grid/List Views:** Users can toggle between grid and list views for resources.

### Q&A System (Expanded)
- **Single-table Model:** Both questions and answers are stored in a single `questionanswers` table, differentiated by an `is_answered` flag.
- **Voting:** Both questions and answers support upvote/downvote, with per-user vote tracking.
- **Answer Comments:** Answers can have threaded comments.
- **Editing/Deleting:** Users can edit or delete their own questions/answers.
- **Categories:** There is a category filter, but categories are currently hardcoded and not stored in the DB.
- **Trending/Unanswered Tabs:** UI supports sorting/filtering for trending and unanswered questions.

---

### AI-Powered Q&A and Answer Generation

Focus Hub integrates advanced AI answer generation directly into the Q&A module using the Groq API. This enables:
- Instant, high-quality AI-generated answers to user questions
- Regeneration, copying, and rating of AI answers
- Use of fast, cost-effective, and privacy-focused models (Groq Llama3, Mixtral, Gemma2, etc.)
- A seamless blend of community and AI knowledge

**Workflow:**
- Users can request an AI-generated answer for any question
- The backend calls Groq API, stores the answer, and displays it in the Q&A interface
- Users can provide feedback, copy, or regenerate the AI answer

For setup and customization, see `docs/AI_INTEGRATION_SETUP.md` and `docs/GROQ_AI_INTEGRATION_SETUP.md`.

### Chat System (Expanded)
- **File Sharing in Chat:** Users can share files in chat, with file-type icons and download links.
- **Online Status:** User presence is tracked and updated.

## UI/UX Features

### Design System
- **Consistent Components**: shadcn/ui component library
- **Accessibility**: WCAG 2.1 AA compliance
- **Responsive Design**: Mobile-first approach
- **Theme Support**: Dark and light mode with system preference detection

### User Experience
- **Loading States**: Skeleton screens and spinners
- **Error Handling**: User-friendly error messages and recovery
- **Toast Notifications**: Non-intrusive feedback system
- **Smooth Animations**: Framer Motion animations and transitions
- **Progressive Enhancement**: Works without JavaScript

### Responsive Design
- **Mobile-First**: Optimized for mobile devices
- **Breakpoint System**: Tailwind's responsive utilities
- **Touch-Friendly**: Optimized for touch interactions
- **Cross-Platform**: Consistent experience across devices

## Development & Deployment

### Development Environment
- **Hot Reload**: Instant feedback during development
- **TypeScript**: Strict typing and IntelliSense support
- **ESLint**: Code quality and style enforcement
- **Path Aliases**: Clean import paths with @/ prefix

### Build System
- **Vite**: Fast build tool with optimized output
- **SWC**: Rapid compilation for development
- **Asset Optimization**: Minified CSS, JS, and images
- **Tree Shaking**: Unused code elimination

### Deployment Platform
- **Lovable Platform**: Integrated deployment and hosting
- **Custom Domains**: Support for custom domain names
- **SSL Certificates**: Automatic HTTPS configuration
- **CDN Distribution**: Global content delivery network
- **Automatic Deployments**: Deploy from Git repository

### Environment Management
- **Development Mode**: Local development with hot reload
- **Production Mode**: Optimized builds for production
- **Environment Variables**: Secure configuration management
- **Build Scripts**: Automated build and deployment processes

## Performance & Scalability

### Frontend Performance
- **Code Splitting**: Lazy loading of routes and components
- **Bundle Optimization**: Efficient JavaScript bundling
- **Image Optimization**: Compressed and responsive images
- **Caching Strategy**: Browser and CDN caching

### Backend Performance
- **Database Optimization**: Indexed queries and efficient schemas
- **Real-time Subscriptions**: Efficient WebSocket connections
- **File Storage**: Optimized file upload and delivery
- **API Rate Limiting**: Protection against abuse

### Scalability Features
- **Horizontal Scaling**: Stateless application architecture
- **Database Scaling**: Supabase's managed PostgreSQL scaling
- **CDN Integration**: Global content distribution
- **Load Balancing**: Automatic traffic distribution

## Monitoring & Analytics

### System Monitoring
- **Error Tracking**: Application error monitoring and reporting
- **Performance Metrics**: Load times and user experience tracking
- **User Analytics**: Usage patterns and feature adoption
- **System Health**: Platform uptime and performance monitoring

### User Analytics
- **Engagement Metrics**: User activity and interaction tracking
- **Feature Usage**: Most and least used platform features
- **User Journey**: User flow and conversion tracking
- **A/B Testing**: Feature testing and optimization

## Future Roadmap

### Planned Features
- **Mobile App**: Native iOS and Android applications
- **Advanced Search**: Full-text search across all content
- **API Integration**: Third-party service integrations
- **Advanced Analytics**: Detailed user behavior insights
- **Multi-tenancy**: Support for multiple organizations
- **Advanced Moderation**: AI-powered content moderation
- **Video Streaming**: Live video and streaming capabilities

### Technical Improvements
- **Microservices**: Service-oriented architecture
- **GraphQL API**: Flexible data querying
- **Real-time Collaboration**: Live document editing
- **Advanced Caching**: Redis-based caching layer
- **Containerization**: Docker-based deployment
- **CI/CD Pipeline**: Automated testing and deployment

---

**Documentation Version**: 1.0.0  
**Last Updated**: January 2025  
**Maintainer**: Focus Hub Development Team
