<template>
  <div id="Outils">
    <IDCCSearch class="section-outil"></IDCCSearch>
      <hr class="outil-horizontal-separator">
    <Catalogue class="section-outil"></Catalogue>
  </div>
</template>
<script>

  import IDCCSearch from './IDCCSearch.vue'
  import Catalogue from './Catalogue.vue'

  export default {
    name: 'Outils',
    components: {
      IDCCSearch,
      Catalogue
    }
    
  }
</script>
<style scoped>
    .section-outil {
        padding-top: 3rem;
        padding-bottom: 3rem;
        margin-left: 2rem;
    }
</style>
