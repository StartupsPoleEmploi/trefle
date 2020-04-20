<template>
  <div id="Outils">
    <div class="container ml-3 mr-3 mt-5">
      <div class="row outils-row">
        <div class="col-md-6 col-sm-12">
          <IDCCSearch class="section-outil"></IDCCSearch>
        </div>
        <div class="col-md-6 col-sm-12">
          <CatalogueSearch class="section-outil"></CatalogueSearch>
        </div>
      </div>
      <div class="col-md-12 pb-3">
        <hr class="outil-horizontal-separator">
      </div>
      <div class="row">
        <div class="col-md-6 col-sm-12">
          <CertifInfoSearch class="section-outil"></CertifInfoSearch>
        </div>
        <div class="col-md-6 col-sm-12">
          <NAFSearch class="section-outil"></NAFSearch>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import IDCCSearch from './IDCCSearch.vue'
  import CatalogueSearch from './CatalogueSearch.vue'
  import CertifInfoSearch from './CertifInfoSearch.vue'
  import NAFSearch from './NAFSearch.vue'

  export default {
    name: 'Outils',
    components: {
      IDCCSearch,
      CatalogueSearch,
      CertifInfoSearch,
      NAFSearch
    }
  }
</script>
<style scoped>
  #Outils {
    padding-top: 2vh;
  }
  .outils-row {
    min-height:30vh;
  }
</style>
