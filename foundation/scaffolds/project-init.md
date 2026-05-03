# Project Initialization Template

> Use this file to quickly bootstrap new projects with the AI toolkit.

---

## Quick Start Commands

```bash
# 1. Create project directory
mkdir my-new-project && cd my-new-project

# 2. Initialize git
git init

# 3. Initialize BMAD (if doing full project)
npx bmad-method@alpha install

# 4. Copy toolkit files
cp ~/MY_AI_TOOLKIT.md .
cp ~/KINGMODE.md .

# 5. Create PROJECT_INIT.md (see template below)
# 6. Optional: add JustBash for AI agent features needing safe script execution
```

---

## Per-Stack Checklists

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
cd frontend && npm install
```

**Plugins:** security-guidance, php-lsp, typescript-lsp, feature-dev, frontend-design, ralph-wiggum

### Next.js

```bash
npm create next-app@latest my-app --typescript --tailwind --app-router
```

**Plugins:** security-guidance, typescript-lsp, feature-dev, frontend-design, ralph-wiggum

### Python + FastAPI

```bash
pip install fastapi uvicorn sqlalchemy psycopg2-binary
mkdir myapp && cd myapp
```

**Plugins:** security-guidance, pyright-lsp (if available), feature-dev

### Simple/Prototype

```bash
npm init -y
```

**Plugins:** language LSP, ralph-wiggum. **Skip BMAD** for prototypes unless growing beyond MVP.

---

## PROJECT_INIT.md Template

```markdown
# Project: [PROJECT_NAME]

## AI Toolkit Config
- BMAD: Installed
- MCP Gateway: Configured
- Plugins: [list essential ones]

## Tech Stack
- Frontend:
- Backend:
- Database:
- Testing:

## Project Status
- Phase: [Planning/Dev/Deployed]
- Last Updated: [date]
```

---

## Quick Start Checklist

For any new project:

1. **Initialize BMAD** — `npx bmad-method@alpha install`
2. **Copy KINGMODE.md** — project-level AI guidance
3. **Install essential plugins** — via Claude Plugin Manager
4. **Configure MCP servers** — Docker MCP Gateway covers 90% of needs
5. **Create initial repomix** (optional) — `repomix . --output initial-state.txt`
6. **Add JustBash** (optional) — for AI agent features needing safe script execution

---

## File Structure After Init

```
my-project/
├── PROJECT_INIT.md        # Project metadata
├── MY_AI_TOOLKIT.md       # AI toolkit config
├── KINGMODE.md            # AI assistant instructions
├── _bmad/                 # BMAD configuration
├── _bmad-output/          # BMAD generated artifacts
├── .claude/               # Claude Code config + skills
├── .augment/              # Augment integration
├── .cursor/               # Cursor integration
├── .github/               # GitHub config + CI/CD
└── [project files]        # Backend, frontend, etc.
```
