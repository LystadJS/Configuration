[CmdletBinding()]
param(
  [string]$PositronUserDirectory = (Join-Path $env:APPDATA 'Positron\User'),
  [switch]$AirOnly
)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$airDir = Join-Path $env:APPDATA 'air'
$airTarget = Join-Path $airDir 'air.toml'
$airSource = Join-Path $root 'config\air\air.toml'
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
New-Item -ItemType Directory -Force -Path $airDir | Out-Null
if (Test-Path $airTarget) { Copy-Item $airTarget "$airTarget.backup-$stamp" }
Copy-Item $airSource $airTarget
Write-Host "Air defaults installed: $airTarget"
if ($AirOnly) { return }
$settingsPath = Join-Path $PositronUserDirectory 'settings.json'
New-Item -ItemType Directory -Force -Path $PositronUserDirectory | Out-Null
$source = Get-Content (Join-Path $root 'config\positron\settings.json') -Raw | ConvertFrom-Json
if (Test-Path $settingsPath) {
  Copy-Item $settingsPath "$settingsPath.backup-$stamp"
  try { $target = Get-Content $settingsPath -Raw | ConvertFrom-Json }
  catch { throw "Existing settings are not strict JSON. Backup saved; merge manually (JSONC comments/trailing commas are common)." }
} else { $target = [pscustomobject]@{} }
foreach ($p in $source.PSObject.Properties) {
  if ($p.Name -eq 'workbench.settings.applyToAllProfiles') {
    $existing = @()
    if ($target.PSObject.Properties[$p.Name]) { $existing = @($target.PSObject.Properties[$p.Name].Value) }
    $value = @($existing + @($p.Value) | Select-Object -Unique)
  } else { $value = $p.Value }
  if ($target.PSObject.Properties[$p.Name]) { $target.PSObject.Properties[$p.Name].Value = $value }
  else { $target | Add-Member -NotePropertyName $p.Name -NotePropertyValue $value }
}
$target | ConvertTo-Json -Depth 40 | Set-Content -Encoding utf8 $settingsPath
Write-Host "Positron user settings merged: $settingsPath"
Write-Host 'Install the Research Rail VSIX and verify each profile, following README.md.'
