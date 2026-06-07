@echo off
:: ============================================================
:: MODEL-SPECIFIC — Gemma4 12B Q4_K_M (minimized background mode)
:: ============================================================
:: Dense model — VRAM: ~7.4 GB weights + ~5 GB KV cache (q4_0) at 128K = ~12.4 GB
::
:: To use a different model:
::   1. Copy this file, rename to start-server-background_<ModelName>.bat
::   2. Update MODEL_PATH, NGL, CTX, EXTRA_ARGS
:: ============================================================

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

set MODEL_PATH=C:\Users\Username\models\gemma-4-12B-it-Q4_K_M.gguf
set NGL=99
set CTX=131072
set EXTRA_ARGS=--jinja --cache-type-k q4_0 --cache-type-v q4_0

tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% EQU 0 (
    echo A server is already running. Use stop-server.bat first.
    pause
    exit /B 1
)

echo Starting Gemma4 12B Q4_K_M on port 8033 (minimized)...
start "llama-server" /MIN "%LLAMA_BIN%" --model "%MODEL_PATH%" --host 0.0.0.0 --port 8033 -ngl %NGL% --ctx-size %CTX% %EXTRA_ARGS%

:: ── Verify the process actually launched ──────────────────────────────────────
echo Waiting for process to appear...
timeout /t 5 /nobreak >NUL
tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] llama-server did not start.
    echo   Run start-server_Gemma4-12B-Q4_K_M.bat to see the error in the console.
    echo   Or lower CTX in this file (try 65536) and retry.
    pause
    exit /B 1
)

echo.
echo [OK] Server running (minimized in taskbar). Takes ~15s to load model.
echo.
echo   Local:     http://localhost:8033/v1
echo   Tailscale: http://100.102.126.128:8033/v1
echo   Web chat:  http://localhost:8033
echo.
echo Restore the minimized window to watch startup. Close it to stop the server.
echo Run stop-server.bat to shut it down cleanly.
