<template>
  <div data-cy="custom-select" class="custom-select" :tabindex="tabindex" @blur="open = false">
    <div data-cy="selected-open" class="selected" :class="{ open: open }" @click="open = !open">
      <span data-cy="color-custom" class="color-custom" :style="`${getDefault}` == 'very-high'
              ? {background:'#ed4c5c'} : `${getDefault}` == 'high'
              ? {background:'#f8a540'} : `${getDefault}` == 'normal'
              ? {background:'#00a790'} : `${getDefault}` == 'low'
              ? {background:'#418bc1'} : `${getDefault}` == 'very-low'
              ? {background:'#8942c1'} : ''" v-if="!open"/>
        <span data-cy="get-caption" v-if="!open">{{ getCaption }}</span>
        <span data-cy="priority" v-if="open">Pilih Priority</span>
    </div>
    <div data-cy="items-data" class="items" :class="{ selectHide: !open }">
      <div
        data-cy="looping-options"
        v-for="(option, i) of options"
        :key="i"
      >
       <span
       data-cy="getPriority"
        @click="getPriority(option.priority, option.caption)"
       >
          <span data-cy="color-custom" class="color-custom" :style="{
          padding: '0px 7px',
          borderRadius:'100%',
          background: `${option.color}`,
          color:'red',
          fontSize:'10px',
          marginLeft: '10px',
          marginRight: '20px'
        }"/>
        {{ option.caption }}
        <div data-cy="line" class="line"></div>
       </span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    options: {
      type: Array,
      required: true
    },
    default: {
      type: String,
      required: false,
      default: null
    },
    tabindex: {
      type: Number,
      required: false,
      default: 0
    }
  },
  data () {
    return {
      getDefault: 'very-high',
      getCaption: 'Very High',
      selected: this.default
        ? this.default
        : this.options.length > 0
          ? this.options[0].priority
          : null,
      open: false
    }
  },
  methods: {
    getPriority: function (data, caption) {
      this.getDefault = data
      this.getCaption = caption
      this.open = false
      this.$emit('input', this.getDefault)
    }
  }
}
</script>

<style scoped>
.custom-select {
  margin-top: 20px;
  position: fixed;
  width: 20%;
  text-align: left;
  outline: none;
  height: 40px;
  line-height: 40px;
}

.custom-select .selected {
  background-color: #fff;
  border-radius: 6px;
  border: 1px solid #E5E5E5;
  color: #111;
  padding-left: 1em;
  cursor: pointer;
  font-weight: 400;
  user-select: none;
}

.custom-select .selected.open {
  border: 1px solid #E5E5E5;
  border-radius: 6px 6px 0px 0px;
  color: #111;
}

.custom-select .selected:after {
  position: absolute;
  content: "";
  color: #111;
  top: 22px;
  right: 1em;
  width: 0;
  height: 0;
  border: 5px solid #E5E5E5;
  border-color: #fff #E5E5E5 #E5E5E5 #E5E5E5;
}

.custom-select .items {
  color: #111;
  border-radius: 0px 0px 6px 6px;
  overflow: hidden;
  border-right: 1px solid #E5E5E5;
  border-left: 1px solid #E5E5E5;
  border-bottom: 1px solid #E5E5E5;
  position: absolute;
  background-color: #fff;
  font-weight: 400;
  left: 0;
  right: 0;
  z-index: 1;
}

.custom-select .items div {
  color: #111;
  padding-left: 1em;
  cursor: pointer;
  user-select: none;
}

.custom-select .items div:hover {
  background-color: #15aaf8;
}

.selectHide {
  display: none;
}
.line{
  position: absolute;
  left: 0;
  width: 100%;
  height: 1px;
  background: #E5E5E5;
}
.color-custom{
  padding: 0px 7px;
  border-radius:100%;
  font-weight: 400;
  color:red;
  font-size:10px;
  margin-left: 10px;
  margin-right: 20px;
}
@media(max-width: 817px){
  .custom-select {
  margin-top: 20px;
  position: fixed;
  width: 50%;
  text-align: left;
  outline: none;
  height: 47px;
  line-height: 47px;
}
}
</style>
