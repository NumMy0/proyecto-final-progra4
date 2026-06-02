# Base de datos

## Ubicación

- `mi-sitio-maquillaje/init_db.sql`

## Motor esperado

- MySQL / XAMPP

## Base de datos

- Nombre: `sistema_maquillaje`

## Tablas

### `productos`

Campos principales:

- `id`
- `nombre`
- `marca`
- `precio`
- `precioBase`
- `stock`
- `tipo`
- `atributoEspecial`

### `clientes`

Campos principales:

- `id`
- `nombre`
- `email`

## Semilla inicial

El script inserta productos de ejemplo y dos clientes de prueba.

## Notas de compatibilidad

- El DAO de productos usa `precioBase`, `tipo` y `atributoEspecial` para reconstruir los objetos.
- El backend envía JSON con `precioBase`, `tipo` y `atributoEspecial`.

## Recomendación

Ejecuta este script antes de levantar el backend para asegurar que la API encuentre datos.
