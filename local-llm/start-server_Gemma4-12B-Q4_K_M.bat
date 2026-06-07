@echo off
:: ============================================================
:: MODEL-SPECIFIC — Gemma4 12B Q4_K_M (visible terminal window)
:: ============================================================
:: Dense model (not MoE) — all layers go to GPU with -ngl 99
:: VRAM: ~7.4 GB weights + ~5 GB KV cache (q4_0) at 128K = ~12.4 GB of 16 GB
::
:: To use a different model:
::   1. Copy this file, rename to start-server_<ModelName>.bat
::   2. Update MODEL_PATH, NGL, CTX, EXTRA_ARGS
::   Dense model: NGL=99,  EXTRA_ARGS=--jinja --cache-type-k q4_0 --cache-type-v q4_0
::   MoE model:   NGL=999, EXTRA_ARGS=--n-cpu-moe N --no-mmap --cache-type-k q8_0 --cache-type-v q8_0
:: ============================================================

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

set MODEL_PATH=C:\Users\Username\models\gemma-4-12B-it-Q4_K_M.gguf
set NGL=99
set CTX=131072
set EXTRA_ARGS=--jinja --cache-type-k q4_0 --cache-type-v q4_0

echo Starting server: Gemma4 12B Q4_K_M
echo Port: 8033  ^|  Local: http://localhost:8033/v1
echo Loading takes ~13-15 seconds. Close this window to stop.
echo.

"%LLAMA_BIN%" --model "%MODEL_PATH%" --host 0.0.0.0 --port 8033 -ngl %NGL% --ctx-size %CTX% %EXTRA_ARGS%
