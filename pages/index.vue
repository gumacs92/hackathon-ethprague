x<template>
  <section>
    <!-- <BaseContainer>
      <h1 class="h1">
        hello world
      </h1>
    </BaseContainer> -->
    <div class="max-w-5xl mx-auto grid grid-cols-4 grid-rows-1 items-center -mt-12">
      <div class="col-span-2 items-center p-3">
        <h1 class="h1">
          Red Cross Crypto
        </h1>
        <p class="font-bold text-xl mt-6">
          The only crypto project that truly here to help. Either you are a crypto fraud victim, or an earthquake victim, or anything else, we can help you.
        </p>
      </div>
      <div class="col-span-2">
        <img src="/img/help/helping-hands.png" class="h-[550px]">
      </div>
    </div>

    <div class="relative mt-12 h-[600px]">
      <div class="bg-blue-texture transform skew-y-12 absolute -top-10 w-screen h-[70vh] bg-cover">
        <div class="grid grid-cols-4 grid-rows-1 items-center transform -skew-y-12 z-20 max-w-5xl mx-auto">
          <div class="col-span-2">
            <img src="/img/help/donate-hand.png" class="h-[520px]">
          </div>
          <div class="col-span-2 flex flex-col p-3">
            <h1 class="h1">
              How can I help?
            </h1>
            <h2 class="ml-8">
              Every little matters!
            </h2>
            <p class="font-bold text-xl mt-6 text-white">
              You can help us by donating to the project, or by volunteering to help us. Either way you are here ot help us.
            </p>
            <button class="btn mt-5 text-center self-center w-52">
              I want to help!
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="max-w-5xl mx-auto grid grid-cols-4 grid-rows-1 items-center mt-12">
      <div class="col-span-2 flex flex-col p-3">
        <h1 class="h1">
          How can I apply for help?
        </h1>
        <h2 class="ml-8">
          No one left behind!
        </h2>
        <p class="font-bold text-xl mt-6">
          Our goal is to help everyone regardless of their background. We are here to help you.
        </p>
        <button class="btn mt-5 text-center self-center w-52">
          I need help!
        </button>
      </div>
      <div class="col-span-2">
        <img src="/img/help/need-help.png" class="h-[320px]">
      </div>
    </div>

    <div class="grid grid-cols-3 grid-rows-2 items-center mt-12">
      <div class="col-span-3 row-span-1 text-center">
        <h1 class="h1">
          Made with love!
        </h1>
        <h2>
          And with the following technologies:
        </h2>
      </div>
      <div class="col-span-3 row-span-1 mt-10">
        <div class="flex flex-row justify-around">
          <img src="/img/technologies/nuxt.png" class="h-20 w-auto">
          <img src="/img/technologies/moralis.png" class="h-20 w-auto">
          <img src="/img/technologies/elfi.svg" class="h-20 w-auto">
          <img src="/img/technologies/solidity.png" class="h-20 w-auto">
        </div>
      </div>
    </div>
  </section>
</template>
<script>
// import BaseContainer from '~/components/BaseContainer'
export default {
  name: 'IndexPage',
  components: {
    // BaseContainer
  }
}
</script>
