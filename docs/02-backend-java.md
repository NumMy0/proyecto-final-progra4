# Backend Java

## Ubicación

- `sistemamakeup`

## Tecnologías

- Java
- `com.sun.net.httpserver.HttpServer`
- JDBC
- MySQL Connector/J

## Responsabilidad

El backend expone una API HTTP simple para productos y clientes, compila el modelo de negocio Java y conecta con MySQL.

## Componentes principales

- `RestServer.java`: servidor HTTP y endpoints REST.
- `ProductoDAO.java`: lectura del catálogo desde MySQL.
- `ClienteDAO.java`: lectura e inserción de clientes.
- `ConexionBD.java`: apertura de conexión a la base de datos.
- `Producto.java`, `ProductoRostro.java`, `ProductoOjos.java`: jerarquía de productos.
- `Cliente.java`, `Observer.java`, `TiendaMaquillaje.java`: patrón Observer para notificaciones.
- `Venta.java`: agregación de productos y cálculo de total.

## Endpoints

- `GET /api/productos`
- `GET /api/clientes`
- `POST /api/clientes`

## Modelo de ejecución

El servidor escucha en `http://localhost:8080`.

## Observaciones técnicas

- El backend genera JSON de forma manual.
- El proyecto usa una contraseña fija en `ConexionBD.java`.
- El servidor `POST /api/clientes` espera un body JSON plano con `nombre` y `email`.

## Ejecución local

```powershell
cd sistemamakeup
.\run_backend.ps1
```
