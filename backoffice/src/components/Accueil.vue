<template>
    <div id="Accueil">
      <div class="container">
        <div class="row">
          <div class="col-md-12 mt-3">
            <h2>Bienvenue sur l'outil Trèfle</h2>
          </div>
        </div>
        <div class="row mt-3">
          <div class="col-md-12">
            <p>Vide, quantum, inquam, fallare, Torquate. oratio me istius philosophi non offendit; nam et complectitur verbis, quod vult, et dicit plane, quod intellegam; et tamen ego a philosopho, si afferat eloquentiam, non asperner, si non habeat, non admodum flagitem. re mihi non aeque satisfacit, et quidem locis pluribus. sed quot homines, tot sententiae; falli igitur possumus.</p>
          </div>
        </div>
        <div class="row mt-3">
          <div class="col-md-4 col-sm-12">
            <div id="chart-container">
              <ModificationChart  @on-receive="update" :values="modification_chart_datas.datasets" :labels="modification_chart_datas.labels"></ModificationChart>
            </div>
          </div>
          <div v-if="!isLoading">
            <div class="col-md-8 col-sm-12">
              <div id="modification_list">
                <div v-if="selected_rule">
                  <h5> Modification(s) de la règle en cours de validation {{ selected_rule }} ({{ Object.keys(selected_modification_list).length }}) </h5> 
                  <ul v-for="modification in selected_modification_list" :key="modification.id" class="dash">
                    <li>
                      <a :href="'referentiel#'+selected_rule+'.rules#modified'"> {{ modification.title }} </a>
                    </li>
                  </ul>
                </div>
                <div v-else>
                  <h5> Toutes les modifications en cours de validation ({{ Object.keys(modification_list).length }})</h5>
                  <ul v-for="modification in modification_list" :key="modification.id" class="dash">
                    <li>
                      <a :href="'referentiel#'+modification.file.split('/').pop().split('.')[0]+'.rules#modified'"> {{ modification.title }} - ({{ modification.file.split('/').pop().split('.')[0] }})</a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div v-else class="text-center loading-gif">
            <img src="./../assets/images/loading.gif" alt="loading...">
          </div>
        </div>
      </div>
    </div>
</template>
<script>

  import ModificationChart from './ModificationChart.vue';

  export default {
    name: 'Accueil',
    components: {
      ModificationChart,
    },
    data : function () {
      return {
        modification_list: {},
        selected_modification_list: {},
        selected_rule: '',
        test:0,
        isLoading: true,
      }
    },
    beforeMount: function() {
      this.loadInProgressModification();
    },
    methods: {      
      loadInProgressModification: function () {
        this.$http
          .get('/source/modified')
          .then(response => {
            this.modification_list = response.body;
            this.isLoading = false;
            return true;
          }, response => {
            if(response.status == 500) this.modification_list = {};
            this.isLoading = false;
            return false;
          })
      },
      update (data) {

        this.selected_rule = data.value
        this.$http
          .get('/source/modified?branch='+encodeURIComponent(this.selected_rule))
          .then(response => {
            this.selected_modification_list = response.body;
            return true;
          }, response => {
            if(response.status == 500) this.selected_modification_list = {};
            return false;
          })
      }
    },
    computed : {
      modification_chart_datas: function () {
        var modifications = [];
        var keys = []
        for (let [key, value] of Object.entries(this.modification_list)) {
          keys.push(key);
          modifications.push(value.file.split('/').pop());
        }

        keys = Object.keys(modifications.reduce(function (acc, curr) {
              if (typeof acc[curr] == 'undefined') {
                acc[curr] = 1;
              } else {
                acc[curr] += 1;
              }
              return acc;
            }, {}));

        modifications = Object.values(modifications.reduce(function (acc, curr) {
              if (typeof acc[curr] == 'undefined') {
                acc[curr] = 1;
              } else {
                acc[curr] += 1;
              }
              return acc;
            }, {}))
        
        return {
          labels: keys,
          datasets: [
            {
              data: modifications
            }
          ]
        }
      }
    }
  }
</script>

<style>
  #chart-container {
    width: 20rem;
    height: 20rem;
  }
  
</style>
