# Developer Guide
## Focus Hub Social Learning Platform

---

## Table of Contents

1. [Development Environment Setup](#1-development-environment-setup)
2. [Code Style Guidelines](#2-code-style-guidelines)
3. [Project Structure](#3-project-structure)
4. [Development Workflow](#4-development-workflow)
5. [Testing Procedures](#5-testing-procedures)
6. [Contribution Guidelines](#6-contribution-guidelines)
7. [Release Process](#7-release-process)
8. [Performance Guidelines](#8-performance-guidelines)
9. [Security Best Practices](#9-security-best-practices)
10. [Troubleshooting](#10-troubleshooting)

---

## 1. Development Environment Setup

### 1.1 Prerequisites
```bash
# Required software versions
Node.js: 18.0.0+
npm: 8.0.0+
Git: 2.30.0+
VS Code: 1.70.0+ (recommended)
```

### 1.2 Initial Setup
```bash
# Clone the repository
git clone https://github.com/your-username/focus-hub.git
cd focus-hub

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env.local
# Edit .env.local with your configuration

# Start development server
npm run dev
```

### 1.3 IDE Configuration

#### 1.3.1 VS Code Extensions
```json
{
  "recommendations": [
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "bradlc.vscode-tailwindcss",
    "ms-vscode.vscode-typescript-next",
    "formulahendry.auto-rename-tag",
    "christian-kohler.path-intellisense",
    "ms-vscode.vscode-json"
  ]
}
```

#### 1.3.2 VS Code Settings
```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "typescript.preferences.importModuleSpecifier": "relative",
  "emmet.includeLanguages": {
    "typescript": "html",
    "typescriptreact": "html"
  }
}
```

### 1.4 Database Setup
```bash
# Install Supabase CLI
npm install -g supabase

# Login to Supabase
supabase login

# Start local Supabase
supabase start

# Apply migrations
supabase db push

# Seed database (optional)
supabase db reset
```

---

## 2. Code Style Guidelines

### 2.1 TypeScript Guidelines

#### 2.1.1 Type Definitions
```typescript
// Use interfaces for object shapes
interface User {
  id: string;
  email: string;
  fullName: string;
  role: UserRole;
  createdAt: Date;
}

// Use enums for constants
enum UserRole {
  STUDENT = 'student',
  EDUCATOR = 'educator',
  ADMIN = 'admin'
}

// Use type aliases for unions
type PostStatus = 'draft' | 'published' | 'archived';

// Use generics for reusable components
interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
}

// AI Answer types
interface AIAnswer {
  id: string;
  question_id: number;
  answer_text: string;
  generated_by: 'groq';
  user_id: string;
  model_used: string;
  tokens_used: number;
  processing_time_ms: number;
  user_feedback_rating: number | null;
  generation_attempts: number;
  created_at: string;
}
```

#### 2.1.2 Function Definitions
```typescript
// Use arrow functions for components
const UserProfile: React.FC<UserProfileProps> = ({ user, onUpdate }) => {
  // Component logic
};

// Use regular functions for utilities
function formatDate(date: Date): string {
  return date.toLocaleDateString();
}

// Use async/await for promises
async function fetchUserData(userId: string): Promise<User> {
  try {
    const response = await fetch(`/api/users/${userId}`);
    return response.json();
  } catch (error) {
    throw new Error(`Failed to fetch user: ${error.message}`);
  }
}
```

### 2.2 React Guidelines

#### 2.2.1 Component Structure
```typescript
// Component file structure
import React, { useState, useEffect } from 'react';
import { User } from '@/types/user';
import { Button } from '@/components/ui/button';
import { useUser } from '@/hooks/useUser';
import styles from './UserProfile.module.css';

interface UserProfileProps {
  user: User;
  onUpdate?: (user: User) => void;
}

export const UserProfile: React.FC<UserProfileProps> = ({ user, onUpdate }) => {
  // Hooks
  const { updateUser } = useUser();
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState(user);

  // Event handlers
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await updateUser(formData);
      setIsEditing(false);
      onUpdate?.(formData);
    } catch (error) {
      console.error('Failed to update user:', error);
    }
  };

  // Render
  return (
    <div className={styles.container}>
      {/* Component JSX */}
    </div>
  );
};
```

#### 2.2.2 Custom Hooks
```typescript
// Custom hook for data fetching
export const useApi = <T>(url: string) => {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const result = await response.json();
        setData(result);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unknown error');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [url]);

  return { data, loading, error };
};
```

### 2.3 CSS Guidelines

#### 2.3.1 Tailwind CSS
```typescript
// Use Tailwind utility classes
<div className="flex items-center justify-between p-4 bg-white rounded-lg shadow-md">
  <h2 className="text-xl font-semibold text-gray-900">User Profile</h2>
  <button className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
    Edit
  </button>
</div>

// Use custom CSS for complex styles
<div className="user-card">
  {/* Component content */}
</div>
```

#### 2.3.2 CSS Modules
```css
/* UserProfile.module.css */
.container {
  @apply max-w-4xl mx-auto p-6;
}

.header {
  @apply flex items-center justify-between mb-6;
}

.title {
  @apply text-2xl font-bold text-gray-900;
}

.form {
  @apply space-y-4;
}

.input {
  @apply w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500;
}

.button {
  @apply px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50;
}
```

---

## 3. Project Structure

### 3.1 Directory Structure
```
src/
├── api/                    # API utilities and configurations
│   ├── supabaseClient.ts   # Supabase client configuration
│   ├── auth.ts            # Authentication utilities
│   ├── ai-answers.js      # AI answer generation API
│   └── types.ts           # API type definitions
├── components/            # Reusable React components
│   ├── ui/               # UI components (shadcn/ui)
│   ├── forms/            # Form components
│   ├── layout/           # Layout components
│   ├── AIAnswer.tsx      # AI answer component
│   └── common/           # Common components
├── contexts/             # React contexts
│   ├── AuthContext.tsx   # Authentication context
│   └── ThemeContext.tsx  # Theme context
├── hooks/                # Custom React hooks
│   ├── useAuth.ts        # Authentication hook
│   ├── useApi.ts         # API hook
│   └── useLocalStorage.ts # Local storage hook
├── lib/                  # Utility libraries
│   ├── utils.ts          # General utilities
│   ├── validations.ts    # Form validations
│   └── constants.ts      # Application constants
├── pages/                # Page components
│   ├── auth/            # Authentication pages
│   ├── dashboard/       # Dashboard pages
│   ├── QandA.tsx        # Q&A page with AI integration
│   └── profile/         # Profile pages
├── types/                # TypeScript type definitions
│   ├── user.ts          # User types
│   ├── post.ts          # Post types
│   ├── ai-answers.ts    # AI answer types
│   └── api.ts           # API types
├── styles/               # Global styles
│   ├── globals.css      # Global CSS
│   └── components.css   # Component styles
└── main.tsx             # Application entry point
```

### 3.2 File Naming Conventions
```bash
# Components: PascalCase
UserProfile.tsx
PostCard.tsx
CommentList.tsx

# Utilities: camelCase
formatDate.ts
useLocalStorage.ts
apiUtils.ts

# Constants: UPPER_SNAKE_CASE
API_ENDPOINTS.ts
USER_ROLES.ts

# Types: PascalCase
User.ts
Post.ts
ApiResponse.ts

# CSS Modules: camelCase
userProfile.module.css
postCard.module.css
```

---

## 4. Development Workflow

### 4.1 Git Workflow

#### 4.1.1 Branch Naming
```bash
# Feature branches
feature/user-authentication
feature/real-time-chat
feature/ai-integration

# Bug fix branches
fix/login-validation
fix/chat-message-display

# Hotfix branches
hotfix/security-vulnerability
hotfix/critical-bug
```

#### 4.1.2 Commit Messages
```bash
# Conventional commit format
feat: add user authentication system
fix: resolve login validation issue
docs: update API documentation
style: format code with prettier
refactor: restructure user profile component
test: add unit tests for auth utilities
chore: update dependencies
```

#### 4.1.3 Pull Request Process
1. **Create Feature Branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Changes**:
   - Write code following guidelines
   - Add tests for new functionality
   - Update documentation

3. **Commit Changes**:
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

4. **Push Branch**:
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create Pull Request**:
   - Use PR template
   - Add description of changes
   - Link related issues
   - Request code review

### 4.2 Development Commands
```bash
# Start development server
npm run dev

# Build for production
npm run build

# Run tests
npm test
npm run test:watch
npm run test:coverage

# Run linting
npm run lint
npm run lint:fix

# Type checking
npm run type-check

# Format code
npm run format

# Check for security vulnerabilities
npm audit
npm audit fix
```

---

## 5. Testing Procedures

### 5.1 Unit Testing

#### 5.1.1 Component Testing
```typescript
// UserProfile.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import { UserProfile } from './UserProfile';

const mockUser = {
  id: '1',
  email: 'test@example.com',
  fullName: 'Test User',
  role: 'student',
  createdAt: new Date()
};

describe('UserProfile', () => {
  it('renders user information correctly', () => {
    render(<UserProfile user={mockUser} />);
    
    expect(screen.getByText('Test User')).toBeInTheDocument();
    expect(screen.getByText('test@example.com')).toBeInTheDocument();
  });

  it('handles edit mode toggle', () => {
    render(<UserProfile user={mockUser} />);
    
    const editButton = screen.getByText('Edit');
    fireEvent.click(editButton);
    
    expect(screen.getByDisplayValue('Test User')).toBeInTheDocument();
  });
});
```

#### 5.1.2 Hook Testing
```typescript
// useApi.test.ts
import { renderHook, waitFor } from '@testing-library/react';
import { useApi } from './useApi';

describe('useApi', () => {
  it('fetches data successfully', async () => {
    const mockData = { id: 1, name: 'Test' };
    global.fetch = jest.fn().mockResolvedValue({
      ok: true,
      json: async () => mockData
    });

    const { result } = renderHook(() => useApi('/api/test'));

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.data).toEqual(mockData);
    expect(result.current.error).toBeNull();
  });
});
```

### 5.2 Integration Testing

#### 5.2.1 API Testing
```typescript
// api.test.ts
import { supabase } from './supabaseClient';

describe('API Integration', () => {
  it('creates a new post', async () => {
    const postData = {
      title: 'Test Post',
      content: 'Test content',
      author_id: 'test-user-id'
    };

    const { data, error } = await supabase
      .from('posts')
      .insert(postData)
      .select()
      .single();

    expect(error).toBeNull();
    expect(data.title).toBe('Test Post');
  });
});
```

### 5.3 End-to-End Testing

#### 5.3.1 Cypress Tests
```typescript
// cypress/e2e/user-authentication.cy.js
describe('User Authentication', () => {
  it('allows user to register and login', () => {
    // Visit registration page
    cy.visit('/register');
    
    // Fill registration form
    cy.get('[data-testid="email-input"]').type('test@example.com');
    cy.get('[data-testid="password-input"]').type('password123');
    cy.get('[data-testid="full-name-input"]').type('Test User');
    cy.get('[data-testid="register-button"]').click();
    
    // Verify successful registration
    cy.url().should('include', '/dashboard');
    cy.get('[data-testid="user-menu"]').should('contain', 'Test User');
  });
});
```

---

## 6. Contribution Guidelines

### 6.1 Code Review Process

#### 6.1.1 Review Checklist
- [ ] Code follows style guidelines
- [ ] Tests are included and passing
- [ ] Documentation is updated
- [ ] No security vulnerabilities
- [ ] Performance considerations addressed
- [ ] Accessibility requirements met

#### 6.1.2 Review Comments
```typescript
// Good review comment
// Consider extracting this logic into a custom hook for reusability
const [data, setData] = useState(null);
const [loading, setLoading] = useState(true);

// Better approach
const { data, loading } = useApi('/api/posts');
```

### 6.2 Documentation Requirements

#### 6.2.1 Code Documentation
```typescript
/**
 * Custom hook for managing user authentication state
 * @param {string} userId - The user ID to fetch data for
 * @returns {Object} Object containing user data, loading state, and error
 */
export const useUser = (userId: string) => {
  // Implementation
};
```

#### 6.2.2 README Updates
- Update feature list for new features
- Add installation instructions for new dependencies
- Update API documentation
- Add usage examples

---

## 7. Release Process

### 7.1 Version Management

#### 7.1.1 Semantic Versioning
```bash
# Major version (breaking changes)
npm version major

# Minor version (new features)
npm version minor

# Patch version (bug fixes)
npm version patch
```

#### 7.1.2 Release Checklist
- [ ] All tests passing
- [ ] Code review completed
- [ ] Documentation updated
- [ ] Changelog updated
- [ ] Version bumped
- [ ] Release notes prepared

### 7.2 Deployment Process

#### 7.2.1 Staging Deployment
```bash
# Deploy to staging
npm run build:staging
vercel --prod --env staging
```

#### 7.2.2 Production Deployment
```bash
# Deploy to production
npm run build:production
vercel --prod
```

---

## 8. Performance Guidelines

### 8.1 React Performance

#### 8.1.1 Component Optimization
```typescript
// Use React.memo for expensive components
const ExpensiveComponent = React.memo(({ data }) => {
  return <div>{/* Expensive rendering logic */}</div>;
});

// Use useMemo for expensive calculations
const expensiveValue = useMemo(() => {
  return computeExpensiveValue(data);
}, [data]);

// Use useCallback for event handlers
const handleClick = useCallback(() => {
  // Event handler logic
}, [dependencies]);
```

#### 8.1.2 Code Splitting
```typescript
// Lazy load components
const AdminDashboard = lazy(() => import('./AdminDashboard'));
const Chat = lazy(() => import('./Chat'));

// Use Suspense for loading states
<Suspense fallback={<LoadingSpinner />}>
  <AdminDashboard />
</Suspense>
```

### 8.2 Bundle Optimization

#### 8.2.1 Tree Shaking
```typescript
// Import specific functions instead of entire modules
import { format } from 'date-fns'; // Good
import * as dateFns from 'date-fns'; // Bad
```

#### 8.2.2 Dynamic Imports
```typescript
// Load modules on demand
const loadHeavyModule = async () => {
  const module = await import('./heavy-module');
  return module.default;
};
```

---

## 9. Security Best Practices

### 9.1 Input Validation

#### 9.1.1 Form Validation
```typescript
// Use Zod for schema validation
import { z } from 'zod';

const userSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  fullName: z.string().min(2).max(100)
});

const validateUser = (data: unknown) => {
  return userSchema.parse(data);
};
```

#### 9.1.2 XSS Prevention
```typescript
// Sanitize user input
import DOMPurify from 'dompurify';

const sanitizeHtml = (html: string) => {
  return DOMPurify.sanitize(html);
};
```

### 9.2 Authentication Security

#### 9.2.1 Token Management
```typescript
// Secure token storage
const storeToken = (token: string) => {
  localStorage.setItem('auth_token', token);
};

const getToken = () => {
  return localStorage.getItem('auth_token');
};

const removeToken = () => {
  localStorage.removeItem('auth_token');
};
```

#### 9.2.2 API Security
```typescript
// Include authentication headers
const apiCall = async (url: string, options: RequestInit = {}) => {
  const token = getToken();
  
  return fetch(url, {
    ...options,
    headers: {
      ...options.headers,
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
  });
};
```

---

## 10. Troubleshooting

### 10.1 Common Development Issues

#### 10.1.1 Build Errors
```bash
# Clear cache and reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# Clear Vite cache
rm -rf node_modules/.vite

# Check TypeScript errors
npm run type-check
```

#### 10.1.2 Database Issues
```bash
# Reset local database
supabase db reset

# Check database status
supabase status

# View database logs
supabase logs
```

#### 10.1.3 Environment Issues
```bash
# Check environment variables
echo $VITE_SUPABASE_URL
echo $VITE_SUPABASE_ANON_KEY

# Verify .env.local file
cat .env.local
```

### 10.2 Debugging Tools

#### 10.2.1 React DevTools
- Install React Developer Tools browser extension
- Use Components tab to inspect component tree
- Use Profiler tab to analyze performance

#### 10.2.2 Network Debugging
```typescript
// Enable network logging
const apiCall = async (url: string, options: RequestInit = {}) => {
  console.log('API Call:', url, options);
  
  const response = await fetch(url, options);
  console.log('API Response:', response);
  
  return response;
};
```

#### 10.2.3 Error Boundaries
```typescript
// Implement error boundaries
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }

    return this.props.children;
  }
}
```

---

*This developer guide provides comprehensive information for contributing to the Focus Hub platform, including setup instructions, coding standards, testing procedures, and best practices.* 