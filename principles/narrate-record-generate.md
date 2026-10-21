# Narrate the what, record the why, generate the graph

Distilled 2026-10-21 from a real project (ChurchAfrica) after asking whether
files should carry hand-written "what depends on this" comments. Promoted to
`devops/practices` as AI-044 — this file is the one-line pointer for this
toolkit; the full practice (Why/How/Watch-out) lives there.

**The principle:** a file header docblock narrates what the code can't say
about itself (what it is, why it's shaped this way, non-obvious constraints)
— but never a dependency/linkage list. Significant decisions get one
immutable record each (`issues/incident-log-template.md`'s sibling concept
for decisions rather than bugs — see the decision-record-template in
`devops/practices/playbooks/`). Anything mechanically derivable from the
code — what imports this, what this imports — is generated on demand
(deptrac for PHP layers, dependency-cruiser/madge for JS/TS graphs), never
hand-maintained, because hand-written linkage lists rot the moment either
side changes and then actively mislead.

**Bootstrap checklist:** `devops/practices/playbooks/repo-self-documentation-checklist.md`
— the concrete "does this repo actually have these three things" check, run
once at project init and periodically after (see `foundation/scaffolds/
project-init.md`).
