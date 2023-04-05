# Set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
# Prompt
Import-Module posh-git
$omp_config = Join-Path $PSScriptRoot ".\joelhu.omp.json" # Custom
# $omp_config = Join-Path $PSScriptRoot ".\bubblesextra.omp.json" # Bubbles 
# $omp_config = Join-Path $PSScriptRoot ".\iTerm2.omp.json" # iTerm2
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
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'


# Alias

function cdSA { set-location "~\source\repos\SA" }
function cdHome { set-location "~" }
function cdBack { 
	$localPath = Get-Location | Split-Path -Parent
	set-location $localPath
}
function getAll {
	Get-ChildItem -force
}

Set-Alias n z
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias PATH $Env:Path
Set-Alias sa cdSA
Set-Alias ~ cdHome
Set-Alias .. cdBack
Set-Alias ls getAll

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
