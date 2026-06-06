@echo off
:: Terminal chat — equivalent of "ollama run <model>"
:: Loads the model and starts an interactive chat session in this window.
:: Type your message and press Enter. Type /bye or Ctrl+C to exit.

set LLAMA_CLI=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-cli.exe

:: --- PICK ONE MODEL (comment/uncomment) ---

:: Option A: Qwen3-14B (ready now)
set MODEL_PATH=C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf
set MOE_ARGS=
set NGL=99

:: Option B: Qwen3.6-35B-A3B MoE (after downloading)
:: set MODEL_PATH=C:\Users\Username\models\Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf
:: set MOE_ARGS=--n-cpu-moe 12 --no-mmap --mlock
:: set NGL=999

echo Loading model... (takes ~13 seconds for 14B)
echo Type your message and press Enter to chat. Ctrl+C to exit.
echo.

"%LLAMA_CLI%" ^
  --model "%MODEL_PATH%" ^
  -ngl %NGL% ^
  %MOE_ARGS% ^
  --ctx-size 32768 ^
  -cnv ^
  -i ^
  --chat-template chatml
