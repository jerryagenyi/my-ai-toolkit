# Jev — Decision-Model Layer

> **Jev** is TypeSafe AI's cloud *decision model*: it never writes text — it only answers
> typed questions (pick one, score this, yes/no) with calibrated confidence, in ~0.4 s for a
> fraction of a cent. It gives agents a fast, cheap second brain for the small decisions that
> would otherwise burn main-model tokens: which search result to read, which browser action to
> take next, which model lane should handle a task, which retrieved passages are relevant.

This directory is the safekeeping copy of our Jev integration, vendored from two upstream
projects:

| Upstream | Commit | What it provides |
|---|---|---|
| [dzhng/jevgrep](https://github.com/dzhng/jevgrep) | `9971e04` | `jg` CLI — semantic repo search ("find code by asking what it does"), plus its `jevgrep` skill |
| [kerpopule/hermes-jev-skills](https://github.com/kerpopule/hermes-jev-skills) | `8316358` | The 13 `jev-*` skills + `jev` CLI (Python, stdlib-only) + Claude Code lane subagents |

## What each skill is used for

| Skill | Used for | Typical cost/latency |
|---|---|---|
| `jevgrep` | **Repo search**: ask a behavioral question ("Where is auth checked before a handler?"), get relevant files + verbatim excerpts with line refs. Use *before* broad greps when exploring unfamiliar code. | ~1 search = cents |
| `jev-search` | After a web/API search: rank results, judge if evidence is enough, pick the next query. Cuts wasted fetch rounds. | ~1.9 s/round |
| `jev-browser-use` | **Browser automation**: Jev picks the next page action (click/type/scroll) from the element list our browser tool observes — pairs with ZCode/Claude Code browser-use plugins, or drives [browser-use/jev-ultrafast](https://github.com/browser-use/jev-ultrafast) for an autonomous loop (~0.4 s/step). | ~0.4 s/step |
| `jev-computer-use` | Desktop GUI driving: we build a table of safe actions; Jev picks the next one. Pairs with the computer-use plugin. | ~0.5 s/step |
| `jev-memory` | Filter passages returned by memory/vault/wiki search before reading: drops irrelevant, flags prompt injection hidden in text. | cheap |
| `jev-model-routing` | Pick the cheapest good-enough model/effort lane per task (`jev lane classify`); decide continue/retry/verify/escalate after each dev cycle. | ~$0.00006 |
| `jev-skill-select` | When many skills are installed: Jev ranks the catalog and may say "no skill needed". | ~2.8 s |
| `jev-compaction` | Choose which transcript turns to keep/summarize/drop when a context must be cut. | cheap |
| `jev-mailbox` | Sort a mailbox export into needs-reply / updates / promo / spam lanes. | ~$0.00006 each |
| `jev-social-research` | Research social posts/creators/trends: ranks discovery cards, decides when evidence is enough for a bounded report. | per round |
| `jev-frontier-work` | Route an already-judged-hard task to a paid frontier seat; Jev watches the run and interrupts only when a decision is needed. | cheap |
| `jev-blender` | Blender work: code-first execution with bounded Jev diagnostic advice. | cheap |
| `jev-video-qa` | Video QA: local-first Jev frame triage with targeted review. | cheap |
| `jev-setup` | Connect/fix Jev credentials (runs `jev setup-key`; the key never passes through the agent). | — |

## Installed where (this machine, 2026-10-28)

| Location | What |
|---|---|
| `~/.jev/hermes-jev-skills/` | Runtime checkout — `jevkit` library + `bin/jev` CLI |
| `~/bin/jev`, `~/bin/jev.cmd` | PATH shims (Git Bash + cmd/PowerShell) → the checkout's `bin/jev` |
| `@dzhng/jevgrep` (npm global) | `jg` CLI (Node 22+; installed 0.8.5) |
| `~/.claude/skills/` (Claude Code) | All 14 skills (13 `jev-*` + `jevgrep`) |
| `~/.claude/agents/` (Claude Code) | `jev-lane-small/medium/high/escalate` subagents |
| `~/.claude/CLAUDE.md` (Claude Code) | Managed "Model lanes" block between `hermes-jev-skills:lanes BEGIN/END` markers |
| `~/.zcode/skills/` (ZCode) | All 14 skills |
| `claude-desktop/jev-skills.zip` | Upload bundle — Claude Desktop has no local skills folder; see `claude-desktop/INSTALL.md` |

Lane note: the upstream lane agents name Claude models (`haiku`/`sonnet`/`opus`). On this
machine Claude Code runs a z.ai/GLM backend, so treat lane names as effort tiers and adjust
the `model:` lines if lane delegation misroutes.

## Usage

```bash
# Repo search (behavioral questions — not symbol lookup; use grep/ripgrep for those)
jg "Where is authentication checked before a request reaches a handler?" ~/zeroclaw-saas
jg files ~/zeroclaw-saas        # what a search would read; no key needed

# Browser loop (path A): observe → build candidate rows → Jev picks → act → verify
jev choose < request.json       # schema jev.action_choice_request_v1, see jev-computer-use skill

# Lane routing (from Claude Code / scripts)
jev lane classify --task "rename this variable"          # → jev-lane-small
jev lane step --task "..." --lane small --attempt 1 --run "npm test" --scope "src/**"

# Health / setup
jev doctor                      # key present? provider reachable?
jg doctor
```

## Auth (owner-only, interactive)

Keys never pass through chat or agents. Two stores, set up once by Jerry in a terminal:

1. **Jev skills** — `jev setup-key` (opens a local browser page; paste the TypeSafe key from
   console.typesafe.ai; stored in `~/.config/jev/credentials` on Windows). Alternatives:
   `--provider openrouter|venice|zen`.
2. **jevgrep** — `jg auth` (choose Vercel AI Gateway / TypeSafe / OpenRouter / OpenCode Zen).

Until a key is present, Jev calls **fail open**: tools keep working, Jev just doesn't
decide. `jev doctor` reports `key.present: false` — that's the only missing piece.

## Privacy

Searches/decisions send eligible content to the configured provider. jevgrep excludes
ignore-file matches, hidden/binary/build/dependency files and does best-effort credential
detection; the `jev` skills redact and cap payloads and never send credential-store content.
Not redaction guarantees — don't point `jg` at secrets-heavy roots.

## Updating / uninstalling

```bash
# Update runtimes
npm install -g @dzhng/jevgrep@latest
git -C ~/.jev/hermes-jev-skills pull
# Re-sync skills from this repo (single source of truth for skill files)
cp -r jev/skills/* ~/.claude/skills/ && cp -r jev/skills/* ~/.zcode/skills/

# Uninstall: delete the jev-* dirs in both skill folders, the jev-lane-* agents,
# the marked block in ~/.claude/CLAUDE.md, ~/bin/jev{,.cmd}, ~/.jev, and `npm rm -g @dzhng/jevgrep`
```
