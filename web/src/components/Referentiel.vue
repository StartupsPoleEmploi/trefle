<template>
  <div id="Referentiel">
    <div id="ref-main-div">  
      <div id="ref-header-row">
        <div class="container">
          <div class="row mb-4">
            <div id="ref-count-financements" class="col-md-3 col-sm-6 col-xs-12">
              <span id="ref-count-financements-number" class="ref-results-count-number ref-count-financements-text">{{ this.count_financements }}</span>
              <span class="ref-count-financements-text" v-if="this.lt_two">&nbsp;financement</span>
              <span class="ref-count-financements-text" v-else>&nbsp;financements</span>
            </div>
            <div id="ref-create-financement" class="col-md-3 col-sm-6 col-xs-12 my-auto">
              <button href="#" class="btn btn-outline-success" disabled>Créer un financement</button>
            </div>
            <div id="ref-search-financement" class="col-md-6 col-sm-12 col-xs-12 my-auto">
              <div class="form-inline pull-right">
                <div class="form-group mx-sm-3 mb-2">
                  <input class="form-control" id="financement-search-field" name="financement-search" type="search" placeholder="Rechercher" v-model="search">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div id="ref-last-update" class="col-md-12">
              Dernière mise à jour le __ à __
            </div>
          </div>
        </div>
      </div>
      <hr class="ref-horizontal-separator">
      <div id="ref-filter-row" class="container">
        <label for="financement-filter-select">Filtrer par</label>
        <select id="financement-filter-select" class="form-control" name="financement-filter-select" disabled>
          <option>Tous les publics</option>
        </select>
      </div>
      <hr class="ref-horizontal-separator">
      <div id="ref-result-row" class="container">
        <span v-if="this.lt_two" class="ref-results-count">
            Résultat (<span class="ref-results-count-number"></span>)
        </span>
        <span v-else class="ref-results-count">
            Résultats (<span class="ref-results-count-number"></span>)
        </span>
        <div id="ref-results-list">
          <ul id="ul-ref-results-list" class="container">
            <li v-for="financement in this.financements" :key="financement.id" class="mt-4 row">
              <span class="col-md-3 col-sm-12">
                <strong class="ref-fields">{{ financement.intitule }}</strong>
              </span>
              <span class="col-md-8 col-sm-11">
                <button v-for="tag in financement.tags" :key="tag.id" class="ref-results-tags btn btn-outline-info" href="#" disabled>{{ tag }}</button>
              </span>
              <span class="col-md-1 col-sm-1 pull-right">              
                <button href="https://framagit.org/ybon/trefle/tree/master/trefle/config/financements.yml" target="_blank" class="text-dark btn btn-outline-light" disabled>
                  <i class="icon" style="vertical-align: baseline;">edit</i>
                </button>
              </span>
            </li>         
            <hr class="ref-list-horizontal-separator">
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'Referentiel',
  methods: {
      load: function () {
          this.$http.get(process.env.VUE_APP_TREFLE_URL+process.env.VUE_APP_API_VERSION+'/explore/financements').then(response => {
              this.financements = response.body;
              this.count_financements = this.financements.length;
              if (this.count_financements<2) this.lt_two=true;
              }
          );
      }
  },
  components: {
  },
  data: function(){
      return {
          financements:[],
          count_financements:0,
          lt_two:false,
          search:""
      }
  },
  beforeMount: function () {
      this.load();
  },
  computed: {
      /*filteredFinancements: () => {
        return this.financements.filter((financement) => {
          //return financement.intitule.match(this.search)
        })
      }*/
  },
}
</script>
<style>
#ref-header-row {
  padding-top: 3rem;
}

.ref-count-financements-text {
  font-size: 1.5em;
}
#ref-count-financements-number {
  font-size: 2.5em;
  font-style: bolder;  
}

#ref-last-update {
  font-size: 0.9em;
  color: #000; /* Fallback for older browsers */
  color: rgba(0, 0, 0, 0.5);
}

/*#ref-filter-row {
}

#ref-results-row {
}*/

.ref-results-count {
  color: #000; /* Fallback for older browsers */
  color: rgba(0, 0, 0, 0.5);
}

#ref-results-list {
  padding-top: 2rem;
}

.ref-horizontal-separator {
  border: none;
  border-top: 1px solid #bfbfbf;
  height: 1px;
  width: 90%;
  position:relative;
}


#financement-filter-select {
  width: 15%;
}
</style>