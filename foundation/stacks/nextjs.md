# Next.js

> Modern full-stack framework for React applications.

---

## Overview

| Layer | Technology |
|-------|-----------|
| **Framework** | Next.js 14+ (App Router) |
| **Language** | TypeScript |
| **UI** | React 18+ with Server Components |
| **Backend** | Next.js API Routes + Server Actions |
| **ORM** | Prisma |
| **Database** | PostgreSQL (or Vercel Postgres) |
| **Styling** | TailwindCSS |
| **Components** | shadcn/ui |
| **State** | Zustand or React Context |
| **Data Fetching** | React Query |
| **Unit Tests** | Vitest + Testing Library |
| **E2E Tests** | Playwright |
| **Mocking** | MSW |
| **Deployment** | Vercel (primary), Docker (optional) |

---

## Quick Start

```bash
npm create next-app@latest my-app --typescript --tailwind --app-router
cd my-app
npm install
npm run dev
```

---

## Essential Plugins

- **security-guidance** — mandatory for projects handling user or sensitive data
- **typescript-lsp** — TypeScript language support
- **feature-dev** — architecture and code design
- **frontend-design** — UI/UX assistance

---

## When to Choose This Stack

- SEO-heavy sites (SSR, ISR, SSG out of the box)
- Full-stack TypeScript (one language everywhere)
- Edge/Serverless deployment targets
- Content sites, blogs, marketing pages
- Rapid prototyping with Vercel zero-config deploy
- Teams already in React ecosystem

## When NOT to Choose

- Heavy backend processing (queues, long-running jobs — use Laravel)
- PWA with complex offline needs (use Quasar)
- Non-React teams
- Projects needing fine-grained control over server infrastructure

---

## Project Sizing Guide

| Size | Approach |
|------|----------|
| **Small / MVP** | Single Next.js app, Vercel deploy, no Docker |
| **Medium** | Next.js + separate API routes, Prisma, PostgreSQL |
| **Large** | Next.js frontend + separate backend (Laravel/NestJS), Docker Compose |
