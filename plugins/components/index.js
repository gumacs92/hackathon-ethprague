import Vue from 'vue'
import Toast from '~/plugins/components/Toast.vue'

const ToastClass = Vue.extend(Toast)

Vue.prototype.$rxt = (() => {
  const toastComponents = []
  const offsetGap = 10

  return {
    toast: (title, message) => {
      const toastObject = {}
      let toastComponent = null
      let offset = offsetGap

      if (toastComponents.length) {
        const lastToast = toastComponents[toastComponents.length - 1]
        offset += lastToast.$el.offsetHeight + lastToast.$el.offsetTop
      }

      toastObject.offset = offset
      toastObject.message = message
      toastObject.title = title
      toastComponent = new ToastClass({
        propsData: toastObject
      })
      toastComponents.push(toastComponent)
      toastComponent.$mount()
      document.getElementById('__layout').appendChild(toastComponent.$el)

      console.log(toastComponent)
      const autoHideDelay = toastObject.autoHideDelay || 5000
      setTimeout(() => {
        toastComponent.$el.remove()
        const index = toastComponents.findIndex(item => item === toastComponent)
        if (index !== -1) {
          toastComponents.splice(index, 1)
        }
        let recalculatedOffset = offsetGap
        toastComponents.forEach((item, index) => {
          if (index - 1 > 0) {
            recalculatedOffset += toastComponents[index - 1].offsetHeight + offsetGap
          }
          item.offset = recalculatedOffset
          item.$forceUpdate()
        })
      }, autoHideDelay)
    }
  }
})()
Vue.component('ComponentToast', Toast)
