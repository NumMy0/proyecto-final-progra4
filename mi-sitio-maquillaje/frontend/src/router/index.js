import { createRouter, createWebHistory } from "vue-router";
import WelcomePage from "../views/WelcomePage.vue";
import CatalogoPage from "../views/CatalogoPage.vue";
import CheckoutPage from "../views/CheckoutPage.vue";

const routes = [
  { path: "/", name: "Welcome", component: WelcomePage },
  { path: "/catalogo", name: "Catalogo", component: CatalogoPage },
  { path: "/checkout", name: "Checkout", component: CheckoutPage },
];

export default createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() {
    return { top: 0 };
  },
});
