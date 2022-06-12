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
          You came to the right place
        </h1>
        <h2>
          Please fill in the form below to apply for help
        </h2>
      </div>
      <div class="flex flex-col gap-5 mt-10 w-1/2">
        <Input v-model="form.name" placeholder="Name" class="w-full" />
        <Input v-model="form.email" placeholder="Email" class="w-full" />
        <Textarea v-model="form.description" placeholder="Please describe your situation and how you got there, it will help the governors to decide about the help" class="w-full" />
        <Input v-model="form.expectedAmount" type="number" placeholder="Place your expected ETH amount here" class="w-full" />

        <button class="btn text-center self-center w-52" @click="helpMe()">
          I need help!
        </button>
      </div>
    </div>
  </section>
</template>
<script>
// import BaseContainer from '~/components/BaseContainer'
import Moralis from 'moralis'
import Input from '~/components/inputs/Input'
import Textarea from '~/components/inputs/Textarea'
import RedCrossVault from '~/build/contracts/RedCrossVault.json'

export default {
  name: 'ApplyForHelpPage',
  components: {
    // BaseContainer
    Input,
    Textarea
  },
  data () {
    return {
      form: {
        name: '',
        email: '',
        description: '',
        expectedAmount: 0
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
      console.log(this.form)
      console.log('HALP')
      console.log(RedCrossVault.abi)

      const options = {
        contractAddress: this.$config.redCrossVaultContract,
        functionName: 'requestHelp',
        abi: RedCrossVault.abi,
        params: { input: this.form }
      }
      const help = await Moralis.executeFunction(options)
      console.log(help)
    }
  }
}
</script>
