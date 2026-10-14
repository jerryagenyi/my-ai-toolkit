# Local LLM Experiments Log

Hands-on experiments on this PC — what was tried, with which flags, and what it actually
did. This log records **measured reality** (the slowest-decaying knowledge we own — nobody's
YouTube benchmark replaces it). Update [hardware-targets.md](hardware-targets.md) when an
experiment changes what we know the rig can do.

Entry format — keep it to a few lines each:

```markdown
## YYYY-MM-DD — Short title
- **What:** model / tool / technique, and the goal
- **Flags:** the exact llama.cpp or tool flags that mattered
- **Result:** t/s or latency, VRAM/RAM used, load time — numbers, not vibes
- **Verdict:** keep / drop / retry when X changes
```

Rules of thumb: one entry per session; note the GPU driver/version only when it misbehaves;
record failures too — they define the rig's limits.

---

## Backfill — known configurations (numbers to fill in next run)

Configs already scripted in this folder but not yet benchmarked with recorded numbers:

| Config | Notes | t/s / latency |
|---|---|---|
| Qwen3-14B Q4_K_M, 128K ctx, all layers GPU | daily driver | _fill in_ |
| Gemma4-12B Q4_K_M, `--jinja` | | _fill in_ |
| Qwen3.6-35B-A3B Q4_K_M, `--n-cpu-moe` split | ~5 GB VRAM + ~17 GB RAM, ~45 s load | _fill in_ |

## Open experiment ideas (from the radar)

Priorities when hands-on time appears — link the source capture when one exists:

- Micro-turn duplex loop per Codacus recipe — needs CUDA (see `sources/videos/2026-10-14-codacus-microturn-full-duplex-voice-ai.md`); **runnable now on Kaggle/RunPod** ([cloud-gpu-options.md](cloud-gpu-options.md)), no hardware purchase required
- Whistle STT vs whisper base (claimed better) — ls2-relevant, CPU-runnable today
- KittenTTS 2 / Phonon-2 — small, try today (local CPU or Kaggle)
- KV-cache quant sweep (`q8_0` vs `q4_0`) on the 35B — max context before spill?
- `--n-cpu-moe` sweep on the 35B — t/s vs VRAM split curve for this exact card
- ComfyUI / Flux-class image-gen trial — RunPod one-click template, first cloud-GPU session candidate
