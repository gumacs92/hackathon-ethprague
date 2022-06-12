<template>
  <div
    class="fixed w-60 z-50 bg-white rounded-3xl shadow-md"
    :style="'top: ' + offset + 'px; right: 10px;'"
  >
    <div class="flex flex-col">
      <h2 class="p-3 border-b bg-red-50" style="border-top-left-radius: 1.5rem; border-top-right-radius: 1.5rem">
        {{ title }}
      </h2>
      <p class="p-3">
        {{ message }}
      </p>
    </div>
  </div>
</template>
<script>
export default {
  name: 'ComponentToast',
  props: {
    title: {
      required: true,
      type: String
    },
    message: {
      required: true,
      type: String
    },
    offset: {
      type: Number
    }
  }
}
</script>
