# Local-AI PC — Target Specs & Upgrade Path

> A reminder note, not a purchase order. Distilled 2026-10-14 from: measured results in
> this repo, the ls2 design doc (§9 minimum requirements), the Codacus captures in
> `sources/videos/`, and Jerry's upgrade notes taken at different moments — which ranged
> from reality-checked ("used RTX 3090") to max-ambition ("2× RTX PRO 6000, 192GB VRAM").
> Those aren't contradictions; read them as the **floor and the ceiling of the same axis**.
> Nothing here is a decision — focus shifts as knowledge grows.

---

## Where I am — measured, not guessed

| Component | Spec | Local-AI consequence |
|---|---|---|
| GPU | AMD RX 6800 XT — 16 GB | **Vulkan only.** No CUDA (NVIDIA), no ROCm on Windows. llama.cpp inference works great; PyTorch training, ComfyUI, CTranslate2 GPU, most diffusion tooling = CUDA-first → effectively blocked |
| CPU | Ryzen 7 5800X (8c/16t, AVX2) | Fine. MoE experts in RAM, tokenisation. CPU is never the bottleneck worth spending on |
| RAM | 64 GB DDR4 | The star of the current rig — enables `--n-cpu-moe` offload of the 35B MoE (~17 GB in RAM) |
| PSU | Corsair CX 750 (budget tier) | Blocks any big-GPU add — see PSU note below |
| Board | B550 (PCIe 4.0 x16) | A used RTX 3090 runs fine in this slot — the AM4 box does **not** need replacing for the floor target |
| Storage | 1 TB NVMe | Tight — each model is 5–25 GB. Second NVMe for models is cheap capability |

**What it runs today** (from the scripts in this folder): Qwen3-14B Q4 @ 128K ctx (~14 GB
VRAM), Gemma4-12B Q4 (~12 GB), Qwen3.6-35B-A3B Q4 MoE (~5 GB VRAM + ~17 GB RAM, ~45 s load).
The ls2 voice pipeline (faster-whisper small, Opus-MT, Piper) runs **CPU-only** because
CTranslate2's GPU path is CUDA-only.

**What it can't do** — the actual gap: LoRA/QLoRA training (Codacus's micro-turn recipe
needs CUDA), local image/video generation (Flux/ComfyUI class), 32B+ dense models
comfortably, large model + large context simultaneously. Most of the CUDA-blocked items can
be **rented instead of bought** — see [cloud-gpu-options.md](cloud-gpu-options.md).

---

## The one rule

**VRAM is the currency of local AI. RAM is the MoE runway. NVIDIA buys ecosystem breadth.**

- Rule of thumb: Q4_K_M ≈ 0.6 GB per billion params (+ KV cache, which grows with context).
  14B → ~9 GB · 32B → ~19 GB · 70B → ~42 GB · 100B MoE → ~60 GB.
- MoE models only activate a few % of weights per token, so `--n-cpu-moe` trades speed for
  RAM instead of VRAM — that's how a 16 GB card serves a 35B model today.
- Everything beyond llama.cpp inference (training, diffusion, Whisper GPU paths) assumes
  CUDA. An AMD card caps you at "serve quantised text models well" — which the current rig
  already does.

| VRAM tier | Unlocks (Q4-ish) |
|---|---|
| 12 GB | 14B dense tight; 35B MoE offloaded (Codacus's 3060 demo) |
| **16 GB (now)** | 14B + 128K ctx; 35B MoE via RAM offload; Flux-class image gen tight |
| **24 GB — the floor** | 32B dense; 35B MoE fully on GPU; QLoRA training 7–14B; Flux comfortable; full duplex voice stack (STT + 35B LLM + TTS concurrent) |
| 32 GB | 32B at Q6/Q8; 70B Q4 with partial offload |
| 96 GB | 70B Q8; 100B+ MoE Q4 fully resident |
| 192 GB | ~200B+ MoE class (Q3/Q4); frontier open weights at practical quants; huge context |

---

## The target ladder

### 1. The Floor — "run the bulk of what we've always wished to try"

**Used RTX 3090 24 GB + 64→128 GB RAM + a quality 850–1000 W PSU, in the current AM4 box.**

- The £741 Gainward 3090 note was the reality-checked version of this — it's the right call.
- Unlocks, mapped to the wishlist: CUDA (LoRA training, ComfyUI, Flux 3 image), 32B dense
  serving, 35B MoE fully on GPU (faster + full context), full local duplex voice stack for
  the Lanstreamer-2 direction (GPT-Live/Moshi/PersonaPlex-class experiments, incl.
  training a micro-turn LoRA per Codacus's recipe), KittenTTS/Whisper/Phonon-2 experiments
  with room to spare.
- Doesn't unlock: 70B dense comfortable, heavy local video gen (Flux 3 Video class) — those
  wait for tier 2/3, or accept offload slowness.
- **PSU caveat:** a 3090 spikes well above its 350 W TDP; the CX 750 is a budget unit.
  Budget the PSU replacement into the same purchase — this is the silent constraint.
- Keep the RX 6800 XT as a second display/inference card if convenient; llama.cpp mixes
  Vulkan + CUDA backends fine for *serving* (training wants matched cards).

### 2. Comfortable — RTX 5090 32 GB (± the 3090 as helper)

70B Q4 with partial offload, 32B at high quant, video-gen experiments become possible.
New AM5 platform starts making sense here mainly for RAM ceiling and PCIe lanes.

### 3. The Ideal — 2× RTX PRO 6000 Max-Q (96 GB each = 192 GB VRAM) + 256 GB RAM

The max-ambition note, and it holds up: X870E + Ryzen 9 + 1600 W PSU (two native 12V-2x6)
+ Define 7 XL. Runs essentially everything open-weights at practical quants, 70B at Q8,
100B+ MoE resident, large-context work without cache anxiety. Max-Q variant because 300 W
cards fit standard tower cooling. This is the "stop wishing" machine — buy it when a real
project demands it, not before.

### What NOT to spend on

- **The old 7900X + RX 7900 XTX plan** — that's the gaming-era plan. XTX adds zero CUDA;
  it repeats the current AMD ceiling with more VRAM. Every local-AI-era note correctly
  drifted to NVIDIA.
- **CPU/platform upgrades for inference speed** — buys almost nothing. Memory bandwidth
  helps CPU-offloaded layers; a 5800X already feeds them fine.
- ls2's own floor (§9 of its design doc) — 8 GB VRAM / 16 GB RAM / AVX2 quad-core — is the
  *event-team-machine* floor, a different axis from this experimentation rig.

---

## Upgrade order (when it happens)

0. **First, rent:** before any purchase, check [cloud-gpu-options.md](cloud-gpu-options.md) — Kaggle's free GPU quota alone covers occasional training runs; buying makes sense only for daily-use convenience, 24/7 serving, or privacy needs
1. GPU: used 3090 24 GB
2. PSU: quality 850–1000 W (same time as the GPU)
3. RAM: 64 → 128 GB (doubles the MoE runway; also helps 70B offload experiments)
4. Storage: second 2–4 TB NVMe for models
5. Platform rebuild (X870E etc.) only at tier 2/3

Related: [experiments.md](experiments.md) — log what each rig actually achieves; the
measured numbers here should be updated as experiments land.
