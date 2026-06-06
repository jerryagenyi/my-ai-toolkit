# Local LLM — Operational Guide

Everything you need to know about running models, what conflicts, and what to do when.

---

## The one rule you need to know

**The VRAM rule:** Your GPU has 16 GB. Both `llama-cli.exe` (terminal chat) and `llama-server.exe` (API server) each load a full copy of the model into VRAM. You cannot run both at the same time.

| What you want | Result |
|---------------|--------|
| Server running + open browser chat | Works — they share the same process |
| Server running + start terminal chat | VRAM overflow, model fails to load |
| Terminal chat running + start server | Same — VRAM overflow |
| Two models loaded at once | Not possible on 16 GB |

---

## Decision flow: "I want to chat"

```
Want a chat UI in the browser?
  → Double-click open-webui.bat
     • If server is already running: browser opens immediately
     • If not: choose which model, it starts in the background, browser opens when ready

Want to chat in the terminal?
  → Double-click chat_<Model>.bat
     • If server is NOT running: model loads, terminal chat starts
     • If server IS running: you'll be asked:
         (B) Open browser chat instead  ← recommended, server keeps running
         (K) Kill server, then start terminal chat
         (C) Cancel
```

---

## What can run at the same time

| Combination | OK? | Notes |
|-------------|-----|-------|
| Server + browser chat | Yes | Browser chat is just the server's built-in UI |
| Server + Python/curl API calls | Yes | That's what the server is for |
| Server + another machine on Tailscale | Yes | Port 8033 is open on Tailscale interface |
| Server + terminal chat (`llama-cli`) | **No** | VRAM conflict |
| Two terminal chats | **No** | VRAM conflict |
| Two servers | **No** | Port conflict + VRAM conflict |

---

## What each file does

### Start from scratch (nothing running)

| File | What it does | Load time |
|------|-------------|-----------|
| `open-webui.bat` | Asks which model, starts server, opens browser | auto |
| `chat_Qwen3-14B-Q4_K_M.bat` | Loads 14B model, opens terminal chat | ~13s |
| `chat_Qwen3.6-35B-A3B-Q4_K_M.bat` | Loads 35B MoE model, opens terminal chat | ~45s |
| `start-server_Qwen3-14B-Q4_K_M.bat` | Starts 14B API server (visible window) | ~13s |
| `start-server_Qwen3.6-35B-A3B-Q4_K_M.bat` | Starts 35B MoE API server (visible window) | ~45s |
| `start-server-background_Qwen3-14B-Q4_K_M.bat` | Starts 14B server silently (no window) | ~13s |
| `start-server-background_Qwen3.6-35B-A3B-Q4_K_M.bat` | Starts 35B MoE server silently (no window) | ~45s |

### While server is running

| File | What it does |
|------|-------------|
| `open-webui.bat` | Opens `http://localhost:8033` in browser |
| `chat_*.bat` | Asks: browser chat / kill server / cancel |
| `status-server.bat` | Shows which model is loaded, health check |
| `stop-server.bat` | Kills server, frees all VRAM |

### One-time setup

| File | What it does |
|------|-------------|
| `add-firewall-rule.bat` | Opens port 8033 on Tailscale (triggers UAC — run once) |
| `download-model_Qwen3.6-35B-A3B-Q4_K_M.bat` | Downloads the 35B MoE model (~22 GB) |

---

## Common tasks

**Chat with the browser UI:**  
Double-click `open-webui.bat` — it handles everything.

**Use the API from another device on Tailscale:**  
Server must be running. Endpoint: `http://100.102.126.128:8033/v1`

**Check which model is loaded:**  
Run `status-server.bat`. It shows the model path and health status.

**Switch from 14B to the MoE model:**  
Stop the current server (`stop-server.bat`), then start `start-server_Qwen3.6-35B-A3B-Q4_K_M.bat`.  
The MoE model takes ~45 seconds to load.

**Free up VRAM completely:**  
Run `stop-server.bat` (if server is running) or close the terminal chat window.  
After that, all VRAM is returned to the GPU.

---

## If something goes wrong

**Model loads but GPU isn't being used:**  
Look for `Vulkan0 : AMD Radeon RX 6800 XT` in the server startup output. If missing, the Vulkan backend didn't load — check that `ggml-vulkan.dll` is in the same folder as `llama-server.exe`.

**"Out of memory" when starting the MoE model:**  
Open `start-server_Qwen3.6-35B-A3B-Q4_K_M.bat` and increase `--n-cpu-moe` from 12 to 15 or 18.  
This offloads more expert layers to RAM instead of VRAM.

**Responses are very slow:**  
Check that `-ngl 999` (MoE) or `-ngl 99` (14B) is in the startup command. Without it, inference runs entirely on CPU.

**Chat window flashes and disappears:**  
The server is probably running and VRAM is full. Use `open-webui.bat` to chat in the browser instead, or run `stop-server.bat` first.

**Server won't start — port already in use:**  
Another server is running. Run `stop-server.bat` then try again.

---

## API access (for scripts and agents)

| What | Value |
|------|-------|
| Base URL (local) | `http://localhost:8033/v1` |
| Base URL (Tailscale) | `http://100.102.126.128:8033/v1` |
| Web UI | `http://localhost:8033` |
| Health check | `http://localhost:8033/health` → `{"status":"ok"}` |
| API key | Not required (leave blank or use any string) |
| Model name | Any string — `local`, `qwen3`, doesn't matter |

See `workflow.md` for curl, Python, and agent integration examples.
