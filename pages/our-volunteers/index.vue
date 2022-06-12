<template>
  <section>
    <OverlayLoader :loading="loading">
      <div class="max-w-3xl md:max-w-xl mx-auto flex flex-col items-center mt-12 w-full">
        <div class="text-center">
          <h1 class="h1">
            Our Volunteers
          </h1>
          <h2>
            Feel free to ask them for help
          </h2>
        </div>

        <div v-if="volunteers.length" class="max-w-5xl mx-auto w-full mt-5 overflow-y-auto">
          <BaseContainer v-for="(volunteer, index) in volunteers" :key="index" class="w-auto">
            <div class="flex flex-col">
              <h2 class="h1">
                {{ volunteer.name }}
              </h2>
              <p>
                {{ volunteer.introduction }}
              </p>
            </div>
          </BaseContainer>
        </div>
        <div v-else class="max-w-5xl mx-auto w-full mt-5">
          <h2 class="text-center">
            No volunteers yet
          </h2>
        </div>
      </div>
    </OverlayLoader>
  </section>
</template>
<script>
import Moralis from 'moralis'
import BaseContainer from '~/components/BaseContainer'
import OverlayLoader from '~/components/OverlayLoader'
import RedCrossVault from '~/build/contracts/RedCrossVault.json'
import { normalizeContractOutput } from '~/utils/methods'
export default {
  name: 'ApplyForHelpPage',
  components: {
    BaseContainer,
    OverlayLoader
  },
  data () {
    return {
      loading: false,
      volunteers: []
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
    this.loadData()
  },
  methods: {
    async loadData () {
      this.loading = true

      this.volunteers = normalizeContractOutput(await Moralis.executeFunction({
        abi: RedCrossVault.abi,
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        functionName: 'getVolunteers'
      }))

      this.loading = false
    }
  }
}
</script>
