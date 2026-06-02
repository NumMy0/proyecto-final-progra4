/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{vue,js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        cuties: {
          blush: "#fff4f8",
          petal: "#ffd7e5",
          rose: "#fb7185",
          berry: "#e11d48",
          cream: "#fffaf4",
          sky: "#eff6ff",
          lavender: "#f7f0ff",
        },
      },
      keyframes: {
        "fade-up": {
          "0%": { opacity: "0", transform: "translateY(16px) scale(0.985)" },
          "100%": { opacity: "1", transform: "translateY(0) scale(1)" },
        },
        float: {
          "0%, 100%": { transform: "translateY(0px)" },
          "50%": { transform: "translateY(-10px)" },
        },
        drift: {
          "0%, 100%": { transform: "translate3d(0, 0, 0)" },
          "50%": { transform: "translate3d(10px, -12px, 0)" },
        },
        shimmer: {
          "0%": { backgroundPosition: "0% 50%" },
          "50%": { backgroundPosition: "100% 50%" },
          "100%": { backgroundPosition: "0% 50%" },
        },
        pop: {
          "0%": { transform: "scale(0.95)", opacity: "0" },
          "100%": { transform: "scale(1)", opacity: "1" },
        },
      },
      animation: {
        "fade-up": "fade-up 700ms ease-out both",
        float: "float 7s ease-in-out infinite",
        drift: "drift 10s ease-in-out infinite",
        shimmer: "shimmer 8s ease-in-out infinite",
        pop: "pop 420ms ease-out both",
      },
      boxShadow: {
        glow: "0 24px 80px rgba(244, 114, 182, 0.18)",
      },
    },
  },
  plugins: [],
};
