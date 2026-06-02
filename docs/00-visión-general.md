# Visión general

Este proyecto implementa una tienda de maquillaje con una separación clara entre interfaz, lógica de negocio y persistencia.

## Estructura principal

- `mi-sitio-maquillaje/frontend`: aplicación Vue 3 con Vite, Vue Router y Tailwind CSS.
- `sistemamakeup`: backend Java con servidor HTTP nativo, DAOs y modelo de dominio.
- `mi-sitio-maquillaje/init_db.sql`: script de creación e inicialización de la base de datos.
- `run_all.ps1`: script orquestador para levantar backend, frontend e inicializar MySQL.

## Flujo general

1. El frontend consulta productos a `GET /api/productos`.
2. El backend lee los datos desde MySQL y los transforma en JSON.
3. La vista de catálogo agrega productos al carrito en memoria local.
4. El checkout usa el total acumulado del carrito y simula la confirmación de pago.

## Objetivo visual

La interfaz sigue una estética “Cuties”: paleta suave, cards redondeadas, gradientes rosados y microanimaciones ligeras.
