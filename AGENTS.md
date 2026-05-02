# AGENTS.md

## What this repo does

Windows batch script that blocks Microsoft Office Copilot AI (ai.exe) using Windows IFEO (Image File Execution Options).

## Running the script

- Must run as Administrator - Right-click .bat file → Run as administrator
- Script creates registry key at `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ai.exe`
- Sets `Debugger` value to `systray.exe` to redirect ai.exe to a harmless executable
- After running, restart Word/Outlook to apply

## Reversing the block

```cmd
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ai.exe" /f
```

## Related

- `../bloquer_ia_outlook/outlook_kill_ai.bat` - Same script, single-line version