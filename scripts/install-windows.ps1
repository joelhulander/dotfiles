# Function to write colored output
function Write-ColoredOutput($message, $color) {
    Write-Host $message -ForegroundColor $color
}

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not ${isAdmin}) {
    Write-ColoredOutput "This script requires administrator privileges. Please run it as an administrator." "Red"
    exit
}

# Check and set execution policy
try {
    ${currentPolicy} = Get-ExecutionPolicy
    if (${currentPolicy} -ne "RemoteSigned") {
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Write-ColoredOutput "Execution policy set to RemoteSigned for current user." "Green"
    }
} catch {
    Write-ColoredOutput "Failed to set execution policy: $_" "Red"
    exit
}

# Function to check if a command exists
function Test-Command(${command}) {
    try {
        if (Get-Command ${command} -ErrorAction Stop) { return $true }
    } catch {
        return $false
    }
}

# Check if winget is installed
if (-not (Test-Command winget)) {
    Write-ColoredOutput "Winget is not installed. Attempting to install..." "Yellow"
    try {
        ${wingetUrl} = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        ${wingetInstaller} = "${env:TEMP}\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        Invoke-WebRequest -Uri ${wingetUrl} -OutFile ${wingetInstaller}
        Add-AppxPackage -Path ${wingetInstaller}
        Remove-Item ${wingetInstaller}

        if (Test-Command winget) {
            Write-ColoredOutput "Winget has been successfully installed." "Green"
        } else {
            throw "Winget installation failed."
        }
    } catch {
        Write-ColoredOutput "Failed to install winget: $_" "Red"
        Write-ColoredOutput "Please install it manually from the Microsoft Store." "Yellow"
        exit
    }
}

# Function to install a winget package
function Install-WingetPackage(${packageId}, ${commandName}) {
    if (-not (Test-Command ${commandName})) {
        Write-ColoredOutput "Installing ${packageId}..." "Cyan"
        try {
            winget install ${packageId}
            Write-ColoredOutput "${packageId} installed successfully." "Green"
        } catch {
            Write-ColoredOutput "Failed to install ${packageId}: $_" "Red"
        }
    } else {
        Write-ColoredOutput "${packageId} is already installed." "Green"
    }
}

# Function to install a module if it's not already installed
function Install-ModuleIfNotPresent(${moduleName}) {
    if (-not (Get-Module -ListAvailable -Name ${moduleName})) {
        Write-ColoredOutput "Installing ${moduleName}..." "Cyan"
        try {
            Install-Module -Name ${moduleName} -Force -Scope CurrentUser
            Write-ColoredOutput "${moduleName} installed successfully." "Green"
        } catch {
            Write-ColoredOutput "Failed to install ${moduleName}: $_" "Red"
        }
    } else {
        Write-ColoredOutput "${moduleName} is already installed." "Green"
    }
}

Write-ColoredOutput "Enable long path support since it is recommended for komorebi" "Magenta"
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

# Install winget packages
${wingetPackages} = @(
    @{Id="Microsoft.PowerShell"; Command="pwsh"},
    @{Id="JanDeDobbeleer.OhMyPosh"; Command="oh-my-posh"},
    @{Id="fzf"; Command="fzf"},
    @{Id="Git.Git"; Command="git"},
    @{Id="Neovim.Neovim"; Command="nvim"},
    @{Id="jesseduffield.lazygit"; Command="lazygit"},
    @{Id="wez.wezterm"; Command="wezterm"},
	@{Id="LGUG2Z.komorebi"; Command="komorebi"},
	@{Id="LGUG2Z.whkd"; Command="whkd"}
)

Write-ColoredOutput "Installing Winget packages..." "Magenta"
foreach (${package} in ${wingetPackages}) {
    Install-WingetPackage ${package}.Id ${package}.Command
}

# Install PowerShell modules
${psModules} = @("posh-git", "Terminal-Icons", "PSReadLine", "PSFzf")

Write-ColoredOutput "Installing PowerShell modules..." "Magenta"
foreach (${module} in ${psModules}) {
    Install-ModuleIfNotPresent ${module}
}

# Install Kanata
if (-not (Test-Command kanata)) {
    Write-ColoredOutput "Installing Kanata..." "Cyan"
    try {
        ${kanataPath} = "${env:LOCALAPPDATA}\Programs\kanata"
        New-Item -ItemType Directory -Force -Path ${kanataPath}
        ${kanataUrl} = "https://github.com/jtroo/kanata/releases/latest/download/kanata.exe"
        Invoke-WebRequest -Uri ${kanataUrl} -OutFile "${kanataPath}\kanata.exe"
        [Environment]::SetEnvironmentVariable("Path", ${env:Path} + ";${kanataPath}", [System.EnvironmentVariableTarget]::User)
        ${env:Path} += ";${kanataPath}"
        Write-ColoredOutput "Kanata installed successfully." "Green"
    } catch {
        Write-ColoredOutput "Failed to install Kanata: $_" "Red"
    }
} else {
    Write-ColoredOutput "Kanata is already installed." "Green"
}

