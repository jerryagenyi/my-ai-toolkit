@echo off
:: llama-server startup script — AMD RX 6800 XT (Vulkan)
:: Edit MODEL_PATH and N_CPU_MOE for your use case

set LLAMA_BIN=C:\Users\Username\AppData\Local\Microsoft\WinGet\Packages\ggml.llamacpp_Microsoft.Winget.Source_8wekyb3d8bbwe\llama-server.exe

:: --- PICK ONE MODEL ---

:: Option A: Qwen3-14B (already downloaded, simpler, full GPU)
set MODEL_PATH=C:\Users\Username\.cache\huggingface\hub\models--Qwen--Qwen3-14B-GGUF\snapshots\530227a7d994db8eca5ab5ced2fb692b614357fd\Qwen3-14B-Q4_K_M.gguf
set N_CPU_MOE=0
set CTX=32768

:: Option B: Qwen3-30B-A3B MoE (download first — see playbooks/local-llm-amd-rdna2.md)
:: set MODEL_PATH=C:\Users\Username\models\Qwen3-30B-A3B-Q4_K_M.gguf
:: set N_CPU_MOE=12
:: set CTX=131072

set PORT=8033
set HOST=0.0.0.0

echo Starting llama-server on %HOST%:%PORT%
echo Model: %MODEL_PATH%

if "%N_CPU_MOE%"=="0" (
    "%LLAMA_BIN%" ^
      --model "%MODEL_PATH%" ^
      --host %HOST% ^
      --port %PORT% ^
      -ngl 99 ^
      --cache-type-k q8_0 ^
      --cache-type-v q8_0 ^
      --ctx-size %CTX%
) else (
    "%LLAMA_BIN%" ^
      --model "%MODEL_PATH%" ^
      --host %HOST% ^
      --port %PORT% ^
      -ngl 999 ^
      --n-cpu-moe %N_CPU_MOE% ^
      --no-mmap ^
      --mlock ^
      --cache-type-k q8_0 ^
      --cache-type-v q8_0 ^
      --ctx-size %CTX%
)
