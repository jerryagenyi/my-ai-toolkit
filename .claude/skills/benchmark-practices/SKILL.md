---
name: benchmark-practices
description: Benchmark a feature (or a whole app) against the curated DevOps/backend best-practices database. Use whenever the user asks to review, audit, benchmark, or sanity-check a feature, endpoint, design, or app against best practices — security, reliability, data, performance, architecture, frontend, compliance.
---

# Benchmark against best practices

Two access modes — pick by where you're running:

**Mode A — practices-db MCP (any agent, no repo access needed).** The reviewed
database is served at `https://devops-mcp.jerryagenyi.xyz/mcp` (streamable
HTTP). Read the bearer token from the machine credential store — the file
`practices-mcp` in the hidden secrets folder at the user profile root
(`C:\Users\Username\.secrets\practices-mcp`) — and send it as
`Authorization: Bearer <token>`. Never echo the token into output, files, or
commits. MCP tools: `stats` (overview + db version), `check_practices`
(filter by domains / applicability / severity), `search_practices` (query),
`get_record` (id), `get_checklists` (playbooks), `benchmark_procedure`
(these steps, verbatim). A permission error on a tool call means the token
is missing or stale — report that and stop; do not guess or retry tokens.

**Mode B — repo filesystem (inside the devops repo).** Records live in
`practices/active/` (YAML frontmatter: `id`, `domain`, `severity`,
`applicability`, `tags`, `status`, plus a terse Why/How/Watch-out body;
schema rules: `practices/SCHEMA.md`). Operational instruments (pressure
checklist, design review checklist, decision record template,
degradation/observability checklists, anti-pattern table) live in
`practices/playbooks/`. Skip records with `status: superseded` — follow the
`supersedes` chain to the live record.

Both available (in the repo AND holding a token)? Prefer Mode B for full
fidelity (includes draft records); Mode A is the interface for agents
without repo access.

## Procedure (both modes)

0. **Standard gates.** For any non-trivial feature or design review, also
   apply the pressure checklist (7 hostile conditions) and the design-review
   checklist (7 review questions). For significant architectural decisions,
   produce a decision record using the decision-record template. For a new
   repo, or the first benchmark pass on an existing one, also run the
   repo-self-documentation checklist (AI-044: header docblocks, a real
   decision-record directory, a generated — never hand-maintained —
   dependency graph with at least one CI-enforced rule) once, as a
   foundational check rather than a per-feature one.
1. **Determine scope.** Identify what is being benchmarked: the feature's
   surface (endpoints, data writes, external calls, auth flows, frontend
   state) and the stack tags that apply (`backend`, `api`, `db`, `frontend`,
   `infra`, `payments`, `ecommerce`, ...).
2. **Load relevant records.** Match domains to the feature's surface
   (security-auth for anything touching auth or user input; data for
   anything writing to a database; reliability-async for anything calling
   external services or processing in the request cycle;
   architecture-frontend-compliance for structural/frontend/compliance
   work). Filter by `applicability` overlap — skip records whose
   applicability has nothing in common with the feature.
3. **Evaluate per record.** For each matching record judge: compliant /
   violated / not-applicable / undetermined. Cite the practice `id` and the
   concrete code location or design decision as evidence. Do not guess — if
   the code under review doesn't show it, mark undetermined and say what to
   check. If a record's source is the product under review, report the
   verdict as self-consistent rather than independently verified.
4. **Report with severity gating:**
   - `blocker` violations → list first, framing as "fix before shipping"
   - `should` violations → recommended fixes
   - `nice` → optional improvements
   - Include a one-line summary: counts by severity, and overall verdict
     (ship / fix-then-ship / redesign).
5. **Suggest fixes tied to the practice**, quoting its How/Watch-out guidance.

## Ingesting new practices (Mode B only — repo required)

1. Draft the new record(s) in `practices/draft/` following SCHEMA.md, with
   full source attribution. One practice per record.
2. Run `node scripts/check-conflicts.mjs` (drafts) — resolve any OVERLAP
   findings by merging, cross-linking, or marking `conflicts_with`.
3. Ask the user to review before promoting to `practices/active/` and setting
   `status: active`. Never silently overwrite an existing record — use a
   `supersedes` chain instead. On promotion, delete the record from
   `practices/draft/` (SCHEMA.md rule 0) — don't leave a stale copy behind.

## Conventions

- Records are the single source of truth; narrative sources stay in `sources/`.
- If two records genuinely conflict, both stay `disputed` until the user
  resolves — present both sides when benchmarking.
