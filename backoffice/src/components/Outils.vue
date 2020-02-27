<template>
  <div id="Outils">
    <IDCCSearch class="section-outil"></IDCCSearch>
      <hr class="outil-horizontal-separator">
    <Catalogue class="section-outil"></Catalogue>
      <hr class="outil-horizontal-separator">
    <CertifInfo class="section-outil"></CertifInfo>
  </div>
</template>
<script>

  import IDCCSearch from './IDCCSearch.vue'
  import Catalogue from './Catalogue.vue'
  import CertifInfo from './CertifInfo.vue'

  export default {
    name: 'Outils',
    components: {
      IDCCSearch,
      Catalogue,
      CertifInfo
    }
    
  }
</script>
<style scoped>
  .section-outil {
    padding-top: 1.5rem;
    padding-bottom: 1.5rem;
    margin-left: 2rem;
  }
</style>
