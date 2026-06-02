<template>
  <section class="grid gap-5 opacity-0 animate-fade-up lg:grid-cols-[1.15fr_0.85fr] lg:items-center">
    <div class="rounded-[30px] border border-rose-100/80 bg-white/85 p-8 shadow-[0_24px_80px_rgba(244,114,182,0.18)] backdrop-blur-xl sm:p-10 lg:p-14">
      <p class="mb-3 text-xs font-extrabold uppercase tracking-[0.25em] text-rose-500">Cuties Beauty Studio</p>
      <h1 class="text-5xl font-black leading-none tracking-tight text-rose-700 sm:text-7xl lg:text-8xl">Cuties</h1>
      <p class="mt-4 max-w-xl text-base leading-8 text-rose-700/75 sm:text-lg">
        Belleza suave, coquette y contemporánea para descubrir maquillaje que se siente tan lindo
        como se ve.
      </p>

      <div class="mt-8 flex flex-wrap gap-3">
        <RouterLink
          to="/catalogo"
          class="rounded-full bg-gradient-to-r from-cuties-rose to-pink-500 bg-[length:200%_200%] px-5 py-3.5 font-extrabold text-white shadow-[0_18px_40px_rgba(244,63,94,0.22)] transition duration-300 hover:-translate-y-1 hover:scale-[1.02] hover:from-rose-300 hover:to-pink-400 hover:shadow-[0_22px_50px_rgba(244,63,94,0.28)] hover:animate-shimmer"
        >
          Explorar Catálogo
        </RouterLink>
        <RouterLink
          to="/checkout"
          class="rounded-full border border-rose-200 bg-white/80 px-5 py-3.5 font-extrabold text-rose-700 transition duration-300 hover:-translate-y-1 hover:scale-[1.02] hover:bg-rose-50 hover:shadow-sm"
        >
          Ir al Checkout
        </RouterLink>
      </div>
    </div>

    <div class="relative grid min-h-[340px] place-items-center overflow-hidden rounded-[30px] border border-rose-100/80 bg-[radial-gradient(circle_at_top_right,_rgba(251,207,232,0.78),_transparent_34%),radial-gradient(circle_at_bottom_left,_rgba(191,219,254,0.55),_transparent_32%),linear-gradient(180deg,_rgba(255,255,255,0.95),_rgba(255,241,245,0.88))] p-6 shadow-[0_24px_80px_rgba(244,114,182,0.18)] backdrop-blur-xl">
      <div class="absolute right-[8%] top-[10%] h-44 w-44 rounded-full bg-[radial-gradient(circle,_rgba(251,207,232,0.8),_rgba(251,207,232,0))] blur-sm animate-drift"></div>
      <div class="absolute bottom-[-6%] left-[-4%] h-56 w-56 rounded-full bg-[radial-gradient(circle,_rgba(191,219,254,0.6),_rgba(191,219,254,0))] blur-sm animate-float"></div>

      <div class="relative z-10 max-w-xs rounded-[26px] border border-white/70 bg-white/75 p-6 text-center shadow-lg backdrop-blur-xl animate-pop">
        <span class="mb-3 inline-block text-xs font-extrabold uppercase tracking-[0.2em] text-rose-500">coquette aesthetic</span>
        <strong class="block text-xl leading-8 text-rose-800">
          Makeup that feels sweet, dreamy and effortless.
        </strong>
      </div>
    </div>
  </section>
</template>
