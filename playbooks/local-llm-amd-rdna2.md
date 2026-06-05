# Local LLM — AMD RDNA2 Playbook

**GPU:** AMD Radeon RX 6800 XT — 16 GB VRAM (RDNA2)  
**CPU:** AMD Ryzen 7 5800X — 8 cores / 16 threads (Zen 3)  
**RAM:** 64 GB  
**Runtime:** llama.cpp v9310 (Vulkan backend, WinGet) — no ROCm, no Docker needed  
**Updated:** 2026-06-05  
**Status:** Tested ✓ — 14B loads in ~13s, GPU confirmed via Vulkan

---

## Binary

Already installed via WinGet — Vulkan-capable (v9310):

```
C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe
```

Shortcut path — add to PATH or use the script at `scripts/start-llama-server.bat`.

**Do not use Docker for AMD GPU on Windows.** `--gpus all` is NVIDIA-only. Vulkan runs natively on Windows without ROCm.

---

## Models

### Model A — Already downloaded (use now)

**Qwen3-14B Q4_K_M**  
Path: `C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf`  
VRAM: ~9 GB — full GPU inference, no tricks needed  
Speed: ~40-60 tok/s estimated

### Model B — MoE (download when ready)

**Qwen3-30B-A3B Q4_K_M** (35B total params, 3B active per token)  
HuggingFace: `bartowski/Qwen3-30B-A3B-GGUF` or `Qwen/Qwen3-30B-A3B-GGUF`  
Download: ~20 GB  
VRAM: ~5-6 GB for attention layers; experts in RAM (64 GB RAM covers this easily)  
Speed: ~35-50 tok/s estimated (vs video's 17 tok/s on 6 GB GTX 1060)

```bash
# Download (run in PowerShell or Git Bash)
pip install huggingface_hub
huggingface-cli download bartowski/Qwen3-30B-A3B-GGUF \
  --include "Qwen3-30B-A3B-Q4_K_M.gguf" \
  --local-dir "C:\Users\Username\models"
```

### Why MoE for security research

The 30B-A3B thinks in longer chains than 14B — better for multi-step reasoning (exploit analysis, CTF, protocol reversal, code audits). Running locally means no cloud provider logging your queries. No specific "hacker model" exists; capability = reasoning depth, and the MoE wins on complex tasks.

---

## Run Commands

### 14B — Simple (works now)

```bat
llama-server.exe ^
  --model "C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf" ^
  --host 0.0.0.0 ^
  --port 8033 ^
  -ngl 99 ^
  --ctx-size 32768
```

### 30B MoE — Full trick stack (after download)

```bat
llama-server.exe ^
  --model "C:\Users\Username\models\Qwen3-30B-A3B-Q4_K_M.gguf" ^
  --host 0.0.0.0 ^
  --port 8033 ^
  -ngl 999 ^
  --n-cpu-moe 12 ^
  --no-mmap ^
  --mlock ^
  --cache-type-k q8_0 ^
  --cache-type-v q8_0 ^
  --ctx-size 131072
```

**Flag explanations:**
- `-ngl 999` — all layers to GPU (attention etc; experts redirected by `--n-cpu-moe`)
- `--n-cpu-moe 12` — put 12 expert layers in RAM instead of VRAM; tune this up/down to balance speed vs context
- `--no-mmap` — load full 20 GB into RAM upfront (64 GB RAM handles this fine); eliminates disk reads mid-inference
- `--mlock` — pins RAM so OS never pages experts to disk; required for stable multi-day uptime
- `--cache-type-k/v q8_0` — 8-bit KV cache; nearly lossless, halves KV VRAM vs f16
- `--ctx-size 131072` — 128K context; increase or decrease to trade VRAM vs context

**TurboQuant** (`--cache-type-k turbo4 --cache-type-v turbo3`): available in a custom llama.cpp fork (see video source). The standard WinGet build uses `q8_0` which is the safe baseline. Try `turbo4`/`turbo3` — if the build supports it, you gain 256K context; if not, it errors out harmlessly.

---

## Tailscale Access

Port 8033 must be allowed through Windows Firewall for the Tailscale interface:

```powershell
# Run once in elevated PowerShell
New-NetFirewallRule `
  -DisplayName "llama-server Tailscale" `
  -Direction Inbound `
  -Protocol TCP `
  -LocalPort 8033 `
  -Action Allow `
  -InterfaceAlias "Tailscale"
```

After that, any Tailnet device can reach the API at:

```
http://100.102.126.128:8033/v1/chat/completions
```

In Hermes agents: set `OPENAI_BASE_URL=http://100.102.126.128:8033/v1`

---

## Video vs Your Hardware

| Factor | Video (GTX 1060) | Your PC (RX 6800 XT) |
|--------|-----------------|----------------------|
| VRAM | 6 GB | 16 GB |
| CPU | i3 8100 (4c/4t) | Ryzen 7 5800X (8c/16t, Zen 3) |
| RAM | 24 GB | 64 GB |
| PCIe | Gen 3 | Gen 4 (5800X platform) |
| `--n-cpu-moe` needed | 35-36 | 10-15 (more experts on GPU) |
| `--mlock` risk | Would evict under pressure | No risk — 44 GB free after model |
| Expert RAM fetch speed | Limited by old DDR4 + i3 | Fast — Zen 3 memory controller |
| Speed estimate | 17 tok/s | 40-60 tok/s |
| Max context (q8_0) | 64K | 131K+ |
| Max context (turbo quant) | 256K | 256K+ |

---

## Tuning Guide

If you want **more speed**: lower `--n-cpu-moe` (e.g. 8) — more experts on GPU = fewer PCIe transfers  
If you want **more context**: raise `--n-cpu-moe` (e.g. 18) — frees VRAM for KV cache  
If the server **OOMs at startup**: raise `--n-cpu-moe` by 2-3 until it loads  

---

## Health Check

```bash
curl http://localhost:8033/health
# Expected: {"status":"ok"}

# Test inference
curl http://localhost:8033/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"local","messages":[{"role":"user","content":"Hello"}],"max_tokens":50}'
```
