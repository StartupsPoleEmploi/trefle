<template>
  <div id="Referentiel">
    <div id="referentiel-main-div">
      <div v-if="!this.isLoading">
        <div id="referentiel-main-row">
          <div class="container ml-5 mr-2">
            <div class="row">
              <div v-if="!isEditMode" :class="classCollapsedMenu">
                  <div class="mb-3 pull-right">
                    <button @click="collapsed = !collapsed" type="button" class="btn main-button mb-5">
                      <span v-show="collapsed"><span class="chevron-toggle">&#8594;</span>  Ouvrir le panneau</span>
                      <span v-show="!collapsed"><span class="chevron-toggle">&#8592;</span>  Fermer le panneau</span>
                    </button>
                  </div>
                  <div v-show="!collapsed">
                    <h2 class="mb-5">Dispositifs de financement</h2>
                    <RulesMenu title="Régionaux" namespace="région" class="rules-menu" @click="this.forceRerender()"></RulesMenu>
                    <RulesMenu title="Nationaux" namespace="règles nationales" class="rules-menu"></RulesMenu>
                    <RulesMenu title="Organismes paritaires" namespace="organisme paritaire" class="rules-menu"></RulesMenu>
                    <RulesMenu title="Rémunérations" namespace="rémunération" class="rules-menu"></RulesMenu>
                    <RulesMenu title="Normalisations" namespace="normalisation" class="rules-menu"></RulesMenu>
                  </div>
              </div>
              <div v-show="!collapsed" :class="classCollapsedSeparator">
                <hr class="referentiel-vertical-separator">
              </div>
              <div :class="classCollapsedContent">
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
      <div v-else class="text-center loading-gif">
        <div v-if="modificationInProgress" class="mt-5">
          <h2>Modification en cours...</h2>
        </div>
        <img src="./../assets/images/loading.gif" alt="loading...">
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
        modificationInProgress: false,
        rerenderKey: 0,
        collapsed: false,
        currentRuleName: decodeURI(window.location.hash).split('#').pop() == "modified" ? decodeURI(window.location.hash).split('#')[1]:decodeURI(window.location.hash).split('#').pop(),
        inProgressModification : false,
        isEditMode: false,
      }
    },
    computed: {
      show: function () {
        return (this.currentRuleName !== '')
      },
      currentRuleContent: function() {
        this.forceRerender();
        if(this.currentRuleName !== '') return this.rules[this.currentRuleName]['data'];
        else return null;
      },
      currentRuleFilePath: function () {
        if(this.currentRuleName !== '') return this.rules[this.currentRuleName]['path'];
        else return null;
      },
      printRulePath: function () {
        var path = "";
        var printpath = "";
        if(this.windowLocationHash.split('#').length -1 > 1) {
          for(var i=1; i <= this.windowLocationHash.split('#').length -1; i++) {
            if (this.windowLocationHash.split('#').pop() == 'modified') return "";
            path += "#"+ this.windowLocationHash.split('#')[i];
            if (i == this.windowLocationHash.split('#').length - 1) printpath += "<a class='btn main-button' href='"+ path + "'>" + this.windowLocationHash.split('#')[i] + "</a>"
            else printpath += "<a class='btn main-button' href='"+ path + "'>" + this.windowLocationHash.split('#')[i] + "</a> <b>></b> ";
          } return printpath;
        } else return "";
      },
      rulePath: function () {
        var path = "";
        for(var i=1; i <= this.windowLocationHash.split('#').length -1; i++) {
          path += "#"+ this.windowLocationHash.split('#')[i];
        }
        return path;
      },
      classCollapsedContent: function () {
        if(this.collapsed) return "col-md-12 col-sm-12 col-xs-12";
        return "col-md-8 col-sm-12 col-xs-12";
      },
      classCollapsedMenu: function () {
        if(this.collapsed) return "col-md-0 col-sm-0 col-xs-0";
        return "col-md-3 col-sm-12 col-xs-12";
      },
      classCollapsedSeparator: function () {
        if(this.collapsed) return "col-md-0 col-sm-0 col-xs-0";
        return "col-md-1 col-sm-0 col-xs-0";
      }
    },
    created: function () {
      this.loadRules();
      window.addEventListener('popstate', () => {
        this.windowLocationHash = decodeURI(window.location.hash);
        this.currentRuleName = decodeURI(window.location.hash).split('#').pop() == "modified" ? decodeURI(window.location.hash).split('#')[1]:decodeURI(window.location.hash).split('#').pop();
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
    height:         95%;
    width:          1px;
  }
  .chevron-toggle {
    font-weight: bold;
  }
</style>
