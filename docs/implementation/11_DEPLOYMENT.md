# Deployment Implementation

## Overview

This document covers the complete deployment process for the Focus Hub application, including build configuration, environment setup, and deployment strategies.

## Build Configuration

### 1. Vite Configuration

**File**: `vite.config.ts`
```typescript
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";

export default defineConfig(({ mode }) => ({
  server: {
    host: "::",
    port: 5173,
    proxy: {
      '/api': 'http://localhost:8080'
    }
  },
  plugins: [
    react(),
  ],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
    dedupe: ["react", "react-dom"],
  },
  build: {
    minify: "esbuild",
    cssCodeSplit: true,
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (id.includes('node_modules')) {
            return id.toString().split('node_modules/')[1].split('/')[0].toString();
          }
        },
      },
    },
    reportCompressedSize: true,
  },
}));
```

### 2. Package.json Scripts

**File**: `package.json`
```json
{
  "name": "focus_hub",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "build:dev": "vite build --mode development",
    "lint": "eslint .",
    "preview": "vite preview",
    "test:groq": "node test-groq.js"
  }
}
```

### 3. TypeScript Configuration

**File**: `tsconfig.json`
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

## Environment Configuration

### 1. Environment Variables

**File**: `.env.example`
```env
# Supabase Configuration
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key

# AI Integration
GROQ_API_KEY=your_groq_api_key

# Development
NODE_ENV=development
VITE_API_URL=http://localhost:8080

# Production
# VITE_API_URL=https://your-api-domain.com
```

### 2. Environment Types

**File**: `src/vite-env.d.ts`
```typescript
/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_SUPABASE_URL: string
  readonly VITE_SUPABASE_ANON_KEY: string
  readonly VITE_API_URL: string
  readonly GROQ_API_KEY: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
```

## Build Process

### 1. Development Build

```bash
# Install dependencies
npm install

# Start development server
npm run dev
```

### 2. Production Build

```bash
# Create production build
npm run build

# Preview production build
npm run preview
```

### 3. Build Optimization

The build process includes several optimizations:

- **Code Splitting**: Automatic chunk splitting for better caching
- **Tree Shaking**: Unused code elimination
- **Minification**: ESBuild minification for smaller bundle sizes
- **CSS Optimization**: CSS code splitting and optimization
- **Asset Optimization**: Automatic asset optimization

## Deployment Strategies

### 1. Static Hosting (Vercel/Netlify)

#### Vercel Deployment

**File**: `vercel.json`
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "framework": "vite",
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "/api/$1"
    }
  ],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        }
      ]
    }
  ]
}
```

#### Netlify Deployment

**File**: `netlify.toml`
```toml
[build]
  command = "npm run build"
  publish = "dist"

[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/api/:splat"
  status = 200

[[headers]]
  for = "/*"
  [headers.values]
    X-Content-Type-Options = "nosniff"
    X-Frame-Options = "DENY"
    X-XSS-Protection = "1; mode=block"
    Referrer-Policy = "strict-origin-when-cross-origin"
```

### 2. Docker Deployment

#### Dockerfile

**File**: `Dockerfile`
```dockerfile
# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
COPY bun.lockb ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Build application
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built application
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
```

#### Nginx Configuration

**File**: `nginx.conf`
```nginx
events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;

    server {
        listen 80;
        server_name localhost;
        root /usr/share/nginx/html;
        index index.html;

        # Security headers
        add_header X-Content-Type-Options nosniff;
        add_header X-Frame-Options DENY;
        add_header X-XSS-Protection "1; mode=block";
        add_header Referrer-Policy "strict-origin-when-cross-origin";

        # Handle client-side routing
        location / {
            try_files $uri $uri/ /index.html;
        }

        # API proxy
        location /api/ {
            proxy_pass http://backend:8080/;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        # Static assets caching
        location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
            expires 1y;
            add_header Cache-Control "public, immutable";
        }
    }
}
```

#### Docker Compose

**File**: `docker-compose.yml`
```yaml
version: '3.8'

services:
  frontend:
    build: .
    ports:
      - "80:80"
    depends_on:
      - backend
    environment:
      - VITE_API_URL=http://backend:8080

  backend:
    image: node:18-alpine
    working_dir: /app
    ports:
      - "8080:8080"
    volumes:
      - ./api:/app
    environment:
      - NODE_ENV=production
      - GROQ_API_KEY=${GROQ_API_KEY}
    command: ["node", "server.js"]

  nginx:
    image: nginx:alpine
    ports:
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - frontend
      - backend
```

### 3. Cloud Deployment

#### AWS S3 + CloudFront

**File**: `deploy-aws.sh`
```bash
#!/bin/bash

# Build the application
npm run build

