mkdir installer
"" > .\installer\installer.ps1
Get-Content .\chocoinstaller.psm1 >> installer\installer.ps1
Get-Content .\exeinstaller-init.ps1 >> installer\installer.ps1
invoke-ps2exe .\installer\installer.ps1 -requireAdmin