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

## Index of Integrated Tools

| Tool | Summary | How we use it in this toolkit | GitHub / link |
|------|---------|-------------------------------|---------------|
| **BMAD Method** | Enterprise agentic development framework (product brief → PRD → architecture → epics & stories → implementation). | Core development methodology; we run `npx bmad-method@alpha install` for new projects and use its workflows for planning, code review, and testing. | https://github.com/aicodeking/bmad-method |
| **KINGMODE.md** | Instructions for AI assistants on communication style, updates, and code preferences. | Project init: we copy from yt-tutorial as a project-level AI guidance file. | https://github.com/aicodeking/yt-tutorial |
| **Claude Skills (Reflect)** | Self-improving memory: analyses sessions, extracts corrections/patterns, updates skill files. | We ship `.claude/skills/` (reflect, ui-conventions, code-style, api-design, security-practices) and use `/reflect` so the AI learns our preferences over time. | Part of Claude Code; skills live in this repo’s `.claude/skills/`. |
| **Ralph Wiggum** | Milk tea coupon easter egg plugin. | Optional fun/morale plugin in Claude Code. | https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum |
| **Security Guidance** | Security vulnerability detection and best practices (incl. Docker). | Mandatory for projects with user/sensitive data; we enforce Docker security policies and checklists from this toolkit. | Claude Code plugin (search "security-guidance"). |
| **Trivy** | Security scanner for containers, images, and configs (CVEs, misconfigurations). | Required for Docker projects: image and docker-compose scanning, CI/CD integration, severity filters. | https://github.com/aquasecurity/trivy |
| **Docker Scout** | Built-in Docker security scanning (Docker Desktop 4.25+). | Alternative to Trivy for quick local scans and image comparison when using Docker Desktop. | https://docs.docker.com/scout/ |
| **Repomix** | Packages a codebase into a single LLM-friendly file. | We use it to share project context with AI (e.g. `repomix . --output codebase.txt`) before reviews or deep analysis. | https://github.com/yamadashy/repomix |
| **JustBash** | TypeScript implementation of Bash with an in-memory (or overlay) filesystem; safe, sandboxed bash for AI agents. | Optional: when building features that need script-like execution for AI agents without giving real shell/containers; zero infra, sandboxed by default. | https://github.com/vercel-labs/just-bash |
| **Docker MCP Gateway** | Single MCP server exposing 100+ tools (GitHub, NPM, Brave Search, Playwright, Context7, etc.). | Primary MCP: we prefer it over many separate plugins for GitHub, search, browser automation, and docs. | Via MCP server marketplace (search "docker-mcp-gateway"). |
| **Feature Dev / Frontend Design / LSPs** | Architecture, UI/UX, and language server plugins for Claude Code. | We install by stack: feature-dev + frontend-design + php-lsp or typescript-lsp as essential; code-review, context7, playwright as optional. | Claude Code Plugin Manager. |

---

## Claude Skills (Self-Improving Memory)

### What Are Claude Skills?

Claude Skills are a feature in Claude Code that creates **self-improving memory**. They analyze sessions, extract corrections/patterns, and automatically update skill files - creating a system that learns from you over time.

**The Problem They Solve:**
LLMs don't learn between sessions. You correct the same mistakes repeatedly. Every conversation starts from zero.

**The Solution:**
Skills analyze sessions, extract learnings, update themselves, and commit to Git. You correct once, it remembers forever.

### How It Works

```
Session → Corrections/Paterns → Reflect Skill → Update Skills → Git Commit
                     ↑                                            ↓
                     └────────────── Learned Forever ←───────────┘
```

### Three Ways to Use

**1. Manual Reflection** (Recommended to Start)
```bash
# After a session with corrections:
/reflect

# Specify which skill to update:
/reflect ui-conventions
```

**2. Automatic Reflection** (For Advanced Users)
Set up hooks to trigger reflection at session end:
```json
// .claude/hooks.json
{
  "hooks": {
    "stop-hook": "bash scripts/reflect-auto.sh"
  }
}
```

**3. Toggle On/Off**
```bash
/reflect on    # Enable auto-reflection
/reflect off   # Disable auto-reflection
/reflect status  # Check if enabled
```

### What Gets Learned

| Signal Type | Example | Confidence | Stored As |
|-------------|---------|------------|-----------|
| **Correction** | "Never use alert()" | HIGH | Rule: Never do X |
| **Approval** | "That Quasar pattern worked well" | MEDIUM | Pattern: Use this approach |
| **Observation** | "Seems to prefer composition API" | LOW | Note: Review later |

