function Write-ColoredOutput($message, $color) {
    Write-Host $message -ForegroundColor $color
}

Write-ColoredOutput "==== Upgrading winget packages ====" "Magenta"
winget upgrade --all --accept-source-agreements --accept-package-agreements --silent

Write-Host ""
Write-ColoredOutput "==== Upgrading scoop packages ====" "Magenta"
scoop update *

Write-Host ""
Write-ColoredOutput "==== Upgrading PowerShell modules ====" "Magenta"
Get-InstalledModule | ForEach-Object {
    Write-ColoredOutput "  $($_.Name)..." "Cyan"
        Update-Module -Name $_.Name -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-ColoredOutput "All upgrades complete." "Green"
