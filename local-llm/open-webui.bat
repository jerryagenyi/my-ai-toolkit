@echo off
:: MODEL-AGNOSTIC
:: Opens the llama-server built-in web chat UI in your default browser.
:: The server must already be running (use start-server_<model>.bat first).

tasklist /FI "IMAGENAME eq llama-server.exe" 2>NUL | find /I "llama-server.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] No server is running.
    echo Start a server first: double-click start-server_^<model^>.bat
    pause
    exit /B 1
)

echo Opening web chat UI at http://localhost:8033 ...
start "" "http://localhost:8033"
