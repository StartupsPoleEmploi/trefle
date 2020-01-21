<template>
  <div id="Referentiel">
    <div id="referentiel-main-div">
      <div v-if="!this.isLoading">
        <div id="referentiel-main-row">
          <div class="container">
            <div class="row">
              <div class="col-md-4">
                <h2 class="mb-5">MENU</h2>
                <RulesMenu title="Règles régionales" namespace="région" class="rules-menu" @click="this.forceRerender()"></RulesMenu>
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
                  <Rule :data="this.currentRuleContent" :name="this.currentRuleName" :key="this.rerenderKey"></Rule>
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
  import RulesMenu from './RulesMenu.vue';
  import Rule from './Rule.vue';

  export default {
    name: 'Referentiel',
    components: {
      RulesMenu,
      Rule,
    },
    data: function(){
      return {
        rules: [],
        isLoading: true,
        windowLocationHash: decodeURI(window.location.hash),
        rerenderKey: 0
      }
    },
    computed: {
      show: function () {
        return (this.windowLocationHash !== '')
      },
      currentRuleContent: function() {
        if(this.windowLocationHash !== '') return this.rules[this.currentRuleName]['data'];
        else return null;
      },
      currentRuleName: function() {
        return this.windowLocationHash.split('#')[1]
      },
    },
    mounted: function () {
      this.loadRules();
      window.addEventListener('popstate', () => {
        this.windowLocationHash = decodeURI(window.location.hash);
      })
    },
    methods: {
      loadRules: function () {
        this.$http.get('/explore/rules').then(response => {
          this.rules = response.body;
          this.isLoading = false;
        }).created;
      },
      forceRerender: function () {
        this.rerenderKey +=1;
      }
    },
  }

</script>

<style>
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
