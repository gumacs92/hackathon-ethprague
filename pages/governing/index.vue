<template>
  <section>
    <div class="fixed w-1/6 left-0 h-screen top-0 z-40 border-r shadow-md bg-white overflow-y-auto">
      <div class="mt-28">
        <div class="text-center border-b py-3">
          <h2>
            Incoming request
          </h2>
        </div>
        <div v-if="incomingRequests.length === 0">
          <p class="text-center">
            No ended votes yet
          </p>
        </div>
        <div v-else>
          <div v-for="(request, index) in incomingRequests" :key="index">
            <div class="flex flex-col items-center border-b pb-2 text-lg">
              <div class="flex-1">
                <p class="text-gray-600">
                  For {{ request.name }}
                </p>
              </div>
              <div class="flex-1 text-right">
                <p class="font-bold">
                  Amount {{ request.expectedAmount }} ETH
                </p>
              </div>
              <button class="btn" @click="showModalFor(request)">
                Details
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="fixed w-1/6 right-0 h-screen top-0 z-40 border-l shadow-md bg-white overflow-y-auto">
      <div class="mt-32">
        <div class="text-center border-b pb-6">
          <h2>
            Current vault
          </h2>
          <h1>
            {{ vaultMoney }} ETH
          </h1>
        </div>
        <div class="text-center border-b py-3">
          <h2>
            Approved request
          </h2>
        </div>
        <div v-if="endedRequests.length === 0">
          <p class="text-center">
            No ended votes yet
          </p>
        </div>
        <div v-else>
          <div v-for="(request, index) in endedRequests" :key="index">
            <div class="flex flex-col items-center border-b pb-2 text-lg">
              <div class="flex-1">
                <p class="text-gray-600">
                  For {{ request.name }}
                </p>
              </div>
              <div class="flex-1 text-right">
                <p class="font-bold">
                  Amount {{ request.expectedAmount }} ETH
                </p>
              </div>
              <button class="btn">
                Execute
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="max-w-3xl mx-auto flex flex-col items-center mt-12 w-full">
      <div class="text-center">
        <h1 class="h1">
          Govern with us
        </h1>
        <h2>
          Here you can see and help people in need
        </h2>
      </div>

      <div class="max-w-5xl mx-auto flex flex-col gap-5 w-full mt-5 overflow-auto">
        <BaseContainer v-for="(request, index) in currentRequests" :key="index">
          <div class="grid grid-cols-4 grid-rows-1">
            <div class="col-span-3">
              <h2 class="h1">
                Request #{{ index }} from {{ request.name }}
              </h2>
              <p>
                {{ request.description }}
              </p>
              <h3 class="mt-3 text-lg font-bold">
                Requested amount: {{ request.expectedAmount }} ETH
              </h3>
            </div>
            <div class="col-span-1">
              <div class="flex flex-row gap-3 justify-around h-full">
                <p>
                  <span class="text-red-200 font-bold">Vote until</span><br>
                  <span class="font-raleway font-bold">{{ request.voteUntil | formatDate }}</span>
                </p>
                <div class="flex flex-col justify-center items-end">
                  <img
                    src="/img/icons/thumbs-up.png"
                    :class="{ 'bg-green-600 rounded-full w-12 h-12': request.userApproved === true }"
                    @click="voteFor(request)"
                  >
                  <img
                    src="/img/icons/thumbs-down.png"
                    :class="{ 'bg-red-600 rounded-full w-12 h-12': request.userApproved === false}"
                    @click="voteAgainst(request)"
                  >
                </div>
              </div>
            </div>
          </div>
        </BaseContainer>
      </div>
    </div>
    <BaseModal v-if="modalRequest">
      <div class="flex flex-col">
        <div class="mb-3">
          <h2 class="h1">
            Request from {{ modalRequest.name }}
          </h2>
          <p>
            {{ modalRequest.description }}
          </p>
          <h3 class="mt-3 text-lg">
            Requested amount: {{ modalRequest.expectedAmount }} ETH
          </h3>
        </div>
        <div class="flex flex-row justify-around items-center gap-3">
          <button class="btn" @click="validateRequest()">
            Valid
          </button>
          <button class="btn" @click="deleteRequest()">
            Delete
          </button>
          <button class="btn-outline" @click.prevent="modalRequest = null">
            Cancel
          </button>
        </div>
      </div>
    </BaseModal>
  </section>
</template>
<script>
// change amount window
// validate list
import { DateTime } from 'luxon'
import BaseContainer from '~/components/BaseContainer'
import BaseModal from '~/components/BaseModal'
export default {
  name: 'ApplyForHelpPage',
  components: {
    BaseContainer,
    BaseModal
  },
  filters: {
    formatDate (date) {
      return DateTime.fromSeconds(date).toFormat('dd.MM.yyyy HH:mm:ss')
    }
  },
  data () {
    return {
      vaultMoney: 3.2,
      modalRequest: null,
      incomingRequests: [
        {
          description: 'I need help, please help me!',
          expectedAmount: 1.2,
          name: 'Test Eset'
        },
        {
          description: 'My house has been destroyed during and earthquake, please help me!',
          expectedAmount: 13,
          name: 'Test Elek'
        }
      ],
      currentRequests: [
        {
          description: 'I need help, please help me!',
          expectedAmount: 1.2,
          name: 'Test Eset',
          userApproved: null,
          voteUntil: 1654994038
        },
        {
          description: 'My house has been destroyed during and earthquake, please help me!',
          expectedAmount: 13,
          name: 'Test Elek',
          userApproved: null,
          voteUntil: 1654994038
        }
      ],
      endedRequests: [
        {
          description: 'I need help, please help me!',
          expectedAmount: 1.2,
          name: 'Test Eset'
        },
        {
          description: 'My house has been destroyed during and earthquake, please help me!',
          expectedAmount: 13,
          name: 'Test Elek'
        }
      ]
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
  methods: {
    showModalFor (request) {
      this.modalRequest = request
    },
    validateRequest () {

    },
    deleteRequest () {

    },
    voteFor (request) {
      request.userApproved = true
    },
    voteAgainst (request) {
      request.userApproved = false
    }
  }
}
</script>
