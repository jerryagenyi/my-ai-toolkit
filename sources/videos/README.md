# Video Captures

One file per video, named `YYYY-MM-DD-slug.md`, with frontmatter (`id`, `type`,
`url`, `captured_at`, `status`). Deep research notes from local-AI creators —
Codacus, theAIsearch, and others.

Lifecycle: `status: captured` when the note lands here → `status: distilled`
when its knowledge has been applied somewhere (e.g. `local-llm/` playbook
entries) — note where in the file's frontmatter or index row below.

Project-specific implications (e.g. "how this applies to ls2 / Lanstreamer 2")
stay in the *project* repo as a short pointer note linking back to the capture
here. This directory is the central, project-agnostic knowledge base.

| Date | Video | Creator | File | Status |
|---|---|---|---|---|
| 2026-06-05 | Run 35B MoE on a 6 GB GPU — llama.cpp 5 tricks | Codacus | [2026-06-05-llama-cpp-moe-tricks.md](2026-06-05-llama-cpp-moe-tricks.md) | distilled → `local-llm/` |
| 2026-10-14 | Full-duplex voice AI on a local 35B LLM (micro-turns, Qwen3.6-35B LoRA) | Codacus | [2026-10-14-codacus-microturn-full-duplex-voice-ai.md](2026-10-14-codacus-microturn-full-duplex-voice-ai.md) | captured (ls2 pointer: `ls2/codacus-insights/`) |
