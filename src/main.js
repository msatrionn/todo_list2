import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import '../public/main.css'
import '../public/modal.css'

createApp(App).use(router).mount('#app')
