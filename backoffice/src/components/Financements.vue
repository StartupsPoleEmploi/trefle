<template>
  <div id="Financements">
    <div id="financement-main-div">
      <div v-if="!this.isLoading">
        <div id="financement-header-row">
          <div class="container">
            <div class="row mb-4">
              <div id="financement-count-financements" class="col-md-6 col-sm-12 col-xs-12">
                <span id="financement-count-financements-number" class="financement-results-count-number financement-count-financements-text">{{ this.countFinancements }}</span>
                <span class="financement-count-financements-text" v-if="this.countFinancements < 2">&nbsp;financement</span>
                <span class="financement-count-financements-text" v-else>&nbsp;financements</span>
              </div>
              <div id="financement-create-financement" class="col-md-6 col-sm-12 col-xs-12 my-auto">
                <div class="form-inline pull-right">
                  <div class="form-group mx-sm-3 mb-2">
                    <input type="button" href="#" class="btn main-button form-control" value="Créer un financement"  disabled />
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div id="financement-last-update" class="col-md-12">
                Dernière mise à jour le __ à __
              </div>
            </div>
          </div>
        </div>
        <hr class="financement-horizontal-separator">
        <div id="financement-filter-row" class="container">
          <label for="financement-filter-select">Filtrer par</label>
          <select id="financement-filter-select" class="form-control" name="financement-filter-select" v-model="search">
            <option value="" selected>Tous les financements</option>
            <optgroup label="Champ d'action">
              <option value="national">Financements nationaux</option>
              <option value="région">Financements régionaux</option>
            </optgroup>
            <optgroup label="Public visé">
              <option value="DE">Demandeurs d'Emploi</option>
              <option value="salarié">Salariés</option>
              <option value="TH">Travailleurs Handicapés</option>
              <option value="jeune">Personnes Niv inférieur au Bac</option>
            </optgroup>
          </select>
        </div>
        <hr class="financement-horizontal-separator">
        <div id="financement-result-row" class="container">
          <div class="row">
            <div id="financement-search-financement" class="col-md-6 col-sm-12 col-xs-12 my-auto">
              <span v-if="this.countFinancements < 2" class="financement-results-count">
                Résultat (<span class="financement-results-count-number">{{ this.countResultats }}</span>)
              </span>
              <span v-else class="financement-results-count">
                Résultats (<span class="financement-results-count-number">{{ this.countResultats }}</span>)
              </span>
            </div>
            <div id="financement-search-financement" class="col-md-6 col-sm-12 col-xs-12 my-auto">
              <div class="form-inline pull-right">
                <div class="form-group mx-sm-3 mb-2">
                  <input class="form-control" id="financement-search-field" name="financement-search" placeholder="Rechercher" v-model="search">
                </div>
              </div>
            </div>
          </div>
          <div id="financement-results-list">
            <ul id="ul-financement-results-list">
              <li v-for="financement in this.filteredFinancements" :key="financement.id" class="mt-4 row">
              <span class="col-md-3 col-sm-12">
                <a :href="'/0.7/explorer/referentiel#'+financement.racine">
                  <strong class="financement-fields">{{ financement.intitule }}</strong>
                </a>
              </span>
              <span class="col-md-8 col-sm-11">
                <span v-for="tag in financement.tags" :key="tag.id" class="financement-results-tags" >
                  <span class="btn main-button">
                    {{ tag }}
                  </span>
                </span>
              </span>
              <span class="col-md-1 col-sm-1 pull-right">
                <button href="https://git.beta.pole-emploi.fr/open-source/trefle/edit/master/trefle/config/financements.yml" target="_blank" class="text-dark btn btn-outline-light" disabled>
                  <i class="icon" style="vertical-align: baseline;">edit</i>
                </button>
              </span>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div v-else class="text-center loading-gif">
        <img src="./../assets/images/loading.gif" alt="loading...">
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'Financements',
    methods: {
      load: function () {
        this.$http.get('/explore/financements').then(response => {
          this.financements = response.body;
          this.isLoading = false;
        }).created;
      },
      filterable: function (intitule,tags) {
        //replace all accents characters in the search string by their non-accented equivalent
        return intitule.concat(tags.join("")).normalize('NFD').replace(/[\u0300-\u036f]/g, "");
      }
    },
    data: function(){
      return {
        financements:[],
        search: "",
        isLoading: true,
      }
    },
    created: function () {
      this.load();
    },
    computed: {
      filteredFinancements() {
        return this.financements.filter(financement => {
          if (this.search != "") {
            //replace all accents characters in the search string by their non-accented equivalent
            var searchWithoutAccents = this.search.normalize('NFD').replace(/[\u0300-\u036f]/g, "")
            //create a RegExp for the search string to be case-insensitive
            var searchRegExp = new RegExp(searchWithoutAccents,'i')
            return this.filterable(financement.intitule, financement.tags).match(searchRegExp)
          }
          return true
        })
      },
      countResultats() {
        return this.filteredFinancements.length;
      },
      countFinancements() {
        return this.financements.length;
      }
    },
  }
</script>
<style>
  .currentTagFilter{
    color: #fff;
    background-color: #17a2b8;
    border-color: #17a2b8;
  }
  #financement-header-row {
    padding-top: 3rem;
  }

  .financement-count-financements-text {
    font-size: 1.5em;
  }
  #financement-count-financements-number {
    font-size: 2.5em;
    font-style: bolder;
  }

  #financement-last-update {
    font-size: 0.9em;
    color: #000; /* Fallback for older browsers */
    color: rgba(0, 0, 0, 0.5);
  }

  .financement-results-count {
    color: #000; /* Fallback for older browsers */
    color: rgba(0, 0, 0, 0.5);
  }

  #financement-results-list {
    padding-top: 0.5rem;
  }

  .financement-results-tags {
    margin-right: 5px;
  }

  .financement-horizontal-separator {
    border: none;
    border-top: 1px solid #bfbfbf;
    height: 1px;
    width: 90%;
    position:relative;
  }


  #financement-filter-select {
    width : auto;
  }
</style>
