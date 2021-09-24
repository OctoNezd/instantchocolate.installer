function Choco-Installer {
    param (
        [Array]$packageList,
        [Switch]$Dummy
    )
    Write-Host "Checking if chocolatey is installed or not..."  
    try { choco }
    catch {
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        Write-Host "Checking if choco installed successfully..."
        try { choco } 
        catch {
            Write-Error "Failed to install choco, can't continue."
            Pause
            Exit
        }
    }

    $index = 1
    $fails = New-Object System.Collections.ArrayList
    foreach ($package in $packageList) {
        $host.ui.RawUI.WindowTitle = "InstantChocolate - $index of $($packageList.Length) - $($package.displayName)"
        Write-Progress -Activity "Installing `"$($package.displayName)`" ($($package.packageName))" -Status "Package $index out of $($packageList.Length)" -PercentComplete ($index / $packageList.Length * 100)
        if ($Dummy) {
            Start-Sleep 1
        } else {
            choco install -y $package.packageName
        }
        if (-Not $?) {
            $fails.Add($package.displayName) | out-null
        }
        $index++ | out-null
    }
    $host.ui.RawUI.WindowTitle = "InstantChocolate - Done"
    if ($fails.Count -ne 0) {
        Write-Host "Done, but with errors. Following packages failed to install: $($fails -join ", ")"
    } else {
        Write-Host "Done!"
    }
    if (-Not $Dummy) {
        pause
    }
}