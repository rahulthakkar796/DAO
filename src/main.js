import Vue from 'vue'
import Vuetify from 'vuetify'
import Gravatar from 'vue-gravatar'
import VueClipboards from 'vue-clipboards'
// index.js or main.js
import 'vuetify/dist/vuetify.min.css' // Ensure you are using css-loader
import App from './App.vue'
import { store } from './store'
import router from './router'
import EmbarkJS from '../embarkArtifacts/embarkjs'
import AsyncComputed from 'vue-async-computed'
import Loading from 'vue-loading-overlay'
// Import stylesheet
import 'vue-loading-overlay/dist/vue-loading.css'
import Vuex from 'vuex'
import 'aos/dist/aos.css'
import AOS from 'aos'
Vue.config.productionTip = false
Vue.config.devtools = false
Vue.config.silent = true
Vue.use(Vuetify)
Vue.use(EmbarkJS)
Vue.use(Vuex)
Vue.use(store)
Vue.use(VueClipboards)
Vue.component('v-gravatar', Gravatar)
Vue.component('loading', Loading)

Vue.use(AsyncComputed)
Vue.directive('rainbow', {
  bind(el, binding, vnode) {
    el.style.backgroundColor =
      '#' +
      Math.random()
        .toString()
        .slice(2, 8)
  }
})
new Vue({
  router,
  store,
  created() {
    AOS.init()
  },
  render: h => h(App)
}).$mount('#app')
