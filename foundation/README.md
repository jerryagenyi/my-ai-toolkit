# Foundation Layer

> The "build brain" — what to build with, and when to use each tool.

This directory contains the curated set of tools, stacks, scaffolds, and conventions that any new project should start from. It is Layer 1 of the two-layer personal engineering operating system described in [IDEAS.md](../../IDEAS.md).

## Directory Guide

| Directory | Purpose | Start here |
|-----------|---------|------------|
| `tools/` | Approved tools with rationale, usage context, and stage guidance | `tools/README.md` |
| `stacks/` | Preferred default stacks per app type, with decision tree | `stacks/README.md` |
| `scaffolds/` | Starter templates and project initialization checklists | `scaffolds/project-init.md` |
| `conventions/` | Coding, naming, security, and tool-selection conventions | `conventions/security.md`, `conventions/philosophy.md` |
| `architecture-kits/` | Reference architectures (to be populated) | — |

## Guiding Principles

1. **Essential only** — every tool must justify its place
2. **Prefer standards** — MCP over custom plugins, alpine over full images
3. **Boring beats clever** — proven tech over bleeding edge
4. **Security is mandatory** — not optional, not "later"

## How to Use

1. Check `stacks/README.md` to pick your stack
2. Check `tools/README.md` to select tools for your stage and project type
3. Use `scaffolds/project-init.md` to bootstrap
4. Follow `conventions/security.md` for all Docker projects
