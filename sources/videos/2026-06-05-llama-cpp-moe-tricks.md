---
id: SRC-VIDEO-LLAMA-CPP-MOE-2026
type: youtube
title: "5 Tricks to Run a 35B MoE on a 6 GB GPU"
url: https://www.youtube.com/watch?v=8F_5pdcD3HY
captured_at: 2026-06-05
model: Qwen3.6-35B-A3B (35B total, 3B active per token — MoE)
hardware_in_video: GTX 1060 6 GB + i3 8100 + 24 GB DDR4
status: distilled
---

# Video: Run 35B MoE on a 6 GB GPU — llama.cpp 5 Tricks

## Core insight

MoE models (Mixture of Experts) have most of their weight in "sleeping" expert blocks that only a few activate per token. The smart split is: put the small always-firing attention layers on GPU, pin the large sleeping experts in CPU RAM. This is more efficient than naively splitting layers 50/50.

## The 5 flags (in order of impact)

### 1. `--n-cpu-moe N` — MoE expert offload to CPU RAM

```bash
--n-cpu-moe 41   # all expert layers to CPU
--n-cpu-moe 35   # 35 to CPU, 6 on GPU (saves VRAM for context)
```

**Effect on 6 GB GPU:** 3 tok/s → 10 tok/s (230% speed jump, no hardware change)  
**Why it works:** The bulk of the model (experts) sits in RAM. Per token, the GPU fetches whichever 8 of 256 experts are needed. The attention layers that fire constantly stay on GPU.

### 2. `--no-mmap` — load model into RAM upfront

By default llama.cpp lazily pages model chunks from disk. With a MoE model and experts in RAM, page faults on cold experts cause mid-inference stalls.

```bash
--no-mmap
```

**Effect:** 10 → 13.5 tok/s (~35% bump). Requires enough RAM for the full model (~20 GB for 35B Q4_K_M).

### 3. Tune `--n-cpu-moe` lower — put some experts back on GPU

After `--no-mmap`, VRAM headroom appears. Pulling 6 expert layers back from CPU to GPU reduces PCIe transfers.

```bash
--n-cpu-moe 35   # was 41, now 35
```

**Effect:** 13.5 → 17 tok/s. Trade-off: less VRAM for KV cache (context shrinks from 100K to 64K at default precision).

### 4. `--cache-type-k turbo4 --cache-type-v turbo3` — TurboQuant KV cache

Google DeepMind paper: random rotation before aggressive quantization preserves quality at 4-bit keys / 3-bit values. The asymmetry (`turbo4` keys, `turbo3` values) is because grouped query attention means keys can absorb heavier compression.

```bash
--cache-type-k turbo4 --cache-type-v turbo3
```

**Effect:** no speed change — same 17 tok/s. But context jumps 64K → 256K on same VRAM.  
**Note:** Requires the TurboQuant fork of llama.cpp, not the standard build. Standard build alternative: `q8_0` (lossless) or `q4_0` (some quality loss).

### 5. `--mlock` — pin experts in RAM, prevent OS eviction

Without mlock, after hours of uptime the OS pages cold experts to disk. Inference stutters randomly. Must be enabled in 3 places: Docker (`--cap-add=IPC_LOCK`), LXC (`lxc.prlimit.memlock: unlimited`), llama.cpp flag.

```bash
--mlock
```

**Effect:** no speed change at fresh boot (experts already cached). Prevents day-3 degradation. Required for production stability.

## What didn't work: speculative decoding

Adding an 800M draft model (Qwen3 0.8B) for speculative decoding dropped speed from 17 → 11 tok/s. Reason: MoE expert loading dominates per-token cost, and SSM (state space) layers can't be parallelized across draft windows. Speculative decoding is designed for dense transformers. Skip it for MoE models.

## Final command from video (Docker + NVIDIA)

```bash
docker run --rm -it --gpus all \
  --cap-add=IPC_LOCK \
  -v ./models:/models \
  ghcr.io/ggml-org/llama.cpp:server-cuda \
  -m /models/qwen3-35b-a3b.gguf \
  -ngl 999 \
  --n-cpu-moe 35 \
  --no-mmap \
  --mlock \
  --cache-type-k turbo4 --cache-type-v turbo3 \
  -c 262144 \
  --host 0.0.0.0
```

**For AMD on Windows:** replace with native Vulkan binary — see `playbooks/local-llm-amd-rdna2.md`.
