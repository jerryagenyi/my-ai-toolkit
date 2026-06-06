@echo off
:: ============================================================
:: MODEL-SPECIFIC — Qwen3.6-35B-A3B Q4_K_M (visible terminal window)
:: ============================================================
:: To use a different model:
::   1. Copy this file
::   2. Rename it to match the model: start-server_<ModelName>.bat
::   3. Update MODEL_PATH below
::   4. Update NGL: use 99 for dense models, 999 for MoE
::   5. Update EXTRA_ARGS: remove --n-cpu-moe/--no-mmap/--mlock for dense models
::   6. Adjust N_CPU_MOE: lower = more experts on GPU (faster), higher = more VRAM freed for context
::   7. Adjust CTX to taste
:: ============================================================

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

set MODEL_PATH=C:\Users\Username\models\Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf
set NGL=999
set CTX=131072
set EXTRA_ARGS=--n-cpu-moe 12 --no-mmap --mlock --cache-type-k q8_0 --cache-type-v q8_0

echo Starting server: Qwen3.6-35B-A3B Q4_K_M (MoE)
echo Port: 8033  ^|  Local: http://localhost:8033/v1
echo Loading takes ~30-45 seconds. Close this window to stop.
echo.

"%LLAMA_BIN%" --model "%MODEL_PATH%" --host 0.0.0.0 --port 8033 -ngl %NGL% --ctx-size %CTX% %EXTRA_ARGS%
