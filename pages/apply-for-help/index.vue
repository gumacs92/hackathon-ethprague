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
        <Input v-model="form.address" placeholder="Place your public address here" class="w-full" />
        <Textarea v-model="form.description" placeholder="Please describe your situatun and how you got there, it will help the governors to decide about the help" class="w-full" />

        <button class="btn text-center self-center w-52" @click="helpMe()">
          I need to help!
        </button>
      </div>
    </div>
  </section>
</template>
<script>
// import BaseContainer from '~/components/BaseContainer'
import Input from '~/components/inputs/Input'
import Textarea from '~/components/inputs/Textarea'
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
    helpMe () {
      console.log(this.form)
      console.log('HALP')
      // MOralis.exextadsojfksad
    }
  }
}
</script>
