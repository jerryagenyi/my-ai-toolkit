@echo off
:: ============================================================
:: MODEL-SPECIFIC — Gemma4 12B Q4_K_M download (~7.4 GB)
:: ============================================================
:: Downloads from HuggingFace to C:\Users\Username\models\
:: Model is free and public (Apache 2.0 license, by Google)
::
:: Requires huggingface_hub: pip install huggingface_hub
:: ============================================================

set TARGET_DIR=C:\Users\Username\models
set REPO=lmstudio-community/gemma-4-12B-it-GGUF
set FILENAME=gemma-4-12B-it-Q4_K_M.gguf

echo Downloading %FILENAME% (~7.4 GB)...
echo Destination: %TARGET_DIR%\%FILENAME%
echo.
echo If interrupted, run this script again to resume.
echo.

huggingface-cli download %REPO% %FILENAME% --local-dir "%TARGET_DIR%"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [OK] Download complete: %TARGET_DIR%\%FILENAME%
) else (
    echo.
    echo [ERROR] Download failed.
    echo   Make sure huggingface_hub is installed: pip install huggingface_hub
    echo   For gated models, log in first: huggingface-cli login
)
pause
