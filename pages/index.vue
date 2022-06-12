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

    <div class="relative mt-12 h-[650px]">
      <div class="bg-blue-texture transform skew-y-12 absolute -top-10 w-screen h-[65vh] bg-cover">
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
            <button class="btn mt-5 text-center self-center w-52" @click.prevent="$router.push('/be-an-angel')">
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
        <button class="btn mt-5 text-center self-center w-52" @click.prevent="$router.push('/apply-for-help')">
          I need help!
        </button>
      </div>
      <div class="col-span-2">
        <img src="/img/help/need-help.png" class="h-[320px]">
      </div>
    </div>

    <div class="grid grid-cols-3 grid-rows-2 items-center mt-12 bg-white py-14">
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
          <img src="/img/technologies/nuxt.png" class="h-20 w-auto rounded-3xl">
          <img src="/img/technologies/moralis.png" class="h-20 w-auto">
          <!-- <img src="/img/technologies/elfi.svg" class="h-20 w-auto"> -->
          <img src="/img/technologies/solidity.png" class="h-20 w-auto">
        </div>
      </div>
    </div>

    <div class="grid grid-cols-3 grid-rows-2 items-center mt-12">
      <div class="col-span-3 row-span-1 text-center h-10">
        <h1 class="h1">
          The Team
        </h1>
        <h2>
          Made by friendly neighborhood guys!
        </h2>
      </div>
      <div class="col-span-3 row-span-1 my-5">
        <div class="flex flex-row justify-center gap-5 text-center">
          <!-- <a href="https://github.com/HabacucMX">
          <div class="teamMB"><img src="https://avatars.githubusercontent.com/u/57845110?s=400&u=5460231e3addfd30b2f4f35650c81206e3d7552f&v=4" class="bg-deco-100 rounded-full h-60 w-60">
            habacuc.eth<div class="text-lg text-deco-400">UX/UI</div></div></a> -->
          <a href="https://github.com/Riki0923">
            <div class="teamMB">
              <img src="https://wallpapercave.com/wp/wp10533483.jpg" class="rounded-full h-48 w-48">
              <h2>Riki0923</h2>
              <p>Smart contracts</p>
            </div>
          </a>
          <a href="https://github.com/gumacs92">
            <div class="teamMB">
              <img src="https://i.pinimg.com/736x/63/6c/45/636c451fd0a774623a45ec805fd91f1a.jpg" class="rounded-full h-48 w-48">
              <h2>gumacs92</h2>
              <p>Fullstack dev</p>
            </div>
          </a>
        <!-- <a href="https://github.com/tyrasz">
          <div class="teamMB"><img src="https://avatars.githubusercontent.com/u/16234736?v=4" class="bg-deco-100 rounded-full h-60 w-60">
            tyrasz<div class="text-lg text-deco-400">Contract verification</div></div></a> -->
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
