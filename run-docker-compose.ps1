param(
    [switch]$Detached
)

$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $scriptDir) {
    $scriptDir = Get-Location
}

Push-Location $scriptDir
try {
    $composeArgs = @('compose', 'up', '--build')
    if ($Detached) {
        $composeArgs += '--detach'
    }
    Write-Host "Running: docker $($composeArgs -join ' ')" -ForegroundColor Cyan
    docker @composeArgs
}
finally {
    Pop-Location
}
