<template>
  <section>
    <OverlayLoader :loading="loading">
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
              {{ Math.round(vaultMoney, 2) }} ETH
            </h1>
          </div>
          <div class="text-center border-b py-3">
            <h2>
              Approved request
            </h2>
          </div>
          <div v-if="approvedRequests.length === 0">
            <p class="text-center">
              No ended votes yet
            </p>
          </div>
          <div v-else>
            <div v-for="(request, index) in approvedRequests" :key="index">
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
                <button class="btn" @click.prevent="executeProposal(request)">
                  Execute
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="max-w-3xl md:max-w-xl mx-auto flex flex-col items-center mt-12 w-full">
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
                    <span class="font-raleway font-bold">{{ request.votingEndsAt | formatDate }}</span>
                  </p>
                  <div class="flex flex-col justify-center items-end">
                    <img
                      src="/img/icons/thumbs-up.png"
                      :class="{ 'bg-green-600 rounded-full w-12 h-12': request.userApproved === true }"
                      @click="vote(request)"
                    >
                    <img
                      src="/img/icons/thumbs-down.png"
                      :class="{ 'bg-red-600 rounded-full w-12 h-12': request.userApproved === false}"
                      @click="vote(request, false)"
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
            <Input v-model="changedExpectedAmount" class="mt-3" type="number" placeholder="Here you can change the expected amount" />
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
    </OverlayLoader>
  </section>
</template>
<script>
// change amount window
// validate list
import { DateTime } from 'luxon'
import Moralis from 'moralis'
import BaseContainer from '~/components/BaseContainer'
import BaseModal from '~/components/BaseModal'
import OverlayLoader from '~/components/OverlayLoader'
import Input from '~/components/inputs/Input'
import RedCrossVault from '~/build/contracts/RedCrossVault.json'
import { normalizeContractOutput } from '~/utils/methods'
export default {
  name: 'ApplyForHelpPage',
  components: {
    BaseContainer,
    BaseModal,
    OverlayLoader,
    Input
  },
  filters: {
    formatDate (date) {
      return DateTime.fromSeconds(date).toFormat('dd.MM.yyyy HH:mm:ss')
    }
  },
  data () {
    // uint256 id;
    // address payable myAddress;
    // string name;
    // string email;
    // string description;
    // uint256 expectedAmount;
    // bool invalid;
    // bool valid;
    // bool isOnVote;
    // bool approved;
    return {
      loading: false,
      vaultMoney: 3.2,
      modalRequest: null,
      changedExpectedAmount: null,
      requests: []
    }
  },
  computed: {
    incomingRequests () {
      return this.requests.filter(r => !r.valid && !r.invalid)
    },
    currentRequests () {
      return this.requests.filter(r => r.valid && DateTime.now().toSeconds() < r.votingEndsAt)
    },
    approvedRequests () {
      return this.requests.filter(r => !r.approved && r.valid && DateTime.now().toSeconds() > r.votingEndsAt && r.yesVotes > r.noVotes)
    },
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

      this.requests = normalizeContractOutput(await Moralis.executeFunction({
        abi: RedCrossVault.abi,
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        functionName: 'getAllRequests'
      }))

      const result = await Moralis.executeFunction({
        abi: RedCrossVault.abi,
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        functionName: 'getVaultBalance'
      })
      // console.log(result)
      // console.log(result.toBigInt())
      // console.log(Moralis.Units.FromWei(result.toBigInt()))
      this.vaultMoney = Moralis.Units.FromWei(result.toBigInt())

      this.loading = false
    },
    showModalFor (request) {
      this.modalRequest = request
    },
    async validateRequest () {
      if (this.changedExpectedAmount) {
        this.modalRequest.expectedAmount = this.changedExpectedAmount
      }
      // TODO fix the problem where not whole number are causing error
      this.loading = true
      const transaction = await Moralis.executeFunction({
        abi: RedCrossVault.abi,
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        functionName: 'validateRequest',
        params: {
          _requestId: this.modalRequest.id,
          _valid: true,
          _expectedAmount: this.modalRequest.expectedAmount
        }
      })
      await transaction.wait()
      await this.loadData()
      this.modalRequest = null
      this.loading = false
      this.$rxt.toast('Success', 'Succesfully validated the request!')
    },
    async deleteRequest () {
      this.loading = true
      const transaction = await Moralis.executeFunction({
        abi: RedCrossVault.abi,
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        functionName: 'validateRequest',
        params: {
          _requestId: this.modalRequest.id,
          _valid: false,
          _expectedAmount: this.modalRequest.expectedAmount
        }
      })
      await transaction.wait()
      await this.loadData()
      this.modalRequest = null
      this.loading = false
      this.$rxt.toast('Success', 'Succesfully deleted the request!')
    },
    async vote (request, voteFor = true) {
      this.loading = true
      const transaction = await Moralis.executeFunction({
        abi: RedCrossVault.abi,
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        functionName: 'vote',
        params: {
          _requestId: request.id,
          _voteNumber: voteFor ? 0 : 2
        }
      })
      await transaction.wait()
      await this.loadData()
      this.loading = false
      this.$rxt.toast('Success', 'Succesfully voted for request!')
    },
    async executeProposal (request) {
      this.loading = true
      const transaction = await Moralis.executeFunction({
        abi: RedCrossVault.abi,
        contractAddress: RedCrossVault.networks[this.$config.networkId].address,
        functionName: 'approveRequest',
        params: {
          _requestId: request.id
        }
      })
      await transaction.wait()
      await this.loadData()
      this.loading = false
      this.$rxt.toast('Success', 'Succesfully executed the proposal!')
    }
  }
}
</script>
