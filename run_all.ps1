<#
run_all.ps1
Comando único para arrancar backend y frontend del proyecto.

Uso:
  cd C:\Users\santi\dev\Progra4
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
  .\run_all.ps1

Comportamiento:
#- Lanza el backend y el frontend como procesos PowerShell separados.
#- Redirige la salida de ambos a logs dentro de `out\logs`.
#- Devuelve los PID para poder seguirlos o cerrarlos manualmente.
#>

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$backendScript = Join-Path $root 'sistemamakeup\run_backend.ps1'
$frontendScript = Join-Path $root 'mi-sitio-maquillaje\frontend\run_frontend.ps1'
$dbScript = Join-Path $root 'mi-sitio-maquillaje\init_db.sql'

function Stop-PortOwner {
    param(
        [Parameter(Mandatory = $true)]
        [int]$Port
    )

    $listeners = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue
    foreach ($listener in $listeners) {
        if ($listener.OwningProcess -and $listener.OwningProcess -ne 0) {
            try {
                Stop-Process -Id $listener.OwningProcess -Force -ErrorAction Stop
                Write-Host "[all] Cerrado proceso $($listener.OwningProcess) que ocupaba el puerto $Port"
            } catch {
                Write-Host "[all] No se pudo cerrar el proceso $($listener.OwningProcess) del puerto ${Port}: $($_.Exception.Message)"
            }
        }
    }
}

function Find-MySqlClient {
    $candidates = @(
        'C:\xampp\mysql\bin\mysql.exe',
        'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe'
    )

    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    $command = Get-Command mysql.exe -ErrorAction SilentlyContinue
    if ($command -and $command.Source) {
        return $command.Source
    }

    return $null
}

function Get-MySqlUser {
    if ($env:MYSQL_USER) {
        return $env:MYSQL_USER
    }

    return 'root'
}

function Get-MySqlPasswordArg {
    if ($env:MYSQL_PASSWORD) {
        return '-p' + $env:MYSQL_PASSWORD
    }

    return ''
}

if (-not (Test-Path $backendScript)) {
    Write-Error "No se encontró el script del backend: $backendScript"
    exit 1
}

if (-not (Test-Path $frontendScript)) {
    Write-Error "No se encontró el script del frontend: $frontendScript"
    exit 1
}

Write-Host "[all] Iniciando backend y frontend..."

Stop-PortOwner -Port 8080
Stop-PortOwner -Port 5173

if (-not (Test-Path $dbScript)) {
    Write-Error "No se encontró el script SQL de inicialización: $dbScript"
    exit 1
}

$mysqlPath = Find-MySqlClient
if (-not $mysqlPath) {
    Write-Error "No se encontró mysql.exe. Instala XAMPP/MySQL o agrega mysql.exe al PATH."
    exit 1
}

Write-Host "[all] Inicializando base de datos con $mysqlPath..."
$mysqlUser = Get-MySqlUser
$mysqlPasswordArg = Get-MySqlPasswordArg
$mysqlCommand = '"' + $mysqlPath + '" -u ' + $mysqlUser
if ($mysqlPasswordArg) {
    $mysqlCommand += ' ' + $mysqlPasswordArg
}
$mysqlCommand += ' < "' + $dbScript + '"'
cmd.exe /c $mysqlCommand
if ($LASTEXITCODE -ne 0) {
    Write-Error "Falló la inicialización de la base de datos. Revisa MYSQL_USER/MYSQL_PASSWORD o ejecuta init_db.sql manualmente."
    exit 1
}

$logDir = Join-Path $root 'out\logs'
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

$backendOutLog = Join-Path $logDir 'backend.out.log'
$backendErrLog = Join-Path $logDir 'backend.err.log'
$frontendOutLog = Join-Path $logDir 'frontend.out.log'
$frontendErrLog = Join-Path $logDir 'frontend.err.log'

$backendProcess = Start-Process `
    -FilePath 'powershell.exe' `
    -ArgumentList @(
        '-NoProfile',
        '-ExecutionPolicy', 'Bypass',
        '-File', $backendScript
    ) `
    -WorkingDirectory $root `
    -RedirectStandardOutput $backendOutLog `
    -RedirectStandardError $backendErrLog `
    -PassThru

$frontendProcess = Start-Process `
    -FilePath 'powershell.exe' `
    -ArgumentList @(
        '-NoProfile',
        '-ExecutionPolicy', 'Bypass',
        '-File', $frontendScript
    ) `
    -WorkingDirectory $root `
    -RedirectStandardOutput $frontendOutLog `
    -RedirectStandardError $frontendErrLog `
    -PassThru

Write-Host "[all] Backend iniciado con PID $($backendProcess.Id)"
Write-Host "[all] Frontend iniciado con PID $($frontendProcess.Id)"
Write-Host "[all] Logs:"
Write-Host "[all]   Backend stdout -> $backendOutLog"
Write-Host "[all]   Backend stderr -> $backendErrLog"
Write-Host "[all]   Frontend stdout -> $frontendOutLog"
Write-Host "[all]   Frontend stderr -> $frontendErrLog"
