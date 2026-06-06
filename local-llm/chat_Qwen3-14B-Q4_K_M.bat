@echo off
:: ============================================================
:: MODEL-SPECIFIC — Qwen3-14B Q4_K_M (terminal chat, no server)
:: ============================================================
:: To use a different model:
::   1. Copy this file
::   2. Rename it: chat_<ModelName>.bat
::   3. Update MODEL_PATH, NGL, EXTRA_ARGS below
:: Note: chat runs standalone — the server does NOT need to be running.
::       Type /bye or press Ctrl+C to exit.
:: ============================================================

set LLAMA_CLI=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-cli.exe

set MODEL_PATH=C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf
set NGL=99
set EXTRA_ARGS=

:: Check if server is already using VRAM — can't load model twice on 16 GB
tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% EQU 0 (
    echo [ERROR] llama-server is already running and using VRAM.
    echo.
    echo You cannot run chat and server at the same time on 16 GB VRAM.
    echo.
    echo Options:
    echo   A) Stop the server first:  stop-server.bat  then re-run this file
    echo   B) Chat via browser instead: open-webui.bat  (server stays running)
    pause
    exit /B 1
)

echo Loading Qwen3-14B Q4_K_M (~13 seconds)...
echo Type your message and press Enter. /bye or Ctrl+C to exit.
echo.

"%LLAMA_CLI%" --model "%MODEL_PATH%" -ngl %NGL% %EXTRA_ARGS% --ctx-size 32768 -cnv -i --chat-template chatml
