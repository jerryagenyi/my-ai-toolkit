# Laravel + Vue/Quasar

> Primary stack for enterprise web applications.

---

## Overview

| Layer | Technology |
|-------|-----------|
| **Backend** | Laravel 10+ (PHP Framework) |
| **Database** | PostgreSQL |
| **Cache & Queues** | Redis |
| **Storage** | MinIO (S3-compatible) |
| **Auth** | Laravel Sanctum (API) |
| **Frontend** | Vue 3 (Composition API) |
| **UI Framework** | Quasar (PWA, UI Components) |
| **Language** | TypeScript |
| **State** | Pinia |
| **Build** | Vite |
| **Backend Tests** | PHPUnit / Pest |
| **Frontend Tests** | Vitest (unit), Playwright (E2E) |
| **DevOps** | Docker Compose, Dokploy, GitHub Actions |

---

## Quick Start

```bash
# Backend
composer create-project laravel/laravel backend
cd backend
cp .env.example .env
php artisan key:generate
php artisan migrate

# Frontend
npm create quasar@latest frontend
cd frontend
npm install
```

---

## Essential Plugins

- **security-guidance** — mandatory for any project handling user or sensitive data
- **php-lsp** — PHP/Laravel language support
- **typescript-lsp** — TypeScript support for Vue frontend
- **feature-dev** — architecture and code design
- **frontend-design** — Quasar UI/UX assistance

---

## When to Choose This Stack

- Enterprise or data-heavy web applications
- Projects needing robust backend (queues, events, jobs)
- API-first architecture with SPA frontend
- PWA requirements (offline, push notifications)
- Teams with PHP experience

## When NOT to Choose

- Pure static sites or blogs (use Next.js SSG)
- Heavy real-time / WebSocket needs (consider Node.js)
- Mobile-only apps (use Flutter)
- When you need server components / edge rendering

---

## Reference Project: CCIP

**Crisis Communication Intelligence Platform** — a real-world example of this stack in production:

- **Type:** Public Health Crisis Management
- **Target:** Low-bandwidth environments, African health contexts
- **Specialties:** Offline-first, low-bandwidth optimization, PWA
- **Stack:** Laravel 10 + PostgreSQL + Redis + Vue 3 + Quasar PWA + MinIO
- **Deployment:** Docker Compose + Dokploy
- **Testing:** PHPUnit + Vitest + Playwright
