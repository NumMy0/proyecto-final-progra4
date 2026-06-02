<#
run_frontend.ps1
Script PowerShell para preparar e iniciar el frontend Vue (Vite).

Funcionamiento:
- Comprueba que Node.js esté disponible.
- Entra a la carpeta `frontend`, ejecuta `npm install` si no existe `node_modules`.
- Ejecuta `npm run dev` para levantar el servidor de desarrollo.

Ejecutar desde PowerShell:
  cd <ruta a>/mi-sitio-maquillaje/frontend
  .\run_frontend.ps1
#>

$ErrorActionPreference = 'Stop'

Write-Host "[frontend] Iniciando script de preparación..."

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Error "Node.js no encontrado en PATH. Instala Node.js (v16+) antes de continuar."
    exit 1
}

if (-not (Test-Path -Path "node_modules")) {
    Write-Host "[frontend] node_modules no encontrada. Ejecutando 'npm install'..."
    try {
        & npm install
    } catch {
        Write-Error "Error en 'npm install': $_"
        exit 1
    }
} else {
    Write-Host "[frontend] node_modules ya existe. Saltando 'npm install'."
}

Write-Host "[frontend] Iniciando servidor de desarrollo (npm run dev)..."
try {
    & npm run dev
} catch {
    Write-Error "Error al ejecutar 'npm run dev': $_"
    exit 1
}