### Project Skills Structure

```
.claude/
├── skills/
│   ├── reflect.md           # The meta-skill that learns
│   ├── ui-conventions.md    # UI/UX patterns learned
│   ├── code-style.md        # Coding style preferences
│   ├── api-design.md        # API design patterns
│   └── security-practices.md # Security learnings
└── hooks.json               # Auto-reflection triggers
```

### Example Learning Session

```
You: Create a submit button
Claude: [Creates button with inline alert()]

You: Don't use alert(). Use Quasar's $q.notify instead.
Claude: [Fixes to use $q.notify]

---

Later: /reflect

Signals Detected:
✓ HIGH: Never use alert() in this project
✓ MEDIUM: Use Quasar's $q.notify for notifications

Proposed Changes:
→ Update ui-conventions.md
→ Add alert() prohibition rule
→ Add Quasar Notify pattern

Commit: feat: learn to use Quasar Notify instead of alert()

[Y] Accept | [n] Reject | [e] Edit
```

### Setting Up in Your Project

**Step 1: Copy Skills to Your Project**
```bash
# Copy the skills directory from this toolkit
cp -r .claude/skills /path/to/your-project/.claude/
```

**Step 2: Customize Skills for Your Project**
```bash
# Edit skills to match your preferences
code .claude/skills/ui-conventions.md
code .claude/skills/code-style.md
```

**Step 3: Start Using Reflect**
```bash
# In Claude Code, after a session:
/reflect
```

### Skill Files Explained

**reflect.md** - The learning engine. Analyzes sessions and updates other skills.

**ui-conventions.md** - UI/UX patterns:
- Component preferences (Quasar vs custom)
- Notification patterns (never alert(), always $q.notify)
- Layout conventions
- Styling guidelines

**code-style.md** - Coding conventions:
- TypeScript/JavaScript patterns
- PHP/Laravel conventions
- Naming conventions
- Async/await preferences

**api-design.md** - API patterns:
- RESTful conventions
- Response formats
- Error handling
- Pagination patterns

### Best Practices

**1. Be Explicit in Corrections**
- ❌ "Not that way"
- ✅ "Never use alert(), always use $q.notify"

**2. Use Consistent Language**
- "Always do X" → HIGH confidence rule
- "I prefer Y" → MEDIUM confidence pattern
- User seems to like Z → LOW confidence observation

**3. Review Before Accepting**
- Always check the proposed changes
- You can edit with natural language
- Git commits create history you can revert

**4. Start Manual, Then Auto**
- Use `/reflect` manually first
- Build confidence in the system
- Enable auto-reflection when comfortable

**5. Version Your Skills**
- Keep skills in Git
- See how your system learns over time
- Rollback if needed: `git revert HEAD`

### What Makes This Different

| Traditional LLM Memory | Claude Skills |
|------------------------|---------------|
| Black box embeddings | Plain markdown files |
| Can't inspect what's stored | Human-readable skills |
| No version control | Full Git history |
| Complex infrastructure | Simple files |
| Vague associations | Explicit rules/patterns |

### Integration with This Toolkit

**BMAD Method:**
- Skills learn your epic/story preferences
- Remembers your sprint planning patterns
- Adapts to your architecture decisions

**Security Guidance:**
- Learns from your security reviews
- Remembers Docker security preferences
- Adapts to your vulnerability handling

**Stack Choices:**
- Remembers when you choose Laravel+Vue vs Next.js
- Learns your testing tool preferences
- Tracks your deployment patterns

### Quick Reference for AI Assistants

```
When working with me, check:
1. .claude/skills/reflect.md - How I learn
2. .claude/skills/ui-conventions.md - UI patterns
3. .claude/skills/code-style.md - Code style
4. .claude/skills/api-design.md - API patterns

If I correct you, that's a learning signal.
Note the correction for future sessions.
```

### Resources

