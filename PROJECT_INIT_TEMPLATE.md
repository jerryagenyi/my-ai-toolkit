# PROJECT INITIALIZATION TEMPLATE

> Use this file to quickly bootstrap new projects with your AI toolkit.

---

## Quick Start Commands

```bash
# 1. Create project directory
mkdir my-new-project
cd my-new-project

# 2. Initialize git
git init

# 3. Initialize BMAD (if doing full project)
npx bmad-method@alpha install

# 4. Copy your toolkit files
cp ~/MY_AI_TOOLKIT.md .
cp ~/KINGMODE.md .

# 5. Create this INIT file
cat > PROJECT_INIT.md << 'EOF'
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
- Last Updated: $(date)
EOF
```

---

## Per-Stack Checklists

### Laravel + Vue Project
```bash
# Backend
composer create-project laravel/laravel backend
cd backend
cp .env.example .env
php artisan key:generate
php artisan migrate

# Frontend
npm create vue@latest frontend
# OR
npm create quasar@latest frontend

# Essential Plugins
# - php-lsp
# - typescript-lsp
# - security-guidance
# - feature-dev
# - ralph-wiggum
```

### Next.js Project
```bash
# Create
npm create next-app@latest

# Essential Plugins
# - typescript-lsp
# - security-guidance
# - feature-dev
# - frontend-design
# - ralph-wiggum
```

### Simple/Prototype Project
```bash
# Just the essentials
npm init -y

# Essential Plugins
# - [language]-lsp
# - ralph-wiggum

# Skip BMAD for prototypes unless growing beyond MVP
```

---

## File Structure After Init

```
my-project/
├── MY_AI_TOOLKIT.md          # Your portable toolkit
├── KINGMODE.md               # Your AI instructions (if you have one)
├── PROJECT_INIT.md           # This file
├── _bmad/                    # BMAD framework (if installed)
├── _bmad-output/             # BMAD artifacts
├── .claude/                  # Claude Code specific configs
├── src/                      # Your code
└── README.md                 # Project readme
```

---

## First AI Conversation Template

When starting with a new AI assistant on a project, share this:

```
I'm using my AI toolkit for this project. Here's what's configured:

TOOLS:
- BMAD Method installed
- Docker MCP Gateway active (100+ tools)
- Security Guidance enabled
- [List your stack-specific LSPs]

PROJECT CONTEXT:
- Type: [Laravel/Vue OR Next.js]
- Phase: [Planning/Implementation/Refinement]
- Key files: [List key files AI should know]

WORKFLOW:
1. Check MY_AI_TOOLKIT.md for my full toolset
2. Check KINGMODE.md for my preferences
3. Use BMAD workflows for complex features
4. Always run security guidance before commits

CURRENT TASK:
[Describe what you're working on]
```

---

## Maintenance

### Monthly Review
```bash
# Review tool usage
cat MY_AI_TOOLKIT.md | grep "Priority:" | wc -l  # Count tools

# Remove unused tools (3-project rule)
# Document new tools discovered
```

### Project Handoff
When handing off to team or archive:
```bash
# Create toolkit snapshot
cp MY_AI_TOOLKIT.md TOOLKIT_SNAPSHOT_$(date +%Y%m%d).md

# Document project-specific tools added
echo "# Project-Specific Tools
# - [tool]: [reason added]" >> TOOLKIT_NOTES.md
```

---

## Troubleshooting

### BMAD Not Working
```bash
# Reinstall
npx bmad-method@alpha install --force

# Check version
npx bmad-method@alpha --version
```

### Plugins Not Loading
```bash
# Check Claude Code plugin directory
# Windows: %USERPROFILE%\.claude\plugins\
# Mac/Linux: ~/.claude/plugins/

# Verify installed_plugins.json
cat ~/.claude/plugins/installed_plugins.json
```

### MCP Servers Not Connecting
```bash
# Check MCP config
cat ~/.claude/settings.json | grep mcp

# Restart Claude Code
# Kill and reopen application
```

---

## Quick Reminders

### Before Committing
- [ ] Security Guidance check passed
- [ ] Code review done (BMAD or plugin)
- [ ] Tests passing
- [ ] Documentation updated

### Before Starting New Feature
- [ ] Feature plan created (BMAD create-tech-spec or create-story)
- [ ] Architecture considered
- [ ] Security implications reviewed
- [ ] Tests planned

### Before Deploying
- [ ] NFR checklist completed (BMAD testarch-nfr)
- [ ] Security scan passed
- [ ] E2E tests passing
- [ ] Rollback plan ready

---

**Remember:** This is YOUR template. Customize it based on what actually works for you. The goal is to make every new project start smoother than the last.
