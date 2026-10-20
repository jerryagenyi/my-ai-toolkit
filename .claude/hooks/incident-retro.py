#!/usr/bin/env python3
"""Stop-hook: troubleshooting retrospective check.

Guard rail, not a lock: on each Stop event, cheaply scan this turn's
transcript tail for signals that the work just done was troubleshooting a
bug/failure/regression. If found, and INCIDENT_LOG_PATH wasn't itself
touched this turn, block the stop and ask the agent to decide whether a
new or updated incident-log entry is warranted before actually finishing.

Logging the FAILED attempts (what was tried, why it seemed reasonable, why
it didn't work) is the point — not just the fix that worked. See
issues/incident-log-template.md for the entry shape this feeds.

False positives (nudged on a turn that wasn't really troubleshooting) are
cheap: the agent reads the question, answers "not applicable," done. False
negatives (a real incident that never gets logged) are the expensive
failure mode this hook exists to reduce, so the signal list is
intentionally broad rather than precise.

Setup: copy this file into your project's .claude/hooks/, set
INCIDENT_LOG_PATH below to your project's actual log path (relative or
absolute, just needs to be a substring that would appear if the file were
mentioned/edited this turn), and wire it into .claude/settings.json's
"Stop" event — see .claude/hooks.json.example in this toolkit.
"""

from __future__ import annotations

import json
import re
import sys

# Adjust to your project's actual incident-log location.
INCIDENT_LOG_PATH = "incident-log.md"

SIGNAL = re.compile(
    r"\bfix\(|\bbug\b|\bregression\b|root cause|red ci|\bfailed\b|"
    r"\brevert(?:ed)?\b|\brollback\b|\b40[0-9]\b|\b50[0-9]\b|\btimeout\b|"
    r"stack trace|exception|traceback|\bincident\b|"
    r"doesn't work|didn't work|wrong (?:result|value|instant|date)",
    re.IGNORECASE,
)

TAIL_LINES = 80


def main() -> int:
    try:
        payload = json.loads(sys.stdin.read() or "{}")
    except Exception:
        return 0

    transcript_path = payload.get("transcript_path")
    if not transcript_path:
        return 0

    try:
        with open(transcript_path, "r", encoding="utf-8", errors="ignore") as f:
            lines = f.readlines()
    except Exception:
        return 0

    tail = "".join(lines[-TAIL_LINES:])

    # Already touched the log this turn (or explicitly discussed it) --
    # assume handled, don't nag.
    if INCIDENT_LOG_PATH in tail:
        return 0

    if not SIGNAL.search(tail):
        return 0

    print(json.dumps({
        "decision": "block",
        "reason": (
            "Before finishing: was this turn troubleshooting a bug, test "
            "failure, or regression? If so, check your incident log -- "
            "does it already cover this, or does what was just tried "
            "(including anything that DIDN'T work and why) belong there as "
            "a new or updated entry? Add it now if so. If this wasn't "
            "actually troubleshooting, say so explicitly and finish normally."
        ),
    }))
    return 0


if __name__ == "__main__":
    sys.exit(main())
