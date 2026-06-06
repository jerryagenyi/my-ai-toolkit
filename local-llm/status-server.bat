@echo off
:: Check if llama-server is running and reachable.

tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo [STOPPED] llama-server is not running.
    pause
    exit /B 0
)

echo [RUNNING] llama-server process found.
echo.
echo Checking HTTP health endpoint...
curl -s http://localhost:8033/health
echo.
echo.
echo Use stop-server.bat to stop it.
pause
