import Vue from 'vue'
import Vuetify from 'vuetify/lib'
import 'vuetify/src/stylus/app.styl'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)
export default new Vuetify({
  icons: {
    iconfont: 'mdi'
  }
})
