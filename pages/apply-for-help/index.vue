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
            You came to the right place
          </h1>
          <h2>
            Please fill in the form below to apply for help
          </h2>
        </div>
        <div class="flex flex-col gap-5 mt-10 w-1/2">
          <Input v-model="form._name" placeholder="Name" class="w-full" />
          <Input v-model="form._email" placeholder="Email" class="w-full" />
          <Textarea v-model="form._description" placeholder="Please describe your situation and how you got there, it will help the governors to decide about the help" class="w-full" />
          <Input v-model="form._expectedAmount" type="number" placeholder="Place your expected ETH amount here" class="w-full" />

          <button class="btn text-center self-center w-52" @click="helpMe()">
            I need help!
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
import Input from '~/components/inputs/Input'
import Textarea from '~/components/inputs/Textarea'
import RedCrossVault from '~/build/contracts/RedCrossVault.json'

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
        _name: '',
        _email: '',
        _description: '',
        _expectedAmount: 0
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
    async helpMe () {
      this.loading = true
      console.log(this.form)
      console.log('HALP')
      console.log(RedCrossVault.abi)

      this.form._expectedAmount = parseInt(this.form._expectedAmount)
      const options = {
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        functionName: 'requestHelp',
        abi: RedCrossVault.abi,
        params: this.form
      }
      console.log(options)
      const transaction = await Moralis.executeFunction(options)
      console.log(transaction)
      await transaction.wait()
      this.loading = false

      this.$rxt.toast('Success', 'Your request has been sent to the governor')
    }
  }
}
</script>