- **Video:** [Self-Improving Skills in Claude Code](https://youtu.be/-4nUCaMNBR8) by Developers Digest
- **Example Skills:** See `.claude/skills/` directory in this toolkit
- **Hooks Example:** See `.claude/hooks.json.example`

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

**Docker Security Policies (MANDATORY):**
All Docker Compose files and Dockerfiles MUST follow these security requirements:

1. **Non-Root Users:**
   - All containers MUST run as non-root users
   - Add `USER` directive in Dockerfiles
   - Add `user:` specification in docker-compose.yml
   - Exception: Apache/nginx may need root for port 80, but must drop privileges

2. **Security Options:**
   - ALL services MUST include: `security_opt: - no-new-privileges:true`
   - Prevents privilege escalation attacks

3. **Secrets Management:**
   - NEVER hardcode secrets in docker-compose.yml or Dockerfiles
   - Use environment variables: `${SECRET_NAME}`
   - Use Docker secrets for production
   - Add `.env` files to `.gitignore`

4. **Docker Socket Mounts:**
   - NEVER mount `/var/run/docker.sock` without read-only flag
   - If write access required (e.g., Watchtower), add security warnings
   - Consider Docker-in-Docker (DinD) or rootless Docker for better isolation

5. **Resource Limits:**
   - Add resource limits to prevent DoS:
     ```yaml
     deploy:
       resources:
         limits:
           cpus: '2'
           memory: 1G
     ```

6. **File Permissions:**
   - Use `755` or `750`, NEVER `777` (world-write access)
   - Set proper ownership in Dockerfiles

7. **Base Images:**
   - Prefer minimal images (alpine, distroless)
   - Pin to specific tags, avoid `:latest`
   - Regularly scan for CVEs (Trivy, Docker Scout)

8. **Network Security:**
   - Use bridge networks, avoid host network mode
   - Only expose necessary ports
   - Use health checks for service dependencies

9. **Security Scanning (MANDATORY):**
   - Scan images before deployment using Trivy or Docker Scout
   - Integrate scanning into CI/CD pipeline
   - Set up weekly automated scans
   - Fix HIGH and CRITICAL vulnerabilities immediately
   - Document MEDIUM and LOW vulnerabilities for review

**Security Checklist for Every Docker Project:**
- [ ] All containers run as non-root
- [ ] `security_opt: - no-new-privileges:true` on all services
- [ ] No hardcoded secrets
- [ ] Docker socket mounts are read-only (if needed)
- [ ] Resource limits defined
- [ ] File permissions are secure (755/750, not 777)
- [ ] Minimal base images used
- [ ] Images pinned to specific tags
- [ ] Health checks configured
- [ ] Security scanning integrated (Trivy/Docker Scout)
- [ ] CI/CD pipeline includes vulnerability scanning

**Security Scanning Tools:**

1. **Trivy (Recommended):**
   ```bash
   # Install
   brew install trivy  # macOS
   # or download from: https://github.com/aquasecurity/trivy/releases
   
   # Scan image
   trivy image <image-name>
   
   # Scan with severity filter
   trivy image --severity HIGH,CRITICAL <image-name>
   
   # Scan docker-compose files
   trivy config docker-compose.yml
   ```

2. **Docker Scout:**
   ```bash
   # Enable (Docker Desktop 4.25+)
   docker scout quickview
   
   # Scan image
   docker scout cves <image-name>
   
   # Compare images
   docker scout compare <old-image> <new-image>
   ```

3. **CI/CD Integration:**
   - Add Trivy to GitHub Actions (see example workflow)
   - Set up weekly scheduled scans
   - Block deployments on CRITICAL vulnerabilities
   - Upload scan results to GitHub Security tab

**Security Scanning Workflow:**
```yaml
# .github/workflows/security-scan.yml
name: Docker Security Scan
on:
  push:
    paths: ['docker-compose*.yml', '**/Dockerfile*']
  schedule:
    - cron: '0 0 * * 0'  # Weekly

jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'image'
          scan-ref: 'your-image:latest'
          severity: 'CRITICAL,HIGH'
          exit-code: '1'
```

**Regular Security Maintenance:**
- Weekly: Automated vulnerability scans
- Monthly: Review and update base images
- Quarterly: Rotate secrets and credentials
- Annually: Full security audit and penetration testing

**Security Scanning Checklist:**
- [ ] Trivy or Docker Scout installed
- [ ] Security scanning script created (`scripts/security-scan.sh`)
- [ ] CI/CD pipeline includes security scanning
- [ ] Weekly automated scans configured
- [ ] Pre-deployment security checks in place
- [ ] Vulnerability tracking system (GitHub Issues/Projects)
- [ ] Remediation process documented
- [ ] Team trained on security scanning workflow

**Quick Security Commands:**
```bash
# Install Trivy
brew install trivy  # macOS

# Scan all images
trivy image $(docker-compose config --images)

# Scan with severity filter
trivy image --severity HIGH,CRITICAL <image>

# Scan docker-compose config
trivy config docker-compose.yml

# Generate HTML report
trivy image --format template --template "@contrib/html.tpl" --output report.html <image>
```

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

## Security Tools

### Trivy (CRITICAL for Docker Projects)
**What:** Comprehensive security scanner for containers, images, and configs
**Use Case:** Scan Docker images for CVEs, check docker-compose security
**Install:** 
```bash
brew install trivy  # macOS
# Or download from: https://github.com/aquasecurity/trivy/releases
```
**Link:** https://aquasecurity.github.io/trivy/

**Usage:**
```bash
# Scan image
trivy image <image-name>

# Scan with severity filter
trivy image --severity HIGH,CRITICAL <image>

# Scan docker-compose
trivy config docker-compose.yml

# Generate report
trivy image --format template --template "@contrib/html.tpl" --output report.html <image>
```

**Priority:** CRITICAL (all Docker projects must use this)

### Docker Scout (Alternative)
**What:** Built-in Docker security scanning (Docker Desktop 4.25+)
**Use Case:** Quick vulnerability checks, image comparison
**Install:** Included with Docker Desktop
**Link:** https://docs.docker.com/scout/

**Usage:**
```bash
docker scout quickview
docker scout cves <image>
docker scout compare <old> <new>
```

**Priority:** High (if using Docker Desktop)

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

### JustBash
**What:** TypeScript implementation of Bash with an in-memory (or overlay) virtual filesystem. Gives AI agents safe, sandboxed bash-like execution with zero containers or servers.

**Video assessment:** [JustBash – Bash for AI agents (BetterStack)](https://youtu.be/EoyLzyJUcfI) (~6 min) explains the idea well: simulated bash (grep, sed, awk, jq, cat, ls, etc.) in TypeScript, in-memory FS, no host access. **Verdict: strong addition** when you need AI agents to run script-like tasks without real shell access—fits the toolkit’s security-first, minimal-infra approach.

**Use Case:** AI agent features that need “run commands” behaviour (file ops, text processing, data wrangling) without giving real shell or standing up containers.

**Install:** `npm install just-bash` (or `bash-tool` for AI SDK integration).

**Link:** https://github.com/vercel-labs/just-bash

**Usage:**
```bash
# As library (Node/TypeScript)
npm install just-bash
```

```ts
import { Bash } from "just-bash";
const env = new Bash();
await env.exec('echo "Hello" > greeting.txt');
const result = await env.exec("cat greeting.txt");
// result.stdout, result.exitCode; filesystem is in-memory by default
```

**When to Use:**
- Building agent features that need safe “run bash-like commands” (e.g. process JSON, filter text, list files).
- Avoiding containers/servers while still giving agents a familiar shell model.
- Optional: use OverlayFs for read-from-disk / write-in-memory, or ReadWriteFs in a dedicated sandbox dir.

**Priority:** Optional (add when you have a concrete agent-use case).

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

# 6. Optional: add JustBash when building AI agent features that need safe script execution
# npm install just-bash   # or bash-tool for AI SDK
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
7. Self-Improving Skills - Memory and pattern learning enabled

My Stack: Laravel+Vue OR Next.js
My Philosophy: Essential, maintained, standardized, stack-agnostic

When I start a project: BMAD init → KingMode → Essential plugins → MCP gateway → Enable memory

Self-Improvement: Learn from my code patterns, preferences, and feedback. Remember project context across sessions.
```

---

## Version History

- **2025-02-07 v6** - Tools index and JustBash
  - Added "Index of Integrated Tools" table (name, summary, how we use it, GitHub/link) for all integrated tools
  - Added JustBash to Utility Tools with video assessment ([BetterStack video](https://youtu.be/EoyLzyJUcfI)), usage, and optional priority
  - JustBash: TypeScript Bash with in-memory FS for safe AI agent script execution without containers

- **2025-01-28 v5** - Added Self-Improving Skills Section
  - Comprehensive guide to memory and context persistence
  - Pattern recognition and workflow refinement
  - Best practices for enabling self-improvement
  - Integration with existing toolkit components
  - Memory and context file management

- **2025-01-27 v4** - Enhanced Security Section
  - Added Trivy and Docker Scout as critical security tools
  - Comprehensive security scanning guidance
  - CI/CD security scanning workflow templates
  - Security maintenance schedules and checklists
  - Incident response procedures

- **2025-01-27 v3** - Added Docker Security Policies
  - Mandatory security requirements for all Docker projects
  - Security checklist for Docker Compose and Dockerfiles
  - Best practices for secrets, users, permissions, and resource limits
  - Based on comprehensive security audit across 8 repositories

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
