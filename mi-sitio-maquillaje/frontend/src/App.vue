<template>
  <div class="min-h-screen bg-[radial-gradient(circle_at_top_left,_rgba(255,214,229,0.78),_transparent_26%),radial-gradient(circle_at_top_right,_rgba(191,219,254,0.55),_transparent_22%),radial-gradient(circle_at_bottom_right,_rgba(233,213,255,0.45),_transparent_24%),linear-gradient(160deg,_#fff7fb_0%,_#fff1f4_42%,_#fffdfc_100%)] text-rose-950">
    <header class="sticky top-0 z-20 border-b border-rose-100/80 bg-white/72 backdrop-blur-xl">
      <div class="mx-auto flex max-w-7xl flex-col gap-4 px-4 py-4 sm:px-6 lg:flex-row lg:items-center lg:justify-between lg:px-8">
        <router-link to="/" class="inline-flex items-center gap-3 rounded-full transition hover:opacity-90 focus:outline-none focus:ring-4 focus:ring-cuties-petal/60">
          <span class="grid h-11 w-11 place-items-center rounded-full bg-gradient-to-br from-cuties-petal via-rose-300 to-cuties-rose text-lg font-black text-rose-950 shadow-[0_12px_30px_rgba(251,113,133,0.28)] animate-float">C</span>
          <span class="grid leading-tight">
            <strong class="text-lg font-extrabold tracking-tight text-rose-950">Cuties</strong>
            <small class="text-[0.7rem] font-semibold uppercase tracking-[0.26em] text-rose-500">beauty studio</small>
          </span>
        </router-link>

        <nav class="flex flex-wrap items-center gap-2">
          <router-link to="/" active-class="bg-white text-rose-700 border-rose-200 shadow-sm" class="rounded-full border border-transparent px-4 py-3 text-sm font-semibold text-rose-700 transition duration-200 hover:-translate-y-0.5 hover:border-rose-200 hover:bg-white/90">Bienvenida</router-link>
          <router-link to="/catalogo" active-class="bg-white text-rose-700 border-rose-200 shadow-sm" class="rounded-full border border-transparent px-4 py-3 text-sm font-semibold text-rose-700 transition duration-200 hover:-translate-y-0.5 hover:border-rose-200 hover:bg-white/90">Catálogo</router-link>
          <router-link to="/checkout" active-class="ring-2 ring-cuties-petal ring-offset-2 ring-offset-white" class="rounded-full bg-gradient-to-r from-cuties-rose via-rose-500 to-pink-500 bg-[length:200%_200%] px-4 py-3 text-sm font-semibold text-white shadow-[0_18px_40px_rgba(244,63,94,0.24)] transition duration-300 hover:-translate-y-0.5 hover:shadow-[0_22px_50px_rgba(244,63,94,0.28)] hover:animate-shimmer">Checkout</router-link>
        </nav>
      </div>
    </header>

    <main class="mx-auto w-full max-w-7xl px-4 pb-8 pt-6 sm:px-6 lg:px-8">
      <router-view />
    </main>
  </div>
</template>
