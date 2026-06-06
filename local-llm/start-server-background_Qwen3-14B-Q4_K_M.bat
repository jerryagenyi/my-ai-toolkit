@echo off
:: ============================================================
:: MODEL-SPECIFIC — Qwen3-14B Q4_K_M (minimized background mode)
:: ============================================================
:: To use a different model:
::   1. Copy this file
::   2. Rename it to match the model: start-server-background_<ModelName>.bat
::   3. Update MODEL_PATH, NGL, CTX, EXTRA_ARGS (same rules as start-server variant)
:: ============================================================

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

set MODEL_PATH=C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf
set NGL=99
set CTX=131072
set EXTRA_ARGS=--cache-type-k q4_0 --cache-type-v q4_0

tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% EQU 0 (
    echo A server is already running. Use stop-server.bat first.
    pause
    exit /B 1
)

echo Starting Qwen3-14B Q4_K_M on port 8033 (minimized)...
start "llama-server" /MIN "%LLAMA_BIN%" --model "%MODEL_PATH%" --host 0.0.0.0 --port 8033 -ngl %NGL% --ctx-size %CTX% %EXTRA_ARGS%

:: ── Verify the process actually launched ──────────────────────────────────────
echo Waiting for process to appear...
timeout /t 5 /nobreak >NUL
tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] llama-server did not start.
    echo   Possible cause: not enough VRAM for 128K context.
    echo   Fix: run start-server_Qwen3-14B-Q4_K_M.bat instead to see the error.
    echo   Or lower CTX in this file (try 98304 or 65536^) and retry.
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
