Write-ColoredOutput "Upgrade pip" "Magenta"
python -m pip install --upgrade pip

# Install yasb
Write-Host ""
$yasbPath = "${env:USERPROFILE}\tools\yasb"
if (-not (Test-Path ${yasbPath})) {
	Write-ColoredOutput "Clone yasb" "Magenta"
	git clone https://github.com/da-rth/yasb.git $yasbPath
}
else {
	Write-ColoredOutput "Update yasb" "Magenta"
	git -C $yasbPath pull
}

$requirementsContent = Get-Content ${env:USERPROFILE}\tools\yasb\requirements.txt
$requirementsContent = $requirementsContent -replace 'pywin32==304', 'pypiwin32'
$requirementsContent | Set-Content ${env:USERPROFILE}\tools\yasb\requirements.txt

Write-Host ""
pip install -r ${env:USERPROFILE}\tools\yasb\requirements.txt

