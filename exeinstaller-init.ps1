$host.ui.RawUI.WindowTitle = "InstantChocolate - Please wait..."

Function Get-PSScriptPath {

    <#
    
    .SYNOPSIS
    Returns the current filepath of the .ps1 or compiled .exe with Win-PS2EXE.
    
    .DESCRIPTION
    This will return the path of the file. This will work when the .ps1 file is
    converted with Win-PS2EXE
    
    .NOTES
    Author: Ste
    Date Created: 2021.05.03
    Tested with PowerShell 5.1 and 7.1.
    Posted here: https://stackoverflow.com/q/60121313/8262102
    
    .PARAMETER None
    NA
    
    .INPUTS
    None. You cannot pipe objects to Get-PSScriptPath.
    
    .OUTPUTS
    Returns the current filepath of the .ps1 or compiled .exe with Win-PS2EXE.
    
    .EXAMPLE (When run from a .ps1 file)
    PS> Get-PSScriptPath
    PS> C:\Users\Desktop\temp.ps1
    
    .EXAMPLE (When run from a compiled .exe file with Win-PS2EXE.
    PS> Get-PSScriptPath
    PS> C:\Users\Desktop\temp.exe
    
    #>
    
    if ([System.IO.Path]::GetExtension($PSCommandPath) -eq '.ps1') {
      $psScriptPath = $PSCommandPath
      } else {
        # This enables the script to be compiles and get the directory of it.
        $psScriptPath = [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
      }
      return $psScriptPath
}

$scriptPath = Get-PsScriptPath
$bytes = Get-Content $scriptPath
$regex = [Regex]"INSTANTCHOCOLATE"
$installList = $regex.Split($bytes)[1]
$installList =  ConvertFrom-Json  $installList
Choco-Installer $installList