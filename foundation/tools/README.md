# Foundation Tools Index

> Curated set of tools, frameworks, and plugins approved for use across all projects. Each entry includes structured metadata so AI agents (and humans) can reason about *when* and *why* to reach for a tool — not just *what* it is. Tools follow the same distillation discipline as engineering principles: context matters more than capability.

---

## Summary Table

| # | Tool | Category | Priority |
|---|------|----------|----------|
| 1 | BMAD Method | methodology | critical |
| 2 | KINGMODE.md | methodology | high |
| 3 | Claude Skills (Reflect) | dev-tool | high |
| 4 | Ralph Wiggum | plugin | low |
| 5 | Security Guidance | security | critical |
| 6 | Trivy | security | critical |
| 7 | Docker Scout | security | high |
| 8 | Repomix | utility | medium |
| 9 | JustBash | utility | optional |
| 10 | Docker MCP Gateway | mcp | critical |
| 11 | Feature Dev | plugin | high |
| 12 | Frontend Design | plugin | medium |
| 13 | Code Review | plugin | medium |
| 14 | GitHub (plugin) | plugin | low |
| 15 | Context7 | plugin | medium |
| 16 | PHP LSP | plugin | high |
| 17 | TypeScript LSP | plugin | high |
| 18 | Serena | plugin | optional |
| 19 | Playwright | utility | medium |

---

## Methodology

### 1. BMAD Method

> Enterprise-grade agentic development framework: product brief → PRD → architecture → epics & stories → implementation.

| Field | Value |
|-------|-------|
| Category | methodology |
| Stage | planning, implementation, review |
| Priority | critical |
| Install | `npx bmad-method@alpha install` |
| Use when | Starting any new project that needs structure; complex features requiring PRD → architecture → stories flow; team collaboration projects; projects needing proper testing architecture (ATDD, CI/CD) |
| Don't use when | Quick prototypes under 1 week; single-file scripts; spike / throwaway investigations; adding a small feature to an existing well-structured project |
| Replaces | Ad-hoc planning, waterfall docs, unstructured feature development |
| Link | https://github.com/aicodeking/bmad-method |

Generates `_bmad/` (config + workflows) and `_bmad-output/` (PRD, architecture, stories, sprint status). IDE/agent integrations auto-created for `.augment/`, `.claude/`, `.cursor/`, `.gemini/`, `.github/`.

### 2. KINGMODE.md

> Instructions for AI assistants on communication style, updates, and code preferences.

| Field | Value |
|-------|-------|
| Category | methodology |
| Stage | planning, implementation |
| Priority | high |
| Install | Copy from project to project |
| Use when | Starting any new project; onboarding a new AI assistant to your workflow; you want consistent AI behavior across sessions |
| Don't use when | One-off questions; quick fixes where style doesn't matter |
| Conflicts with | Nothing — complements BMAD |
| Link | https://github.com/aicodeking/yt-tutorial |

Contains communication preferences, update frequency expectations, code style preferences, and testing philosophy. Copy alongside BMAD on project init.

---

## Development Tools

### 3. Claude Skills (Reflect)

> Self-improving memory system: analyzes sessions, extracts corrections/patterns, updates skill files in `.claude/skills/`.

| Field | Value |
|-------|-------|
| Category | dev-tool |
| Stage | implementation, review, maintenance |
| Priority | high |
| Install | Copy `.claude/skills/` directory to project |
| Use when | You correct the AI and want it remembered; after sessions with significant pattern decisions; to build up project-specific conventions over time |
| Don't use when | One-time throwaway sessions; before you've established any patterns worth remembering |
| Signal types | Correction (HIGH), Approval (MEDIUM), Observation (LOW) |
| Link | Part of Claude Code; skills live in `.claude/skills/` |

Ships with `reflect.md` (meta-skill), `ui-conventions.md`, `code-style.md`, `api-design.md`, `security-practices.md`. Use `/reflect` to trigger manual analysis. Can be automated via hooks.

---

## Security

### 4. Security Guidance

> Security vulnerability detection and best practices including Docker security policies.

| Field | Value |
|-------|-------|
| Category | security |
| Stage | implementation, review, maintenance |
| Priority | critical |
| Install | Claude Code Plugin Manager → search "security-guidance" |
| Use when | ANY project handling user data, authentication, payments, or health data; all Docker projects; before deploying to production; during code review of sensitive areas |
| Don't use when | Static sites with no user input; internal tools with no sensitive data (though still recommended) |
| Pairs with | Trivy or Docker Scout for container scanning |
| Link | Claude Code plugin |

Enforces mandatory Docker security policies: non-root users, `no-new-privileges`, no hardcoded secrets, resource limits, minimal base images, bridge networks. See `foundation/conventions/security.md` for full checklist.

