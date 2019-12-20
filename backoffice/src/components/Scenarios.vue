<template>
  <div id="Scenarios">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <ul>
            <li v-for="filter in filterList" :key="filter.id">
              <a href="#" :class="{selected: filters[filter].selected}" :title="filter" @click="selectToggle(filters[filter])">
                {{ filter }}
              </a>
            </li>
          </ul>
          <div v-if="nbSelected">
            <ul>
              <li v-for="scenario in activeScenario" :key="scenario.id">
                <h4>
                  {{ scenario.name }}
                  <a :href="'https://framagit.org/ybon/trefle/tree/master/'+scenario.filename+'#L'+scenario.line" target=_blank>
                    <i class=icon>edit</i>
                  </a>
                </h4>
              </li>
            </ul>
          </div>
        </div>
        <div class="col-md-6">
          <div v-if="!nbSelected">
              <p>Sélectionner au moins une catégorie dans le menu.</p>
          </div>
        </div>
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
      }
    },
    methods: {
      load: function () {
        this.$http.get('/explore/scenarios').then(response => {
            this.scenarios = response.body
            this.selected_filters = decodeURIComponent(this.$route.params.filters).split(',')
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
      selectToggle: function(item){
          item.selected = !item.selected
          this.$router.append('test')
      }
    },
    created: function () {
      this.load();
    },
    computed: {
      activeScenario: function(){
        var activeScenario = []
        var scenarios = this.scenarios
        this.filterList.forEach(function(tag){
          scenarios.forEach(function(scenario){
          var idx = scenario.tags.indexOf(tag)
            if(idx > -1 && !(idx in activeScenario)){
              activeScenario[idx]=scenario
            }
          })
        })
        return activeScenario
      },
      filterList: function(){
        var filterList = []
        var scenarios = this.scenarios
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
      }
     //active: function(){
     //   return Object.values(this.filters).reduce(function(cnt, item){ if(item.selected) cnt=cnt+1; return cnt},0);
     //}
    }
  }
</script>
