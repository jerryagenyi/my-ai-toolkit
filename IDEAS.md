# my-ai-toolkit — Ideas & Strategy Document

> A working brief for evolving `my-ai-toolkit` from a personal tools repo into a two-layer **personal engineering operating system**: a **build foundation** layer (what to build with) merged with an **engineering intelligence** layer (how to build well), accessible to AI agents through the repo and, eventually, an MCP server.

---

## 1. Vision

Build a single, repo-backed system that gives AI coding agents two things they currently lack when working with a solo / vibe-coder builder:

1. **A standard build foundation** — the curated set of tools, stacks, scaffolds, and conventions that any new project should start from. (This is what `my-ai-toolkit` already aims at.)
2. **A curated engineering judgment layer** — distilled production-grade principles, anti-patterns, and canonical issues drawn from trusted sources (e.g. Akintola Steve, Amos / Naija Code Paddy, docs, talks, postmortems) that agents can use to review code, architecture, and PRDs.

Together, these turn the repo into the agent's "default build brain" **and** "critical reviewer brain."

---

## 2. Why this is not "dead on arrival"

The market has Claude Code Security (Enterprise/Team preview), Cursor security review, CodeRabbit, and similar tools. They validate the category but don't close it.

**The wedge for this project is different:**

- Not "AI reviews code" (commodity).
- But **"AI reviews code and design decisions against a curated production playbook *you* control."**

The defensible asset is **curation + taxonomy + canonical issue logic**, not raw model reasoning. Anthropic, Cursor, OpenAI win on models. A solo builder can win on:

- Source selection.
- Distillation quality.
- Issue canonicalisation.
- Contextual review (PRD → stack → architecture → code).
- Personal/team overlays.

This is a **judgment layer**, not a model.

---

## 3. Core concept: merge `my-ai-toolkit` with the insight engine

| Layer | Role | Answers the question |
|---|---|---|
| **Build foundation** | Standardisation | "What should I build *with*?" |
| **Engineering intelligence** | Judgment | "Am I building this *well*?" |

These should live in **one umbrella repo**, not two. Treat the insight engine as a first-class module inside `my-ai-toolkit`, not a separate afterthought.

**Two-pass agent flow this enables:**

1. Read PRD → match to **build foundation** → propose initial stack & scaffold.
2. Stress-test that proposal and any code/architecture against **engineering intelligence** → produce a build plan + risk report + recommendations.

---

## 4. Three-layer knowledge architecture

Do **not** dump raw threads/transcripts into one bucket and search them. Use three distinct layers so similarity, contradiction, and curation are all manageable.

### 4.1 Sources
- One record per tweet thread, video transcript, blog post, talk, or note.
- Stored largely as captured (after light cleanup), with metadata.
- This is the **evidence layer**.

