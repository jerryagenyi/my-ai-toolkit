# Local LLM — Setup Hub

Run AI models fully offline on your own machine. No cloud, no API keys, no query logging.

**Runtime:** llama.cpp (Vulkan/AMD) — installed via WinGet  
**API:** OpenAI-compatible on `http://localhost:8033/v1`  
**Last verified:** 2026-06-05

---

## Your Hardware

| Component | Spec |
|-----------|------|
| GPU | AMD Radeon RX 6800 XT — 16 GB VRAM |
| CPU | AMD Ryzen 7 5800X — 8 cores / 16 threads |
| RAM | 64 GB |
| Backend | Vulkan (no ROCm, no Docker needed) |

---

## Models

| Model | Status | Size | Best for |
|-------|--------|------|----------|
| Qwen3-14B Q4_K_M | ✅ Ready | ~9 GB VRAM | Daily use, coding, Q&A |
| Qwen3-30B-A3B Q4_K_M | ⬇ Download when ready | ~20 GB (in RAM) | Complex reasoning, security research |

Model files location:
- Qwen3-14B: `C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\...`
- Qwen3-30B MoE: `C:\Users\Username\models\Qwen3-30B-A3B-Q4_K_M.gguf` (after download)

---

## Files in This Folder

| File | Purpose |
|------|---------|
| `quickstart.md` | **Start here** — run a model, start/stop server, switch models |
| `workflow.md` | Use the API — curl, Python, Hermes agents |
| `start-server.bat` | **Run this** to start the model server |
| `download-model.bat` | Download the MoE model when you're ready |
| `add-firewall-rule.bat` | One-time setup: open port 8033 on Tailscale (triggers UAC prompt) |

---

## llama.cpp Binary

```
C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe
```

Version: 9310 (Vulkan-enabled). Update with: `winget upgrade ggml.llamacpp`