### 5. Trivy

> Comprehensive security scanner for containers, images, IaC configs, and dependencies.

| Field | Value |
|-------|-------|
| Category | security |
| Stage | implementation, review, maintenance |
| Priority | critical |
| Install | `brew install trivy` (macOS) or download from releases |
| Use when | Scanning Docker images before deployment; checking docker-compose.yml for misconfigurations; CI/CD pipeline security gates; weekly automated vulnerability scans; any Docker project (mandatory) |
| Don't use when | Quick local dev builds; non-containerized projects (use language-specific scanners instead) |
| Replaces | Manual CVE checking, Docker Scout (partial overlap) |
| Commands | `trivy image <img>`, `trivy config docker-compose.yml`, `trivy image --severity HIGH,CRITICAL <img>` |
| Link | https://github.com/aquasecurity/trivy |

Generate HTML reports with `--format template --template "@contrib/html.tpl"`. Integrate into GitHub Actions with `aquasecurity/trivy-action`. Block deployments on CRITICAL findings.

### 6. Docker Scout

> Built-in Docker security scanning for Docker Desktop 4.25+.

| Field | Value |
|-------|-------|
| Category | security |
| Stage | implementation, review |
| Priority | high |
| Install | Included with Docker Desktop 4.25+ |
| Use when | Quick local vulnerability checks during development; comparing image versions before updating; you're already on Docker Desktop and want zero-config scanning |
| Don't use when | You need CI/CD integration (use Trivy instead); scanning non-Docker artifacts; you need detailed HTML reports |
| Replaces | Nothing — complementary to Trivy |
| Commands | `docker scout quickview`, `docker scout cves <img>`, `docker scout compare <old> <new>` |
| Link | https://docs.docker.com/scout/ |

---

## MCP Servers

### 7. Docker MCP Gateway

> Single MCP server exposing 100+ tools: GitHub, NPM, Brave Search, Playwright, Context7, n8n, Hostinger, web fetch, and more.

| Field | Value |
|-------|-------|
| Category | mcp |
| Stage | planning, implementation, review, maintenance |
| Priority | critical |
| Install | MCP server marketplace → search "docker-mcp-gateway" |
| Use when | You need GitHub API access, NPM package analysis, web search, browser automation, library docs, or any of the 90+ other tools — this replaces installing 10+ separate plugins |
| Don't use when | You only need one specific tool and want minimal overhead (but overhead is negligible) |
| Replaces | GitHub plugin, Context7 plugin, Playwright plugin, Brave Search, and many others |
| Link | MCP server marketplace |

Includes: GitHub (repos, PRs, issues, search, Copilot), NPM (search, analysis, vulnerabilities), Brave (web, news, images, videos, local), n8n (workflow automation), Playwright (browser automation), Context7 (library docs), Hostinger (VPS, DNS, hosting), Web Fetch, and 90+ more.

---

## Plugins (Claude Code)

### 8. Feature Dev

> Architecture and code design patterns for planning and refactoring.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | planning, implementation |
| Priority | high |
| Install | Claude Code Plugin Manager → search "feature-dev" |
| Use when | Designing new features or modules; making technical architecture decisions; refactoring existing code; evaluating trade-offs between approaches |
| Don't use when | Simple bug fixes; styling changes; one-line changes |
| Pairs with | BMAD Method (feature-dev handles micro decisions, BMAD handles macro flow) |

### 9. Frontend Design

> UI/UX design assistance for Vue/Quasar or Next.js frontends.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | implementation |
| Priority | medium |
| Install | Claude Code Plugin Manager → search "frontend-design" |
| Use when | Building UI components; designing layouts and navigation; choosing Quasar components or Tailwind/shadcn patterns; responsive design decisions |
| Don't use when | Backend-only work; API design; infrastructure/DevOps tasks |
| Pairs with | TypeScript LSP or PHP LSP (depending on stack) |

### 10. Code Review

> Automated adversarial code review for pre-commit quality gates.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | review |
| Priority | medium |
| Install | Claude Code Plugin Manager → search "code-review" |
| Use when | Pre-commit PR reviews; quality gates before merging; you're NOT using BMAD's built-in code review workflow |
| Don't use when | Already using BMAD review workflow (overlap); trivial changes not worth reviewing |
| Overlaps with | BMAD Method (has code-review workflow built in) |

### 11. GitHub (Plugin)

> GitHub integration for repos, PRs, and issues.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | implementation, review, maintenance |
| Priority | low |
| Install | Claude Code Plugin Manager → search "github" |
| Use when | You need GitHub integration AND are NOT using Docker MCP Gateway (which already includes comprehensive GitHub tools) |
| Don't use when | Docker MCP Gateway is configured (redundant — MCP version is more comprehensive) |
| Replaced by | Docker MCP Gateway GitHub tools |

