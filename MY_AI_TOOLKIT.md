# MY AI TOOLKIT

> Portable toolkit for AI-assisted development. Share this file with AI assistants to quickly configure them with my preferred tools and workflows.

---

## 🎯 PURPOSE (What This Document Is For)

### This Toolkit Serves Three Purposes:

**1. Self-Reference** 📚
- Reminder of what tools I use and why
- Documentation of my tech stack choices
- Quick reference when starting new projects
- Track what to keep/remove based on actual usage

**2. AI Configuration** 🤖
- Share with ANY AI assistant (Claude, GPT, Cursor, Copilot, etc.)
- Quickly configure AI with my tools, preferences, and workflow
- Provides context without re-explaining every time
- Ensures consistent AI assistance across projects

**3. Team Collaboration** 👥
- Share with team members to explain my development approach
- Onboarding document for my tooling choices
- Reference when discussing architecture and tooling
- Can be forked/modified for others' use

### What This Toolkit Is NOT:

- ❌ NOT an automated installer (I configure tools manually when needed)
- ❌ NOT tied to specific AI platform (works with Claude, GPT, others)
- ❌ NOT a permanent commitment (tools evolve, so does this doc)
- ❌ NOT prescriptive (others should build their own toolkits)

### How I Use This:

**When Starting a New Project:**
```bash
# 1. Copy this file to project
cp MY_AI_TOOLKIT.md ./

# 2. Share with AI assistant
"Check MY_AI_TOOLKIT.md for my tools and preferences.
I'm using [Laravel+Vue OR Next.js] stack.
Help me set up [specific feature/task]."
```

**When Sharing with New AI Assistant:**
```
"Here's my development context:
[Copy the 'LLM-Friendly Quick Reference' section from bottom of document]

My current project uses [Laravel+Vue OR Next.js].
Key files to know: [list key files]
Current task: [what I'm working on]"
```

**Quarterly Review:**
- Remove tools I haven't used in 3 projects
- Add new tools I've adopted
- Update tech stack if it changed
- Note: This document evolves with me

### Philosophy:

**"Simple tools, well-documented, consistently applied."**

I prefer a reference list over automation because:
- ✅ Manual setup helps me understand what I'm using
- ✅ Not locked into specific automation that breaks
- ✅ Easy to adapt to different projects/teams
- ✅ Forces me to be intentional about tool choices
- ✅ Portable across any AI platform or IDE

The goal isn't to automate everything - it's to be **intentional** about what I use.

---

## Quick Context for AI Assistants

If you're an AI assistant helping me, here's what you need to know:

```
My Development Approach:
- I use BMAD Method for project structure and workflow
- I prefer Laravel+Vue OR Next.js for most projects
- Security is critical (always check with security-guidance plugin)
- I value clean architecture over quick hacks
- I test thoroughly (unit + E2E)

My Current Project:
- Stack: Laravel 10 + Vue 3 + Quasar OR Next.js 14
- See "MY TECH STACK" section for full details
- See "My Current Project Stack (CCIP)" for specifics

When suggesting solutions:
1. Consider security implications
2. Follow BMAD workflows for complex features
3. Use TypeScript/Vue 3 best practices
4. Include tests (unit + E2E)
5. Document architectural decisions
```

---

---

## Core Development Methodology

### BMAD Method ⭐ (ESSENTIAL)
**What:** Enterprise-grade agentic development framework
**Use Case:** Complete software development lifecycle - from product brief to deployment
**Tech Stack Agnostic:** Works with Laravel, Next.js, or any stack
**Key Workflows:**
- Product Brief → PRD → Architecture → Epics & Stories → Implementation
- Automated code reviews, retrospectives, sprint planning
- Built-in testing architecture (ATDD, CI/CD)

**Install:**
```bash
npx bmad-method@alpha install
# Or via GitHub: https://github.com/aicodeking/bmad-method
```

**When to Use:**
- Every new project (for structure)
- Complex features requiring planning
- Team collaboration projects
- Projects needing proper testing architecture

**Files Generated:**
- `_bmad/` - All BMAD configuration and workflows
- `_bmad-output/` - Generated artifacts (PRD, architecture, stories, sprint status)
- `.augment/`, `.claude/`, `.cursor/`, `.gemini/`, `.github/` - IDE/Agent integrations

---

## Project Initialization Files

