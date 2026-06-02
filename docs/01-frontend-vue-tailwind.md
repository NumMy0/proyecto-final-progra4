# Frontend Vue y Tailwind

## Ubicación

- `mi-sitio-maquillaje/frontend`

## Tecnologías

- Vue 3
- Vue Router
- Tailwind CSS 3
- Vite

## Estructura

- `src/App.vue`: shell principal de la aplicación, navbar y contenedor de páginas.
- `src/views/WelcomePage.vue`: landing de bienvenida.
- `src/views/CatalogoPage.vue`: pantalla de catálogo con carga desde la API.
- `src/views/CheckoutPage.vue`: flujo visual de checkout.
- `src/components/ProductList.vue`: listado, búsqueda y tarjetas de productos.
- `src/store/cart.js`: estado del carrito en memoria.
- `src/router/index.js`: rutas públicas del frontend.

## Estilo visual

La UI usa únicamente clases utilitarias de Tailwind.

Se priorizan:

- bordes redondeados amplios
- gradientes rosados suaves
- sombras ligeras
- fondo con halos y capas de color pastel
- animaciones sutiles en entrada, flotación y botones

## Responsabilidades por archivo

### `App.vue`

Contiene la navegación superior, el logo, y el contenedor principal de rutas.

### `WelcomePage.vue`

Presenta la marca, el mensaje principal y accesos directos al catálogo y checkout.

### `CatalogoPage.vue`

Recupera productos desde `http://localhost:8080/api/productos`, muestra el contador del carrito y dirige al checkout.

### `ProductList.vue`

Renderiza búsqueda, estados de carga/error y las cards de producto.

### `CheckoutPage.vue`

Simula la pasarela de pago y muestra el resumen de compra.

## Datos consumidos

El frontend espera objetos con esta forma general:

- `id`
- `nombre`
- `marca`
- `precioBase`
- `tipo`
- `atributoEspecial`

## Ejecución local

```powershell
cd mi-sitio-maquillaje/frontend
npm install
npm run dev
```

## Observación

El frontend depende de que el backend esté activo en el puerto 8080.
