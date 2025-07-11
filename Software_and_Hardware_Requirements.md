# Focus Hub – Software and Hardware Requirements

## 1. Software Requirements

### 1.1. Operating System
| Environment           | Supported OS Versions                |
|----------------------|--------------------------------------|
| Development          | Ubuntu 20.04+, macOS Monterey+, Windows 10+ |
| Production/Deployment| Any OS supporting Node.js & Docker (Linux recommended) |

### 1.2. Runtime & Languages
| Component    | Version/Details         |
|-------------|------------------------|
| Node.js     | v18.x or higher        |
| npm         | v9.x or higher         |
| TypeScript  | v5.5.x                 |
| PostgreSQL  | Managed by Supabase (local install only if self-hosting) |

### 1.3. Frameworks & Libraries
| Layer     | Library/Tool                | Version/Details         |
|-----------|----------------------------|------------------------|
| Frontend  | React                      | 18.3.1                 |
|           | Vite                       | 5.4.1                  |
|           | React Router DOM           | 6.26.2                 |
|           | shadcn/ui (Radix UI-based) | -                      |
|           | Tailwind CSS               | 3.4.11                 |
|           | Framer Motion              | -                      |
|           | Lucide React               | -                      |
|           | Next Themes                | -                      |
|           | TanStack React Query       | 5.56.2                 |
|           | React Hook Form + Zod      | 7.53.0 + latest        |
| Backend   | Supabase                   | BaaS (auth, DB, storage, real-time) |
|           | PostgreSQL                 | Managed by Supabase    |
| Other     | ESLint                     | 9.9.0                  |
|           | PostCSS, Autoprefixer      | -                      |
|           | Lovable Tagger             | -                      |
|           | Docker                     | Optional, for containers |
|           | Git                        | Version control        |

### 1.4. Browser Support
| Browser         | Supported Versions         |
|----------------|---------------------------|
| Chrome         | Latest (desktop & mobile)  |
| Firefox        | Latest (desktop & mobile)  |
| Edge           | Latest                     |
| Safari         | Latest (desktop & mobile)  |

### 1.5. Cloud Services
| Service         | Purpose                                    |
|----------------|--------------------------------------------|
| Supabase       | Auth, database, file storage, real-time     |
| Lovable        | Deployment and hosting (or compatible cloud)|

---

## 2. Hardware Requirements

### 2.1. Development Machine (Minimum)
| Component   | Minimum Requirement         | Recommended         |
|-------------|----------------------------|---------------------|
| CPU         | Dual-core 2.0 GHz          | Quad-core 2.5 GHz   |
| RAM         | 4 GB                       | 8 GB                |
| Storage     | 2 GB free disk space        | 10 GB+              |
| Display     | 1366x768 resolution         | 1920x1080+          |
| Network     | Broadband internet          | Broadband           |

### 2.2. Production Server (if self-hosting)
| Component   | Minimum Requirement         |
|-------------|----------------------------|
| CPU         | Quad-core 2.0 GHz           |
| RAM         | 8 GB                        |
| Storage     | 20 GB SSD                   |
| Network     | Reliable broadband, low latency |
| OS          | Ubuntu 20.04+ or equivalent |
| Docker      | Optional, for containers    |

### 2.3. Client Devices (End Users)
| Device Type     | Minimum Requirement                        |
|-----------------|--------------------------------------------|
| Desktop/Laptop  | Modern device, current web browser         |
| Mobile          | Android 8.0+ or iOS 13+ with Chrome/Safari/Firefox |

---

## 3. Additional Recommendations

| Area                | Recommendation                                             |
|---------------------|-----------------------------------------------------------|
| Developer Tools     | VS Code or WebStorm with TypeScript & ESLint plugins      |
| Production          | Use CDN for static assets, enable HTTPS, monitor health   |
| Scaling             | Use Supabase scaling or cloud VM/container with load balancing |

---

*Document generated for Focus Hub project. Last updated: July 2024.* 