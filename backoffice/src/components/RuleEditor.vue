<template v-show="isEditMode">
   <div id="editor">
     <vue-editor v-model="content" :editorToolbar="customToolbar"></vue-editor>
   </div>
</template>

<script>
 import { VueEditor } from 'vue2-editor'

 export default {
  name: 'RuleEditor',
  props: {
    rawRule: Text,
    isEditMode: {
      type: Boolean,
      default: false
    }
  },
  components: {
      VueEditor
  },
  data() {
      return {
        content: this.rawRule,
        customToolbar: ['code-block']

      }
    },
  method: {
    save: function(){
      this.$parent.updatedRule = this.content
    }
  }
 }
</script>
