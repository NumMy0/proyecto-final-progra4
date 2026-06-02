<#
run_backend.ps1
Script PowerShell para preparar, compilar y ejecutar el backend Java (RestServer).

Funcionamiento:
- Comprueba/crea carpeta `lib` y descarga `mysql-connector-java.jar` si falta.
- Compila todos los `.java` del directorio actual hacia `..\out\classes`.
- Ejecuta `sistemamakeup.RestServer` con el classpath correcto.

Ejecutar desde PowerShell (en Windows):
  cd <ruta a>/sistemamakeup
  .\run_backend.ps1
#>

$ErrorActionPreference = 'Stop'

Write-Host "[backend] Iniciando script de preparación..."

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

if (-not (Test-Path -Path "lib")) {
    Write-Host "[backend] Carpeta 'lib' no encontrada. Creando..."
    New-Item -ItemType Directory -Path lib | Out-Null
}

$jarPath = Join-Path -Path $here -ChildPath "lib\\mysql-connector-java.jar"
if (-not (Test-Path -Path $jarPath)) {
    Write-Host "[backend] Descargando MySQL Connector/J..."
    $versions = @('8.0.33','8.0.32','8.0.31','8.0.30')
    $downloaded = $false
    foreach ($v in $versions) {
        $url = "https://repo1.maven.org/maven2/mysql/mysql-connector-java/$v/mysql-connector-java-$v.jar"
        try {
            Invoke-WebRequest -Uri $url -OutFile $jarPath -UseBasicParsing -ErrorAction Stop
            Write-Host "[backend] Descarga completada: $jarPath (versión $v)"
            $downloaded = $true
            break
        } catch {
            Write-Host "[backend] URL no disponible: $url"
        }
    }
    if (-not $downloaded) {
        Write-Error "No se pudo descargar el driver desde Maven Central. Por favor descarga manualmente y colócalo en lib\\mysql-connector-java.jar"
        exit 1
    }
} else {
    Write-Host "[backend] Driver ya existe: $jarPath"
}

function Resolve-JavaTool {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ToolName
    )

    $knownPaths = @(
        "C:\Program Files\Eclipse Adoptium\jdk-25.0.3.9-hotspot\bin\$ToolName.exe",
        "C:\Program Files\Java\jdk-25\bin\$ToolName.exe",
        "C:\Program Files\Java\jdk-21\bin\$ToolName.exe"
    )

    foreach ($path in $knownPaths) {
        if (Test-Path -Path $path) {
            return $path
        }
    }

    $command = Get-Command $ToolName -ErrorAction SilentlyContinue
    if ($command -and $command.Source) {
        return $command.Source
    }

    try {
        $located = & where.exe $ToolName 2>$null | Select-Object -First 1
        if ($located) {
            return $located.Trim()
        }
    } catch {
        # Ignore and fall through to error below.
    }

    return $null
}

$javacPath = Resolve-JavaTool -ToolName 'javac'
$javaPath = Resolve-JavaTool -ToolName 'java'

if (-not $javacPath) {
    Write-Error "javac no encontrado. Instala JDK o ajusta la ruta en run_backend.ps1."
    exit 1
}

if (-not $javaPath) {
    Write-Error "java no encontrado. Instala JRE/JDK o ajusta la ruta en run_backend.ps1."
    exit 1
}

Write-Host "[backend] Usando javac: $javacPath"
Write-Host "[backend] Usando java : $javaPath"

$outDir = Join-Path -Path $here -ChildPath "..\out\classes"
if (-not (Test-Path -Path $outDir)) {
    Write-Host "[backend] Creando directorio de salida: $outDir"
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

Write-Host "[backend] Compilando archivos .java..."
$cp = Join-Path -Path $here -ChildPath "lib\mysql-connector-java.jar"

try {
    & $javacPath -d "..\out\classes" -cp $cp *.java
    Write-Host "[backend] Compilación finalizada correctamente."
} catch {
    Write-Error "Error durante la compilación: $_"
    exit 1
}

Write-Host "[backend] Ejecutando RestServer..."
$classpath = "..\out\classes;lib\mysql-connector-java.jar"

try {
    & $javaPath -cp $classpath sistemamakeup.RestServer
} catch {
    Write-Error "Error al ejecutar RestServer: $_"
    exit 1
}
