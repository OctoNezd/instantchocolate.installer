Remove-Module "chocoinstaller"
Import-Module ".\chocoinstaller.psm1"
. .\test-data.ps1
ChocoInstaller $packageJson -Dummy