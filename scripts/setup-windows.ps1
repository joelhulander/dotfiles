# Function to install or update a Scoop package
function Install-OrUpdateScoopPackage(${packageName}) {
    if (-not (scoop info ${packageName})) {
        Write-ColoredOutput "Installing ${packageName} with Scoop..." "Cyan"
        try {
            scoop install ${packageName}
        } catch {
            Write-ColoredOutput "Failed to install ${packageName}: $_" "Red"
        }
    } else {
        Write-ColoredOutput "Checking for updates for ${packageName}..." "Cyan"
        try {
            $updateOutput = scoop update ${packageName} 2>&1
        } catch {
            Write-ColoredOutput "Failed to update ${packageName}: $_" "Red"
        }
    }
}

# Function to install or update a winget package
function Install-OrUpdateWingetPackage(${packageId}, ${commandName}) {
    if (-not (Test-Command ${commandName})) {
        Write-ColoredOutput "Installing ${commandName}..." "Cyan"
        try {
            $installOutput = winget install --id ${packageId} --accept-source-agreements --accept-package-agreements
            if ($installOutput -match "Successfully installed") {
                Write-ColoredOutput "${commandName} installed successfully." "Green"
            } else {
                Write-ColoredOutput "Unexpected result when installing ${packageId}. Please check manually." "Yellow"
                Write-ColoredOutput $installOutput "Gray"
            }
        } catch {
            Write-ColoredOutput "Failed to install ${commandName}: $_" "Red"
        }
    } else {
        Write-ColoredOutput "Checking for updates for ${commandName}..." "Cyan"
        try {
            $updateOutput = winget upgrade ${packageId} --accept-source-agreements --accept-package-agreements
            
            if ($updateOutput -match "No applicable update" -or 
                $updateOutput -match "No updates found" -or 
                $updateOutput -match "No available upgrade" -or
                $updateOutput -match "is already installed") {
                Write-ColoredOutput "${commandName} is already up to date." "Green"
            } 
            elseif ($updateOutput -match "Successfully installed" -or 
                    $updateOutput -match "Successfully upgraded") {
                Write-ColoredOutput "${commandName} updated successfully." "Green"
            }
            elseif ($updateOutput -match "Unable to upgrade") {
                Write-ColoredOutput "${commandName} could not be upgraded. It may already be up to date." "Yellow"
            }
            else {
                Write-ColoredOutput "Unexpected result when updating ${commandName}. Please check the output below:" "Yellow"
                Write-ColoredOutput $updateOutput "Gray"
            }
        } catch {
            Write-ColoredOutput "Failed to update ${commandName}: $_" "Red"
        }
    }
}

