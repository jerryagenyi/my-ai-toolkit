@echo off
:: Download Qwen3.6-35B-A3B-Q4_K_M (exact model from the MoE tricks video)
:: Size: ~20 GB. Can be interrupted and resumed safely.

set HF_CLI=C:\Users\Username\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.13_qbz5n2kfra8p0\LocalCache\local-packages\Python313\Scripts\hf.exe
set MODEL_REPO=bartowski/Qwen_Qwen3.6-35B-A3B-GGUF
set MODEL_FILE=Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf
set DEST=C:\Users\Username\models

echo Downloading %MODEL_FILE% from HuggingFace...
echo Repo: %MODEL_REPO%
echo Destination: %DEST%
echo.
echo This is ~20 GB. If interrupted, run this script again to resume.
echo.

"%HF_CLI%" download %MODEL_REPO% --include "%MODEL_FILE%" --local-dir "%DEST%"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Download complete: %DEST%\%MODEL_FILE%
    echo.
    echo Next step: open local-llm\start-server.bat and switch to Option B.
) else (
    echo.
    echo Download failed or interrupted. Run this script again to resume.
)
pause
