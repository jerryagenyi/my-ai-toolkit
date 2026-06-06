@echo off
:: Stop the llama-server process (works whether started via window or background).

tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo llama-server is not running.
    pause
    exit /B 0
)

taskkill /F /IM llama-server.exe >NUL 2>&1
echo llama-server stopped. VRAM freed.
pause
