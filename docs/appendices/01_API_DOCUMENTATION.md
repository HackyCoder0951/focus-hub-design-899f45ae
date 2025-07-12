# API Documentation
## Focus Hub Social Learning Platform

---

## Table of Contents

1. [Authentication APIs](#1-authentication-apis)
2. [User Management APIs](#2-user-management-apis)
3. [Social Feed APIs](#3-social-feed-apis)
4. [Q&A Module APIs](#4-qa-module-apis)
5. [Chat System APIs](#5-chat-system-apis)
6. [Resource Sharing APIs](#6-resource-sharing-apis)
7. [Admin Dashboard APIs](#7-admin-dashboard-apis)
8. [Error Codes](#8-error-codes)
9. [Rate Limiting](#9-rate-limiting)

---

## Base URL
```
Production: https://api.focushub.com/v1
Development: http://localhost:3000/api/v1
```

## Authentication
All API requests require authentication using JWT tokens in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

---

## 1. Authentication APIs

### 1.1 User Registration
**POST** `/auth/register`

Register a new user account.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123",
  "full_name": "John Doe",
  "username": "johndoe",
  "role": "student"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "user": {
      "id": "uuid",
      "email": "user@example.com",
      "full_name": "John Doe",
      "username": "johndoe",
      "role": "student",
      "created_at": "2024-01-01T00:00:00Z"
    },
    "token": "jwt-token"
  }
}
```

### 1.2 User Login
**POST** `/auth/login`

Authenticate user and return JWT token.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": "uuid",
      "email": "user@example.com",
      "full_name": "John Doe",
      "username": "johndoe",
      "role": "student"
    },
    "token": "jwt-token"
  }
}
```

### 1.3 Password Reset
**POST** `/auth/reset-password`

Request password reset email.

**Request Body:**
```json
{
  "email": "user@example.com"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Password reset email sent"
}
```

---

## 2. User Management APIs

### 2.1 Get User Profile
**GET** `/users/profile`

Get current user's profile information.

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "email": "user@example.com",
    "full_name": "John Doe",
    "username": "johndoe",
    "role": "student",
    "bio": "Software engineering student",
    "avatar_url": "https://example.com/avatar.jpg",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

### 2.2 Update User Profile
**PUT** `/users/profile`

Update user profile information.

**Request Body:**
```json
{
  "full_name": "John Smith",
  "bio": "Updated bio",
  "avatar_url": "https://example.com/new-avatar.jpg"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Profile updated successfully",
  "data": {
    "id": "uuid",
    "full_name": "John Smith",
    "bio": "Updated bio",
    "avatar_url": "https://example.com/new-avatar.jpg",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

---

## 3. Social Feed APIs

### 3.1 Get Posts
**GET** `/posts`

Get paginated list of posts.

**Query Parameters:**
- `page` (number): Page number (default: 1)
- `limit` (number): Posts per page (default: 10, max: 50)
- `category` (string): Filter by category
- `author` (string): Filter by author username

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "posts": [
      {
        "id": "uuid",
        "title": "Post Title",
        "content": "Post content...",
        "author": {
          "id": "uuid",
          "username": "johndoe",
          "full_name": "John Doe",
          "avatar_url": "https://example.com/avatar.jpg"
        },
        "category": "technology",
        "likes_count": 15,
        "comments_count": 5,
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 100,
      "pages": 10
    }
  }
}
```

### 3.2 Create Post
**POST** `/posts`

Create a new post.

**Request Body:**
```json
{
  "title": "New Post Title",
  "content": "Post content...",
  "category": "technology",
  "tags": ["react", "javascript"]
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Post created successfully",
  "data": {
    "id": "uuid",
    "title": "New Post Title",
    "content": "Post content...",
    "author": {
      "id": "uuid",
      "username": "johndoe",
      "full_name": "John Doe"
    },
    "category": "technology",
    "tags": ["react", "javascript"],
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

### 3.3 Like/Unlike Post
**POST** `/posts/{postId}/like`

Toggle like status for a post.

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Post liked successfully",
  "data": {
    "liked": true,
    "likes_count": 16
  }
}
```

---

## 4. Q&A Module APIs

### 4.1 Get Questions
**GET** `/questions`

Get paginated list of questions.

**Query Parameters:**
- `page` (number): Page number (default: 1)
- `limit` (number): Questions per page (default: 10)
- `category` (string): Filter by category
- `status` (string): Filter by status (open, answered, closed)

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "questions": [
      {
        "id": "uuid",
        "title": "How to implement real-time features?",
        "content": "Question content...",
        "author": {
          "id": "uuid",
          "username": "johndoe",
          "full_name": "John Doe"
        },
        "category": "technology",
        "status": "open",
        "answers_count": 3,
        "votes_count": 5,
        "created_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 50,
      "pages": 5
    }
  }
}
```

### 4.2 Create Question
**POST** `/questions`

Create a new question.

**Request Body:**
```json
{
  "title": "How to implement real-time features?",
  "content": "I'm building a social platform and need help with real-time updates...",
  "category": "technology",
  "tags": ["websockets", "react", "real-time"]
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Question created successfully",
  "data": {
    "id": "uuid",
    "title": "How to implement real-time features?",
    "content": "I'm building a social platform...",
    "author": {
      "id": "uuid",
      "username": "johndoe",
      "full_name": "John Doe"
    },
    "category": "technology",
    "tags": ["websockets", "react", "real-time"],
    "status": "open",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

### 4.3 Get AI Answer Suggestion
**POST** `/questions/{questionId}/ai-suggest`

Get AI-powered answer suggestion.

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "suggestion": "Based on your question about real-time features, here's a comprehensive answer...",
    "confidence": 0.85,
    "sources": [
      "WebSocket API documentation",
      "React documentation"
    ]
  }
}
```

---

## 5. Chat System APIs

### 5.1 Get Chat Rooms
**GET** `/chat/rooms`

Get user's chat rooms.

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "rooms": [
      {
        "id": "uuid",
        "name": "General Discussion",
        "type": "group",
        "last_message": {
          "content": "Hello everyone!",
          "sender": "johndoe",
          "timestamp": "2024-01-01T00:00:00Z"
        },
        "unread_count": 3,
        "participants_count": 15
      }
    ]
  }
}
```

### 5.2 Get Chat Messages
**GET** `/chat/rooms/{roomId}/messages`

Get messages for a specific chat room.

**Query Parameters:**
- `page` (number): Page number (default: 1)
- `limit` (number): Messages per page (default: 50)

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "messages": [
      {
        "id": "uuid",
        "content": "Hello everyone!",
        "sender": {
          "id": "uuid",
          "username": "johndoe",
          "full_name": "John Doe",
          "avatar_url": "https://example.com/avatar.jpg"
        },
        "timestamp": "2024-01-01T00:00:00Z",
        "type": "text"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 50,
      "total": 150,
      "pages": 3
    }
  }
}
```

---

## 6. Resource Sharing APIs

### 6.1 Get Resources
**GET** `/resources`

Get paginated list of resources.

**Query Parameters:**
- `page` (number): Page number (default: 1)
- `limit` (number): Resources per page (default: 20)
- `category` (string): Filter by category
- `search` (string): Search in title and description

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "resources": [
      {
        "id": "uuid",
        "title": "React Best Practices",
        "description": "A comprehensive guide to React development",
        "file_url": "https://example.com/file.pdf",
        "file_size": 2048576,
        "file_type": "pdf",
        "category": "documentation",
        "author": {
          "id": "uuid",
          "username": "johndoe",
          "full_name": "John Doe"
        },
        "downloads_count": 25,
        "created_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 200,
      "pages": 10
    }
  }
}
```

### 6.2 Upload Resource
**POST** `/resources`

Upload a new resource file.

**Request Body (multipart/form-data):**
```
file: [binary file data]
title: "React Best Practices"
description: "A comprehensive guide to React development"
category: "documentation"
tags: ["react", "javascript", "frontend"]
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Resource uploaded successfully",
  "data": {
    "id": "uuid",
    "title": "React Best Practices",
    "description": "A comprehensive guide to React development",
    "file_url": "https://example.com/file.pdf",
    "file_size": 2048576,
    "file_type": "pdf",
    "category": "documentation",
    "tags": ["react", "javascript", "frontend"],
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

---

## 7. Admin Dashboard APIs

### 7.1 Get Platform Statistics
**GET** `/admin/statistics`

Get platform-wide statistics (admin only).

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "users": {
      "total": 1500,
      "active": 1200,
      "new_this_month": 150
    },
    "content": {
      "posts": 2500,
      "questions": 800,
      "resources": 300
    },
    "engagement": {
      "total_likes": 15000,
      "total_comments": 8000,
      "total_downloads": 5000
    }
  }
}
```

### 7.2 Get User Management
**GET** `/admin/users`

Get user management data (admin only).

**Query Parameters:**
- `page` (number): Page number (default: 1)
- `limit` (number): Users per page (default: 20)
- `role` (string): Filter by role
- `status` (string): Filter by status (active, suspended, banned)

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "users": [
      {
        "id": "uuid",
        "email": "user@example.com",
        "full_name": "John Doe",
        "username": "johndoe",
        "role": "student",
        "status": "active",
        "created_at": "2024-01-01T00:00:00Z",
        "last_login": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 1500,
      "pages": 75
    }
  }
}
```

---

## 8. Error Codes

| Code | Message | Description |
|------|---------|-------------|
| 400 | Bad Request | Invalid request parameters |
| 401 | Unauthorized | Authentication required |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource not found |
| 409 | Conflict | Resource already exists |
| 422 | Unprocessable Entity | Validation errors |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Server error |

### Error Response Format
```json
{
  "success": false,
  "error": {
    "code": 400,
    "message": "Bad Request",
    "details": "Invalid email format"
  }
}
```

---

## 9. Rate Limiting

### Rate Limits
- **Authentication APIs**: 5 requests per minute
- **User Management APIs**: 60 requests per hour
- **Social Feed APIs**: 100 requests per hour
- **Q&A APIs**: 50 requests per hour
- **Chat APIs**: 200 requests per hour
- **Resource APIs**: 30 requests per hour
- **Admin APIs**: 1000 requests per hour

### Rate Limit Headers
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640995200
```

### Rate Limit Exceeded Response
```json
{
  "success": false,
  "error": {
    "code": 429,
    "message": "Too Many Requests",
    "details": "Rate limit exceeded. Try again in 60 seconds."
  }
}
```

---

*This API documentation provides comprehensive information about all endpoints, request/response formats, error handling, and rate limiting for the Focus Hub platform.* 