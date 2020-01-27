<template>
  <div id="Referentiel">
    <div id="referentiel-main-div">
      <div v-if="!this.isLoading">
        <div id="referentiel-main-row">
          <div class="container ml-5 mr-5">
            <div class="row">
              <div class="col-md-4 col-sm-12 col-xs-12">
                <div class="row">
                  <div class="col-md-11 col-sm-11 col-xs-11">
                    <h2 class="mb-5">Dispositifs de financement :</h2>
                    <RulesMenu title="Règles régionales" namespace="région" class="rules-menu" @click="this.forceRerender()"></RulesMenu>
                    <RulesMenu title="Règles nationales" namespace="règles nationales" class="rules-menu"></RulesMenu>
                    <RulesMenu title="Règles des organismes paritaires" namespace="organisme paritaire" class="rules-menu"></RulesMenu>
                    <RulesMenu title="Règles de rémunérations" namespace="rémunération" class="rules-menu"></RulesMenu>
                    <RulesMenu title="Règles de normalisation" namespace="normalisation" class="rules-menu"></RulesMenu>
                  </div>
                  <div class="col-md-1 col-sm-1 col-xs-1">
                    <hr class="referentiel-vertical-separator">
                  </div>
                </div>
              </div>
              <div class="col-md-8 col-sm-12 col-xs-12">
                <div v-if="this.show">
                  <Rule :data="this.currentRuleContent" :name="this.currentRuleName" :path="this.currentRuleFilePath" :printRulePath="this.printRulePath" :rulePath="this.rulePath" :key="this.rerenderKey"></Rule>
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
        this.forceRerender();
        if(this.windowLocationHash !== '') return this.rules[this.currentRuleName]['data'];
        else return null;
      },
      currentRuleName: function () {
        return this.windowLocationHash.split('#').pop();
      },
      currentRuleFilePath: function () {
        if(this.windowLocationHash !== '') return this.rules[this.currentRuleName]['path'];
        else return null;
      },
      printRulePath: function () {
        var path = "";
        var printpath = "(";
        if(this.windowLocationHash.split('#').length -1 > 1) {
          for(var i=1; i <= this.windowLocationHash.split('#').length -1; i++) {
            path += "#"+ this.windowLocationHash.split('#')[i];
            if (i == this.windowLocationHash.split('#').length - 1) printpath += "<a href='"+ path + "'>" + this.windowLocationHash.split('#')[i] + "</a>"
            else printpath += "<a href='"+ path + "'>" + this.windowLocationHash.split('#')[i] + "</a> > ";
          }
          return printpath+")";
        } else return "";
      },
      rulePath: function () {
        var path = "";
        for(var i=1; i <= this.windowLocationHash.split('#').length -1; i++) {
          path += "#"+ this.windowLocationHash.split('#')[i];
        }
        return path;
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