### 4.2 Principles
- Atomic, distilled statements extracted from a source.
- Each principle links back to its source(s).
- One source can produce many principles (Akintola's queue thread → "remove non-critical side effects from request path", "queue consumers need retries + DLQ + idempotency", "DB connections held during downstream waits cause cascade failures", etc.).
- This is the **distillation layer**.

### 4.3 Issues library (canonical)
- Higher-level, *merged* records: e.g. `synchronous-side-effects`, `missing-idempotency`, `retry-storm-risk`, `tight-request-coupling`.
- Each canonical issue cites multiple principles and sources.
- Encodes **conditional logic** (when this applies, when it does not).
- This is the **judgment layer** the agent actually uses for review.

> **Key rule:** retrieval and review run primarily against **issues** and **principles**, not raw sources. Sources exist for traceability and re-distillation.

---

## 5. Contradiction & similarity handling

When new content is being distilled, the pipeline should explicitly classify the relationship to existing knowledge — *not* silently overwrite or duplicate.

**Four actions on similarity match:**

1. **Attach** — same idea; add as additional evidence to the existing principle/issue.
2. **Refine** — same idea, but adds nuance, conditions, or scope.
3. **Contradict** — disagrees with existing guidance; surface for human resolution.
4. **Fork** — different context (stack, scale, domain); create a sibling entry.

This protects against the trap of "always use queues" type oversimplifications. Steve's own thread already shows queues are context-dependent; the canonical issue should encode that:

> *Use queues when side effects are non-critical and burst handling matters; avoid them when immediate consistency is required and task volume is low.*

---

## 6. Workflow (human-in-the-loop, deliberately)

The MVP capture flow is intentionally **not fully automated**. The bottleneck is judgment, not capture.

```
1. See useful thread on X
2. Reply: @threadreaderapp unroll
3. Thread Reader returns a clean URL
4. Paste URL into agent (Hermes / OpenClaw / Claude / Cursor)
5. Agent extracts → proposes structured entries (sources + principles + issue links)
6. Human approves / edits
7. Agent commits to repo
8. CI/CD redeploys MCP server with latest corpus
```

**Why this discipline matters:**

- You unroll many threads; only the ones you intentionally hand to the agent become candidates.
- Editorial control = corpus quality.
- Repo stays the trusted source of truth.
- Hands-free comes *later*, only inside the repo (after content is approved).

**Boundary lines:**

| Stage | Owner |
|---|---|
| Collection | X / Thread Reader / YouTube |
| Extraction & structuring | Agent |
| Editorial approval | Human (you) |
| Storage & serving | Repo + MCP server |

---

## 7. Proposed unified repo structure

```
my-ai-toolkit/
├── foundation/              # Build foundation layer
│   ├── stacks/              # Preferred default stacks per app type
│   ├── tools/               # Approved tools with rationale
│   ├── scaffolds/           # Starter templates / boilerplates
│   ├── conventions/         # Coding, naming, infra conventions
│   └── architecture-kits/   # Reference architectures
│
├── sources/                 # Raw imported captures
│   ├── threads/             # X / Thread Reader unrolls
│   ├── videos/              # YouTube transcripts
│   ├── articles/            # Blog posts, docs
│   └── notes/               # Personal observations
│
├── principles/              # Distilled atomic statements
│
├── issues/                  # Canonical merged issue records
│
├── playbooks/               # Review checklists by app type
│   ├── saas-api.md
│   ├── civic-platform.md
│   ├── ai-product.md
│   └── internal-dashboard.md
│
├── reviews/                 # Generated audit outputs
│
├── schemas/                 # JSON/YAML schemas for all entry types
│
├── evaluators/              # Adapters: Semgrep, tree-sitter, ESLint, Bandit, etc.
│
└── mcp/                     # MCP server wrapper (added later)
```

---

## 8. Data model / schemas

### 8.1 Principle (Markdown + YAML front matter)

```yaml
---
id: ENG-QUEUE-001
title: Remove non-critical side effects from synchronous request path
category: performance
tags: [queues, async, api-design, reliability]
source_author: Akintola Steve
source_url: https://x.com/Akintola_steve/status/2048054276568547814
source_type: x_thread
stack_scope: [nodejs, nestjs, backend, distributed-systems]
severity_if_ignored: high
confidence: medium
review_targets: [api-endpoints, workers, architecture-docs]
linked_issues: [synchronous-side-effects, retry-storm-risk]
---

## Principle
Non-critical side effects (email, SMS, analytics, receipts) must not block
the main request lifecycle.

## Why it matters
Holding the request open while waiting on slow downstream services increases
latency, exhausts DB connections, and amplifies failure during spikes.

## Signals (what to look for in a codebase)
- API handlers calling SMS/email/payment-adjacent side effects inline
- Long DB transaction or connection hold time
- No queue or background worker for deferred tasks

## Audit questions
- What must complete before the HTTP response returns?
- Which steps are user-critical vs eventually consistent?
- Are retries and DLQs defined?

## Recommended action
Move non-critical tasks to background workers behind a queue;
preserve idempotency and observability.
```

### 8.2 Canonical Issue

```yaml
---
id: ISSUE-SYNC-SIDE-EFFECTS
title: Synchronous side effects in request path
status: active
severity: high
applies_when:
  - app_type: [saas-api, civic-platform, marketplace]
  - traffic_profile: [bursty, high-volume]
does_not_apply_when:
  - traffic_profile: [low-volume, internal-tool]
  - consistency_requirement: strict-immediate
supporting_principles: [ENG-QUEUE-001, ENG-DB-CONN-002, ENG-IDEMP-001]
recommended_remedies:
  - introduce-queue-for-non-critical-side-effects
  - cap-and-instrument-db-connection-pool
  - design-idempotent-consumers
contradictions: []
last_reviewed: 2026-05-01
---
```

### 8.3 Source

```yaml
---
id: SRC-AKINTOLA-2048054276568547814
type: x_thread
author: Akintola Steve
url: https://x.com/Akintola_steve/status/2048054276568547814
captured_at: 2026-05-01
unroll_url: https://threadreaderapp.com/...
status: distilled
derived_principles: [ENG-QUEUE-001, ENG-DB-CONN-002, ENG-IDEMP-001]
notes: |
  Strong thread. Mixes general rule with explicit "when not to use queues"
  caveats. Useful for retry-storm-risk canonical entry.
---
```

---

## 9. Review engine design

The real value is **staged review**, not a single LLM "review my repo" prompt.

```
1. Parse context
   - Language, framework, package manifest, infra files, README, PRD.
2. Detect declared intent
   - From PRD, README, architecture notes, issues, commit history.
3. Retrieve relevant principles & issues
   - Filter by stack, subsystem, scale, traffic profile.
4. Run targeted audits
   - API path, auth flows, queues, data access, retries, observability, cost.
5. Cross-check intent vs implementation
   - "PRD says high-volume transactions, but no queueing strategy appears."
6. Produce findings
   - Issue, why it matters, example failure mode, suggested fix,
     links back to source-backed principles.
```

This goes beyond what generic AI review tools do. CodeRabbit and similar focus on local PR-level issues. A staged engine like this can ask the more architectural question: *is this design appropriate for the operational profile this product claims to need?*

---

## 10. PRD summary

**Product:** InsightOps Review Engine (working name) — a module of `my-ai-toolkit`.

**Problem:** Vibe coders ship working code fast but miss deeper production concerns (concurrency, retries, boundaries, integration brittleness, mismatch with business intent). Existing AI review tools don't let users build & apply their own curated, source-grounded playbook.

**Goal:** Repo-backed system that ingests trusted engineering content, distills it into structured principles + canonical issues, and exposes them to AI agents for code, architecture, and PRD review.

**Users:** Solo builders using AI heavily, technical founders, small teams, AI agents acting as reviewers.

**Core jobs:**

1. Save & distill technical content from threads, videos, docs.
2. Search insights semantically by topic / failure mode.
3. Review a codebase against the knowledge base.
4. Review a PRD or architecture against stack and systems-design best practices.
5. Produce reports with findings, rationale, severity, and recommendations.

**MVP features:**

- Manual paste of thread / transcript / link.
- LLM distillation pipeline with fixed extraction schema.
- Markdown/YAML repo as source of truth.
- Semantic retrieval over principles & issues.
- Repo / PR review mode.
- PRD / architecture review mode.
- Markdown report output.

**Non-goals (MVP):**

- Autonomous scraping at scale.
- Full multi-language deep static analysis.
- Replacing SAST/DAST or enterprise AppSec.
- Automatic verification of source truthfulness.

**Inputs:** source text/URL, code repo or PR diff, optional PRD/architecture doc, optional stack metadata.

**Outputs:** distilled knowledge entries, search results, review checklists, audit reports, architecture critique mapped to source-backed principles.

**Evaluation metrics:**

- Retrieval precision (right principle returned for a query).
- Review usefulness (% findings judged valuable).
- False-positive rate.
- Time saved per review.
- Coverage across categories: reliability, security, performance, architecture, observability, cost.

---

## 11. Build sequence (four phases)

**Phase 1 — Substrate (no automation)**
- Define schemas (source / principle / issue).
- Manually add 20–30 high-quality principles from Akintola, Amos, your own notes.
- Build a few canonical issues by hand.
- Write the first 2–3 playbooks (e.g. SaaS API, civic platform).

**Phase 2 — Distillation pipeline**
- Build the agent prompt + extraction schema.
- CLI/API: paste URL or text → propose structured entries → human approves → commit.
- Add similarity check (attach / refine / contradict / fork).

**Phase 3 — Retrieval & checklist generation**
- Embeddings + semantic search over principles & issues.
- Endpoint: `generate_checklist(app_type, stack, scale_profile)`.

**Phase 4 — Review engine + MCP**
- Repo / PR / PRD review modes.
- Wrap as MCP server (Dokploy on VPS, auto-redeploy on repo commit).
- Endpoints: `search_principles`, `get_checklist`, `review_repo`, `review_prd`, `explain_finding`.

> **Discipline:** don't skip Phase 1. The corpus is the asset.

---

## 12. Suggested MVP stack

| Layer | Choice |
|---|---|
| Repo | GitHub — Markdown + YAML front matter |
| Embeddings / search | pgvector or Qdrant |
| Metadata store | Postgres |
| Ingestion | Manual paste → agent → approve |
| Distillation | LLM with fixed extraction schema |
| Review engine | Retrieval + prompt workflows + optional static analysers (Semgrep / tree-sitter / ESLint / Bandit) |
| API | FastAPI or Node/Nest |
| MCP server | Thin wrapper around the API |
| Hosting | Dokploy on VPS |
| CI/CD | GitHub Actions — auto-deploy on commit, reindex corpus |

This fits the "knowledge repo as source of truth, MCP as serving layer" architecture cleanly.

---

## 13. Source ingestion strategy

### 13.1 Reality check on Thread Reader
- No documented public developer API was confirmed.
- The reliable trigger is the public bot flow: reply `@threadreaderapp unroll` → Thread Reader returns URL.
- Premium PDF archive can be a canonical artifact for ingestion later.

### 13.2 MVP ingestion pattern (deliberately manual)
- You unroll on X.
- You paste the Thread Reader URL into your agent.
- Agent fetches, distills, proposes entries.
- You approve.

### 13.3 Pluggable connector model (later)
Treat all sources through a single ingestion interface:

```
source_type → source_locator → fetcher → normalizer →
chunker → distiller → deduper → issue-linker
```

Adapters: `threadreader`, `youtube`, `webpage`, `github`, `manual-paste`, `rss`, `pdf`. Each one feeds the same canonical pipeline. This is the path to a NotebookLM-style multi-source experience.

---

## 14. Future expansion roadmap

Ordered from closest to furthest from MVP. **Rule:** every expansion must improve **source quality**, **retrieval quality**, or **review quality**. Anything else is a distraction.

### Near-term
- Paste-URL importers for Thread Reader, YouTube, blog posts.
- Approval queue UI before repo write.
- Similarity check + attach/refine/contradict/fork classifier.
- Auto-generated checklists per app type.

### Mid-term
- MCP server on Dokploy backed by repo, auto-redeploy on commit.
- PRD-to-stack benchmarking (agent picks stack from `foundation/`).
- Repo review mode with per-finding source links.
- Playbooks per app class (SaaS API, civic platform, AI product, dashboard, marketplace).
- Integrate static analysers (Semgrep, ESLint, Bandit, CodeQL) as evaluators.

### Long-term
- **Community overlays:** public base corpus + private personal/team layers.
- **Trust scoring:** weight sources by author reputation, recency, corroboration, domain.
- **Context-aware review:** factor in PRD, scale assumptions, maturity stage.
- **Design-pressure simulation:** if PRD says "high volume" or "unreliable third-party APIs", the system proactively elevates queues / retries / idempotency / backpressure issues.
- **Provenance views:** every recommendation links back to the evidence chain.
- **"Why this matters" teaching mode:** explanations alongside findings, so the tool teaches as it audits.
- **Review modes by artifact:** PR, repo, architecture doc, incident postmortem, PRD.
- **Postmortem ingestion:** pipe outage learnings back into canonical issues.
- **Continuous index refresh:** repo commit → reindex → agents see new corpus immediately.

---

## 15. Guiding principles for the project

1. **Repo is the source of truth.** MCP is just a serving layer.
2. **Curation > automation.** A small corpus of high-quality, distilled entries beats a large pile of raw threads.
3. **Distil into testable primitives.** "Build for high availability" is too vague. "Flag network calls without deadlines" is reviewable.
4. **Human-in-the-loop at the editorial boundary.** Agents extract; humans approve.
5. **Canonical issues, not author opinions.** Sources are evidence; canonical issues are the agent's working memory.
6. **Encode context, not absolutes.** Conditional rules (`applies_when` / `does_not_apply_when`) over universal claims.
7. **Build for one user first (you).** Community features come *after* the personal system actually works.
8. **Every expansion must improve source / retrieval / review quality.** No other axes count.
9. **Don't compete with foundation models.** Compete on judgment, taxonomy, and traceability.
10. **Boring beats clever.** Markdown + YAML is fine. Vector DB + MCP can wait until they're earned.

---

## 16. Immediate next steps

1. Lock the three schemas (`source`, `principle`, `issue`) in `schemas/`.
2. Add 20–30 hand-written principles from Akintola Steve's threads + Amos's videos + your own production notes.
3. Build 5–10 canonical issues from those principles, with proper conditional logic.
4. Write 2–3 playbooks (SaaS API, civic platform / ScaleDem-style civic engagement, AI product).
5. Draft the agent's distillation prompt + approval flow (no MCP yet).
6. Only then start the MCP server wrapper.

---

## 17. Open questions to resolve later

- How do you want to version canonical issues? (Semver? Date-stamped? Git history alone?)
- Should sources be deleted if their principles get merged into canonical issues, or always preserved?
- Where does proprietary / private knowledge sit if the repo eventually goes public? (Likely: split into `public/` and `private/` overlays.)
- Trust scoring: who decides author reputation, and is it transparent?
- Multi-user editorial review: stays solo, or eventually formal review workflow?
- How is contradiction resolution surfaced to the human — diff view? Issue thread? Agent recommendation?

---

*This document is a working brief, not a spec. It should be revised as the repo evolves and as canonical issues start to reveal real patterns.*
