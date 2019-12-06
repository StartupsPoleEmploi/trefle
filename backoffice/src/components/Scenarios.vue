<template>
  <div id="Scenarios">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <ul>
            <li v-for="filter in this.filters" :key="filter.id">
              <a href="#" :title="filter">
                {{ filter }}
              </a>
            </li>
          </ul>
          <div v-if="this.selected_filters.length && this.active.length">
            <ul>
              <li v-for="active in this.active" :key="active.id">
                <h4>
                  {{ active.name }}
                  <a :href="'https://framagit.org/ybon/trefle/tree/master/'+active.filename+'#L'+active.line" target=_blank>
                    <i class=icon>edit</i>
                  </a>
                </h4>              
              </li>
            </ul>
          </div>
        </div>
        <div class="col-md-6">
          <div v-if="!this.selected_filters.length">
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
        toggled: ""
      }
    },
    methods: {
      load: function () {
        this.$http.get('/explore/scenarios').then(response => {
            this.scenarios = response.body
            if(this.filters) {
              this.active = []
            }
            for (var i = 0, scenario; i < this.scenarios.length; i++) {
              scenario = this.scenarios[i]
              if (scenario.tags.length>0) {
                for (var k = 0; k < scenario.tags.length; k++) {
                  if (this.filters.indexOf(scenario.tags[k]) === -1) this.filters.push(scenario.tags[k])
                }
              }
              this.active.push(scenario)
            }
            this.filters.sort((a, b) => a.localeCompare(b))
        }).created;
      }
    },
    created: function () {
      this.load();
    },
  }
</script>