# Install GlazeWM
if (-not (Test-Command glazewm)) {
    Write-ColoredOutput "Installing GlazeWM..." "Cyan"
    try {
        ${glazeWmUrl} = "https://github.com/glazerdesktop/GlazeWM/releases/latest/download/GlazeWM_x64.msi"
        ${glazeWmInstaller} = "${env:TEMP}\GlazeWM_x64.msi"
        Invoke-WebRequest -Uri ${glazeWmUrl} -OutFile ${glazeWmInstaller}
        Start-Process msiexec.exe -Wait -ArgumentList "/I ${glazeWmInstaller} /quiet"
        Remove-Item ${glazeWmInstaller}
        Write-ColoredOutput "GlazeWM installed successfully." "Green"
    } catch {
        Write-ColoredOutput "Failed to install GlazeWM: $_" "Red"
    }
} else {
    Write-ColoredOutput "GlazeWM is already installed." "Green"
}

# Function to create a directory if it doesn't exist
function Ensure-Directory(${path}) {
    if (-not (Test-Path ${path})) {
        try {
            New-Item -ItemType Directory -Path ${path} -Force | Out-Null
            Write-ColoredOutput "Created directory: ${path}" "Green"
        } catch {
            Write-ColoredOutput "Failed to create directory ${path}: $_" "Red"
            return $false
        }
    }
    return $true
}

# Function to create a symlink
function Create-Symlink(${source}, ${destination}) {
    try {
        # Resolve full paths
        ${source} = [System.IO.Path]::GetFullPath(${source})
        ${destination} = [System.IO.Path]::GetFullPath(${destination})

        Write-ColoredOutput "Creating symlink:" "Cyan"
        Write-ColoredOutput "  Source: ${source}" "DarkCyan"
        Write-ColoredOutput "  Destination: ${destination}" "DarkCyan"

        # Check if the source exists
        if (-not (Test-Path ${source})) {
            Write-ColoredOutput "Warning: Source does not exist: ${source}" "Yellow"
            return
        }

        # Ensure the parent directory of the destination exists
        ${destinationParent} = [System.IO.Path]::GetDirectoryName(${destination})
        if (-not (Ensure-Directory ${destinationParent})) {
            return
        }

        # Remove existing destination if it exists
        if (Test-Path ${destination}) {
            if ((Get-Item ${destination} -Force).LinkType) {
                Remove-Item ${destination} -Force
                Write-ColoredOutput "  Removed existing link: ${destination}" "Yellow"
            } else {
                # If it's a file or directory, move it to a backup
                ${backupPath} = "${destination}.backup"
                Move-Item ${destination} ${backupPath} -Force
                Write-ColoredOutput "  Moved existing item to backup: ${backupPath}" "Yellow"
            }
        }

        # Create the symlink (for both files and directories)
        New-Item -ItemType SymbolicLink -Path ${destination} -Target ${source} -Force | Out-Null
        
        if (Test-Path ${destination}) {
            Write-ColoredOutput "  Symlink created successfully" "Green"
        } else {
            Write-ColoredOutput "  Failed to create symlink" "Red"
        }
    } catch {
        Write-ColoredOutput "Failed to create symlink ${destination} -> ${source}: $_" "Red"
    }
}

# Create symlinks
${dotfilesDir} = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine(${env:USERPROFILE}, ".dotfiles"))

${symlinks} = @(
    @{Source="${dotfilesDir}\powershell\config.ps1"; Destination="${env:USERPROFILE}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"},
    @{Source="${dotfilesDir}\nvim"; Destination="${env:LOCALAPPDATA}\nvim"},
    @{Source="${dotfilesDir}\lazygit\config.yml"; Destination="${env:APPDATA}\lazygit\config.yml"},
    @{Source="${dotfilesDir}\wezterm\config.lua"; Destination="${env:USERPROFILE}\.wezterm.lua"},
    @{Source="${dotfilesDir}\ohmyposh\catppuccin.yaml"; Destination="${env:USERPROFILE}\Documents\PowerShell\catppuccin.omp.yaml"},
    @{Source="${dotfilesDir}\kanata\red.kbd"; Destination="${env:USERPROFILE}\kanata.kbd"},
    @{Source="${dotfilesDir}\vsvim\.vimrc"; Destination="${env:USERPROFILE}\.vimrc"},
    @{Source="${dotfilesDir}\glaze-wm\config.yaml"; Destination="${env:USERPROFILE}\.glaze-wm\config.yaml"},
    @{Source="${dotfilesDir}\zellij\config.kdl"; Destination="${env:USERPROFILE}\.config\zellij\config.kdl"},
    @{Source="${dotfilesDir}\komorebi\komorebi.json"; Destination="${env:USERPROFILE}\.config\komorebi\komorebi.json"},
    @{Source="${dotfilesDir}\komorebi\applications.yaml"; Destination="${env:USERPROFILE}\.config\komorebi\applications.yaml"},
    @{Source="${dotfilesDir}\komorebi\whkdrc"; Destination="${env:USERPROFILE}\.config\whkdrc"}
)

Write-ColoredOutput "Creating symlinks..." "Magenta"
foreach (${link} in ${symlinks}) {
    Create-Symlink ${link}.Source ${link}.Destination
}

Write-ColoredOutput "Installation completed!" "Green"
