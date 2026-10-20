# MCP Servers

> Model Context Protocol servers — prefer these over individual plugins when both exist.

## Docker MCP Gateway (CRITICAL)

Single MCP server exposing 100+ tools via one connection.

### What's Included

- **GitHub** — repos, PRs, issues, search, Copilot integration
- **NPM** — package search, analysis, alternatives, vulnerabilities
- **Brave Search** — web, news, images, videos, local search
- **n8n** — workflow automation
- **Playwright** — browser automation, E2E testing
- **Context7** — library documentation lookup
- **Hostinger** — VPS, DNS, hosting management
- **Web Fetch** — URL fetching and markdown conversion
- **YouTube** — video transcripts and info
- **npm** — package quality, trends, alternatives, vulnerabilities
- 90+ more tools

### Why This Over Individual Plugins

- One connection instead of 10+
- Better maintained (single codebase)
- Consistent tool interface
- Covers GitHub, search, browser, docs, hosting

### When to Use

- All projects — this is the default MCP server
- Replaces: github plugin, context7 plugin, playwright plugin, brave search

### When to Add Additional MCP Servers

- Need a specific tool NOT in the gateway
- Project-specific integrations (e.g., a database MCP)

## Other MCP Servers

| Server | Use Case | Priority |
|--------|----------|----------|
| GitHub Official | If not using Docker gateway | Medium |
| Filesystem | When native file tools aren't enough | Low |

## devops-practices (benchmark best practices against a reviewed database)

A curated, reviewed database of engineering practices (security, reliability, data,
performance, architecture, frontend, compliance, process, testing, deployment, ai) —
use to benchmark any non-trivial feature/endpoint/schema change before calling it
done, not just at the end of a project.

Two access modes:
- **Hosted MCP** (`https://devops-mcp.jerryagenyi.xyz/mcp`) — portable, needs a
  bearer token from the machine credential store. Tools: `stats`,
  `check_practices`, `search_practices`, `get_record`, `get_checklists`,
  `benchmark_procedure`.
- **Sibling repo filesystem** (this machine only, full fidelity incl. drafts):
  `~/Documents/github/devops/practices/active/*.md` (skip `status: superseded`,
  follow `supersedes` chains) + `practices/playbooks/` for the pressure checklist,
  design-review checklist, and decision-record template.

Procedure lives in the `benchmark-practices` skill — copy it into a new project's
`.claude/skills/` at init (see `foundation/scaffolds/project-init.md`) rather than
re-deriving the procedure each time.
