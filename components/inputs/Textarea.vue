<template>
  <div>
    <div
      v-if="icon"
      class="ml-3 absolute h-12 flex place-items-center place-content-center"
    >
      <img
        :src="icon"
        class="h-5 w-5"
      >
    </div>
    <textarea
      v-model="innerValue"
      :placeholder="placeholder"
      :rows="rows"
      :disabled="disabled"
      :class="{ '!bg-gray-400': disabled, 'pl-11': icon}"
      class="ring-1 ring-[#CFCFCF] rounded min-h-12 px-5 py-3 w-full font-merriweather
      focus:outline-none focus-within:bg-[#e8f0fe] hover:ring-red-600 focus:ring-red-600
      group-hover:bg-[#e8f0fe] group-disabled:bg-gray-400 disabled:bg-gray-400"
      @input="updateText()"
      @focus="isFocus = true"
      @blur="isFocus = false"
    />
    <div
      :class="{ '!h-[32px]': validationErrors }"
      class="font-merriweather text-sm text-red transition-all h-[0px] duration-1000"
    >
      {{ validationErrors ? validationErrors[0] : "" }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'InputTextarea',
  props: {
    value: {
      validator: prop => typeof prop === 'string' || prop === null,
      required: true
    },
    defaultValue: {
      type: String,
      default: ''
    },
    disabled: {
      type: Boolean,
      default: false
    },
    placeholder: {
      type: String,
      default: ''
    },
    icon: {
      type: String,
      default: ''
    },
    validationErrors: {
      type: Array,
      default: () => {
        return []
      }
    },
    rows: {
      type: Number,
      default: 8
    }
  },
  data () {
    return {
      innerValue: '',
      isFocus: false
    }
  },
  watch: {
    value (newValue) {
      this.innerValue = newValue
    }
  },
  beforeMount () {
    this.innerValue = this.defaultValue ? this.defaultValue : this.value
  },
  methods: {
    updateText () {
      this.$emit('input', this.innerValue)
    }
  }
}
</script>
