# Local LLM — llama.cpp Toolkit

Run AI models fully locally on Windows — no cloud, no API keys, no query logging.

**Runtime:** llama.cpp (Vulkan/AMD or CUDA/NVIDIA) via WinGet  
**API:** OpenAI-compatible on `http://localhost:8033/v1`  
**Scripts:** `.bat` files for one-click start/stop/chat/download

> **Adapting this for your machine:** Paths like `C:\Users\Username\...` and IPs like `192.168.1.244` are personalised. Search-replace `Username` with your Windows username and update IPs/model paths as needed.

---

## Origin: The Video That Started This

**"Running a 35B AI Model on 6GB VRAM, FAST (llama.cpp Guide)"**  
Channel: [@Codacus](https://www.youtube.com/@Codacus) | [Watch on YouTube](https://www.youtube.com/watch?v=8F_5pdcD3HY) | Published: May 2026

### What Codacus demonstrates

Codacus runs a 35B-parameter MoE (Mixture of Experts) model — Qwen 3.6 30B-A3B — on an NVIDIA GTX 1060 with just **6 GB VRAM** and 24 GB RAM: a machine most people would assume is too weak for inference at that scale.

The key insight: MoE models have two structurally different types of parameters:
- **Attention layers** — small, must stay on GPU for speed
- **Expert layers** — large in aggregate, but only a small fraction activate per token; they can be fetched from CPU RAM without catastrophic speed loss

llama.cpp's `--n-cpu-moe N` flag controls exactly how many expert layers live in RAM vs. VRAM, turning a VRAM bottleneck into a RAM + CPU bandwidth problem — one that any machine with enough RAM can handle.

### Five techniques from the video, in order of impact

| # | Technique | Flag | What it does | Speed on GTX 1060 |
|---|-----------|------|--------------|-------------------|
| 1 | MoE CPU offload | `--n-cpu-moe N` | Expert layers go to RAM instead of VRAM | 3 → 10 t/s |
| 2 | Preload model | `--no-mmap` | Full model loaded into RAM at startup; no disk reads mid-inference | 10 → 13.5 t/s |
| 3 | Max GPU layers | `-ngl 999` | All non-expert layers on GPU (don't cap at a lower number) | 13.5 → 17 t/s |
| 4 | TurboQuant KV | `--cache-type-k turbo4` | Compresses KV cache; expands context from 64K to 256K with minimal quality loss | No speed cost |
| 5 | Memory lock | `--mlock` | Pins model in RAM; prevents OS paging during long sessions | Prevents slowdown over time |

### How these techniques apply to your hardware

The video is calibrated for a GTX 1060 (6 GB VRAM, 24 GB RAM, Intel i3). The principles are universal — the numbers just change:

| Factor | Video (GTX 1060) | This PC (RX 6800 XT) | Your PC |
|--------|-----------------|----------------------|---------|
| VRAM | 6 GB | **16 GB** | check GPU-Z or Task Manager |
| RAM | 24 GB | **64 GB** | check Task Manager |
| `--n-cpu-moe` for 35B MoE | 35–36 | **12** (more experts on GPU) | start at 12, tune up if OOM |
| `--no-mmap` benefit | Yes — 24 GB RAM is enough | Yes — 64 GB handles it easily | Use if you have ≥32 GB RAM |
| Max context (q8_0 KV) | ~64K | **131K** | scales with VRAM |
| `--mlock` safe? | Risky (RAM near limit) | N/A — see note below | see note below |

**Note on `--mlock` for Windows:**  
Codacus ran on Linux, where `mlock()` is a standard syscall. On Windows, the equivalent is `VirtualLock()`, which requires the `SeLockMemoryPrivilege` privilege that regular users don't have. Attempting it with a large model either silently fails or prevents the server from starting altogether. **Do not use `--mlock` on Windows.** If you have enough free RAM (which you do with 64 GB), paging is not a real-world problem anyway.

**Note on TurboQuant:**  
The `--cache-type-k turbo4 / turbo3` flags Codacus uses come from a custom llama.cpp fork, not the standard WinGet build. The standard build supports `q8_0` and `q4_0` KV quantization instead — these provide similar context expansion with near-lossless quality.

### Applying this to a dense (non-MoE) model

Techniques 1–2 are MoE-specific. For a normal dense model (e.g. Qwen3-14B, Gemma4-12B):

- Skip `--n-cpu-moe` and `--no-mmap` — all layers go to GPU with `-ngl 99`
- Use `-c` (context size) + `--cache-type-k q4_0 --cache-type-v q4_0` to balance context vs. VRAM
- If your VRAM is tight: lower the context size or use a smaller quantization

---

## Requirements

### Hardware minimum (to run anything useful)
- **VRAM:** 6 GB minimum (enough for a 7–8B model at 4-bit quantization)
- **RAM:** 16 GB minimum; 32 GB+ if running MoE models with CPU offload
- **GPU:** Any modern NVIDIA or AMD — NVIDIA uses CUDA, AMD uses Vulkan (no ROCm needed on Windows)
- **Storage:** SSD recommended; NVMe for large model loads

### This PC
| Component | Spec | Role |
|-----------|------|------|
| GPU | AMD RX 6800 XT — 16 GB VRAM | Inference — all model layers offloaded here |
| CPU | AMD Ryzen 7 5800X — 8c/16t | MoE expert layers in RAM, prompt tokenisation |
| RAM | 64 GB | Large MoE models load fully without paging |
| OS | Windows 11 Pro | Scripts are `.bat`; PowerShell also available |

**AMD on Windows = Vulkan.** No ROCm, no Docker needed. The `amdhip64_6.dll` in System32 is an AMD driver component — it does not mean ROCm is installed. llama.cpp's WinGet build has Vulkan support built in.

### Software needed
- **llama.cpp** — `winget install ggml.llamacpp`
- **Python + huggingface_hub** — for model downloads: `pip install huggingface_hub`
- No Docker, no ROCm, no CUDA toolkit required

---

## Install llama.cpp

```powershell
winget install ggml.llamacpp
```

The binaries land at:
```
C:\Users\<YourName>\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\
  llama-server.exe   ← API server
  llama-cli.exe      ← terminal chat (no server needed)
```

Update any time: `winget upgrade ggml.llamacpp`

---

## Models

### Quantization guide (applies to any model)

| Quant | Quality | VRAM usage | When to use |
|-------|---------|-----------|------------|
| Q8_0 | Near-lossless | Highest | When you have VRAM headroom |
| Q6_K | Very high | High | Sweet spot with sufficient VRAM |
| **Q4_K_M** | **Good** | **Moderate** | **Default — best quality-per-GB ratio** |
| Q4_0 | Acceptable | Low | When VRAM is genuinely tight |
| Q2_K | Degraded | Lowest | Last resort |

### Current models on this machine

| Model | Type | HF Repo | VRAM at 128K ctx | Load time | Best for |
|-------|------|---------|-----------------|-----------|---------|
| Qwen3-14B Q4_K_M | Dense | `Qwen/Qwen3-14B-GGUF` | ~14 GB | ~13s | Daily dev, coding, chat |
| **Gemma4-12B Q4_K_M** | Dense | `lmstudio-community/gemma-4-12B-it-GGUF` | ~12 GB | ~13s | Coding, reasoning, chat (Google) |
| Qwen3.6-35B-A3B Q4_K_M | MoE | `bartowski/Qwen_Qwen3.6-35B-A3B-GGUF` | ~5 GB GPU + ~17 GB RAM | ~45s | Complex tasks, long context |

**Gemma 4 note:** Gemma 4 is a multimodal model (text + image input) from Google, licensed Apache 2.0. When running via llama.cpp GGUF, only text input is available. It uses a custom Jinja chat template — the `--jinja` flag in the scripts handles this automatically.

### Downloading models

Each model has a `download-model_<Name>.bat` script. Run it once.

Alternatively, any `start-server_*.bat` that uses the `-hf` flag will auto-download the model on first run.

**For models requiring a HuggingFace token (gated models):**
```powershell
# One-time login
huggingface-cli login
# Or set token directly
echo hf_YOUR_TOKEN > C:\Users\Username\.cache\huggingface\token
```

---

## The One Rule You Need to Know

`llama-server.exe` (API server) and `llama-cli.exe` (terminal chat) **each load a full copy of the model into VRAM**. You cannot run both at the same time.

| Situation | Result |
|-----------|--------|
| Server running + browser UI open | ✓ Works — browser UI is the server's built-in interface |
| Server running + start terminal chat | ✗ VRAM conflict — model won't load |
| Two servers | ✗ Port + VRAM conflict |
| Server on one model, switch to another | Stop server first (`stop-server.bat`), then start the new one |

---

## Scripts

### File naming convention

`<action>_<ModelName>.bat` — the `ModelName` matches the model in that script. To add a new model, copy any script, rename it, and update the variables at the top.

### Model-specific scripts (one set per model)

| Script | What it does |
|--------|-------------|
| `start-server_<Model>.bat` | Start API server in a visible window — close window to stop |
| `start-server-background_<Model>.bat` | Start API server minimised — use `stop-server.bat` to stop |
| `chat_<Model>.bat` | Terminal chat — loads model directly, no server needed |
| `download-model_<Model>.bat` | Download that model from HuggingFace |

### Model-agnostic scripts

| Script | What it does |
|--------|-------------|
| `open-webui.bat` | Open browser UI — auto-starts the server if not running |
| `stop-server.bat` | Kill server process, free all VRAM |
| `status-server.bat` | Show whether server is running and which model is loaded |
| `add-firewall-rule.bat` | One-time setup: open port 8033 for LAN/Tailscale access |

### Decision flow

```
Want to chat?
  ──► Browser UI: double-click open-webui.bat
        Server running → opens immediately
        Server not running → pick a model → starts minimised → opens when ready

  ──► Terminal: double-click chat_<Model>.bat
        Server NOT running → loads model, opens terminal chat
        Server IS running → choose:
          (B) Browser chat — recommended, server keeps running
          (K) Kill server, then start terminal chat
          (C) Cancel

Want the API (for scripts, agents, IDE)?
  ──► start-server-background_<Model>.bat
  ──► status-server.bat  (wait for [RUNNING] + health ok)
  ──► Use http://localhost:8033/v1
```

### Common tasks

| Goal | Action |
|------|--------|
| Start 14B API (background) | `start-server-background_Qwen3-14B-Q4_K_M.bat` |
| Start Gemma4-12B API (background) | `start-server-background_Gemma4-12B-Q4_K_M.bat` |
| Start 35B MoE API (background) | `start-server-background_Qwen3.6-35B-A3B-Q4_K_M.bat` |
| Chat in browser | `open-webui.bat` |
| Stop server / free VRAM | `stop-server.bat` |
| Check what's loaded | `status-server.bat` |
| Switch from 14B to 35B | `stop-server.bat` → `start-server-background_Qwen3.6-35B-A3B-Q4_K_M.bat` |

---

## Using the API

The server exposes an **OpenAI-compatible API**. Any tool that supports OpenAI works — just change the base URL.

### Endpoints

| From | URL |
|------|-----|
| This PC | `http://localhost:8033/v1` |
| LAN | `http://192.168.1.244:8033/v1` |
| WSL (Ubuntu-22.04) | `http://192.168.1.244:8033/v1` |
| Tailscale (any device) | `http://100.102.126.128:8033/v1` |
| Web UI | `http://localhost:8033` |

No API key required — pass any string or omit it.

### curl

```bash
# Check what model is loaded
curl http://localhost:8033/v1/models

# Chat completion
curl http://localhost:8033/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "local",
    "messages": [{"role": "user", "content": "Write a Python function to validate an email"}],
    "max_tokens": 2048
  }'

# Streaming (token by token)
curl http://localhost:8033/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"local","messages":[{"role":"user","content":"Tell me a story"}],"stream":true}'
```

### Python (openai SDK)

```python
from openai import OpenAI

client = OpenAI(base_url="http://localhost:8033/v1", api_key="local")
response = client.chat.completions.create(
    model="local",
    messages=[{"role": "user", "content": "Your question here"}],
    max_tokens=2048
)
print(response.choices[0].message.content)
```

### Hermes agent integration

```bash
# .env
OPENAI_BASE_URL=http://100.102.126.128:8033/v1
OPENAI_API_KEY=not-needed
```

```yaml
# config.yaml
llm:
  provider: openai
  model: local
  base_url: http://100.102.126.128:8033/v1
  api_key: not-needed
```

The Tailscale IP `100.102.126.128` means any agent on the Tailnet (VPS, Kali, WSL, mobile) can reach this server over the private network without opening a public port.

### Thinking mode (Qwen3 models only)

```json
{
  "messages": [
    {"role": "system", "content": "You are a helpful assistant. /think"},
    {"role": "user", "content": "Debug this race condition..."}
  ]
}
```

`/think` enables chain-of-thought reasoning (slower, more accurate for hard problems).  
`/no_think` disables it (faster, better for simple Q&A).

---

## For AI Agents

### Hard limits — do not exceed

| Limit | Value | What happens if exceeded |
|-------|-------|--------------------------|
| Context window | 32,768 tokens (default; configurable with `-c`) | Server silently truncates from the oldest messages |
| Safe input budget | ~28,000 tokens | Leaves ~4,768 tokens for output |
| Recommended output reserve | 4,096 tokens | Responses cut off beyond this |
| Parallel slots | 1 | Second request queues; does not run in parallel |

**The server does not warn on overflow.** If a response seems to lack context from earlier in the conversation, the input exceeded the window.

### What to route here

- Code generation: single-file, clear spec
- Boilerplate, scaffolding, CRUD handlers
- Regex, transforms, simple algorithms
- Explaining a function or code block
- Renaming, refactoring within a single file
- Quick lookups (syntax, shell commands)
- Drafts to be reviewed by Claude Pro

### Route to Claude Pro or GLM-5 instead

- Multi-file architecture decisions
- Long debugging sessions (>10 turns, full context each time)
- Tasks requiring >28K tokens of input
- Agentic tool-use chains (this server has no tool use)
- Final production implementations (quality > cost)
- GLM-5: Chinese-language tasks, GLM ecosystem

### Recommended Hermes config

```
max_input_tokens: 28000
max_output_tokens: 4096
trim_strategy: keep_system + keep_last_N_turns + summarise_older
```

---

## Auto-start at Login (Windows Scheduled Task)

Starts the server automatically at login, survives terminal closure, and restarts on crash.

**Register (run once in PowerShell as Admin):**

```powershell
$exe   = 'C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe'
$flags = '-hf Qwen/Qwen3-14B-GGUF:Q4_K_M --jinja -c 32768 --no-mmap -ngl 99 -np 1 --spec-type ngram-mod --host 0.0.0.0 --port 8033'
$log   = 'C:\Users\Username\llama-server.log'

$action    = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument "/c `"$exe`" $flags > `"$log`" 2>&1"
$trigger   = New-ScheduledTaskTrigger -AtLogon -User 'Username'
$settings  = New-ScheduledTaskSettingsSet -ExecutionTimeLimit 0 -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 2) -StartWhenAvailable
$principal = New-ScheduledTaskPrincipal -UserId 'Username' -LogonType Interactive -RunLevel Highest
Register-ScheduledTask -TaskName 'llama-server' -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Force
```

**Manage:**

```powershell
Start-ScheduledTask  -TaskName 'llama-server'
Stop-ScheduledTask   -TaskName 'llama-server'
Stop-Process -Name 'llama-server' -Force -ErrorAction SilentlyContinue
Get-ScheduledTask    -TaskName 'llama-server' | Select-Object State
Get-Content C:\Users\Username\llama-server.log -Wait -Tail 20
```

**Changing the model in the scheduled task:**

```powershell
Stop-ScheduledTask -TaskName 'llama-server'
Stop-Process -Name 'llama-server' -Force -ErrorAction SilentlyContinue

$flags  = '-hf NEW_REPO/MODEL:QUANT --jinja -c 32768 --no-mmap -ngl 99 -np 1 --spec-type ngram-mod --host 0.0.0.0 --port 8033'
$action = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument "/c `"$exe`" $flags > `"$log`" 2>&1"
Set-ScheduledTask -TaskName 'llama-server' -Action $action
Start-ScheduledTask -TaskName 'llama-server'
```

---

## Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| `[STOPPED]` right after background launch | Process exited — model path wrong, OOM, or bad flag | Run the foreground script to see the error output |
| Chat window flashes and disappears | Server running, VRAM full | Use `open-webui.bat` or run `stop-server.bat` first |
| `Vulkan0 : AMD...` missing in startup output | Vulkan backend not loaded | Verify `ggml-vulkan.dll` is in the same folder as `llama-server.exe` |
| "Out of memory" on 35B MoE | Too many experts on GPU | Increase `--n-cpu-moe` by 3–4 in the `.bat` file |
| Very slow first token on long prompts | Prompt processing at large context | Expected — reduce context or trim input |
| `401` downloading a model | No HuggingFace token for gated model | `huggingface-cli login` or write token to `~/.cache/huggingface/token` |
| Server shows "Ready" in task but not responding | Scheduled task exited silently | Check log: `Get-Content C:\Users\Username\llama-server.log -Tail 30` |
| Second request hangs | `-np 1` — one parallel slot | Wait for first to finish; increase `-np` if sharing across users |
| Model "forgets" early conversation | Silent context truncation at limit | Input exceeded window; trim earlier messages before sending |

---

## Quick Reference

| Action | Command / File |
|--------|----------------|
| Install llama.cpp | `winget install ggml.llamacpp` |
| Update llama.cpp | `winget upgrade ggml.llamacpp` |
| Start 14B (background) | `start-server-background_Qwen3-14B-Q4_K_M.bat` |
| Start Gemma4-12B (background) | `start-server-background_Gemma4-12B-Q4_K_M.bat` |
| Start 35B MoE (background) | `start-server-background_Qwen3.6-35B-A3B-Q4_K_M.bat` |
| Stop server / free VRAM | `stop-server.bat` |
| Check status | `status-server.bat` |
| Browser chat UI | `open-webui.bat` |
| Test API | `curl http://localhost:8033/v1/models` |
| Health check | `curl http://localhost:8033/health` |
| View scheduled task log | `Get-Content C:\Users\Username\llama-server.log -Tail 30` |
| Max safe input (32K ctx) | 28,000 tokens |
| VRAM under load — 14B | ~14 GB of 16 GB |
| VRAM under load — Gemma4-12B | ~12 GB of 16 GB |
| VRAM under load — 35B MoE | ~5 GB GPU + ~17 GB RAM |

---

## Further Reading

`../playbooks/local-llm-amd-rdna2.md` — hardware-specific deep dive: VRAM budget tables, context window trade-offs, speculative decoding details, full run commands with flag explanations, and MoE tuning guide for this specific GPU.
