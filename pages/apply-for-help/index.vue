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
      <div class="flex flex-col gap-5 w-full mt-5">
        <Input v-model="form.name" placeholder="Name" class="w-full" />
        <Input v-model="form.email" placeholder="Email" class="w-full" />
        <Textarea v-model="form.description" placeholder="Please describe your situatun and how you got there, it will help the governors to decide about the help" class="w-full" />
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
import CoreVoting from '~/abis/coreVoting.json'

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

      // await Moralis.executeFunction({
      //   contractAddress: this.$config.councilVotingContract,
      //   functionName: 'changeVaultStatus',
      //   abi: CoreVoting,
      //   params: { vault: this.$config.councilVotingContract, isValid: true }
      // })

      const web3 = await Moralis.web3Library
      const rInterface = new web3.utils.Interface(RedCrossVault.abi)
      console.log('rInterface:', rInterface)
      const callDataRedCrossApproved = rInterface.encodeFunctionData('approveRequest', [0]) // 0 helyére majd requestId kell
      console.log('callDataResCrossApproved:', callDataRedCrossApproved)
      // const toBeHashed = web3.utils.defaultAbiCoder.encode(['uint256'], [callDataRedCrossApproved])
      // console.log('tobeHashed:', toBeHashed)
      const calldata = web3.utils.keccak256(callDataRedCrossApproved)
      console.log('calldata', calldata)
      // web3.utils.keccak256("")

      const options2 = {
        contractAddress: this.$config.councilVotingContract,
        functionName: 'proposal',
        abi: CoreVoting,
        params: {
          votingVaults: [this.$config.councilVotingContract],
          extraVaultData: [''],
          targets: [this.$config.redCrossVaultContract],
          calldatas: [calldata],
          lastCall: 10,
          ballot: 2
        }
      }
      const proposing = await Moralis.executeFunction(options2)
      console.log(proposing)
    }
  }
}
</script>