### KINGMODE.md
**What:** Instructions for AI assistants on how to work with me
**Use Case:** Sets expectations, communication style, and workflow preferences
**Install:** Copy from project to project
**Source:** https://github.com/aicodeking/yt-tutorial

**Contains:**
- My communication preferences
- How I like to receive updates
- Code style preferences
- Testing philosophy

---

## Essential Plugins (Claude Code)

### 1. Ralph Wiggum 🧋
**What:** Milk tea coupon easter egg
**Use Case:** Fun, morale booster
**Install:** Via Claude Plugin Manager → Search "ralph-wiggum"
**Link:** https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum
**Priority:** Low (fun)

### 2. Frontend Design
**What:** UI/UX design assistance
**Use Case:** Vue/Quasar or Next.js frontend work
**Install:** Via Claude Plugin Manager → Search "frontend-design"
**Priority:** Medium (frontend projects)

### 3. Feature Dev (Code Architect)
**What:** Architecture and code design patterns
**Use Case:** Designing new features, refactoring, technical decisions
**Install:** Via Claude Plugin Manager → Search "feature-dev"
**Priority:** High (complex features)

### 4. Security Guidance
**What:** Security vulnerability detection and best practices
**Use Case:** Any project handling user data, authentication, payments
**Install:** Via Claude Plugin Manager → Search "security-guidance"
**Priority:** HIGH (public health, sensitive data)

### 5. Code Review
**What:** Automated code review with adversarial approach
**Use Case:** Pre-commit PR reviews, quality gates
**Install:** Via Claude Plugin Manager → Search "code-review"
**Priority:** Medium (BMAD has code-review workflow too)

### 6. GitHub
**What:** GitHub integration (repos, PRs, issues)
**Use Case:** GitHub automation, PR management
**Install:** Via Claude Plugin Manager → Search "github"
**Priority:** Low (MCP GitHub tools are comprehensive)

### 7. Context7
**What:** Up-to-date library documentation
**Use Case:** Looking up docs for any library/package
**Install:** Via Claude Plugin Manager → Search "context7"
**Priority:** Medium (useful, but MCP version available)
**Note:** Consider using MCP version instead (see MCP Servers below)

### 8. PHP LSP
**What:** PHP language server support
**Use Case:** Laravel/PHP projects
**Install:** Via Claude Plugin Manager → Search "php-lsp"
**Priority:** High (Laravel projects)

### 9. TypeScript LSP
**What:** TypeScript language server support
**Use Case:** Vue 3, Next.js, TypeScript projects
**Install:** Via Claude Plugin Manager → Search "typescript-lsp"
**Priority:** High (TypeScript projects)

### 10. Serena (OPTIONAL)
**What:** Semantic code editing with symbol awareness
**Use Case:** Large-scale refactoring, complex codebase navigation
**Install:** Via Claude Plugin Manager → Search "serena"
**Priority:** Low (native LSP + Edit tools cover most needs)
**Decision:** Enable only when doing heavy refactoring

### 11. Playwright (OPTIONAL)
**What:** Browser automation
**Use Case:** E2E testing, web scraping
**Install:** Via Claude Plugin Manager → Search "playwright"
**Priority:** Low (MCP version available)
**Note:** Consider using MCP version instead (see MCP Servers below)

---

## MCP Servers (Model Context Protocol)

### What are MCP Servers?
Standardized protocol for AI tools. More consistent, better maintained than plugins. **Prefer MCP over plugins when both exist.**

### Essential MCP Servers

#### 1. Docker MCP Gateway (MCP_DOCKER)
**What:** Massive collection of 100+ tools via single gateway
**Includes:**
- **GitHub** - repos, PRs, issues, search, Copilot integration
- **NPM** - package search, analysis, alternatives, vulnerabilities
- **Brave Search** - web, news, images, videos, local search
- **n8n** - workflow automation
- **Playwright** - browser automation, E2E testing
- **Context7** - library documentation
- **Hostinger** - VPS, DNS, hosting management
- **Web Fetch** - URL fetching and markdown conversion
- And 90+ more tools

**Install:**
```bash
# Via MCP server marketplace
# Search: "docker-mcp-gateway" or similar
```

**Priority:** CRITICAL (this one server replaces 10+ plugins)

#### 2. GitHub Official (if not using Docker gateway)
**What:** Official GitHub MCP server
**Use Case:** GitHub API integration
**Priority:** Medium (if not in Docker gateway)

