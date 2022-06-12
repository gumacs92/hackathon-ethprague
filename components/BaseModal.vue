<template>
  <div class="fixed top-0 left-0 bg-gray-600 bg-opacity-30 h-screen w-screen z-50">
    <div class="absolute max-w-xl left-1/2 top-1/2 transform -translate-x-1/2 -translate-y-1/2 rounded-3xl bg-white shadow-md px-5 py-3 m-3">
      <div class="relative">
        <slot />
      </div>
    </div>
  </div>
</template>