### 12. Context7 (Plugin)

> Up-to-date library documentation lookup.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | planning, implementation |
| Priority | medium |
| Install | Claude Code Plugin Manager → search "context7" |
| Use when | Looking up docs for a library or package during development; checking API signatures; verifying latest version behavior |
| Don't use when | Docker MCP Gateway is configured (includes Context7); you already have the docs open |
| Replaced by | Docker MCP Gateway Context7 tool |

### 13. PHP LSP

> PHP language server support for Laravel/PHP projects.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | implementation, review |
| Priority | high |
| Install | Claude Code Plugin Manager → search "php-lsp" |
| Use when | Working on Laravel or PHP projects; need type checking, go-to-definition, autocompletion for PHP code |
| Don't use when | Not working on a PHP project (obviously); using a different language |
| Paired with | Security Guidance (Laravel projects handle auth/data) |

### 14. TypeScript LSP

> TypeScript language server support for Vue 3, Next.js, and TypeScript projects.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | implementation, review |
| Priority | high |
| Install | Claude Code Plugin Manager → search "typescript-lsp" |
| Use when | Working on Vue 3, Next.js, React, or any TypeScript project; need type checking, go-to-definition, autocompletion |
| Don't use when | Not working on a TypeScript/JavaScript project; pure PHP or Python projects |
| Paired with | Frontend Design (for UI work in TypeScript) |

### 15. Serena

> Semantic code editing with symbol awareness for large-scale refactoring.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | implementation |
| Priority | optional |
| Install | Claude Code Plugin Manager → search "serena" |
| Use when | Large-scale refactoring across many files; complex codebase navigation where symbol awareness matters; renaming interfaces/types used across the entire project |
| Don't use when | Native LSP + Edit tools cover your needs (most cases); small projects; simple file-level edits |
| Decision | Enable only when doing heavy refactoring — disable otherwise to reduce overhead |

### 16. Playwright (Plugin)

> Browser automation and E2E testing.

| Field | Value |
|-------|-------|
| Category | utility |
| Stage | implementation, review |
| Priority | medium |
| Install | Claude Code Plugin Manager → search "playwright" |
| Use when | Writing E2E tests; browser automation for scraping; testing user flows end-to-end |
| Don't use when | Docker MCP Gateway is configured (includes Playwright); unit testing only; no browser interaction needed |
| Replaced by | Docker MCP Gateway Playwright tool |

### 17. Ralph Wiggum

> Milk tea coupon easter egg. Fun/morale booster.

| Field | Value |
|-------|-------|
| Category | plugin |
| Stage | anytime |
| Priority | low |
| Install | Claude Code Plugin Manager → search "ralph-wiggum" |
| Use when | You need a morale boost; taking a break; onboarding someone and want a laugh |
| Don't use when | You're behind deadline and stressed (actually, especially then) |
| Link | https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum |

---

## Utility Tools

### 18. Repomix

> Packages an entire codebase into a single LLM-friendly file for context sharing.

| Field | Value |
|-------|-------|
| Category | utility |
| Stage | planning, review |
| Priority | medium |
| Install | `npm install -g repomix` |
| Use when | Sharing full project context with an AI assistant for deep analysis; preparing a codebase for review; creating documentation snapshots; comparing project state over time |
| Don't use when | You only need a few files (use direct file reads instead); the project is very large and token limits are a concern |
| Commands | `repomix . --output codebase.txt`, `repomix src/ --output src.txt`, `repomix . --ignore "node_modules,dist" --output clean.txt` |
| Link | https://github.com/yamadashy/repomix |

### 19. JustBash

> TypeScript implementation of Bash with in-memory filesystem. Safe, sandboxed bash for AI agents without real shell or containers.

| Field | Value |
|-------|-------|
| Category | utility |
| Stage | implementation |
| Priority | optional |
| Install | `npm install just-bash` |
| Use when | Building AI agent features that need "run bash-like commands" (file ops, text processing, data wrangling) without giving real shell access; avoiding containers while still giving agents a familiar shell model; zero-infra sandboxed execution |
| Don't use when | You need real filesystem access (use native tools); running production scripts; the AI agent already has safe shell access via Claude Code or similar |
| Optional features | OverlayFs (read-from-disk / write-in-memory), ReadWriteFs (dedicated sandbox dir) |
| Link | https://github.com/vercel-labs/just-bash |

```ts
import { Bash } from "just-bash";
const env = new Bash();
await env.exec('echo "Hello" > greeting.txt');
const result = await env.exec("cat greeting.txt");
// result.stdout, result.exitCode; filesystem is in-memory by default
```
