@echo off
:: MODEL-AGNOSTIC — Browser chat UI
:: - If server is running: opens it in your browser immediately
:: - If no server is running: asks which model to start, starts it, then opens browser

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

:: ── Check if server is already running ────────────────────────────────────────
tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% EQU 0 (
    echo [RUNNING] Server detected on port 8033.
    echo Opening browser chat...
    start "" "http://localhost:8033"
    exit /B 0
)

:: ── No server running — ask which model to start ──────────────────────────────
echo [STOPPED] No server is running.
echo.
echo Which model do you want to start?
echo.
echo   (1) Qwen3-14B Q4_K_M       — ~13s load, 14 GB VRAM, best for daily use
echo   (2) Gemma4-12B Q4_K_M      — ~13s load, 12 GB VRAM, Google model
echo   (3) Qwen3.6-35B-A3B Q4_K_M — ~45s load, MoE, best for complex tasks
echo   (C) Cancel
echo.
set /p CHOICE="Your choice (1/2/3/C): "

if /i "%CHOICE%"=="C" exit /B 0
if /i "%CHOICE%"=="1" goto START_14B
if /i "%CHOICE%"=="2" goto START_12B
if /i "%CHOICE%"=="3" goto START_35B
echo Invalid choice. Exiting.
pause
exit /B 1

:START_14B
set MODEL_PATH=C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf
set SERVER_ARGS=--host 0.0.0.0 --port 8033 -ngl 99 --ctx-size 131072 --cache-type-k q4_0 --cache-type-v q4_0
set LOAD_TIME=15
goto START_SERVER

:START_12B
set MODEL_PATH=C:\Users\Username\models\gemma-4-12B-it-Q4_K_M.gguf
set SERVER_ARGS=--host 0.0.0.0 --port 8033 -ngl 99 --ctx-size 131072 --jinja --cache-type-k q4_0 --cache-type-v q4_0
set LOAD_TIME=15
goto START_SERVER

:START_35B
set MODEL_PATH=C:\Users\Username\models\Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf
set SERVER_ARGS=--host 0.0.0.0 --port 8033 -ngl 999 --n-cpu-moe 12 --no-mmap --ctx-size 131072 --cache-type-k q8_0 --cache-type-v q8_0
set LOAD_TIME=50
goto START_SERVER

:START_SERVER
echo.
echo Starting server in background (takes ~%LOAD_TIME% seconds to load)...
start "llama-server" /MIN "%LLAMA_BIN%" --model "%MODEL_PATH%" %SERVER_ARGS%

:: ── Wait for server to be ready ───────────────────────────────────────────────
echo Waiting for model to load...
:WAIT_LOOP
timeout /t 3 /nobreak >NUL
curl -s http://localhost:8033/health 2>NUL | find "ok" >NUL
if %ERRORLEVEL% NEQ 0 goto WAIT_LOOP

echo Server ready. Opening browser...
start "" "http://localhost:8033"
