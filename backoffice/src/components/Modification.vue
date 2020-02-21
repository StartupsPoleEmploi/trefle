<template>
  <div id="Modification">
    <span v-if="this.toggled" @click="toggled = !toggled" style="cursor:pointer">
      <h5 class="d-inline-block text-nowrap" style="display:inline">
        {{ modification.title }} - {{ modification.date | moment("DD/MM/YYYY") }}
        <h6 class="text-muted font-weight-light" style="display:inline">({{ modification.date | moment("from", "now") }})</h6>
        <span class="fas fa-chevron-up modification-menu-chevron fa-sm"></span>
      </h5>
    </span>
    <span v-if="!this.toggled" @click="toggled = !toggled" style="cursor:pointer">
      <h5>
        {{ modification.title }} - {{ modification.date | moment("DD/MM/YYYY") }} 
        <h6 class="text-muted font-weight-light" style="display:inline">({{ modification.date | moment("from", "now") }})</h6>
        &nbsp;
        <span class="fas fa-chevron-down modification-menu-chevron fa-sm"></span>
      </h5>
    </span>
    <div v-show="this.toggled">
      <div v-html="prettyHtml" /> 
    </div>
  </div>
</template>
<script>
  import * as Diff2Html from 'diff2html';
  import 'diff2html/bundles/css/diff2html.min.css';

  export default {
    
    name: 'Modification',
    props: ['modification'],
    data: function() {
      return {
        toggled: false,
        formated_diff: '--- a/'+this.modification.file+'\n+++ b/'+this.modification.file+'\n'+this.modification.diff,
        formated_date: new Date(this.modification.date).getDate() + '/' + new Date(this.modification.date).getMonth() + '/' + new Date(this.modification.date).getFullYear(),
      }
    },
    mounted() {
      this.$moment.locale('fr')
    },
    computed : {
      prettyHtml: function () {
        return Diff2Html.html(this.formated_diff, {
          matching: 'lines',
          outputFormat: 'side-by-side',
        });
      },
    }
  }
</script>
<style scoped>
  .modification-menu-chevron {
    vertical-align: -5%;
    margin-left: 10px;
  }
</style>
