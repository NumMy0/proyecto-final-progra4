<template>
  <section class="grid gap-5 opacity-0 animate-fade-up">
    <div class="flex flex-col gap-6 rounded-[30px] border border-rose-100/80 bg-white/85 p-6 shadow-[0_24px_80px_rgba(244,114,182,0.18)] backdrop-blur-xl sm:p-7 lg:flex-row lg:items-end lg:justify-between">
      <div>
        <p class="mb-2 text-xs font-extrabold uppercase tracking-[0.2em] text-rose-500">Catálogo Cuties</p>
        <h1 class="text-3xl font-black tracking-tight text-rose-700 sm:text-4xl">Descubre tus esenciales favoritos.</h1>
        <p class="mt-3 max-w-3xl text-sm leading-7 text-rose-700/75 sm:text-base">
          Productos suaves, coquetos y listos para acompañarte en looks diarios o especiales.
        </p>
      </div>

      <div class="grid gap-3 justify-items-start sm:justify-items-end">
        <div class="rounded-[18px] border border-rose-100 bg-white/75 px-4 py-3 text-right shadow-sm">
          <span class="block text-xs font-semibold text-rose-400">Carrito</span>
          <strong class="block text-lg font-black text-rose-800">{{ cartCount }} productos</strong>
        </div>
        <button
          type="button"
          class="rounded-full bg-gradient-to-r from-cuties-rose to-pink-500 bg-[length:200%_200%] px-5 py-3.5 font-extrabold text-white shadow-[0_18px_40px_rgba(244,63,94,0.22)] transition duration-300 hover:-translate-y-1 hover:scale-[1.02] hover:from-rose-300 hover:to-pink-400 hover:shadow-[0_22px_50px_rgba(244,63,94,0.28)] hover:animate-shimmer"
          @click="goToCheckout"
        >
          Proceder al Pago
        </button>
      </div>
    </div>

    <ProductList
      :products="products"
      :loading="loading"
      :error="error"
      @add-to-cart="handleAddToCart"
    />
  </section>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import ProductList from '../components/ProductList.vue'
import { useCart } from '../store/cart'

const router = useRouter()
const { cartCount, cartTotal, addToCart } = useCart()

const products = ref([])
const loading = ref(false)
const error = ref('')

async function loadProducts() {
  loading.value = true
  error.value = ''

  try {
    const response = await fetch('http://localhost:8080/api/productos')

    if (!response.ok) {
      throw new Error(`No se pudieron cargar los productos (${response.status})`)
    }

    const data = await response.json()
    products.value = Array.isArray(data) ? data : []
  } catch (err) {
    error.value = err instanceof Error ? err.message : 'Error desconocido al cargar el catálogo.'
  } finally {
    loading.value = false
  }
}

function handleAddToCart(product) {
  addToCart(product)
}

function goToCheckout() {
  router.push({
    path: '/checkout',
    query: {
      total: cartTotal.value.toFixed(2)
    }
  })
}

onMounted(loadProducts)
</script>
