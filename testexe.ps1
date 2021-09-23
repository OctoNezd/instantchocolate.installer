.\build-exeinstaller.ps1
. .\test-data.ps1
invoke-ps2exe .\installer\installer.ps1

Add-Content -Path .\installer\installer.exe -Value ("INSTANTCHOCOLATE" + $packageJson)
"Running installer"
.\installer.exe
