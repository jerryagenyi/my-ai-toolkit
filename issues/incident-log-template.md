# Incident log — gotchas, false fixes, and what actually worked

Copy this file into a new project as `docs/incident-log.md` (or wherever your
project keeps technical docs) and start filling it in as real incidents happen.
Adjust `.claude/hooks/incident-retro.py`'s `INCIDENT_LOG_PATH` constant to match
wherever you put it.

**Purpose:** regression prevention. When the same class of bug resurfaces — often
discovered epics/sprints later, in a context that looks unrelated — this log should
answer "has this been tried before, and why did/didn't it work" before anyone
re-derives the same wrong hypothesis from scratch. Every entry records the FAILED
attempts with equal weight to the fix that worked, because the failed attempts are
what a future session needs to avoid repeating.

**Convention to adopt in your project's AGENTS.md / CLAUDE.md:**
> Before investigating any bug, regression, or "this used to work" report, read the
> incident log first. When an incident is resolved, add an entry in the same commit
> — don't just close a ticket/ledger row silently; the ticket says WHAT is fixed,
> this log says WHY the wrong fixes looked right at the time.

This is enforced loosely by two hooks (see `.claude/hooks.json.example`): a
`SessionStart` reminder, and a `Stop`-event check (`incident-retro.py`) that scans
each turn for troubleshooting signals and nudges a log entry if the log wasn't
already touched.

---

## Entry template

```markdown
## INCIDENT-NNN: <short name for the bug/gotcha>

**First seen:** <date/context>. **Resolved:** <date/commit, or "open" if still
unresolved — a disposition is also a valid outcome>. **Status:** resolved | open.

**Symptom:** what was actually observed — the error message, the test failure, the
user-visible behavior. Be concrete; "it was broken" isn't a symptom.

### Attempt 1 — <short label, e.g. "the wrong theory" or "the real first layer">
**Hypothesis:** what you thought was wrong.
**Why this seemed reasonable:** the actual evidence/reasoning at the time — this is
the part worth preserving even when the hypothesis was wrong, because the NEXT
person will have the same evidence and needs to know it led somewhere else.
**Fix (if one was attempted):** what was actually done.
**Why it didn't fully work:** what was still broken, and when/how that was
discovered. If this was a pure hypothesis never acted on, say so instead.

### Attempt 2 — ...
(repeat for as many rounds as it actually took — don't compress multiple genuinely
distinct attempts into one entry just to look tidier)

### Attempt N — the fix that actually worked
**Root cause:** the real mechanism, stated precisely enough that a future reader
doesn't have to re-derive it.
**Fix:** what changed, and where.
**Why this one worked:** the causal link between the fix and the symptom going away
— and how it was verified (not just "it looked fixed," but what was actually
checked).

**If this resurfaces:** what to check FIRST next time — the specific files,
mechanisms, or conditions, in priority order if there's more than one. This is the
single highest-value line in the entry; write it for someone who has 2 minutes and
zero context.

**Cross-references:** related tickets/issue-tracker IDs, commit hashes, related
incidents in this same log.
```

---

## Worked example (from a real project, trimmed)

```markdown
## INCIDENT-001: Dokploy deploy webhook — 403 on every CI run

**First seen:** story 4-2 (Dokploy auto-deploy). **Resolved:** CI run all green.
**Status:** resolved.

**Symptom:** GitHub Actions' deploy job POSTs to a webhook URL and gets
`curl: (22) The requested URL returned error: 403` on every retry.

### Attempt 1 (not acted on — hypotheses relayed secondhand, untested)
**Hypothesis:** three candidates floated without direct testing: wrong webhook URL,
wrong API-key scope, or a front-door rule blocking the CI runner's IP range.
**Why this seemed reasonable:** these are the three usual suspects for this class of
403 against a self-hosted PaaS, and nobody had tested the hostname directly yet.
**Why it would have failed if acted on:** none of the three could have mattered —
the request never reached the target's own auth/routing logic at all (see below).

### Attempt 2 (the real first layer, found and fixed)
**Investigation:** curled the webhook URL directly and followed redirects. Found
the hostname sitting entirely behind a Zero Trust SSO wall — every path
redirected to a login page. This explains the 403 independent of whether the
URL/scope was correct: CI can't complete an interactive SSO flow.
**Fix:** added a path-scoped bypass policy for the exact webhook path only.
**Why it still didn't fully work:** re-ran CI — still 403, identically. One blocker
cleared does not mean the symptom clears if more than one independent blocker
exists on the same path.

### Attempt 3 — the second layer
**Investigation:** found a separate, zone-wide bot-defense feature rejecting the
CI runner's non-browser user-agent from a datacenter IP — exactly why manual
testing from a laptop never reproduced it.
**Fix:** a path-scoped rule disabling that specific defense for the webhook path.
**Why it still didn't fully work:** one more run, still 403.

### Attempt 4 — the fix that actually worked
**Investigation:** a third, zone-wide bot-fight toggle, not path-scopable.
**Fix:** disabled it zone-wide (acceptable here — sensitive hosts sit behind the
SSO wall regardless).
**Why this one worked:** it was the last of three INDEPENDENT edge-level defenses
stacked on the same hostname. Clearing one or two still left a 403 from whichever
was left; only clearing all three let the request reach the target. Verified: CI
green, webhook responded with success, live smoke passed.

**If this resurfaces:** check all three layers in this order before assuming a new
cause — the SSO bypass is still scoped correctly, the path-scoped rule still
matches, the zone-wide toggle is still off. A 403 after any infra change should
re-check all three, not assume the first culprit found.
```

Note the shape: each failed attempt gets equal narrative weight to the fix that
worked, including WHY each wrong turn looked reasonable at the time. That's the
part that actually prevents regression — not the final fix alone.
