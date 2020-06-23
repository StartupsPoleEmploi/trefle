<template>
  <div id="Scenarios">
    <div id="scenarios-main-div">
      <div v-if="!this.isLoading">
        <div class="container ml-5 mr-2">
          <div class="row">
            <div :class="classCollapsedMenu">
              <div class="mb-3 pull-right">
                <button @click="collapsed = !collapsed" type="button" class="btn main-button mb-5">
                  <span v-show="collapsed"><span class="chevron-toggle">&#8594;</span>  Ouvrir le panneau</span>
                  <span v-show="!collapsed"><span class="chevron-toggle">&#8592;</span>  Fermer le panneau</span>
                </button>
              </div>
              <div v-show="!collapsed">
                <h2 class="mb-5">Scénarios</h2>
                <ul>
                  <li v-for="(filter, id) in filterList" :key="id">
                    <a :href="'#'+selected_filters.join(',')" :class="{selected: filters[filter].selected}" @click="setFilter(filter);">
                      {{ filter.charAt(0).toUpperCase() + filter.slice(1) }}
                    </a>
                  </li>
                </ul>
              </div>
            </div>
            <div v-show="!collapsed" :class="classCollapsedSeparator">
              <hr class="referentiel-vertical-separator">
            </div>
            <div :class="classCollapsedContent">
              <div v-if="this.show">
                <div v-if="this.activeScenarios.length > 0">
                  <ul>
                    <li v-for="(scenario, id) in this.activeScenarios" :key="id">
                      <h4>
                        {{ scenario.name.toUpperCase() }}
                        <!--<a :href="'https://framagit.org/ybon/trefle/tree/master/'+scenario.filename+'#L'+scenario.line" target=_blank>
                          <i class=icon>edit</i>
                        </a>-->
                      </h4>
                      <pre v-html="transform(scenario.raw)"/>
                      <br><br>
                    </li>
                  </ul>
                </div>
                <div v-else>
                  <h4 class="mt-5">Sélectionnez au moins une catégorie dans le menu.</h4>
                </div>
              </div>
              <div v-else>
                <h2>Sélectionnez une catégorie dans le menu.</h2>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div v-else class="text-center loading-gif">
        <img src="@/assets/images/loading.gif" alt="loading...">
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'Scenarios',
    data: function () {
      return {
        scenarios: {},
        active: [],
        selected_filters: [],
        filters: [],
        toggled: "",
        collapsed: false,
        isLoading: true,
      }
    },
    computed: {
      show: function () {
        return (this.nbSelected !== '')
      },
      activeScenarios: function () {
        var activeScenarios = [];
        var scenarios = this.scenarios;
        if(this.selected_filters.length > 0) {
          for (var i=0; i < scenarios.length; i++) {
            var scenario = scenarios[i];
            if(this.selected_filters.every(function(current_filter) {
              return (scenario.tags.find(scenario_tag => scenario_tag == current_filter) != undefined)
            })) activeScenarios.push(scenario);
          }
        }
        return activeScenarios;
      },
      filterList: function(){
        var filterList = []
        var scenarios = this.activeScenarios
        Object.values(this.filters).forEach(function(filter){
          if(filter.selected){
            scenarios.forEach(function(scenario){
              if(scenario.tags.indexOf(filter.tag) > -1){
                scenario.tags.forEach(function(tag){
                  if(filterList.indexOf(tag) === -1){
                    filterList.push(tag)
                  }
                })
              }
            })
          }
        });
        if(filterList.length === 0) filterList = Object.keys(this.filters)
        filterList.sort((a, b) => a.localeCompare(b))
        return filterList
      },
      selectedItem: function(){
        var itemList = Object.values(this.filters).reduce(function(selected, item){ if(item.selected && selected.indexOf(item.tag) === -1) selected.push(item); return selected }, []);
        if(itemList.length === 0)
          itemList = this.filters
        return itemList;
      },
      nbSelected: function(){
        return Object.values(this.selectedItem).reduce(function(cnt, item){ if(item.selected) cnt=cnt+1; return cnt},0);
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
      },
    },
    created: function () {
      this.load();
      if(decodeURI(window.location.hash) != "") this.selected_filters = decodeURI(window.location.hash).split('#')[1].split(',');
    },
    methods: {
      load: function () {
        this.$http.get('/explore/scenarios').then(response => {
          this.scenarios = response.body
          this.isLoading = false;
          if(this.filters) {
            this.active = []
          }

          for (var i = 0, scenario; i < this.scenarios.length; i++) {
            scenario = this.scenarios[i]
            if (scenario.tags.length>0) {
              for (var k = 0; k < scenario.tags.length; k++) {
                if (this.filters.indexOf(scenario.tags[k]) === -1)
                {
                  var isSelected=(this.selected_filters.indexOf(scenario.tags[k]) > -1)
                  this.filters.push({tag:scenario.tags[k], selected:isSelected})
                }
              }
            }
            this.active.push(scenario)
          }
          this.filters.sort((a, b) => a.tag.localeCompare(b.tag))
          this.filters = this.filters.reduce(function(filters, item){ filters[item.tag]=item; return filters }, {})
        }).created;
      },
      setFilter: function (filter) {
        var index = this.selected_filters.indexOf(filter)
        if (index > -1) this.selected_filters.splice(index, 1)
        else this.selected_filters.push(filter)

        this.filters[filter].selected = !this.filters[filter].selected
      },
      transform: function(data) {
        return data
          .replace(/Si /g, '<span class="bold text-dark">Si </span>')
          .replace(/Soit /g, '<span class="bold text-dark">Soit </span>')
          .replace(/Quand /g, '<span class="bold text-dark">Quand </span>')
          .replace(/Scénario: /g, '<span class="bold text-dark">Scénario: </span>')
          .replace(/Ou /g, '<span class="bold text-dark">Ou </span>')
          .replace(/, ou /g, '<span class="bold text-dark">, ou </span>')
          .replace(/Et /g, '<span class="bold text-dark">Et </span>')
          .replace(/, et /g, '<span class="bold text-dark">, et </span>')
          .replace(/Alors /g, '<span class="bold text-dark">Alors </span>')
          .replace(/(#.+)/g, "<em class=\"comment\">$1</em>")
          .replace(/appliquer les règles «([^»]+?)(.rules)?»/g, 'appliquer les règles « <a href="'+this.rulePath+'#$1.rules" class="btn main-button" title="Ouvrir les règles" style="display:inline-block">$1</a> »')
          .replace(/(«.+»)/g, "<span class=\"string\">$1</span>")
          .replace(/,([^ ])/g, ", $1");
      },
    },
  }
</script>

<style scoped>
  #scenarios-main-div {
    padding-top: 3rem;
  }
  .selected {
    font-weight: bold;
  }
</style>
