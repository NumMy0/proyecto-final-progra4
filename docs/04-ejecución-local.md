# Ejecución y despliegue local

## Requisitos

- Node.js
- JDK instalado
- MySQL o XAMPP

## Opción recomendada

Desde la raíz del proyecto:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\run_all.ps1
```

Si tu MySQL requiere credenciales distintas, configura antes:

```powershell
$env:MYSQL_USER = 'root'
$env:MYSQL_PASSWORD = ''
```

Este script:

- inicializa la base de datos
- arranca el backend Java
- arranca el frontend Vue

## Ejecución manual

### Backend

```powershell
cd sistemamakeup
.\run_backend.ps1
```

### Frontend

```powershell
cd mi-sitio-maquillaje/frontend
.\run_frontend.ps1
```

## Puertos

- Frontend: `5173`
- Backend: `8080`

## Logs

Si ejecutas `run_all.ps1`, los logs quedan en:

- `out/logs/backend.out.log`
- `out/logs/backend.err.log`
- `out/logs/frontend.out.log`
- `out/logs/frontend.err.log`
