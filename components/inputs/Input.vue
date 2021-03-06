<template>
  <div
    class="h-20"
    :class="{ '!h-12': !hasErrors && !small, 'h-8': !hasErrors && small, 'h-16': hasErrors && small}"
  >
    <div
      v-if="icon"
      class="ml-3 absolute h-12 flex place-items-center place-content-center"
      :class="{'h-8': small }"
    >
      <img
        :src="icon"
        class="h-5 w-5"
      >
    </div>
    <input
      :id="id"
      ref="input"
      v-model="inputValue"
      :type="type"
      :placeholder="placeholder"
      :disabled="disabled ? true : false"
      autocomplete="off"
      :class="{ '!bg-gray-400 !placeholder-gray-300': disabled, 'h-8': small, 'pl-11': icon}"
      class="ring-1 ring-[#CFCFCF] rounded h-12 px-5 w-full font-merriweather
        focus:ring-red-600
        focus:outline-none focus-within:bg-[#e8f0fe] hover:ring-red-600 group-hover:bg-[#e8f0fe]
        group-disabled:bg-gray-400 disabled:bg-gray-400"
      @input="onInput()"
      @focus="onFocus($event)"
      @blur="onBlur($event)"
    >
    <div
      v-if="hasErrors"
      :class="{ '!h-[32px]': validationErrors }"
      class="font-merriweather text-sm text-red transition-all h-[0px] duration-1000"
    >
      {{ validationErrors ? validationErrors[0] : "" }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'InputInput',
  props: {
    // eslint-disable-next-line
    value: {
      required: true,
      validation: (prop) => {
        return (
          prop instanceof String || prop instanceof Number || prop === null
        )
      }
    },
    placeholder: {
      type: String,
      default: ''
    },
    type: {
      type: String,
      default: ''
    },
    id: {
      type: String,
      default: null
    },
    validationErrors: {
      type: Array,
      default: () => {
        return []
      }
    },
    icon: {
      type: String,
      default: ''
    },
    disabled: {
      type: Boolean,
      default: false
    },
    afterText: {
      type: String,
      default: ''
    },
    hasFocus: {
      type: Boolean,
      default: true
    },
    hasErrors: {
      type: Boolean,
      default: true
    },
    small: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      isFocus: false,
      inputValue: ''
    }
  },
  watch: {
    hasFocus () {
      if (this.hasFocus) {
        this.$refs.input.focus({
          preventScroll: true
        })
      }
    },
    value (newValue) {
      this.inputValue = newValue
      // this.$emit("input", this.inputValue);
    }
  },
  beforeMount () {
    this.inputValue = this.value
  },
  methods: {
    onInput () {
      this.$emit('input', this.inputValue)
    },
    onFocus (event) {
      this.isFocus = true
      this.$emit('focus', event)
    },
    onBlur (event) {
      this.isFocus = false
      this.$emit('blur', event)
    }
  }
}
</script>
