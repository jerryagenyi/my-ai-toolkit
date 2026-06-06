@echo off
:: MODEL-AGNOSTIC — works regardless of which model is loaded

tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo [STOPPED] No llama-server process found.
    pause
    exit /B 0
)

echo [RUNNING] llama-server is active.
echo.

echo Currently loaded model:
powershell -Command "(Get-WmiObject Win32_Process -Filter \"name='llama-server.exe'\").CommandLine" | tr ' ' '\n' | grep -A1 "\-\-model" 2>NUL || powershell -Command "(Get-WmiObject Win32_Process -Filter \"name='llama-server.exe'\").CommandLine"

echo.
echo HTTP health check:
curl -s http://localhost:8033/health
echo.
echo.
echo Active model via API:
curl -s http://localhost:8033/v1/models
echo.
echo.
echo Use stop-server.bat to stop it.
pause
