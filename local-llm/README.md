# Local LLM — Setup Hub

Run AI models fully offline on your own machine. No cloud, no API keys, no query logging.

**Runtime:** llama.cpp v9310 (Vulkan/AMD) — installed via WinGet  
**API:** OpenAI-compatible on `http://localhost:8033/v1`  
**Last verified:** 2026-06-06

---

## Your Hardware

| Component | Spec |
|-----------|------|
| GPU | AMD Radeon RX 6800 XT — 16 GB VRAM |
| CPU | AMD Ryzen 7 5800X — 8 cores / 16 threads |
| RAM | 64 GB |
| Backend | Vulkan (no ROCm, no Docker needed) |

---

## File Naming Convention

**Model-specific files** are named `<action>_<ModelName>.bat`. To use a different model:
1. Copy the file
2. Rename it to `<action>_<NewModelName>.bat`
3. Open it and update `MODEL_PATH`, `NGL`, `CTX`, and `EXTRA_ARGS` (instructions are inside each file)

**Model-agnostic files** have no model name in the filename — they work regardless of which model is loaded.

---

## Files

### Model-specific (one file per model)

| File | What it does |
|------|-------------|
| `start-server_<Model>.bat` | Start API server (visible terminal window — close to stop) |
| `start-server-background_<Model>.bat` | Start API server silently in background |
| `chat_<Model>.bat` | Terminal chat — no server needed (like `ollama run`) |
| `download-model_<Model>.bat` | Download that model from HuggingFace |

### Model-agnostic (always the same)

| File | What it does |
|------|-------------|
| `stop-server.bat` | Stop any running server, free VRAM |
| `status-server.bat` | Check if server is running, show active model |
| `add-firewall-rule.bat` | One-time setup: open port 8033 on Tailscale (triggers UAC) |

---

## Current Models

| Model | File suffix | Location | Size | VRAM usage |
|-------|-------------|----------|------|------------|
| Qwen3-14B Q4_K_M | `_Qwen3-14B-Q4_K_M` | HuggingFace cache | 9 GB | Full GPU |
| Qwen3.6-35B-A3B Q4_K_M | `_Qwen3.6-35B-A3B-Q4_K_M` | `C:\Users\Username\models\` | 22 GB | ~5 GB GPU + RAM |

---

## Quick Reference

| Goal | Run |
|------|-----|
| Chat in terminal (14B) | `chat_Qwen3-14B-Q4_K_M.bat` |
| Chat in terminal (35B MoE) | `chat_Qwen3.6-35B-A3B-Q4_K_M.bat` |
| Start API server visible (14B) | `start-server_Qwen3-14B-Q4_K_M.bat` |
| Start API server visible (35B MoE) | `start-server_Qwen3.6-35B-A3B-Q4_K_M.bat` |
| Start API server background (14B) | `start-server-background_Qwen3-14B-Q4_K_M.bat` |
| Start API server background (35B MoE) | `start-server-background_Qwen3.6-35B-A3B-Q4_K_M.bat` |
| Stop server | `stop-server.bat` |
| Check what's running | `status-server.bat` |

---

## llama.cpp Binary

```
C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\
  llama-server.exe   ← API server
  llama-cli.exe      ← terminal chat
```

Version: 9310 (Vulkan-enabled). Update with: `winget upgrade ggml.llamacpp`

---

## Further reading

- `quickstart.md` — step-by-step for common tasks
- `workflow.md` — API usage, Python, Hermes agent integration
- `../playbooks/local-llm-amd-rdna2.md` — hardware reference and tuning guide
