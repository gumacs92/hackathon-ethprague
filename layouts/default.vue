<template>
  <section>
    <div class="fixed top-0 left-1/2 transform -translate-x-1/2 right-0 rounded-b-full h-8 bg-gray-300 max-w-5xl w-full">
      <div class="relative grid grid-cols-3 grid-rows-1 px-2">
        <div class="col-span-1 px-2">
          <a v-if="!user" class="btn" @click.prevent="connectWithMoralis()">
            Connect with wallet
          </a>
          <a v-else class="btn" @click.prevent="logOut()">
            Logout
          </a>
        </div>
        <div v-if="user" class="col-span-2 px-2 text-right">
          <a class="btn disabled">
            Logged in as {{ address }}
          </a>
        </div>
      </div>
    </div>

    <Nuxt />
  </section>
</template>
<script>
import Moralis from 'moralis'

export default {
  name: 'DefaultLayout',
  computed: {
    user () {
      return this.$store.state.auth.user
    },
    username () {
      return this.$store.state.auth.username
    },
    address () {
      return this.$store.state.auth.address
    }
  },
  beforeMount () {
    this.initMoralisUser()
  },
  methods: {
    initMoralisUser () {
      const user = Moralis.User.current()
      if (user) { this.$store.commit('setUser', user) }
    },
    async connectWithMoralis () {
      if (!this.user) {
        try {
          const user = await Moralis.authenticate({
            signingMessage: 'Log in using Moralis'
          })
          if (user) { this.$store.commit('setUser', user) }
        } catch (e) {
          console.log(e)
        }
      }
      this.showConnectWalletModal = false
    },
    async logOut () {
      await Moralis.User.logOut()
      this.$store.commit('setUser', null)
    }
  }
}
</script>
