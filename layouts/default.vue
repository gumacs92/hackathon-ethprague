<template>
  <section class="">
    <div class="fixed bg-fixed bg-white h-screen w-screen top-0" />
    <div class="relative">
      <div class="fixed top-0 w-full z-50">
        <div class="bg-white border-b shadow-b-md h-20 relative">
          <div class="grid grid-rows-1 grid-cols-4 h-full ">
            <div class="col-span-2 flex flex-row items-center w-full h-full">
              <nuxt-link to="/">
                <img src="/img/logo/redcross.png" class="h-16 w-24 mx-4">
              </nuxt-link>
              <h1 class="text-red-600 font-bold text-2xl inline font-merriweather">
                Red Cross Crypto
              </h1>
            </div>
            <div class="col-span-2 text-right flex flex-row gap-8 mr-4 justify-end h-full leading-4 items-center">
              <nuxt-link class="btn-link" to="apply-for-help">
                Apply for help
              </nuxt-link>
              <nuxt-link class="btn-link" to="/be-an-angel">
                Be an angel
              </nuxt-link>
              <a class="btn-link" target="_blank" href="http://localhost:3000">Help us govern</a>
            </div>
          </div>
        </div>

        <div class="rounded-b-full bg-gray-300  grid grid-cols-3 grid-rows-1 mx-auto px-2 max-w-5xl h-8">
          <div class="col-span-1 px-2">
            <a v-if="!user" class="btn-link" @click.prevent="connectWithMoralis()">
              Connect with wallet
            </a>
            <a v-else class="btn-link" @click.prevent="logOut()">
              Logout
            </a>
          </div>
          <div v-if="user" class="col-span-2 px-2 text-right">
            <a class="btn-link disabled">
              Logged in as {{ address }}
            </a>
          </div>
        </div>
      </div>

      <div class="mt-32">
        <Nuxt />
      </div>
    </div>
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
