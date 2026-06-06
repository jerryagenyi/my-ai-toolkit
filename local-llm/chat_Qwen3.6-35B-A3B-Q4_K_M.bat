@echo off
:: ============================================================
:: MODEL-SPECIFIC — Qwen3.6-35B-A3B Q4_K_M (terminal chat)
:: ============================================================
:: VRAM rule: chat loads the model directly into VRAM.
:: It CANNOT run at the same time as the server.
::
:: To use a different model:
::   1. Copy this file, rename to chat_<ModelName>.bat
::   2. Update MODEL_PATH, NGL, EXTRA_ARGS, CTX below
:: ============================================================

set LLAMA_CLI=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-cli.exe
set MODEL_PATH=C:\Users\Username\models\Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf
set NGL=999
set CTX=131072
set EXTRA_ARGS=--n-cpu-moe 12 --no-mmap --mlock

:: ── Check if server is running ────────────────────────────────────────────────
tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% NEQ 0 goto RUN_CHAT

:: ── Server IS running — ask what to do ───────────────────────────────────────
echo [WARNING] llama-server is already running and holding VRAM.
echo Terminal chat cannot load the model while the server is active.
echo.
echo What do you want to do?
echo.
echo   (B) Open browser chat instead  (server stays running — recommended)
echo   (K) Kill server, then use terminal chat
echo   (C) Cancel
echo.
set /p CHOICE="Your choice (B/K/C): "

if /i "%CHOICE%"=="B" (
    start "" "http://localhost:8033"
    exit /B 0
)
if /i "%CHOICE%"=="K" goto KILL_AND_CHAT
echo Cancelled.
exit /B 0

:KILL_AND_CHAT
echo Stopping server...
taskkill /F /IM llama-server.exe >NUL 2>&1
echo Server stopped. Starting terminal chat...
timeout /t 2 /nobreak >NUL

:RUN_CHAT
echo.
echo Loading Qwen3.6-35B-A3B Q4_K_M (~45 seconds)...
echo Type your message and press Enter. /bye or Ctrl+C to exit.
echo.
"%LLAMA_CLI%" --model "%MODEL_PATH%" -ngl %NGL% %EXTRA_ARGS% --ctx-size %CTX% -cnv -i --chat-template chatml
