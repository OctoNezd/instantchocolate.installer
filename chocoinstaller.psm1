function ChocoInstaller {
    param (
        [Array]$packageList
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
    foreach ($package in $packageList) {
        Write-Progress -Activity "Installing `"$($package.displayName)`" ($($package.packageName))" -Status "Package $index out of $($packageList.Length)" -PercentComplete ($index / $packageList.Length * 100)
        choco install -y $package.packageName
        $index++
    }
}