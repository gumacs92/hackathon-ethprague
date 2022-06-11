<template>
  <section>
    <!-- <BaseContainer>
      <h1 class="h1">
        hello world
      </h1>
    </BaseContainer> -->

    <div class="max-w-5xl mx-auto flex flex-col items-center mt-12 w-full">
      <div class="text-center">
        <h1 class="h1">
          Be an angel for us
        </h1>
        <h2>
          Thank you for your generosity
        </h2>
      </div>
      <div v-if="user" class="flex flex-col gap-5 w-full mt-5">
        <Input v-model="form.name" placeholder="Name" class="w-full" />
        <Input v-model="form.email" placeholder="Email" class="w-full" />
        <Input v-model="form.amount" placeholder="How much ETH would you like to give?" class="w-full" />

        <button class="btn text-center self-center w-52" @click="iWishToHelp()">
          I wish to help
        </button>
      </div>
      <div v-else class="flex flex-col gap-5 w-full mt-5">
        <button class="btn text-center self-center w-60" @click="connectWithMoralis()">
          Please login to contribute
        </button>
      </div>
    </div>
  </section>
</template>
<script>
// import BaseContainer from '~/components/BaseContainer'
import Moralis from 'moralis'
import Input from '~/components/inputs/Input'
export default {
  name: 'ApplyForHelpPage',
  components: {
    // BaseContainer
    Input
  },
  data () {
    return {
      form: {
        name: '',
        email: '',
        address: '',
        description: ''
      }
    }
  },
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
    this.form.address = this.user ? this.address : ''
  },
  methods: {
    iWishToHelp () {
      console.log(this.form)
      console.log('HALP IS ON THE WAY')
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
    }
  }
}
</script>
