<template>
  <div id="Modification">
    <div id="modification-title" class="mt-5 mb-3">
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
    </div>
    <div id="modification-content">
      <div v-show="this.toggled" class="ml-5">
        <div v-html="prettyHtml" />
      </div>
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
          rawTemplates: {
            'tag-file-changed': '<span class="d2h-tag d2h-changed d2h-changed-tag">MODIFIÉ</span>',
            'tag-file-deleted': '<span class="d2h-tag d2h-deleted d2h-deleted-tag">SUPPRIMÉ</span>',
            'tag-file-renamed': '<span class="d2h-tag d2h-moved d2h-moved-tag">RENOMMÉ</span>',
            'tag-file-added': '<span class="d2h-tag d2h-added d2h-added-tag">AJOUTÉ</span>',
            'file-summary-wrapper': '<div class="d2h-file-list-wrapper"><div class="d2h-file-list-header"><span class="d2h-file-list-title">Fichiers modifiés ({{filesNumber}})</span><a class="d2h-file-switch d2h-hide">cacher</a><a class="d2h-file-switch d2h-show">show</a></div><ol class="d2h-file-list">{{{files}}}</ol></div>',
            'generic-wrapper': '<div class="d2h-wrapper">{{{content}}}</div>',
            'file-summary-line':'<li class="d2h-file-list-line"><span class="d2h-file-name-wrapper">{{>fileIcon}}<a href="#'+this.modification.file.split('/').pop()+'" class="d2h-file-name">{{fileName}}</a><span class="d2h-file-stats"><span class="d2h-lines-added">{{addedLines}}</span><span class="d2h-lines-deleted">{{deletedLines}}</span></span></span></li>'
          }
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
  .modification-horizontal-separator {
    border: none;
    border-top: 1px solid #bfbfbf;
    height: 1px;
    width: 100%;
    position:relative;
  }
</style>
