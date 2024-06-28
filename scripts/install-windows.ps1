# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
	Write-Host "This script requires administrator privileges. Please run it as an administrator."
		exit
}

# Check and set execution policy
try {
	$currentPolicy = Get-ExecutionPolicy
		if ($currentPolicy -ne "RemoteSigned") {
			Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
				Write-Host "Execution policy set to RemoteSigned for current user."
		}
} catch {
	Write-Host "Failed to set execution policy: $_"
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

# Check if winget is installed
if (-not (Test-Command winget)) {
	Write-Host "Winget is not installed. Attempting to install..."
		try {
			$wingetUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
				$wingetInstaller = "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
				Invoke-WebRequest -Uri $wingetUrl -OutFile $wingetInstaller
				Add-AppxPackage -Path $wingetInstaller
				Remove-Item $wingetInstaller

				if (Test-Command winget) {
					Write-Host "Winget has been successfully installed."
				} else {
					throw "Winget installation failed."
				}
		} catch {
			Write-Host "Failed to install winget: $_"
				Write-Host "Please install it manually from the Microsoft Store."
				exit
		}
}

# Function to install a winget package
function Install-WingetPackage($packageId, $commandName) {
	if (-not (Test-Command $commandName)) {
		Write-Host "Installing $packageId..."
			try {
				winget install $packageId
			} catch {
				Write-Host "Failed to install $packageId: $_"
			}
	} else {
		Write-Host "$packageId is already installed."
	}
}

# Function to install a module if it's not already installed
function Install-ModuleIfNotPresent($moduleName) {
	if (-not (Get-Module -ListAvailable -Name $moduleName)) {
		Write-Host "Installing $moduleName..."
			try {
				Install-Module -Name $moduleName -Force -Scope CurrentUser
			} catch {
				Write-Host "Failed to install $moduleName: $_"
			}
	} else {
		Write-Host "$moduleName is already installed."
	}
}

# Function to create a symlink
function Create-Symlink($source, $destination) {
	try {
		if (Test-Path $destination) {
			Write-Host "Existing file found at $destination. Creating backup..."
				Move-Item $destination "$destination.backup" -Force
		}
		New-Item -ItemType SymbolicLink -Path $destination -Target $source -Force
			Write-Host "Symlink created: $destination -> $source"
	} catch {
		Write-Host "Failed to create symlink $destination -> $source: $_"
	}
}

# Install winget packages
$wingetPackages = @(
		@{Id="Microsoft.PowerShell"; Command="pwsh"},
		@{Id="JanDeDobbeleer.OhMyPosh"; Command="oh-my-posh"},
		@{Id="fzf"; Command="fzf"},
		@{Id="Git.Git"; Command="git"},
		@{Id="Neovim.Neovim"; Command="nvim"},
		@{Id="jesseduffield.lazygit"; Command="lazygit"},
		@{Id="wez.wezterm"; Command="wezterm"}
		)

foreach ($package in $wingetPackages) {
	Install-WingetPackage $package.Id $package.Command
}

# Install PowerShell modules
$psModules = @("posh-git", "Terminal-Icons", "PSReadLine", "PSFzf")

foreach ($module in $psModules) {
	Install-ModuleIfNotPresent $module
}

# Install Kanata
if (-not (Test-Command kanata)) {
	Write-Host "Installing Kanata..."
		try {
			$kanataPath = "$env:LOCALAPPDATA\Programs\kanata"
				New-Item -ItemType Directory -Force -Path $kanataPath
				$kanataUrl = "https://github.com/jtroo/kanata/releases/latest/download/kanata.exe"
				Invoke-WebRequest -Uri $kanataUrl -OutFile "$kanataPath\kanata.exe"
				[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$kanataPath", [System.EnvironmentVariableTarget]::User)
				$env:Path += ";$kanataPath"
					Write-Host "Kanata installed successfully."
		} catch {
			Write-Host "Failed to install Kanata: $_"
		}
} else {
	Write-Host "Kanata is already installed."
}

# Install GlazeWM
if (-not (Test-Command glazewm)) {
	Write-Host "Installing GlazeWM..."
		try {
			$glazeWmUrl = "https://github.com/glazerdesktop/GlazeWM/releases/latest/download/GlazeWM_x64.msi"
				$glazeWmInstaller = "$env:TEMP\GlazeWM_x64.msi"
				Invoke-WebRequest -Uri $glazeWmUrl -OutFile $glazeWmInstaller
				Start-Process msiexec.exe -Wait -ArgumentList "/I $glazeWmInstaller /quiet"
				Remove-Item $glazeWmInstaller
				Write-Host "GlazeWM installed successfully."
		} catch {
			Write-Host "Failed to install GlazeWM: $_"
		}
} else {
	Write-Host "GlazeWM is already installed."
}

# Function to create a symlink
function Create-Symlink($source, $destination) {
	try {
# Check if the source exists
		if (-not (Test-Path $source)) {
			Write-Host "Warning: Source does not exist: $source"
				return
		}

# Create the parent directory of the destination if it doesn't exist
		$destinationParent = Split-Path -Parent $destination
			if (-not (Test-Path $destinationParent)) {
				New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
			}

		if (Test-Path $destination) {
			Write-Host "Existing file found at $destination. Creating backup..."
				Move-Item $destination "$destination.backup" -Force
		}
		New-Item -ItemType SymbolicLink -Path $destination -Target $source -Force
			Write-Host "Symlink created: $destination -> $source"
	} catch {
		Write-Host "Failed to create symlink $destination -> $source: $_"
	}
}

# Create symlinks
$dotfilesDir = "$env:USERPROFILE\.dotfiles"

$symlinks = @(
		@{Source="$dotfilesDir\powershell\config.ps1"; Destination="$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"},
		@{Source="$dotfilesDir\nvim"; Destination="$env:LOCALAPPDATA\nvim-data"},
		@{Source="$dotfilesDir\lazygit\config.yml"; Destination="$env:APPDATA\lazygit\config.yml"},
		@{Source="$dotfilesDir\wezterm\config.lua"; Destination="$env:USERPROFILE\.wezterm.lua"},
		@{Source="$dotfilesDir\kanata\red.kbd"; Destination="$env:USERPROFILE\kanata.kbd"},
		@{Source="$dotfilesDir\glaze-wm\config.yaml"; Destination="$env:USERPROFILE\.glaze-wm\config.yaml"},
		# @{Source="$dotfilesDir\windows-terminal\settings.json"; Destination="$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"},
		@{Source="$dotfilesDir\zellij\config.kdl"; Destination="$env:USERPROFILE\.config\zellij\config.kdl"}
		)

foreach ($link in $symlinks) {
	Create-Symlink $link.Source $link.Destination
}

Write-Host "Installation completed!"
