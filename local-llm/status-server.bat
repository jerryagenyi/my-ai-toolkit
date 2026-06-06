@echo off
:: MODEL-AGNOSTIC — shows whether server is running and which model is loaded

tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo [STOPPED] No llama-server process found.
    pause
    exit /B 0
)

echo [RUNNING] llama-server is active.
echo.

echo Active model:
powershell -NoProfile -Command "$proc = Get-WmiObject Win32_Process -Filter 'name=''llama-server.exe'''; $parts = $proc.CommandLine -split ' '; $idx = [array]::IndexOf($parts, '--model'); if ($idx -ge 0) { Write-Host $parts[$idx+1] } else { Write-Host '(could not parse)' }"

echo.
echo Health check:
curl -s http://localhost:8033/health
echo.

echo.
echo Web chat UI: http://localhost:8033  (open in browser)
echo API endpoint: http://localhost:8033/v1
echo.
echo Use stop-server.bat to stop it.
pause