#### 3. Filesystem (if needed)
**What:** Secure filesystem access
**Use Case:** When native file tools aren't enough
**Priority:** Low (native tools usually sufficient)

---

## Utility Tools

### Repomix
**What:** Package entire codebase into single LLM-friendly file
**Use Case:** Sharing codebase with AI, code review, documentation
**Install:** `npm install -g repomix`
**Link:** https://github.com/yamadashy/repomix

**Usage:**
```bash
# Create repomix of project
repomix . --output codebase.txt

# Include only specific files
repomix src/ --output src.txt

# Exclude patterns
repomix . --ignore "node_modules,dist,*.log" --output clean.txt
```

**When to Use:**
- Before asking AI to analyze entire codebase
- Creating documentation
- Code review portability
- Sharing project with external AI

---

## MY TECH STACK

### 🎯 My Primary Stack (What I Use 90% of the Time)

#### Option A: Laravel + Vue/Quasar (Enterprise Web Apps)
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

#### Option B: Next.js (Modern Full-Stack)
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

---

## STACK-SPECIFIC TOOL RECOMMENDATIONS

### 🛠️ Currently Installed Plugins for My Stack:

✅ **security-guidance** - INSTALLED
✅ **php-lsp** - INSTALLED
✅ **typescript-lsp** - INSTALLED
✅ **feature-dev** - INSTALLED
✅ **frontend-design** - INSTALLED
✅ **ralph-wiggum** - INSTALLED 🧋

✅ **context7** - INSTALLED (consider MCP version)
✅ **playwright** - INSTALLED (consider MCP version)
✅ **serena** - INSTALLED (optional, for heavy refactoring)
⚠️ **github** - INSTALLED (MCP version available)
⚠️ **code-review** - INSTALLED (BMAD has workflow)

---

## Recommendations for Other Popular Stacks

### 🔥 React + Node.js (Express/Fastify)

**Stack:**
```
Frontend: React + TypeScript + Vite
Backend: Node.js + Express/Fastify + TypeScript
Database: PostgreSQL + Prisma
Auth: JWT or Passport.js
Testing: Jest + Playwright
```

**Essential Tools:**
- ✅ BMAD Method
- ✅ Security Guidance
- ✅ TypeScript LSP
- ✅ Feature Dev
- ✅ Docker MCP Gateway

**Plugins to Add:**
- No additional LSP needed (TypeScript covers it)

**When to Choose This Stack:**
- Maximum flexibility in architecture
- JavaScript throughout the stack
- Large NPM ecosystem needed
- Real-time features (WebSocket support)

---

### ⚛️ React + Node.js (NestJS)

**Stack:**
```
Frontend: React/Next.js + TypeScript
Backend: NestJS + TypeScript
Database: PostgreSQL + TypeORM/Prisma
Auth: NestJS Auth Module
Testing: Jest + Supertest + Playwright
```

**Essential Tools:**
- ✅ BMAD Method
- ✅ Security Guidance
- ✅ TypeScript LSP
- ✅ Feature Dev
- ✅ Docker MCP Gateway

**Plugins to Add:**
- No additional LSP needed

**When to Choose This Stack:**
- Enterprise-grade Node.js backend
- Structured, opinionated architecture
- Dependency injection needed
- Microservices architecture

---

### 🐍 Python + FastAPI/Django

**Stack:**
```
Backend: FastAPI or Django + Python
Frontend: React/Next.js OR Vue
Database: PostgreSQL + SQLAlchemy/Django ORM
Auth: JWT or Django Auth
Testing: Pytest + Playwright
```

**Essential Tools:**
- ✅ BMAD Method
- ✅ Security Guidance
- ✅ Feature Dev
- ✅ Docker MCP Gateway

**Plugins to Add:**
- **pyright-lsp** - Python language support

**When to Choose This Stack:**
- Data science/Machine Learning integration
- Rapid backend development (Django)
- High-performance APIs (FastAPI)
- Strong Python ecosystem needed

---

### 🦀 Rust + Actix/Axum + Yew/Leptos

**Stack:**
```
Backend: Rust + Actix/Axum
Frontend: Yew/Leptos (WASM) OR React/Next.js
Database: PostgreSQL + SQLx
Auth: Custom JWT
Testing: Built-in Rust testing + Playwright
```