# Sync to S3
aws s3 sync dist/ s3://your-bucket-name --delete

# Invalidate CloudFront cache
aws cloudfront create-invalidation --distribution-id YOUR_DISTRIBUTION_ID --paths "/*"

echo "Deployment completed!"
```

#### Google Cloud Platform

**File**: `app.yaml`
```yaml
runtime: nodejs18

handlers:
  - url: /api/.*
    script: auto
    secure: always

  - url: /.*
    static_files: dist/index.html
    upload: dist/index.html
    secure: always

  - url: /(.*\..*)
    static_files: dist/\1
    upload: dist/(.*\..*)
    secure: always

env_variables:
  NODE_ENV: "production"
```

## CI/CD Pipeline

### 1. GitHub Actions

**File**: `.github/workflows/deploy.yml`
```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test
      
      - name: Run linting
        run: npm run lint
      
      - name: Build application
        run: npm run build
        env:
          VITE_SUPABASE_URL: ${{ secrets.VITE_SUPABASE_URL }}
          VITE_SUPABASE_ANON_KEY: ${{ secrets.VITE_SUPABASE_ANON_KEY }}

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Build application
        run: npm run build
        env:
          VITE_SUPABASE_URL: ${{ secrets.VITE_SUPABASE_URL }}
          VITE_SUPABASE_ANON_KEY: ${{ secrets.VITE_SUPABASE_ANON_KEY }}
      
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
```

### 2. GitLab CI

**File**: `.gitlab-ci.yml`
```yaml
stages:
  - test
  - build
  - deploy

test:
  stage: test
  image: node:18
  script:
    - npm ci
    - npm run lint
    - npm test
  only:
    - main
    - merge_requests

build:
  stage: build
  image: node:18
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour
  only:
    - main

deploy:
  stage: deploy
  image: alpine:latest
  before_script:
    - apk add --no-cache curl
  script:
    - curl -X POST $DEPLOY_WEBHOOK_URL
  only:
    - main
```

## Performance Optimization

### 1. Bundle Analysis

**File**: `analyze-bundle.js`
```javascript
import { build } from 'vite'
import { visualizer } from 'rollup-plugin-visualizer'

await build({
  plugins: [
    visualizer({
      filename: 'dist/stats.html',
      open: true,
      gzipSize: true,
      brotliSize: true,
    }),
  ],
})
```

### 2. Performance Monitoring

```typescript
// Performance monitoring utility
export const performanceMonitor = {
  measurePageLoad: () => {
    if (typeof window !== 'undefined') {
      window.addEventListener('load', () => {
        const navigation = performance.getEntriesByType('navigation')[0] as PerformanceNavigationTiming
        console.log('Page Load Time:', navigation.loadEventEnd - navigation.loadEventStart)
      })
    }
  },

  measureApiCall: (name: string, startTime: number) => {
    const duration = performance.now() - startTime
    console.log(`API Call ${name}:`, duration)
  }
}
```

## Security Configuration

### 1. Content Security Policy

**File**: `csp.js`
```javascript
export const csp = {
  'default-src': ["'self'"],
  'script-src': ["'self'", "'unsafe-inline'", "'unsafe-eval'"],
  'style-src': ["'self'", "'unsafe-inline'"],
  'img-src': ["'self'", "data:", "https:"],
  'connect-src': ["'self'", "https://*.supabase.co"],
  'frame-src': ["'none'"],
  'object-src': ["'none'"],
  'base-uri': ["'self'"],
  'form-action': ["'self'"],
}
```

### 2. Security Headers

```typescript
// Security headers configuration
export const securityHeaders = {
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'X-XSS-Protection': '1; mode=block',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'camera=(), microphone=(), geolocation=()',
}
```

## Monitoring and Logging

### 1. Error Tracking

```typescript
// Error boundary with logging
export class ErrorBoundary extends React.Component {
  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Error caught by boundary:', error, errorInfo)
    
    // Send to error tracking service
    if (process.env.NODE_ENV === 'production') {
      // Example: Sentry.captureException(error, { extra: errorInfo })
    }
  }

  render() {
    if (this.state.hasError) {
      return <ErrorFallback />
    }
    return this.props.children
  }
}
```

### 2. Health Checks

```typescript
// Health check endpoint
export const healthCheck = async () => {
  try {
    // Check database connection
    const { error } = await supabase.from('profiles').select('count', { count: 'exact', head: true })
    
    if (error) throw error
    
    return { status: 'healthy', timestamp: new Date().toISOString() }
  } catch (error) {
    return { status: 'unhealthy', error: error.message, timestamp: new Date().toISOString() }
  }
}
```

This deployment configuration provides comprehensive build, deployment, and monitoring setup for the Focus Hub application across various platforms and environments. 