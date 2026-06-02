<template>
  <section class="grid gap-4 opacity-0 animate-fade-up">
    <div class="flex flex-col items-start justify-between gap-4 lg:flex-row lg:items-end">
      <div>
        <p class="mb-1 text-xs font-bold uppercase tracking-[0.2em] text-rose-500">Catálogo en vivo</p>
        <h2 class="text-2xl font-black tracking-tight text-rose-800">Productos destacados</h2>
      </div>

      <div class="flex w-full flex-wrap gap-3 lg:w-auto">
        <input
          v-model="query"
          type="search"
          placeholder="Buscar por nombre, marca o tipo"
          aria-label="Buscar productos"
          class="w-full min-w-[16rem] flex-1 rounded-full border border-rose-200 bg-white/90 px-4 py-3 text-rose-900 outline-none transition placeholder:text-rose-300 focus:border-rose-300 focus:ring-4 focus:ring-rose-100"
        />
        <button type="button" class="rounded-full border border-rose-200 bg-white/80 px-4 py-3 font-semibold text-rose-700 transition hover:bg-rose-50 disabled:cursor-progress disabled:opacity-60" @click="emit('refresh')" :disabled="loading">
          {{ loading ? 'Actualizando...' : 'Actualizar' }}
        </button>
      </div>
    </div>

    <div v-if="loading" class="rounded-[22px] border border-rose-100 bg-white/85 p-6 text-rose-500 shadow-sm">
      <div class="mb-3 h-5 w-5 animate-spin rounded-full border-2 border-rose-200 border-t-rose-400"></div>
      <p>Cargando productos desde la API...</p>
    </div>

    <div v-else-if="error" class="rounded-[22px] border border-rose-200 bg-rose-50 p-6 text-rose-700 shadow-sm">
      <strong class="block font-extrabold">No fue posible cargar el catálogo.</strong>
      <p class="mt-2 text-rose-600">{{ error }}</p>
    </div>

    <div v-else class="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
      <article v-for="(product, index) in filteredProducts" :key="product.id" :class="['relative overflow-hidden rounded-[24px] border border-rose-100/80 bg-white/88 p-5 shadow-[0_20px_60px_rgba(244,114,182,0.12)] transition duration-300 hover:-translate-y-1 hover:shadow-[0_24px_70px_rgba(244,114,182,0.18)]', index % 2 === 0 ? 'animate-fade-up' : 'animate-pop']">
        <div class="absolute inset-auto -right-12 -bottom-16 h-44 w-44 rounded-full bg-[radial-gradient(circle,_rgba(251,207,232,0.42),_transparent_70%)] animate-drift"></div>
        <div class="relative z-10 mb-4 overflow-hidden rounded-[22px] border border-rose-100 bg-gradient-to-b from-cuties-blush to-white p-4">
          <img
            :src="getProductImage(product)"
            :alt="product.nombre"
            class="mx-auto h-44 w-full max-w-[220px] object-contain drop-shadow-[0_18px_18px_rgba(244,114,182,0.12)] transition duration-300 hover:scale-[1.03]"
            loading="lazy"
          />
        </div>
        <div class="relative z-10 inline-flex items-center rounded-full bg-rose-50 px-3 py-1 text-xs font-bold text-rose-500">{{ product.tipo || 'Cuties' }}</div>
        <h3 class="relative z-10 mt-4 text-lg font-black tracking-tight text-rose-800">{{ product.nombre }}</h3>
        <p class="relative z-10 mt-1 text-sm text-rose-400">{{ product.marca }}</p>

        <div class="relative z-10 mt-5 flex justify-between gap-4 border-t border-rose-100 pt-4">
          <div>
            <span class="block text-sm text-rose-400">Precio</span>
            <strong class="mt-1 block text-base font-extrabold text-rose-700">${{ formatPrice(product.precioBase) }}</strong>
          </div>
          <div>
            <span class="block text-sm text-rose-400">Stock</span>
            <strong class="mt-1 block text-base font-extrabold text-rose-700">{{ product.stock ?? '—' }}</strong>
          </div>
        </div>

        <button type="button" class="relative z-10 mt-5 rounded-full bg-gradient-to-r from-cuties-rose via-rose-500 to-pink-500 bg-[length:200%_200%] px-4 py-3 text-sm font-extrabold text-white shadow-[0_18px_40px_rgba(244,63,94,0.22)] transition duration-300 hover:-translate-y-1 hover:scale-[1.02] hover:shadow-[0_22px_50px_rgba(244,63,94,0.28)] hover:animate-shimmer" @click="emit('add-to-cart', product)">
          Añadir al carrito
        </button>
      </article>

      <div v-if="filteredProducts.length === 0" class="rounded-[22px] border border-rose-100 bg-white/80 p-6 text-rose-500 shadow-sm">
        <p>No hay productos que coincidan con tu búsqueda.</p>
      </div>
    </div>
  </section>
</template>

<script setup>
import { computed, ref } from 'vue'

const productImages = {
  'P001': new URL('../../images/paleta sunset.jpg', import.meta.url).href,
  'P002': new URL('../../images/base.jpg', import.meta.url).href,
  'P003': new URL('../../images/delineador.jpg', import.meta.url).href,
  'P004': new URL('../../images/polvos.jpg', import.meta.url).href,
  'P005': new URL('../../images/mascara.jpg', import.meta.url).href,
}

const props = defineProps({
  products: {
    type: Array,
    default: () => []
  },
  loading: {
    type: Boolean,
    default: false
  },
  error: {
    type: String,
    default: ''
  }
})

const emit = defineEmits(['add-to-cart', 'refresh'])

const query = ref('')

const filteredProducts = computed(() => {
  const value = query.value.trim().toLowerCase()

  if (!value) {
    return props.products
  }

  return props.products.filter((product) => {
    return [product.nombre, product.marca, product.tipo]
      .filter(Boolean)
      .some((field) => String(field).toLowerCase().includes(value))
  })
})

function formatPrice(value) {
  return Number(value ?? 0).toFixed(2)
}

function getProductImage(product) {
  return productImages[product.id] || productImages.P001
}
</script>
