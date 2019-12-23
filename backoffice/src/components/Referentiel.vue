<template>
  <div id="Referentiel">
    <div id="referentiel-main-div">
      <div v-if="!this.isLoading">
        <div id="referentiel-main-row">
          <div class="container">
            <div class="row">
              <div class="col-md-4">
                <h2>MENU</h2>
                <br>
                <RulesMenu title="Règles régionales" namespace="région" class="rules-menu"></RulesMenu>
                <RulesMenu title="Règles nationales" namespace="règles nationales" class="rules-menu"></RulesMenu>
                <RulesMenu title="Règles des organismes paritaires" namespace="organisme paritaire" class="rules-menu"></RulesMenu>
                <RulesMenu title="Règles de rémunérations" namespace="rémunération" class="rules-menu"></RulesMenu>
                <RulesMenu title="Règles de normalisation" namespace="normalisation" class="rules-menu"></RulesMenu>
              </div>
              <div class="col-md-1">
                <hr class="referentiel-vertical-separator">
              </div>
              <div class="col-md-7">
                <div v-if="this.show">
                  <h2> {{ this.ruleToShow.name.toUpperCase() }}</h2>
                  <br>
                  <pre>{{ this.ruleToShow.data }}</pre>
                </div>
                <div v-else>
                  <h2>Sélectionnez une règle.</h2>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div v-else class="text-center">
        <img src="./../assets/images/loading.gif" align="center" alt="loading...">
      </div>
    </div>
  </div>
</template>
<script>
  import RulesMenu from './RulesMenu.vue'

  export default {
    name: 'Referentiel',
    components: {
      RulesMenu
    },
    methods: {
      load: function () {
        this.$http.get('/explore/rules').then(response => {
          this.rules = response.body;
          this.isLoading = false;
        }).created;
      }
    },
    computed: {
      show: function () {
        return (this.windowLocationHash !== '')
      },
      ruleToShow: function() {
        if(this.show) {
          return this.rules[this.windowLocationHash.split('#')[1]];
        } return null;
      }
    },
    data: function(){
      return {
        rules:[],
        isLoading: true,
        windowLocationHash: decodeURI(window.location.hash)
      }
    },
    created: function () {
      this.load();
      window.addEventListener('popstate', () => {
        this.windowLocationHash = decodeURI(window.location.hash);
      })
    },
  }
</script>
<style>
  :scope.tools {
    min-width: 1200px;
    grid-template-columns: 1fr 4fr;
  }
  h3 {
    font-variant: small-caps;
  }
  #referentiel-main-row {
    padding-top: 3rem;
  }
  .referentiel-vertical-separator {
    border:         none;
    border-left:    1px solid #bfbfbf;
    height:         100%;
    width:          1px;
  }
</style>
