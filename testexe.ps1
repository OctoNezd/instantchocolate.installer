.\build-exeinstaller.ps1
. .\test-data.ps1

Add-Content -Path .\installer\installer.exe -Value ("INSTANTCHOCOLATE" + (ConvertTo-Json $packageJson))
