@echo off
:: Start llama-server silently in the background (no terminal window).
:: Use stop-server.bat to stop it. Use status-server.bat to check if it's running.

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

:: --- PICK ONE MODEL (uncomment one block) ---

:: Option A: Qwen3-14B (ready now)
set MODEL_PATH=C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf
set EXTRA_ARGS=-ngl 99 --cache-type-k q8_0 --cache-type-v q8_0 --ctx-size 32768

:: Option B: Qwen3.6-35B-A3B MoE (after downloading)
:: set MODEL_PATH=C:\Users\Username\models\Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf
:: set EXTRA_ARGS=-ngl 999 --n-cpu-moe 12 --no-mmap --mlock --cache-type-k q8_0 --cache-type-v q8_0 --ctx-size 131072

:: Check if already running
tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% EQU 0 (
    echo Server is already running. Use stop-server.bat first.
    pause
    exit /B 1
)

echo Starting llama-server in background on port 8033...
powershell -Command "Start-Process -FilePath '%LLAMA_BIN%' -ArgumentList '--model ""%MODEL_PATH%"" --host 0.0.0.0 --port 8033 %EXTRA_ARGS%' -WindowStyle Hidden"

echo.
echo Server started silently.
echo   Local:     http://localhost:8033/v1
echo   Tailscale: http://100.102.126.128:8033/v1
echo   Health:    curl http://localhost:8033/health
echo.
echo Run stop-server.bat to shut it down.
