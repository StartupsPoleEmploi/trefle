<template>
  <div id="Accueil">
    <div class="container">
      <div class="row">
        <div class="col-md-5 mt-5">
          <h2>Bienvenue sur l'outil Trèfle</h2>
        </div>
        <div class="col-md-7 mt-5">
          <p>
            Trèfle est un outil dédié aux dispositifs de financement des formations.<br>
            Il recense région par région tous les dispositifs applicables.<br>
            Trèfle vous permet de consulter ou de modifier un dispositif de financement existant.<br>
            Les règles enregistrées dans Trèfle alimentent le simulateur de financement de formation disponible sur <a  class="link_class" href="https://labonneformation.pole-emploi.fr/" target="_blank">La Bonne Formation</a> et <a  class="link_class" href="https://candidat.pole-emploi.fr/formations/accueil" target="_blank">Pole Emploi.fr</a>
          </p>
        </div>
      </div>
      <div v-if="!isLoading">
        <div class="row">
          <div class="col-md-6">
            <h4>
              <strong>
                {{ Object.keys(modification_list).length }}
              </strong>
              modifications en cours de validation
            </h4>
            <span style="color:#384EAA">
              Cliquez sur le graphique pour afficher les modifications par région
            </span>
          </div>
          <div class="col-md-6">
            <!--<a href="referentiel" class="main-button-primary btn float-right">Accédez au référentiel de règles</a>-->
          </div>
        </div>
      </div>
      <div v-else class="text-center loading-gif">
        <img src="@/assets/images/loading.gif" alt="loading...">
      </div>
      <div class="row">
        <div class="col-md-12 mt-5">
          <div id="chart-container" class="text-center">
            <ModificationChart :width="1200" :height="200" @on-receive="update" :values="modification_chart_datas.datasets" :labels="modification_chart_datas.labels"></ModificationChart>
          </div>
        </div>
        <div class="col-md-12">
          <div v-if="!isUpdateLoading">
            <div id="modification_list">
              <div v-if="selected_rule">
                <h5>
                  <strong>
                    {{ Object.keys(selected_modification_list).length }}
                  </strong>
                    Modification(s) de la règle
                  <strong>
                    {{ selected_rule }}
                  </strong>
                  en cours de validation
                </h5>
                <ul v-for="modification in selected_modification_list" :key="modification.id" class="dash">
                  <li>
                    <a :href="'referentiel#'+selected_rule+'.rules#modified'" class="link_class"> {{ modification.title }} </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <div v-else class="text-center loading-gif" style="padding-top:0;">
            <img src="@/assets/images/loading.gif" alt="loading...">
          </div>
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
        isUpdateLoading: false,
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
          if (typeof acc[curr] == 'undefined') acc[curr] = 1;
          else acc[curr] += 1;
          return acc;
        }, {}));

        modifications = Object.values(modifications.reduce(function (acc, curr) {
          if (typeof acc[curr] == 'undefined') acc[curr] = 1;
          else acc[curr] += 1;
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
        this.isUpdateLoading=true;
        this.$http
          .get('/source/modified?branch='+encodeURIComponent(this.selected_rule))
          .then(response => {
            this.selected_modification_list = response.body;
            this.isUpdateLoading=false;
            return true;
          }, response => {
            if(response.status == 500) this.selected_modification_list = {};
            this.isUpdateLoading=false;
            return false;
          })
      }
    },
  }
</script>

<style>
  #chart-container {
    width: 40rem;
    height: 20rem;
  }
  .link_class {
    cursor:pointer;
    color:#384EAA;
  }
</style>
