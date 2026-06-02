# Mi Sitio Maquillaje / SistemaMakeup

Proyecto de tienda de maquillaje dividido en dos partes:

- Frontend Vue + Tailwind en `mi-sitio-maquillaje/frontend`
- Backend Java + MySQL en `sistemamakeup`

## Documentación

- [Visión general](docs/00-visión-general.md)
- [Frontend Vue y Tailwind](docs/01-frontend-vue-tailwind.md)
- [Backend Java](docs/02-backend-java.md)
- [Base de datos](docs/03-base-de-datos.md)
- [Ejecución y despliegue local](docs/04-ejecución-local.md)
- [API HTTP](docs/05-api-http.md)

## Arranque rápido

Desde la raíz del proyecto:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\run_all.ps1
```

Si tu MySQL no usa usuario `root` o tiene contraseña, define antes estas variables en PowerShell:

```powershell
$env:MYSQL_USER = 'root'
$env:MYSQL_PASSWORD = ''
```

## Puertos

- Frontend: `http://localhost:5173`
- Backend: `http://localhost:8080`