**Essential Tools:**
- ✅ BMAD Method
- ✅ Security Guidance
- ✅ Feature Dev
- ✅ Docker MCP Gateway

**Plugins to Add:**
- **rust-analyzer-lsp** - Rust language support

**When to Choose This Stack:**
- Maximum performance required
- Memory safety critical
- WebAssembly needed
- Systems programming

---

### ☕ Java + Spring Boot

**Stack:**
```
Backend: Java 17+ + Spring Boot
Frontend: React/Next.js OR Angular
Database: PostgreSQL + Spring Data JPA
Auth: Spring Security
Testing: JUnit + Playwright
```

**Essential Tools:**
- ✅ BMAD Method
- ✅ Security Guidance
- ✅ Feature Dev
- ✅ Docker MCP Gateway

**Plugins to Add:**
- No Java LSP in official plugins (use IDE integration)

**When to Choose This Stack:**
- Enterprise/corporate environment
- Strong ecosystem needed
- Microservices (Spring Cloud)
- Existing Java team

---

### 💎 Ruby + Rails

**Stack:**
```
Backend: Ruby on Rails 7+
Frontend: Hotwire/Stimulus OR React/Next.js
Database: PostgreSQL
Auth: Devise
Testing: RSpec + Playwright
```

**Essential Tools:**
- ✅ BMAD Method
- ✅ Security Guidance
- ✅ Feature Dev
- ✅ Docker MCP Gateway

**Plugins to Add:**
- No Ruby LSP in official plugins

**When to Choose This Stack:**
- Rapid prototyping/MVP
- Convention over configuration
- Small team, fast iteration
- Startup environment

---

### 📱 Flutter/Dart (Mobile)

**Stack:**
```
Framework: Flutter (Dart)
Backend: Any (Node.js, Python, Go, etc.)
Database: SQLite + API integration
State: Riverpod or Bloc
Testing: Flutter test + integration tests
```

**Essential Tools:**
- ✅ BMAD Method
- ✅ Security Guidance
- ✅ Feature Dev
- ✅ Docker MCP Gateway

**Plugins to Add:**
- No Dart LSP in official plugins

**When to Choose This Stack:**
- Mobile apps (iOS + Android)
- High-performance mobile UI
- Single codebase for mobile
- Google ecosystem

---

### 🎮 Game Development (Godot/Unity)

**Stack:**
```
Engine: Godot (GDScript) OR Unity (C#)
Networking: WebSockets, Photon, etc.
Backend: Node.js/Go/Game server
Database: PostgreSQL/Redis
```

**Essential Tools:**
- ✅ BMAD Method (modified for game dev)
- ✅ Feature Dev
- ✅ Docker MCP Gateway

**Plugins to Add:**
- **csharp-lsp** - For Unity C#
- No GDScript LSP available

**When to Choose This Stack:**
- Game development
- Interactive applications
- Real-time multiplayer
- Visual-heavy applications

---

## Stack Selection Guide

### Quick Decision Tree

```
Need maximum performance?
├── Yes → Rust + Actix/Axum
└── No

Need enterprise/corporate support?
├── Yes → Java + Spring Boot
└── No

Building mobile app?
├── Yes → Flutter
└── No

Have Python team/data needs?
├── Yes → Python + FastAPI/Django
└── No

Need rapid MVP development?
├── Yes → Ruby on Rails
└── No

JavaScript/TypeScript preferred?
├── Yes → Next.js OR React + Node.js (NestJS)
└── No

PHP team/experience?
├── Yes → Laravel + Vue/Quasar
└── No → Start from scratch with Next.js
```

---

## My Current Project Stack (CCIP)

### Crisis Communication Intelligence Platform

```
Type: Public Health Crisis Management
Target: Low-bandwidth environments, African health contexts

Stack:
├── Backend: Laravel 10 + PostgreSQL + Redis
├── Frontend: Vue 3 + Quasar PWA
├── Storage: MinIO (S3-compatible)
├── Testing: PHPUnit + Vitest + Playwright
├── Deployment: Docker + Dokploy
└── Special: Offline-first, low-bandwidth optimization

Key Plugins Installed:
├── ✅ BMAD Method (framework)
├── ✅ Security Guidance (health data = critical)
├── ✅ PHP LSP (Laravel backend)
├── ✅ TypeScript LSP (Vue 3 frontend)
├── ✅ Feature Dev (architecture)
├── ✅ Frontend Design (Quasar UI)
├── ✅ Ralph Wiggum (fun!)
├── ✅ Docker MCP Gateway (100+ tools)
└── ⚠️ Context7/Playwright/Serena (evaluating)
```

