# Index — What's Curated Here & the Front Burner

> The map of this repo plus the standing checklist of things worth attention. Skim this
> when returning to the repo; refresh the Front Burner when priorities shift.
> Last reviewed: 2026-10-28.

## Content map

### Local AI development — the active hub

| Where | What |
|---|---|
| `local-llm/` | llama.cpp serving toolkit on this PC (Windows/Vulkan): install guide, model table (Qwen3-14B, Gemma4-12B, Qwen3.6-35B MoE), one-click `.bat` scripts, LAN/API serving on :8033 |
| `local-llm/hardware-targets.md` | Rig reality, VRAM-tier table, upgrade ladder (floor = used 3090 → ideal = 2× RTX PRO 6000 192 GB), what *not* to buy |
| `local-llm/cloud-gpu-options.md` | Rent CUDA instead of buying it: Kaggle (free ~30 GPU-h/wk), RunPod, vast.ai, Colab — mapped to our blocked experiments |
| `local-llm/experiments.md` | Measured-results log + open experiment ideas |
| `sources/videos/` | Canonical deep captures from local-AI creators (Codacus ×2 so far) — see its README for the captured→distilled lifecycle |
| `playbooks/local-llm-amd-rdna2.md` | AMD RDNA2-specific local-LLM playbook |

### Build foundation — how we build software

| Where | What |
|---|---|
| `foundation/stacks/` | Preferred stacks (Next.js, Laravel+Vue, other) + decision tree |
| `foundation/tools/` | Approved tools (MCP servers, security scanning, AI pentesting agents) |
| `foundation/scaffolds/` | Project-init template/checklist |
| `foundation/conventions/` | Security, philosophy, coding conventions |

### Jev — decision-model layer (installed 2026-10-28)

| Where | What |
|---|---|
| `jev/README.md` | Implementation doc: what Jev (TypeSafe decision model) is, what each of the 14 skills is used for, install map (Claude Code / ZCode / Claude Desktop / `jg` + `jev` CLIs), auth, update/uninstall |
| `jev/skills/` | Canonical vendored copies: 13 `jev-*` skills (hermes-jev-skills `8316358`) + `jevgrep` (jevgrep `9971e04`) |
| `jev/claude-code/` | Lane subagents (`jev-lane-small/medium/high/escalate`) + managed CLAUDE.md block |
| `jev/claude-desktop/` | `jev-skills.zip` upload bundle + INSTALL steps |
| `AGENT.md` | Agent-facing rules: when to use `jg` repo search, browser/computer step-picking, triage, lane routing |

### Knowledge pipeline (convention)

Radar (perishable: releases, shorts) → **Google Keep**, never the repo. An item is
promoted to a repo only when (a) actionable for a project → one line in that project's
docs, or (b) deep-dived → a capture in `sources/videos/`. Deep notes are canonical here;
project repos (ls2 etc.) keep thin pointers + project-specific takeaways.

### Root docs

`README.md` (vision/structure) · `AGENT.md` (agent working notes) · `IDEAS.md` (strategy) · `QUICKSTART.md` ·
`Role-Modelname-...csv` (model picks) · `docs/` (legacy) · `.claude/` (agent skills)

### Empty by design (fill when needed)

`principles/` · `issues/` · `playbooks/` (beyond the one above) · `evaluators/` · `mcp/` ·
`schemas/` · `sources/{articles,notes,threads}`

---

## Front burner

- [ ] **Benchmark the current rig** — fill the backfill table in `local-llm/experiments.md` (t/s for the 3 scripted models; `--n-cpu-moe` sweep on the 35B; KV-cache `q8_0` vs `q4_0` max-context)
- [ ] **First cloud-GPU session** — Kaggle notebook (free): Whistle STT vs whisper-base, or KittenTTS 2 / Phonon-2; RunPod if a ComfyUI/Flux trial
- [ ] **Micro-turn LoRA attempt** — Codacus recipe fits Kaggle's weekly quota; script lives in the capture at `sources/videos/2026-10-14-codacus-microturn-full-duplex-voice-ai.md`
- [ ] **Keep watching** Codacus + theAIsearch — radar in Keep; promote via the pipeline above
- [ ] **Hardware gate** — no GPU purchase until a project demands *daily* CUDA or 24/7 big-model serving; rent first (`cloud-gpu-options.md`)

*Review cadence: glance when opening the repo; full refresh monthly or after any capture lands.*
