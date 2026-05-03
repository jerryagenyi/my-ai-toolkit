# My AI Toolkit

> A personal engineering operating system — curated tools, stacks, conventions, and distilled engineering intelligence for AI-assisted development.

## What This Is

A two-layer system for building software with AI:

| Layer | Purpose | Directory |
|-------|---------|-----------|
| **Build Foundation** | What to build with — tools, stacks, scaffolds, conventions | `foundation/` |
| **Engineering Intelligence** | How to build well — principles, playbooks, issue records | `principles/`, `issues/`, `playbooks/` |

See [IDEAS.md](IDEAS.md) for the full strategy and vision.

## Quick Start

### For a new project
1. Pick your stack → `foundation/stacks/README.md`
2. Select tools by stage → `foundation/tools/README.md`
3. Bootstrap → `foundation/scaffolds/project-init.md`
4. Secure → `foundation/conventions/security.md`

### For AI assistants
```
Check this repo for my tools, stacks, and conventions.
I'm using [your stack here].
Help me with [your task].
```

## Structure

```
my-ai-toolkit/
├── foundation/              # Build foundation layer
│   ├── tools/               # Approved tools with rationale & stage guidance
│   ├── stacks/              # Preferred stacks per app type + decision tree
│   ├── scaffolds/           # Project init templates & checklists
│   ├── conventions/         # Security, philosophy, coding conventions
│   └── architecture-kits/   # Reference architectures (coming later)
│
├── sources/                 # Raw imported captures (threads, videos, articles, notes)
├── principles/              # Distilled atomic engineering statements
├── issues/                  # Canonical merged issue records
├── playbooks/               # Review checklists by app type
├── schemas/                 # JSON/YAML schemas for all entry types
├── evaluators/              # Static analyser adapters (coming later)
├── mcp/                     # MCP server wrapper (coming later)
│
├── docs/
│   ├── legacy/              # Raw strategy conversations
│   └── examples/            # Example config files
│
├── scripts/                 # Utility scripts
└── .claude/                 # Claude Code skills & config
```

## Philosophy

1. **Essential only** — every tool must justify its place
2. **Prefer standards** — MCP over custom plugins, proven over bleeding edge
3. **Boring beats clever** — reliable tech over hype
4. **Curation > automation** — human judgment first, automation second
5. **Security is mandatory** — not optional, not "later"
6. **3-project rule** — remove tools unused across 3 projects

## Primary Stacks

| Stack | Best For |
|-------|----------|
| Laravel + Vue/Quasar | Enterprise web apps, API backends |
| Next.js | Modern full-stack, SSR/SSG |
| Python + FastAPI | Data-heavy services, ML/API |
| Flutter | Cross-platform mobile |

See [foundation/stacks/README.md](foundation/stacks/README.md) for the full decision tree.

## Status

- **Foundation layer**: Active and populated
- **Engineering intelligence layer**: Structure ready, content being built out
