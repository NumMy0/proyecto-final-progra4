import { computed, reactive } from "vue";

const state = reactive({
  items: [],
});

function addToCart(product) {
  const index = state.items.findIndex((item) => item.id === product.id);

  if (index >= 0) {
    state.items[index].quantity += 1;
    return;
  }

  state.items.push({
    id: product.id,
    nombre: product.nombre,
    marca: product.marca,
    precioBase: Number(product.precioBase ?? 0),
    tipo: product.tipo,
    stock: Number(product.stock ?? 0),
    image: product.image,
    quantity: 1,
  });
}

function removeFromCart(id) {
  const index = state.items.findIndex((item) => item.id === id);

  if (index >= 0) {
    state.items.splice(index, 1);
  }
}

function clearCart() {
  state.items.splice(0, state.items.length);
}

const cartCount = computed(() =>
  state.items.reduce((sum, item) => sum + item.quantity, 0),
);
const cartTotal = computed(() =>
  state.items.reduce((sum, item) => sum + item.precioBase * item.quantity, 0),
);

export function useCart() {
  return {
    items: state.items,
    cartCount,
    cartTotal,
    addToCart,
    removeFromCart,
    clearCart,
  };
}
