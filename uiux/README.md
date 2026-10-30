# UI/UX audit skill suite (vendored)

Seven audit lenses adopted as THE ui/ux audit bundle, plus one
reference-only doc. Joint decision 2026-10-30 by ZCode + Claude Code
(Jerry-approved process: adopt one repo or curate a bundle).

## Canonical copies — `skills/`

From **mastepanoski/claude-skills @ ac30238 (MIT — see
`LICENSE-mastepanoski`)**, copied whole (each folder = SKILL.md +
references/, they link relatively — never copy SKILL.md alone):

| Skill | Lens |
|---|---|
| `ux-nielsen-heuristics` | 10 usability heuristics — the default sweep |
| `ux-don-norman-principles` | 7 HCD principles (discoverability, affordances, feedback…) |
| `ux-cognitive-walkthrough` | task-level novice simulation — deep dive on one flow |
| `ux-information-architecture` | organization / labeling / navigation / search |
| `ux-design-review` | visual craft: type, color, spacing, hierarchy |
| `ux-audit-rethink` | IxDF holistic 360° + redesign proposals — entry point |
| `ux-wcag-accessibility` | AA/AAA compliance (pairs with impeccable detector) |

The 7 cross-reference each other as complementary lenses (heuristics vs
task-simulation vs structure vs visual vs holistic). The repo's other 7
skills (gdpr/iso/owasp/nist/ai-assessment) are AI-governance audits,
out of scope for this bundle.

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

## Install map (copy folders whole)

- Claude Code: `~/.claude/skills/` ✅ 2026-10-30
- ZCode (cross-agent share): `~/.agents/skills/` ✅ 2026-10-30
- openclaude: `~/.openclaude/skills/` ✅ 2026-10-30 (project-level runs
  also pick up repo `.claude/skills` via the `.openclaude/skills`
  junction convention)

First real use: ChurchAfrica UI/UX audit 2026-10-30
(`docs/design/ui-ux-audit-2026-10-30.md`).
