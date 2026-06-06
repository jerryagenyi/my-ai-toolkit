# Local LLM — Quick Start

---

## Step 1: Start the server

Double-click (or run from terminal):

```
C:\Users\Username\Documents\github\my-ai-toolkit\local-llm\start-server.bat
```

A terminal window opens. Watch for this line — it means the model is loaded and ready:

```
server is listening on http://0.0.0.0:8033
```

Loading takes about **13 seconds** for the 14B model. Leave the window open while using the server.

---

## Step 2: Test it's working

In a separate terminal (PowerShell or Git Bash):

```powershell
curl http://localhost:8033/health
```

Expected response: `{"status":"ok"}`

Quick chat test:

```powershell
curl http://localhost:8033/v1/chat/completions `
  -H "Content-Type: application/json" `
  -d '{"model":"local","messages":[{"role":"user","content":"What is 2+2?"}],"max_tokens":50}'
```

---

## Step 3: Stop the server

Press **Ctrl+C** in the server terminal window, or just close the window.

The model is unloaded from VRAM immediately on close.

---

## Step 4: Switch from 14B to the MoE model

Open `scripts/start-llama-server.bat` in a text editor.

Find these two lines and swap which one is commented out:

```bat
:: Option A: Qwen3-14B (already downloaded, simpler, full GPU)
set MODEL_PATH=C:\Users\Username\.cache\...Qwen3-14B-Q4_K_M.gguf
set N_CPU_MOE=0
set CTX=32768

:: Option B: Qwen3-30B-A3B MoE (download first)
:: set MODEL_PATH=C:\Users\Username\models\Qwen3-30B-A3B-Q4_K_M.gguf
:: set N_CPU_MOE=12
:: set CTX=131072
```

To use Option B: remove the `:: ` from those three lines, and add `:: ` to the Option A lines.  
Then run the script again. The MoE model takes about 30-45 seconds to load.

---

## Step 5: Download the MoE model

Run this when you want to upgrade to the 30B MoE:

```
C:\Users\Username\Documents\github\my-ai-toolkit\local-llm\download-model.bat
```

This downloads **~20 GB** to `C:\Users\Username\models\`. Make sure you have space and a good connection. You can close and re-run if it gets interrupted — it resumes where it left off.

---

## Firewall: Allow access from other Tailnet devices

Run this **once** — it triggers a UAC (admin) prompt, click Yes:

```
C:\Users\Username\Documents\github\my-ai-toolkit\local-llm\add-firewall-rule.bat
```

After this, any device on your Tailscale network can reach the API at:
`http://100.102.126.128:8033/v1`

---

## Common issues

**Server starts but GPU isn't being used:**  
Look for this in the startup output: `Vulkan0 : AMD Radeon RX 6800 XT`. If it's missing, the Vulkan backend didn't load. Make sure `ggml-vulkan.dll` is in the same folder as `llama-server.exe`.

**"Out of memory" at startup:**  
For the MoE model, increase `N_CPU_MOE` from 12 to 15 or 18 in the bat file and try again.

**Model loads but responses are very slow:**  
Check that `-ngl 99` or `-ngl 999` is present in the startup command. Without it, inference runs on CPU only.
