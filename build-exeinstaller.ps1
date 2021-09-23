mkdir installer
magick -density 1024x1024 -background transparent favicon.svg -define icon:auto-resize installer\favicon.ico
"" > .\installer\installer.ps1
Get-Content .\chocoinstaller.psm1 >> installer\installer.ps1
Get-Content .\exeinstaller-init.ps1 >> installer\installer.ps1
invoke-ps2exe .\installer\installer.ps1 -requireAdmin -iconFile .\installer\favicon.ico