---

## Quick Start by Stack

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

# Plugins to Install:
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

# Plugins to Install:
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

# Plugins to Install:
# - security-guidance (HIGH PRIORITY)
# - pyright-lsp (if available)
# - feature-dev
```

---

## Tool Selection by Project Type

### Laravel + Vue/Quasar Project (Like CCIP)
**Essential:**
- BMAD Method
- Security Guidance ✅ INSTALLED
- PHP LSP ✅ INSTALLED
- TypeScript LSP ✅ INSTALLED
- Feature Dev ✅ INSTALLED
- Context7 (MCP version)
- Docker MCP Gateway

**Nice to Have:**
- Frontend Design ✅ INSTALLED
- Code Review

### Next.js Project
**Essential:**
- BMAD Method
- Security Guidance ✅ INSTALLED
- TypeScript LSP ✅ INSTALLED
- Feature Dev ✅ INSTALLED
- Context7 (MCP version)
- Docker MCP Gateway

**Nice to Have:**
- Frontend Design ✅ INSTALLED
- Code Review

### Simple Project/Prototype
**Essential:**
- BMAD Method (lite usage)
- Docker MCP Gateway

**Optional:**
- Any LSP for your language
- Security Guidance (if handling data)

---

## Quick Start Checklist

For any new project, run through this:

```bash
# 1. Initialize BMAD
npx bmad-method@alpha install

# 2. Copy KINGMODE.md (if you have one)
cp /path/to/KINGMODE.md .

# 3. Install essential plugins (via Claude Plugin Manager)
# - ralph-wiggum (fun)
# - security-guidance (critical)
# - [language]-lsp for your stack
# - feature-dev

# 4. Configure MCP servers
# - Add Docker MCP Gateway (covers 90% of needs)

# 5. Create initial repomix (optional)
repomix . --output initial-state.txt
```

---

## Philosophy

### Tool Selection Criteria
I use a tool if it meets **ALL** of:
1. **Essential** - Can't work without it OR massive time savings
2. **Well-maintained** - Active development, regular updates
3. **Standardized** - Uses standard protocols (MCP over custom plugins)
4. **Stack-agnostic** - Works across my typical projects

### Red Flags
- ❌ Overlapping functionality (keep the best one)
- ❌ Abandoned projects
- ❌ Custom protocols when standard exists
- ❌ Narrow use case unless critical

### Tool Bloat Prevention
**Rule:** If I haven't used a tool in 3 projects, remove it from toolkit.
**Exception:** Security tools, rare but critical needs

---

## LLM-Friendly Quick Reference

For AI assistants, here's the TL;DR:

```
My Essential Toolkit:
1. BMAD Method - Development framework (npx bmad-method@alpha install)
2. Docker MCP Gateway - 100+ tools in one server
3. Security Guidance Plugin - Always enabled
4. [Language]-LSP - PHP for Laravel, TS for Next.js/Vue
5. Feature Dev Plugin - Architecture help
6. Ralph Wiggum - Morale 🧋

My Stack: Laravel+Vue OR Next.js
My Philosophy: Essential, maintained, standardized, stack-agnostic

When I start a project: BMAD init → KingMode → Essential plugins → MCP gateway
```

---

## Version History

- **2025-12-28 v2** - Added security-guidance, php-lsp, typescript-lsp
  - Documented MY TECH STACK in detail (Laravel+Vue OR Next.js)
  - Added recommendations for 8+ popular tech stacks
  - Added stack selection decision tree
  - Added quick start guides by stack
  - Marked currently installed plugins with ✅

- **2025-12-28 v1** - Initial version, consolidated from CCIP project setup
- Focus on essentials only, remove bloat quarterly
- Prefer MCP servers over plugins
- Stack: Laravel/Vue OR Next.js

---

## Contributing

This is my personal toolkit. Fork it for your own use, but remember:
- Start lean, add only what you actually use
- Remove tools you haven't touched in 3 projects
- Prefer standards over custom solutions
- Document WHY, not just WHAT
