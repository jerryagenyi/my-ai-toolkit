@echo off
:: ============================================================
:: MODEL-SPECIFIC — Gemma4 12B Q4_K_M download (~7.4 GB)
:: ============================================================
:: Downloads from HuggingFace to C:\Users\Username\models\
:: Model is free and public (Apache 2.0 license, by Google)
:: ============================================================

set PYTHONIOENCODING=utf-8
set HF_CLI=C:\Users\Username\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.13_qbz5n2kfra8p0\LocalCache\local-packages\Python313\Scripts\hf.exe
set TARGET_DIR=C:\Users\Username\models
set REPO=lmstudio-community/gemma-4-12B-it-GGUF
set FILENAME=gemma-4-12B-it-Q4_K_M.gguf

echo Downloading %FILENAME% (~7.4 GB)...
echo Destination: %TARGET_DIR%\%FILENAME%
echo.
echo If interrupted, run this script again to resume.
echo.

"%HF_CLI%" download %REPO% %FILENAME% --local-dir "%TARGET_DIR%"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [OK] Download complete: %TARGET_DIR%\%FILENAME%
) else (
    echo.
    echo [ERROR] Download failed.
    echo   Check your internet connection and try again.
    echo   For gated models, run: "%HF_CLI%" login
)
pause