# Function to install or update a module
function Install-OrUpdateModule(${moduleName}) {
    if (-not (Get-Module -ListAvailable -Name ${moduleName})) {
        Write-ColoredOutput "Installing ${moduleName}..." "Cyan"
        try {
            Install-Module -Name ${moduleName} -Force -Scope CurrentUser
            Write-ColoredOutput "${moduleName} installed successfully." "Green"
        } catch {
            Write-ColoredOutput "Failed to install ${moduleName}: $_" "Red"
        }
    } else {
        Write-ColoredOutput "Checking for updates for ${moduleName}..." "Cyan"
        try {
            $currentVersion = (Get-Module -ListAvailable -Name ${moduleName}).Version
            Update-Module -Name ${moduleName} -Force -ErrorAction Stop
            $newVersion = (Get-Module -ListAvailable -Name ${moduleName}).Version
            if ($newVersion -gt $currentVersion) {
                Write-ColoredOutput "${moduleName} updated successfully." "Green"
            } else {
                Write-ColoredOutput "${moduleName} is already up to date." "Green"
            }
        } catch {
            Write-ColoredOutput "Failed to update ${moduleName}: $_" "Red"
        }
    }
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

# Script start

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

# Check if winget is installed
if (-not (Test-Command winget)) {
	Write-Host ""
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

# Check if Scoop is installed, if not, install it
if (-not (Test-Command scoop)) {
	Write-Host ""
    Write-ColoredOutput "Scoop is not installed. Attempting to install..." "Yellow"
    try {
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        if (Test-Command scoop) {
            Write-ColoredOutput "Scoop has been successfully installed." "Green"
        } else {
            throw "Scoop installation failed."
        }
    } catch {
        Write-ColoredOutput "Failed to install Scoop: $_" "Red"
        exit
    }
	Write-Host ""
}

# Install or update winget packages
${wingetPackages} = @(
    @{Id="Microsoft.PowerShell"; Command="pwsh"},
    @{Id="JanDeDobbeleer.OhMyPosh"; Command="oh-my-posh"},
    @{Id="fzf"; Command="fzf"},
    @{Id="Git.Git"; Command="git"},
    @{Id="Neovim.Neovim"; Command="nvim"},
    @{Id="jesseduffield.lazygit"; Command="lazygit"},
    @{Id="wez.wezterm"; Command="wezterm"},
    @{Id="LGUG2Z.komorebi"; Command="komorebi"},
    @{Id="LGUG2Z.whkd"; Command="whkd"},
	@{Id="Python.Python.3.10"; Command="Python"},
	@{Id="JernejSimoncic.Wget"; Command="Wget"}
)

Write-ColoredOutput "Installing or updating Winget packages..." "Magenta"
foreach (${package} in ${wingetPackages}) {
    Install-OrUpdateWingetPackage ${package}.Id ${package}.Command
}

Write-Host ""
Write-ColoredOutput "Enable long path support since it is recommended for komorebi" "Magenta"
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

# Install or update Scoop packages
${scoopPackages} = @("kanata", "PSReadLine", "PSFzf", "silicon") 

Write-Host ""
Write-ColoredOutput "Installing or updating Scoop packages..." "Magenta"
foreach(${package} in ${scoopPackages}) {
	Install-OrUpdateScoopPackage ${package}
}

# Install or update PowerShell modules
${psModules} = @("posh-git", "Terminal-Icons") 

Write-Host ""
Write-ColoredOutput "Installing or updating PowerShell modules..." "Magenta"
foreach (${module} in ${psModules}) {
    Install-OrUpdateModule ${module}
}

# Create symlinks
${dotfilesDir} = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine(${env:USERPROFILE}, ".dotfiles"))

${symlinks} = @(
    @{Source="${dotfilesDir}\powershell\config.ps1"; Destination="${env:USERPROFILE}\OneDrive - Sweet Systems AB\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"},
    @{Source="${dotfilesDir}\nvim"; Destination="${env:LOCALAPPDATA}\nvim"},
    @{Source="${dotfilesDir}\lazygit\config.yml"; Destination="${env:APPDATA}\lazygit\config.yml"},
    @{Source="${dotfilesDir}\silicon"; Destination="${env:APPDATA}\silicon"},
    @{Source="${dotfilesDir}\bat"; Destination="${env:APPDATA}\bat"},
    @{Source="${dotfilesDir}\wezterm"; Destination="${env:USERPROFILE}\.config/wezterm"},
    @{Source="${dotfilesDir}\ohmyposh\catppuccin.yaml"; Destination="${env:USERPROFILE}\Documents\PowerShell\catppuccin.omp.yaml"},
    @{Source="${dotfilesDir}\kanata\windows.kbd"; Destination="${env:USERPROFILE}\kanata.kbd"},
    @{Source="${dotfilesDir}\vsvim\.vimrc"; Destination="${env:USERPROFILE}\.vimrc"},
    @{Source="${dotfilesDir}\zellij\config.kdl"; Destination="${env:USERPROFILE}\.config\zellij\config.kdl"},
    @{Source="${dotfilesDir}\komorebi\komorebi.json"; Destination="${env:USERPROFILE}\.config\komorebi\komorebi.json"},
    @{Source="${dotfilesDir}\komorebi\applications.yaml"; Destination="${env:USERPROFILE}\.config\komorebi\applications.yaml"},
    @{Source="${dotfilesDir}\komorebi\whkdrc"; Destination="${env:USERPROFILE}\.config\whkdrc"},
	@{Source="${dotfilesDir}\yasb\config.yaml"; Destination="${env:USERPROFILE}\.yasb\config.yaml"},
	@{Source="${dotfilesDir}\yasb\styles.css"; Destination="${env:USERPROFILE}\.yasb\styles.css"}
)

Write-Host ""
Write-ColoredOutput "Creating symlinks..." "Magenta"
foreach (${link} in ${symlinks}) {
    Create-Symlink ${link}.Source ${link}.Destination
}

Write-Host ""
Write-ColoredOutput "Setup completed!" "Green"
