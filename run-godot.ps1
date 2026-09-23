$ErrorActionPreference = 'Stop'

$projectRoot = $PSScriptRoot
$godotDirectory = Join-Path $projectRoot 'tools\godot'
$godotExecutable = Get-ChildItem -LiteralPath $godotDirectory -Filter '*.exe' -File | Select-Object -First 1

if (-not $godotExecutable) {
	throw "Godot executable not found in '$godotDirectory'."
}

$env:APPDATA = Join-Path $godotDirectory 'userdata'
$env:LOCALAPPDATA = Join-Path $godotDirectory 'cache'
$env:TEMP = Join-Path $godotDirectory 'temp'
$env:TMP = $env:TEMP

& $godotExecutable.FullName --path $projectRoot @args
exit $LASTEXITCODE
