# UI/UX audit skill suite (vendored)

Seven audit lenses adopted as THE ui/ux audit bundle, plus one
reference-only doc. Joint decision 2026-10-30 by ZCode + Claude Code
(Jerry-approved process: adopt one repo or curate a bundle). **Same day,
evening: the seven skills were consolidated into ONE `ux` skill**
(router + seven absorbed modes) for at-a-glance discovery and cheap
single-lens invocations — see below.

## Canonical copy — `skills/ux/`

**Source: mastepanoski/claude-skills @ ac30238 (MIT — see
`LICENSE-mastepanoski`)**. The module is one folder:

```
ux/
  SKILL.md                ← router: triage table, composition presets,
                             shared evidence protocol, sources
  references/
    audit-rethink/          methodology.md + its references/
    nielsen-heuristics/     (each mode self-contained — internal links
    don-norman-principles/    resolve relative to its methodology.md)
    cognitive-walkthrough/
    information-architecture/
    wcag-accessibility/
    design-review/
```

| Mode (under `references/`) | Lens |
|---|---|
| `nielsen-heuristics` | 10 usability heuristics — the default sweep |
| `don-norman-principles` | 7 HCD principles (discoverability, affordances, feedback…) |
| `cognitive-walkthrough` | task-level novice simulation — deep dive on one flow |
| `information-architecture` | organization / labeling / navigation / search |
| `design-review` | visual craft: type, color, spacing, hierarchy |
| `audit-rethink` | IxDF holistic 360° + redesign proposals — the broadest single lens |
| `wcag-accessibility` | AA/AAA compliance (pairs with impeccable detector) |

Rules: methodology content is verbatim upstream (source commit pinned
above) with a provenance header per file; the router, triage table, and
composition presets are local additions. Copy the WHOLE `ux/` folder —
modes link relatively. The repo's other 7 skills
(gdpr/iso/owasp/nist/ai-assessment) are AI-governance audits, out of
scope for this bundle.

## References — `references/`

- `arvindand-ui-ux-design-SKILL.md` (+ REFERENCES.md, LICENSE) from
  **arvindand/agent-skills @ 70a0bcb (MIT)** — **reference only, never
  install live**: upstream frontmatter carries a `hooks.Stop` prompt-hook
  that auto-fires on UI tasks; stripped in this copy. Kept for its
  aesthetic-direction + anti-generic-AI-output guidance.

## Evaluated and rejected (2026-10-30)

- **uxuiprinciples/agent-skills** — no LICENSE (can't vendor legally);
  core taxonomy/flows behind paid uxuiprinciples.com API; JSON-only
  output (Jerry wants readable audit reports).
- **sergekostenchuk/ui-ux-agent-skill-system** (Apache) — 68-skill
  website-building factory (SEO, Figma bridges, launch orchestration);
  different product surface; overlaps impeccable + bmad.

## Install map (copy the `ux/` folder whole)

- ZCode (cross-agent share) + Claude Code: `~/.agents/skills/ux/` ✅
  2026-10-30 (the seven originals were removed after absorption — the
  module replaces them)
- openclaude: `~/.openclaude/skills/ux/` ✅ 2026-10-30 (same)

First real use: ChurchAfrica UI/UX audit 2026-10-30
(`docs/design/ui-ux-audit-2026-10-30.md`).
