$env:Path += ';C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE'
$env:LC_MESSAGES="en-US"
$env:TERM='xterm-256color'
$Env:KOMOREBI_CONFIG_HOME = "${Env:USERPROFILE}\.config\komorebi"
$KanataConfigLocation = "${Env:USERPROFILE}\kanata.kbd"

# Set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
# Prompt
# Import-Module posh-git
# $omp_config = "~/.dotfiles/ohmyposh/config.yaml"

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -EnableAliasFuzzyKillProcess

# Modify table
# Update-FormatData -Prepend C:\Users\joelhu\.config\powershell\FileFormat.format.ps1xml

# Alias
function cdSA { 
	set-location "C:\SA" 
}
function cdHome { 
	set-location "~" 
}
function cdBack { 
	$localPath = Get-Location | Split-Path -Parent
		set-location $localPath
}

function Copy-FileToClipboard {
    param(
        [string]$FilePath
    )

    if (Test-Path $FilePath) {
        Get-Content -Path $FilePath | Set-Clipboard
        Write-Host "Contents of '$FilePath' copied to clipboard."
    } else {
        Write-Host "Error: File '$FilePath' not found."
    }
}

# Function to write colored output
function Write-ColoredOutput($message, $color) {
    Write-Host $message -ForegroundColor $color
}

# Function to check if a command exists
function Test-Command(${command}) {
    try {
        if (Get-Command ${command} -ErrorAction Stop) { return $true }
    } catch {
        return $false
    }
}

# Define a script block to be executed when the current directory changes
# $directoryChangedScriptBlock = {
# 	$Host.UI.RawUI.WindowTitle = Get-Location | Split-Path -Leaf
# }

# Create a FileSystemWatcher to monitor directory changes
# $watcher = New-Object System.IO.FileSystemWatcher
# $watcher.Path = (Get-Location).Path
# $watcher.IncludeSubdirectories = $false
# $watcher.EnableRaisingEvents = $true

# Register the event for directory changes
# $eventSubscriber = Register-ObjectEvent -InputObject $watcher -EventName Changed -Action $directoryChangedScriptBlock


Set-Alias g git
Set-Alias n nvim
Set-Alias t z
Set-Alias to z
Set-Alias lg lazygit
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias PATH $Env:Path
Set-Alias sa cdSA
Set-Alias ~ cdHome
Set-Alias .. cdBack
Set-Alias build buildSA
Set-Alias rebuild rebuildSA
Set-Alias gd showGitDiff
Set-Alias copydir Copy-DirectoryWithConfirmation
Set-Alias yasb startYasb
Set-Alias rb rebuild
Set-Alias b build
Set-Alias c cleanSlnOrProject

function showGitDiff {
	git diff -w
}

function startYasb {
	pythonw ${env:USERPROFILE}\tools\yasb\src\main.py
}

function kb {
	kanata --port 12345 -c $KanataConfigLocation &
}


function komokana {
	komokana -t -p 12345 -d colemak -c .\komokana.yaml &
}

# Utilities
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue | 
		Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function komo {
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [string]$Command,
        
        [Parameter(Position=1)]
        [string]$Config = "komorebi"
    )
    
    switch ($Command.ToLower()) {
        "start" {
            # Kill existing instances if running
            Get-Process komorebi -ErrorAction SilentlyContinue | Stop-Process
            Get-Process whkd -ErrorAction SilentlyContinue | Stop-Process
            Get-Process pythonw -ErrorAction SilentlyContinue | Stop-Process
            
            # Start Komorebi with specific config
            $configPath = "$env:USERPROFILE\.config\komorebi\$Config.json"
            if (Test-Path $configPath) {
				& komorebic start --whkd -c ${configPath}
				& yasb
                Write-Host "Started Komorebi and whkd with config: $Config"
            } else {
                Write-Host "Error: Config file not found at $configPath"
            }
        }
        "stop" {
			& komorebic stop --whkd
            Get-Process pythonw -ErrorAction SilentlyContinue | Stop-Process
            Write-Host "Stopped Komorebi and whkd"
        }
        default {
            Write-Host "Usage:"
            Write-Host "  komo start [config]  - Start Komorebi and whkd with optional config name"
            Write-Host "  komo stop            - Stop Komorebi and whkd"
        }
    }
}

# Functions
function open {
	param ($file)

		Invoke-Item $file
}

function rebuild {
	msbuild /t:Rebuild /maxcpucount:3
}

function build {
	msbuild /maxcpucount:3
}

function cleanSlnOrProject {
	msbuild /t:clean /maxcpucount:3
}

function buildSA {
	$solutionDir = Get-Location;
	$currentDirName = $solutionDir | Split-Path -Leaf;
	if ($currentDirName -ne "SweetAutomation") {
		$solutionDir = Join-Path -Path $solutionDir -ChildPath "..";
	}

	Write-Host "Building $(Get-Location | Split-Path -Leaf)" -foregroundcolor green
		& "msbuild" -t:Build -m:12 -p:SolutionDir=$solutionDir;
}


function rebuildSA {
	$solutionDir = Get-Location;
	$currentDirName = $solutionDir | Split-Path -Leaf;
	if ($currentDirName -ne "SweetAutomation") {
		$solutionDir = Join-Path -Path $solutionDir -ChildPath "..";
	}
	Write-Host "Rebuilding $(Get-Location | Split-Path -Leaf)" -foregroundcolor green
		& "msbuild" -t:Rebuild -m:12 -p:SolutionDir=$solutionDir;
}

function Copy-DirectoryWithConfirmation {
	param(
			[string]$sourcePath,
			[string]$destinationPath
		 )

# Check if source directory exists
		if (-not (Test-Path $sourcePath -PathType Container)) {
			Write-Host "Source directory '$sourcePath' not found."
				return
		}

# Build the full destination path including the source directory name
	$fullDestinationPath = Join-Path -Path $destinationPath -ChildPath (Split-Path $sourcePath -Leaf)

# Check if destination directory exists
		if (Test-Path $fullDestinationPath -PathType Container) {
# Destination directory exists, prompt for confirmation
			$confirmation = Read-Host "Destination directory '$fullDestinationPath' already exists. Do you want to overwrite? (Y/N)"
				if ($confirmation -ne 'Y') {
					Write-Host "Copy operation canceled."
						return
				}
		}

# Copy the directory and its contents
	Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force;

	Write-Host "Directory '$sourcePath' successfully copied to '$fullDestinationPath'."
}


function branch {
	$branch = git rev-parse --abbrev-ref HEAD;

	return $branch;
}

# function Set-EnvVar
# {
#   $p = $executionContext.SessionState.Path.CurrentLocation
#   $osc7 = ""
#   if ($p.Provider.Name -eq "FileSystem")
#   {
#     $ansi_escape = [char]27
#     $provider_path = $p.ProviderPath -Replace "\\", "/"
#     $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
#   }
#   $env:OSC7=$osc7
# }
# New-Alias -Name 'Set-PoshContext' -Value 'Set-EnvVar' -Scope Global -Force

$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

# Invoke-Expression (&starship init powershell)
# $omp_config = "~/.dotfiles/ohmyposh/catppuccin.yaml"
# oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression
Invoke-Expression (&starship init powershell)
