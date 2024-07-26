$env:Path += ';C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE'
$Host.UI.RawUI.WindowTitle = 'Terminal'
$env:LC_MESSAGES="en-US"
$env:TERM='xterm-256color'
$Env:KOMOREBI_CONFIG_HOME = "${Env:USERPROFILE}\.config\komorebi"

# Set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
# Prompt
Import-Module posh-git
# $omp_config = "~/.dotfiles/ohmyposh/config.yaml"
$omp_config = "~/.dotfiles/ohmyposh/catppuccin.yaml"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

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
function getAll {
	Get-ChildItem -force | Format-Wide
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
Set-Alias ls getAll
Set-Alias build buildSA
Set-Alias rebuild rebuildSA
Set-Alias gd showGitDiff
Set-Alias copydir Copy-DirectoryWithConfirmation

function showGitDiff {
	git diff -w
}

# Utilities
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue | 
		Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Functions
function open {
	param ($file)

		Invoke-Item $file
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
	Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force

		Write-Host "Directory '$sourcePath' successfully copied to '$fullDestinationPath'."
}


function deploy {
	param (
			[Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
			[string]$branch
		  )

		$iisDeploymentPath = "C:\Users\joelhu\Applications\SweetAutomation";
	$currentDir = Get-Location;
	$currentDirName = $currentDir | Split-Path -Leaf;

	if ($currentDirName -eq "SweetAutomation") {
		$dir = Join-Path -Path $currentDir -ChildPath "CM\*";
	}
	else {
		$dir = Join-Path -Path $currentDir -ChildPath "Application\SweetAutomation\CM\*";
	}

	if ($branch -eq "dev") 
	{
		$dir = "C:\Users\joelhu\SA\development\Application\SweetAutomation\CM\*";
	}

	Copy-Item -Recurse -Force $dir $iisDeploymentPath;
	if ($branch -eq "dev") {
		Write-Host "Branch 'development' successfully deployed.";
	}
	else {
		$branch = git rev-parse --abbrev-ref HEAD;
			Write-Host "Branch '$branch' successfully deployed.";
	}
}

function root {
	$currentDir = Get-Location
		$dir = Join-Path -Path $currentDir -ChildPath "Application\SweetAutomation"

		set-location $dir
}

function branch {
	$branch = git rev-parse --abbrev-ref HEAD;

	return $branch;
}

function su {
	param (
			[Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
			[string]$folder
		  )


		$currentBranch = branch
		if ($folder) {

			Invoke-Expression "git branch --set-upstream-to=origin/$folder/$currentBranch";
		}
		else {
			Invoke-Expression "git branch --set-upstream-to=origin/$currentBranch";
		}
}
