@echo off
:: Adds Windows Firewall rule to allow llama-server on Tailscale interface.
:: Will trigger a UAC (admin) prompt — click Yes.

echo This will open a UAC prompt asking for administrator permission.
echo Click YES to allow the firewall rule to be added.
echo.

powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -Command New-NetFirewallRule -DisplayName ''llama-server Tailscale'' -Direction Inbound -Protocol TCP -LocalPort 8033 -Action Allow -InterfaceAlias Tailscale' -Verb RunAs -Wait"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Firewall rule added. Port 8033 is now open on Tailscale.
    echo Other Tailnet devices can reach the server at http://100.102.126.128:8033/v1
) else (
    echo.
    echo Failed or cancelled. If you clicked No on the UAC prompt, run this again and click Yes.
)
pause
