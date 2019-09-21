import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import DaoView from './views/DaoView.vue'
import ProposalView from './views/ProposalView.vue'
import HistoryView from './views/HistoryView.vue'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('./views/Home.vue')
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () =>
        import(/* webpackChunkName: "about" */ './views/About.vue')
    },
    {
      path: '/DAO/:contractAddress&:title&:active&:ended&:blocked',
      name: 'DAO',
      component: () => import('./views/DaoView.vue'),
      children: [
        {
          path: 'proposal/:index',
          name: 'proposal',
          component: () => import('./views/ProposalView.vue')
        },
        {
          path: 'history',
          name: 'history',
          component: () => import('./views/HistoryView.vue')
        }
      ]
    },
    {
      path: '/FAQ',
      name: 'FAQ',
      component: () => import('./views/GuideView.vue')
    },
    {
      path: '/Profile/:ethAddress',
      name: 'Profile',
      component: () => import('./views/ProfileView.vue')
    },
    {
      path: '/404',
      name: '404',
      component: () => import('./components/404.vue')
    },
    {
      path: '*',
      redirect: '/404'
    }
  ]
})
