# API HTTP

## Base URL

- `http://localhost:8080`

## Endpoints

### `GET /api/productos`

Devuelve el catálogo completo desde MySQL.

Respuesta típica:

```json
[
  {
    "id": "P001",
    "nombre": "Paleta de Sombras - Sunset",
    "precioBase": 15,
    "marca": "GlamColor",
    "tipo": "Ojos",
    "atributoEspecial": "true"
  }
]
```

### `GET /api/clientes`

Devuelve los clientes suscritos al boletín.

### `POST /api/clientes`

Crea un cliente nuevo.

Body esperado:

```json
{
  "nombre": "Ana Ruiz",
  "email": "ana@example.com"
}
```

## CORS

La API responde con `Access-Control-Allow-Origin: *` para permitir el consumo desde el frontend local.

## Errores conocidos

- El parser de `POST /api/clientes` es simple y solo maneja JSON plano.
- La API de productos no expone `stock` en la respuesta actual.
