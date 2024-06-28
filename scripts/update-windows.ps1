# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges. Please run it as an administrator."
    exit
}

# Function to check if a command exists
function Test-Command($command) {
    try {
        if (Get-Command $command -ErrorAction Stop) { return $true }
    } catch {
        return $false
    }
}

# Function to update a winget package
function Update-WingetPackage($packageId) {
    Write-Host "Checking for updates for $packageId..."
    try {
        winget upgrade $packageId
    } catch {
        Write-Host "Failed to update $packageId: $_"
    }
}

# Function to update a PowerShell module
function Update-Module($moduleName) {
    Write-Host "Updating $moduleName..."
    try {
        Update-Module -Name $moduleName -Force
    } catch {
        Write-Host "Failed to update $moduleName: $_"
    }
}

# Update winget packages
$wingetPackages = @(
    "Microsoft.PowerShell",
    "JanDeDobbeleer.OhMyPosh",
    "fzf",
    "Git.Git",
    "Neovim.Neovim",
    "jesseduffield.lazygit",
    "wez.wezterm"
)

foreach ($package in $wingetPackages) {
    Update-WingetPackage $package
}

# Update PowerShell modules
$psModules = @("posh-git", "Terminal-Icons", "PSReadLine", "PSFzf")

foreach ($module in $psModules) {
    Update-Module $module
}

# Update Kanata
if (Test-Command kanata) {
    Write-Host "Checking for Kanata updates..."
    try {
        $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/jtroo/kanata/releases/latest"
        $latestVersion = $latestRelease.tag_name
        $currentVersion = (Get-Item (Get-Command kanata).Source).VersionInfo.FileVersion
        if ($latestVersion -ne $currentVersion) {
            Write-Host "Updating Kanata..."
            $kanataPath = (Get-Command kanata).Source | Split-Path -Parent
            $kanataUrl = "https://github.com/jtroo/kanata/releases/latest/download/kanata.exe"
            Invoke-WebRequest -Uri $kanataUrl -OutFile "$kanataPath\kanata.exe"
            Write-Host "Kanata updated successfully."
        } else {
            Write-Host "Kanata is up to date."
        }
    } catch {
        Write-Host "Failed to update Kanata: $_"
    }
} else {
    Write-Host "Kanata is not installed. Run the installation script first."
}

# Update GlazeWM
if (Test-Command glazewm) {
    Write-Host "Checking for GlazeWM updates..."
    try {
        $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/glazerdesktop/GlazeWM/releases/latest"
        $latestVersion = $latestRelease.tag_name
        $currentVersion = (Get-Item (Get-Command glazewm).Source).VersionInfo.FileVersion
        if ($latestVersion -ne $currentVersion) {
            Write-Host "Updating GlazeWM..."
            $glazeWmUrl = "https://github.com/glazerdesktop/GlazeWM/releases/latest/download/GlazeWM_x64.msi"
            $glazeWmInstaller = "$env:TEMP\GlazeWM_x64.msi"
            Invoke-WebRequest -Uri $glazeWmUrl -OutFile $glazeWmInstaller
            Start-Process msiexec.exe -Wait -ArgumentList "/I $glazeWmInstaller /quiet"
            Remove-Item $glazeWmInstaller
            Write-Host "GlazeWM updated successfully."
        } else {
            Write-Host "GlazeWM is up to date."
        }
    } catch {
        Write-Host "Failed to update GlazeWM: $_"
    }
} else {
    Write-Host "GlazeWM is not installed. Run the installation script first."
}

Write-Host "Update completed!"
