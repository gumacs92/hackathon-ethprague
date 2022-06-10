<template>
  <section>
    <!-- <BaseContainer>
      <h1 class="h1">
        hello world
      </h1>
    </BaseContainer> -->

    <div class="grid grid-cols-3 grid-rows-2 items-center mt-12">
      <div class="col-span-3 row-span-1 text-center">
        <h1 class="h1">
          You came to the right place
        </h1>
        <h2>
          Please fill in the form below to apply for help
        </h2>
      </div>
      <div class="flex flex-col gap-5">
        <Input v-model="form.name" placeholder="Name">
          <Input v-model="form.email">
            <Input v-model="form.address">
              <Textarea v-model="form.description" />
      </div>
    </div>
  </section>
</template>
<script>
// import BaseContainer from '~/components/BaseContainer'
import Input from '~/components/Input'
import Textarea from '~/components/Textarea'
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
  }
}
</script>
