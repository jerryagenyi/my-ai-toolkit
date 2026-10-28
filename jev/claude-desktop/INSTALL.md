# Claude Desktop — Jev skills install

Claude Desktop has no local skills folder — skills are uploaded and sync through your
Claude account (Pro/Max).

1. Open **Claude Desktop → Settings → Capabilities** (or claude.ai → Settings).
2. Enable **"Code execution and file creation"** (skills require it).
3. Upload `jev-skills.zip` (this folder) — or select this repo's `jev/skills/` folder if the
   UI offers folder upload.
4. Start a new chat and confirm the skills appear (ask: "what skills do you have?").

Notes:

- Desktop skills run against files you attach/share in the chat; the `jev` CLI shims and
  `jg` installed on this PC are **not** visible to Claude Desktop's sandbox. The
  `jev-search`, `jev-memory`, `jev-mailbox`, `jev-compaction`, `jev-skill-select` skills
  work on content you paste/attach; browser/computer-use skills apply when Desktop's own
  computer-use features are enabled.
- Re-upload after updating skills in `../skills/`.
