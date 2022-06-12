<template>
  <section>
    <OverlayLoader :loading="loading">
      <!-- <BaseContainer>
      <h1 class="h1">
        hello world
      </h1>
    </BaseContainer> -->

      <div class="max-w-5xl mx-auto flex flex-col items-center mt-12 w-full">
        <div class="text-center">
          <h1 class="h1">
            Be an angel
          </h1>
          <h2>
            Thank you for your generosity
          </h2>
        </div>
        <div v-if="user" class="flex flex-col gap-5 mt-10 w-1/2">
          <!-- <Input v-model="form.name" placeholder="Name" class="w-full" />
        <Input v-model="form.email" placeholder="Email" class="w-full" /> -->
          <div class="flex flex-col gap-5 ">
            <Input v-model="form.amount" type="number" placeholder="How much ETH would you like to give?" class="w-full" />

            <button class="btn text-center self-center w-52" @click="iWishToHelp()">
              I wish to help
            </button>
          </div>
          <h1 class="text-center">
            OR
          </h1>
          <h2 class="text-center">
            Volunteer to be an active doer
          </h2>
          <div class="flex flex-col gap-5 ">
            <Input v-model="form.name" placeholder="State your name" class="w-full" />
            <Textarea v-model="form.introduction" :rows="3" placeholder="Please introduce yourself, and describe your contact, so people can find you for help" class="w-full" />
            <button class="btn text-center self-center w-52" @click="iWantToVolunteer()">
              I volunteer
            </button>
          </div>
        </div>
        <div v-else class="flex flex-col gap-5 w-full mt-5">
          <button class="btn text-center self-center w-60" @click="connectWithMoralis()">
            Please login to contribute
          </button>
        </div>
      </div>
    </OverlayLoader>
  </section>
</template>
<script>
// import BaseContainer from '~/components/BaseContainer'
import Moralis from 'moralis'
import OverlayLoader from '~/components/OverlayLoader'
import RedCrossVault from '~/build/contracts/RedCrossVault.json'
import Input from '~/components/inputs/Input'
import Textarea from '~/components/inputs/Textarea'
export default {
  name: 'ApplyForHelpPage',
  components: {
    // BaseContainer
    Input,
    Textarea,
    OverlayLoader
  },
  data () {
    return {
      loading: false,
      form: {
        name: '',
        introduction: '',
        // email: '',
        // address: '',
        amount: null
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
    async iWantToVolunteer () {
      this.loading = true
      const transaction = await Moralis.executeFunction({
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        abi: RedCrossVault.abi,
        functionName: 'joinAsVolunteer',
        params: {
          _name: this.form.name,
          _introduction: this.form.introduction
        }
      })

      await transaction.wait()

      this.loading = false
      this.$rxt.toast('Success', 'Thank you for joining to our volunteers!')
    },
    async iWishToHelp () {
      this.loading = true
      const transaction = await Moralis.executeFunction({
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        abi: RedCrossVault.abi,
        functionName: 'donate',
        msgValue: Moralis.Units.ETH(this.form.amount)
      })

      await transaction.wait()

      this.loading = false
      this.$rxt.toast('Success', 'Thank you for your kind and generous donation!')
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
