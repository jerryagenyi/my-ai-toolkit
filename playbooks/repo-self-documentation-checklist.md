# Repo self-documentation checklist

Companion to AI-044 (`practices/active/agents-2026-10-21.md`). Run this once when
bootstrapping a new repo, and again as a periodic audit item on an existing one —
it answers "does this repo actually have the three things AI-044 asks for, or
just a plan to have them."

Unlike a per-feature practice check (does THIS endpoint/schema change comply),
this is a per-repo existence check: does the repo have the foundational pieces
at all, regardless of which feature you're touching today.

## The three checks

- [ ] **Header docblock convention exists and is followed.** Pick a handful of
  files across layers (a controller, a store, a config file with non-obvious
  keys) and confirm each has: what it is, why (only if not obvious from the
  code), special considerations. None of them should contain a hand-written
  dependency/linkage list — if one does, that's the AI-044 rot vector already
  starting; flag it, don't let it spread by example.
- [ ] **A decision-record directory exists and has at least one real entry.**
  Not "we'll start this when a big decision comes up" — if the repo has shipped
  anything non-trivial, a decision has already been made that deserves one.
  Use this database's own `decision-record-template.md`, not an ad-hoc format.
  Zero entries after the repo has real functionality shipped is a fail, not a
  "not yet."
- [ ] **A dependency graph is generated, not narrated, and at least one rule is
  CI-enforced.** For PHP: deptrac with a real layer rule (e.g. the HTTP layer
  may not import the persistence layer directly). For JS/TS: dependency-cruiser
  or madge with at least one rule beyond "no circular dependencies" (that one's
  nearly free and worth having too, but it's not the point — the point is an
  architectural boundary that would actually catch a real mistake). A graph
  tool installed but not wired into CI doesn't count; nothing stops the rule
  from being violated silently.

## What "pass" looks like

All three present and current (the decision-record directory has an entry for
anything recently shipped that was actually a judgment call, not just a
default). A repo that passes all three can safely add the pre-edit
"neighborhood report" skill (AI-044's How section) on top — doing that before
the graph is real just packages a narration of something that doesn't exist
yet.

## What commonly fails here

- Header docblocks that drift into "used by X, Y, Z" the moment a second
  author touches the file — the single most common way this checklist starts
  failing after initially passing. Treat it as a review-time smell, not just a
  one-time audit item.
- A decision-record directory that exists but is empty, or has entries with no
  "Breaks if" / "Revisit when" — a decision record without a falsifiable
  trigger is just a diary entry, not a tool anyone will act on later.
- A dependency-graph tool that's in `package.json`/`composer.json` as a dev
  dependency but has no CI step calling it — "we have the tool" is not "we
  enforce the rule."
