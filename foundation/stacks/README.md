# Stack Selection Guide

> Preferred technology stacks by project type, with tool recommendations and quick-start commands.

---

## Stack Decision Tree

```
Need maximum performance?
├── Yes → Rust + Actix/Axum (see other-stacks.md)
└── No
    Need enterprise/corporate support?
    ├── Yes → Java + Spring Boot (see other-stacks.md)
    └── No
        Building mobile app?
        ├── Yes → Flutter/Dart (see other-stacks.md)
        └── No
            Have Python team/data needs?
            ├── Yes → Python + FastAPI/Django (→ python-fastapi.md)
            └── No
                Need rapid MVP development?
                ├── Yes → Ruby on Rails (see other-stacks.md)
                └── No
                    JavaScript/TypeScript preferred?
                    ├── Yes → Next.js OR React + NestJS
                    └── No
                        PHP team/experience?
                        ├── Yes → Laravel + Vue/Quasar
                        └── No → Start from scratch with Next.js
```

---

## Primary Stacks

### Option A: Laravel + Vue/Quasar — Enterprise Web Apps

```
Backend:
├── Laravel 10+ (PHP Framework)
├── PostgreSQL (Database)
├── Redis (Cache & Queues)
├── MinIO (S3-compatible storage)
└── Laravel Sanctum (API Auth)

Frontend:
├── Vue 3 (Composition API)
├── Quasar Framework (PWA, UI Components)
├── TypeScript
├── Pinia (State Management)
└── Vite (Build Tool)

Testing:
├── PHPUnit (Backend)
├── Vitest (Frontend Unit)
├── Playwright (E2E)
└── Pest (Alternative PHP Testing)

DevOps:
├── Docker Compose
├── Dokploy (Deployment)
└── GitHub Actions (CI/CD)
```

**Best for:** Enterprise web apps, admin dashboards, multi-tenant SaaS, projects needing a mature ORM and job queues.

**Essential tools:** BMAD Method, Security Guidance, PHP LSP, TypeScript LSP, Feature Dev, Context7 (MCP), Docker MCP Gateway

**Nice to have:** Frontend Design, Code Review

### Option B: Next.js — Modern Full-Stack

```
Framework:
├── Next.js 14+ (App Router)
├── TypeScript
├── React 18+
└── Server Components

Backend:
├── Next.js API Routes
├── Server Actions
├── Prisma ORM
└── PostgreSQL (or Vercel Postgres)

Frontend:
├── TailwindCSS
├── shadcn/ui (Components)
├── Zustand or React Context (State)
└── React Query (Data Fetching)

Testing:
├── Vitest
├── Playwright
├── Testing Library
└── MSW (Mocking)

DevOps:
├── Vercel (Deployment)
└── Docker (optional)
```

**Best for:** Marketing sites, content platforms, full-stack apps with SSR/SSG needs, projects wanting maximum JS/TS unification.

**Essential tools:** BMAD Method, Security Guidance, TypeScript LSP, Feature Dev, Context7 (MCP), Docker MCP Gateway

**Nice to have:** Frontend Design, Code Review

---

## Other Supported Stacks

Brief summaries below. Full details in their respective files.

| Stack | File | Best For |
|-------|------|----------|
| React + Node.js (Express/Fastify) | `other-stacks.md` | Maximum flexibility, real-time features, large NPM ecosystem |
| React + Node.js (NestJS) | `other-stacks.md` | Enterprise-grade Node.js, DI, microservices |
| Python + FastAPI/Django | `python-fastapi.md` | Data science/ML, rapid backend, high-performance APIs |
| Rust + Actix/Axum | `other-stacks.md` | Maximum performance, memory safety, WASM |
| Java + Spring Boot | `other-stacks.md` | Enterprise/corporate, Spring Cloud microservices |
| Ruby on Rails | `other-stacks.md` | Rapid MVP, convention over configuration, startups |
| Flutter/Dart | `other-stacks.md` | Mobile (iOS + Android), single codebase |
| Game Dev (Godot/Unity) | `other-stacks.md` | Games, interactive apps, real-time multiplayer |

---

## Tool Selection by Project Type

### Laravel + Vue/Quasar Project

| Priority | Tool |
|----------|------|
| Essential | BMAD Method |
| Essential | Security Guidance |
| Essential | PHP LSP |
| Essential | TypeScript LSP |
| Essential | Feature Dev |
| Essential | Context7 (MCP) |
| Essential | Docker MCP Gateway |
| Nice to have | Frontend Design |
| Nice to have | Code Review |

### Next.js Project

| Priority | Tool |
|----------|------|
| Essential | BMAD Method |
| Essential | Security Guidance |
| Essential | TypeScript LSP |
| Essential | Feature Dev |
| Essential | Context7 (MCP) |
| Essential | Docker MCP Gateway |
| Nice to have | Frontend Design |
| Nice to have | Code Review |

### Simple Project / Prototype

| Priority | Tool |
|----------|------|
| Essential | BMAD Method (lite usage) |
| Essential | Docker MCP Gateway |
| Optional | Language LSP for your stack |
| Optional | Security Guidance (if handling user data) |

---

## Quick Start Commands

### Laravel + Vue/Quasar

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

# Plugins to install (via Claude Plugin Manager):
# - security-guidance (HIGH PRIORITY)
# - php-lsp
# - typescript-lsp
# - feature-dev
# - frontend-design
```

### Next.js

```bash
# Create
npm create next-app@latest my-app --typescript --tailwind --app-router

# Plugins to install (via Claude Plugin Manager):
# - security-guidance (HIGH PRIORITY)
# - typescript-lsp
# - feature-dev
# - frontend-design
```

### Python + FastAPI

```bash
# Backend
pip install fastapi uvicorn sqlalchemy psycopg2-binary
mkdir myapp && cd myapp

# Plugins to install (via Claude Plugin Manager):
# - security-guidance (HIGH PRIORITY)
# - pyright-lsp (if available)
# - feature-dev
```
