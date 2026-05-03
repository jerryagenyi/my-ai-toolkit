# Secondary Stacks

> Stacks beyond the primary Laravel+Vue and Next.js options. For Python, see `python-fastapi.md` (to be created).

---

## React + Node.js (Express/Fastify)

```
Frontend: React + TypeScript + Vite
Backend: Node.js + Express/Fastify + TypeScript
Database: PostgreSQL + Prisma
Auth: JWT or Passport.js
Testing: Jest + Playwright
```

**Essential tools:** BMAD Method, Security Guidance, TypeScript LSP, Feature Dev, Docker MCP Gateway

**When to choose:** Maximum architecture flexibility, JavaScript throughout the stack, large NPM ecosystem, real-time features (WebSocket).

---

## React + Node.js (NestJS)

```
Frontend: React/Next.js + TypeScript
Backend: NestJS + TypeScript
Database: PostgreSQL + TypeORM/Prisma
Auth: NestJS Auth Module
Testing: Jest + Supertest + Playwright
```

**Essential tools:** BMAD Method, Security Guidance, TypeScript LSP, Feature Dev, Docker MCP Gateway

**When to choose:** Enterprise-grade Node.js backend, structured opinionated architecture, dependency injection, microservices architecture.

---

## Rust + Actix/Axum + Yew/Leptos

```
Backend: Rust + Actix/Axum
Frontend: Yew/Leptos (WASM) OR React/Next.js
Database: PostgreSQL + SQLx
Auth: Custom JWT
Testing: Built-in Rust testing + Playwright
```

**Essential tools:** BMAD Method, Security Guidance, Feature Dev, Docker MCP Gateway

**Plugins:** rust-analyzer-lsp

**When to choose:** Maximum performance required, memory safety critical, WebAssembly targets, systems-level programming.

---

## Java + Spring Boot

```
Backend: Java 17+ + Spring Boot
Frontend: React/Next.js OR Angular
Database: PostgreSQL + Spring Data JPA
Auth: Spring Security
Testing: JUnit + Playwright
```

**Essential tools:** BMAD Method, Security Guidance, Feature Dev, Docker MCP Gateway

**When to choose:** Enterprise/corporate environments, strong ecosystem needed, microservices via Spring Cloud, existing Java team.

---

## Ruby on Rails

```
Backend: Ruby on Rails 7+
Frontend: Hotwire/Stimulus OR React/Next.js
Database: PostgreSQL
Auth: Devise
Testing: RSpec + Playwright
```

**Essential tools:** BMAD Method, Security Guidance, Feature Dev, Docker MCP Gateway

**When to choose:** Rapid prototyping/MVP, convention over configuration, small team fast iteration, startup environment.

---

## Flutter/Dart (Mobile)

```
Framework: Flutter (Dart)
Backend: Any (Node.js, Python, Go, etc.)
Database: SQLite + API integration
State: Riverpod or Bloc
Testing: Flutter test + integration tests
```

**Essential tools:** BMAD Method, Security Guidance, Feature Dev, Docker MCP Gateway

**When to choose:** Mobile apps targeting iOS + Android, high-performance mobile UI, single codebase for mobile, Google ecosystem.

---

## Game Development (Godot/Unity)

```
Engine: Godot (GDScript) OR Unity (C#)
Networking: WebSockets, Photon, etc.
Backend: Node.js/Go/Game server
Database: PostgreSQL/Redis
```

**Essential tools:** BMAD Method (modified for game dev), Feature Dev, Docker MCP Gateway

**Plugins:** csharp-lsp (for Unity C#). No GDScript LSP available.

**When to choose:** Game development, interactive applications, real-time multiplayer, visual-heavy applications.
