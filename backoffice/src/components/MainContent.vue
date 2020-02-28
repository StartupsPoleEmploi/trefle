<template>
  <div id="MainContent" class="bg-light">
    <div id="PageContent" class="bg-white">
        <router-view/>
        <router-view name="accueil"/>
        <router-view name="referentiel"/>
        <router-view name="financements"/>
        <router-view name="simulateur"/>
        <router-view name="scenarios"/>
        <router-view name="outils"/>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'MainContent'
  }
</script>
<style>
  #MainContent {
    width: 86vw;
    position: absolute;
    left: 14vw;
    transition: all 0.4s;
  }

  #PageContent {
    border-radius: 5px;
    width: 80vw;
    height: 100%;
    min-height: 86vh;
    margin-top : 7vh;
    margin-bottom: 7vh;
    margin-right: 3vw;
    margin-left: 3vw;
    -webkit-box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.1);
    -moz-box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.1);
    box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.1);
  }

  .page-title {
    padding-bottom: 3rem;
    font-variant: small-caps;
  }
</style>
