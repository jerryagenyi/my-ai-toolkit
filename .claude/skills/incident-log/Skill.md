---
name: Incident Log
description: Maintain a per-project incident log of bugs/regressions, tracking failed attempts (not just the fix) to prevent re-treading the same wrong hypothesis. Use when troubleshooting any bug/failure/regression, or when the Stop-hook retrospective check asks whether this turn's work belongs in the log.
---

# Incident Log — track what was tried, not just what worked

Companion to `issues/incident-log-template.md` (the entry format) and
`.claude/hooks/incident-retro.py` (the Stop-hook nudge). Discovered live
2026-10-20 while working an unrelated project: a bug took five separate
fix-attempts across several days because each fix solved the specific symptom
visible at the time without anyone writing down the general rule until the end —
classic whack-a-mole. This skill exists to make that cheaper to avoid.

## When to use

- Before forming a hypothesis about any bug, regression, or "this used to work"
  report — search the project's incident log FIRST for the symptom or subsystem.
  Re-trying something that already failed wastes a round-trip that's already been
  paid for.
- When the Stop-hook (`incident-retro.py`) blocks and asks whether this turn's
  work belongs in the log.
- Whenever an incident is actually resolved — add the entry in the SAME commit as
  the fix, not as a follow-up someone forgets to do.

## What goes in an entry vs. what doesn't

A one-shot bug (found it, fixed it, verified, done) does NOT need a full entry —
that's just normal work. This log is for incidents that took MORE THAN ONE
genuine attempt, where an earlier fix seemed to work and then didn't, or where a
plausible-but-wrong hypothesis was seriously pursued before the real cause
surfaced. If you're not sure, the test is: would a future session, hitting the
same symptom, benefit from knowing what was already tried and ruled out? If yes,
log it.

## Procedure

1. Read `issues/incident-log-template.md` for the exact entry shape (numbered
   attempts, each with hypothesis / why it seemed reasonable / why it failed; the
   fix that worked and why; an "if this resurfaces" line written for someone with
   2 minutes and zero context).
2. Write the entry with real evidence — commit hashes, error text, specific
   file:line references. A vague "something was probably tried before" entry is
   worse than no entry.
3. Give the failed attempts EQUAL narrative weight to the fix that worked. The
   failed attempts are the part that actually prevents regression.
4. Commit the log update in the same commit as the fix (or the same PR, if the
   project's workflow uses PRs).

## The hooks that enforce this loosely

- `SessionStart`: a reminder to check the log before investigating anything.
- `Stop` (`incident-retro.py`): scans each turn's transcript tail for
  troubleshooting signals (fix(, bug, regression, root cause, red CI, 4xx/5xx,
  timeout, exception, etc). If found and the log wasn't touched this turn, blocks
  the stop and asks whether an entry is warranted. Guard rail, not a lock — false
  positives just get answered "not applicable."

See `.claude/hooks.json.example` for wiring both into a new project's
`.claude/settings.json`.
