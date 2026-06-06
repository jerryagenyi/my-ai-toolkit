@echo off
:: ============================================================
:: MODEL-SPECIFIC — Qwen3-14B Q4_K_M (visible terminal window)
:: ============================================================
:: To use a different model:
::   1. Copy this file
::   2. Rename it to match the model: start-server_<ModelName>.bat
::   3. Update MODEL_PATH below
::   4. Update NGL: use 99 for dense models, 999 for MoE
::   5. Update EXTRA_ARGS: add --n-cpu-moe, --no-mmap, --mlock for MoE models
::   6. Adjust CTX to taste (higher = more context, more VRAM)
:: ============================================================

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

set MODEL_PATH=C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf
set NGL=99
set CTX=131072
set EXTRA_ARGS=--cache-type-k q4_0 --cache-type-v q4_0

echo Starting server: Qwen3-14B Q4_K_M
echo Port: 8033  ^|  Local: http://localhost:8033/v1
echo Close this window to stop the server.
echo.

"%LLAMA_BIN%" --model "%MODEL_PATH%" --host 0.0.0.0 --port 8033 -ngl %NGL% --ctx-size %CTX% %EXTRA_ARGS%
