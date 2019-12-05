import Vue from 'vue'
import VueResource from 'vue-resource'
import VueRouter from 'vue-router'

Vue.use(VueResource);
Vue.use(VueRouter);

window.Vue = Vue;

// Import components
import App from './App.vue';
import Accueil from './components/Accueil.vue'
import Referentiel from './components/Referentiel.vue';
import Financements from './components/Financements.vue';
import Simulateur from './components/Simulateur.vue';
import Scenarios from './components/Scenarios.vue';
import Outils from './components/Outils.vue';

const routes = [
    { path: '/', name: 'accueil', component: Accueil},
    { path: '/referentiel', name: 'referentiel', component: Referentiel },
    { path: '/financements', name: 'financements', component: Financements },
    { path: '/simulateur', name: 'simulateur', component: Simulateur },
    { path: '/scenarios', name: 'scenarios', component: Scenarios },
    { path: '/outils', name: 'outils', component: Outils},
    { path: '*', redirect: '/'}
];

const router = new VueRouter({  
    mode: 'history',
    base: '0.7/explorer',
    routes:routes  
});

new Vue({
    router,
    render: h => h(App)
}).$mount('#App')
