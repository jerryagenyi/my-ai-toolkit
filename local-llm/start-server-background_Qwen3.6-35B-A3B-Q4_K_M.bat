@echo off
:: ============================================================
:: MODEL-SPECIFIC — Qwen3.6-35B-A3B Q4_K_M (silent background mode)
:: ============================================================
:: To use a different model:
::   1. Copy this file
::   2. Rename it to match the model: start-server-background_<ModelName>.bat
::   3. Update MODEL_PATH, NGL, CTX, EXTRA_ARGS (same rules as start-server variant)
:: ============================================================

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

set MODEL_PATH=C:\Users\Username\models\Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf
set NGL=999
set CTX=131072
set EXTRA_ARGS=--n-cpu-moe 12 --no-mmap --mlock --cache-type-k q8_0 --cache-type-v q8_0

tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% EQU 0 (
    echo A server is already running. Use stop-server.bat first.
    pause
    exit /B 1
)

echo Starting Qwen3.6-35B-A3B Q4_K_M (MoE) silently on port 8033...
powershell -Command "Start-Process -FilePath '%LLAMA_BIN%' -ArgumentList '--model ""%MODEL_PATH%"" --host 0.0.0.0 --port 8033 -ngl %NGL% --ctx-size %CTX% %EXTRA_ARGS%' -WindowStyle Hidden"

echo.
echo Server started. Takes ~30-45s to load before accepting requests.
echo   Local:     http://localhost:8033/v1
echo   Tailscale: http://100.102.126.128:8033/v1
echo.
echo Run status-server.bat to confirm it's ready.
echo Run stop-server.bat to shut it down.
