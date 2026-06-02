<template>
  <section class="grid gap-5 opacity-0 animate-fade-up">
    <div class="flex flex-col gap-6 rounded-[30px] border border-rose-100/80 bg-white/85 p-6 shadow-[0_24px_80px_rgba(244,114,182,0.18)] backdrop-blur-xl sm:p-7 lg:flex-row lg:items-end lg:justify-between">
      <div>
        <p class="mb-2 text-xs font-extrabold uppercase tracking-[0.2em] text-rose-500">Checkout</p>
        <h1 class="text-3xl font-black tracking-tight text-rose-700 sm:text-4xl">Pasarela de pago</h1>
        <p class="mt-3 max-w-4xl text-sm leading-7 text-rose-700/75 sm:text-base">
          Revisa tu pedido, completa los datos y confirma tu compra en un flujo visual inspirado
          en Cuties.
        </p>
      </div>

      <div class="rounded-[20px] border border-rose-100 bg-white/75 px-4 py-3 text-right shadow-sm">
        <span class="block text-xs font-semibold text-rose-400">Total acumulado</span>
        <strong class="block text-3xl font-black text-rose-800 animate-pulse">${{ displayedTotal.toFixed(2) }}</strong>
      </div>
    </div>

    <div class="grid gap-5 xl:grid-cols-[minmax(0,1.2fr)_minmax(320px,0.8fr)]">
      <form class="grid gap-4 rounded-[30px] border border-rose-100/80 bg-white/85 p-6 shadow-[0_24px_80px_rgba(244,114,182,0.18)] backdrop-blur-xl" @submit.prevent="confirmPayment">
        <h2 class="text-2xl font-black tracking-tight text-rose-800">Datos de pago</h2>

        <div class="grid gap-4 lg:grid-cols-3">
          <label class="grid gap-2 text-sm font-medium text-rose-700">
            Número de tarjeta
            <input v-model="form.cardNumber" type="text" maxlength="19" placeholder="1234 5678 9012 3456" class="rounded-2xl border border-rose-200 bg-white/90 px-4 py-3 text-rose-900 outline-none transition placeholder:text-rose-300 focus:border-rose-300 focus:ring-4 focus:ring-rose-100" />
          </label>

          <label class="grid gap-2 text-sm font-medium text-rose-700">
            Expiración
            <input v-model="form.expiration" type="text" maxlength="5" placeholder="MM/AA" class="rounded-2xl border border-rose-200 bg-white/90 px-4 py-3 text-rose-900 outline-none transition placeholder:text-rose-300 focus:border-rose-300 focus:ring-4 focus:ring-rose-100" />
          </label>

          <label class="grid gap-2 text-sm font-medium text-rose-700">
            CVV
            <input v-model="form.cvv" type="text" maxlength="4" placeholder="123" class="rounded-2xl border border-rose-200 bg-white/90 px-4 py-3 text-rose-900 outline-none transition placeholder:text-rose-300 focus:border-rose-300 focus:ring-4 focus:ring-rose-100" />
          </label>
        </div>

        <label class="grid gap-2 text-sm font-medium text-rose-700">
          Nombre completo
          <input v-model="form.fullName" type="text" placeholder="Tu nombre" class="rounded-2xl border border-rose-200 bg-white/90 px-4 py-3 text-rose-900 outline-none transition placeholder:text-rose-300 focus:border-rose-300 focus:ring-4 focus:ring-rose-100" />
        </label>

        <label class="grid gap-2 text-sm font-medium text-rose-700">
          Dirección de envío
          <textarea v-model="form.address" rows="4" placeholder="Calle, número, ciudad..." class="rounded-2xl border border-rose-200 bg-white/90 px-4 py-3 text-rose-900 outline-none transition placeholder:text-rose-300 focus:border-rose-300 focus:ring-4 focus:ring-rose-100"></textarea>
        </label>

        <button type="submit" class="rounded-full bg-gradient-to-r from-cuties-rose via-rose-500 to-pink-500 bg-[length:200%_200%] px-5 py-3.5 font-extrabold text-white shadow-[0_18px_40px_rgba(244,63,94,0.22)] transition duration-300 hover:-translate-y-1 hover:scale-[1.02] hover:shadow-[0_22px_50px_rgba(244,63,94,0.28)] hover:animate-shimmer disabled:cursor-not-allowed disabled:opacity-60" :disabled="processing || cartItems.length === 0">
          {{ processing ? 'Procesando...' : 'Confirmar Pago' }}
        </button>
      </form>

      <aside class="grid gap-4 rounded-[30px] border border-rose-100/80 bg-white/85 p-6 shadow-[0_24px_80px_rgba(244,114,182,0.18)] backdrop-blur-xl">
        <h2 class="text-2xl font-black tracking-tight text-rose-800">Resumen de compra</h2>

        <div v-if="cartItems.length" class="grid gap-3">
          <article v-for="item in cartItems" :key="item.id" class="flex items-start gap-4 rounded-[18px] border border-rose-100 bg-white/75 px-4 py-3 shadow-sm">
            <div class="h-16 w-16 shrink-0 overflow-hidden rounded-2xl border border-rose-100 bg-white">
              <img v-if="item.image" :src="item.image" :alt="item.nombre" class="h-full w-full object-contain p-1" />
            </div>
            <div class="min-w-0 flex-1">
              <strong class="block font-bold text-rose-800">{{ item.nombre }}</strong>
              <p class="mt-1 text-sm text-rose-400">{{ item.marca }} · x{{ item.quantity }}</p>
            </div>
            <span class="shrink-0 font-extrabold text-rose-700">${{ (item.precioBase * item.quantity).toFixed(2) }}</span>
          </article>
        </div>

        <div v-else class="grid gap-3 text-rose-500">
          <p>No hay productos en el carrito.</p>
          <RouterLink to="/catalogo" class="font-semibold text-rose-700 underline decoration-rose-300 underline-offset-4">Volver al catálogo</RouterLink>
        </div>

        <div v-if="processing" class="rounded-[18px] border border-rose-100 bg-rose-50 px-4 py-3 font-semibold text-rose-700 animate-pulse">Procesando...</div>
        <div v-if="successMessage" class="rounded-[18px] border border-emerald-100 bg-emerald-50 px-4 py-3 font-semibold text-emerald-700 animate-pop">{{ successMessage }}</div>
      </aside>
    </div>
  </section>
</template>

<script setup>
import { computed, reactive, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useCart } from '../store/cart'

const router = useRouter()
const route = useRoute()
const { items: cartItems, cartTotal, clearCart } = useCart()

const form = reactive({
  cardNumber: '',
  expiration: '',
  cvv: '',
  fullName: '',
  address: ''
})

const processing = ref(false)
const successMessage = ref('')

const displayedTotal = computed(() => {
  const queryTotal = Number(route.query.total)
  if (!Number.isNaN(queryTotal) && queryTotal > 0) {
    return queryTotal
  }

  return cartTotal.value
})

function confirmPayment() {
  if (cartItems.length === 0) {
    successMessage.value = ''
    return
  }

  processing.value = true
  successMessage.value = ''

  window.setTimeout(() => {
    processing.value = false
    successMessage.value = '¡Gracias por tu compra en Cuties!'
    clearCart()

    window.setTimeout(() => {
      router.push('/catalogo')
    }, 2200)
  }, 1800)
}
</script>