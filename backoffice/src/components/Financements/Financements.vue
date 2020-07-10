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
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <hr class="financement-horizontal-separator">
        <div id="financement-filter-row" class="container">
          <label for="financement-filter-select">Filtrer par</label>
          <select id="financement-filter-select" class="form-control" name="financement-filter-select" v-model="searchSelect">
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
                  <input class="form-control" id="financement-search-field" name="financement-search" placeholder="Rechercher" v-model="searchInput">
                </div>
              </div>
            </div>
          </div>
          <div id="financement-results-list">
            <ul id="ul-financement-results-list">
              <li v-for="financement in this.filteredFinancements" :key="financement.id" class="mt-4 row">
              <span class="col-md-3 col-sm-12">
                <span v-if="financement.racine!='région du bénéficiaire'">
                  <a :href="'/0.8/explorer/referentiel#'+financement.racine">
                    <strong class="financement-fields">{{ financement.intitule }}</strong>
                  </a>
                </span>
                <span v-else>
                    <strong class="financement-fields">{{ financement.intitule }}</strong>
                </span>
              </span>
              <span class="col-md-8 col-sm-11">
                <span v-for="tag in financement.tags" v-on:click="setSearchTag(tag)" :key="tag.id" class="financement-results-tags" >
                  <span class="btn main-button" :class="{'main-button-primary': tag==search}">
                    {{ tag }}
                  </span>
                </span>
              </span>
              </li>
            </ul>
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
    name: 'Financements',
    data: function(){
      return {
        financements:[],
        filteredFinancements:[],
        search: "",
        searchInput: "",
        searchSelect: "",
        isLoading: true,
      }
    },
    watch: {
      searchInput: function () {
        this.search = this.searchInput;
        this.filteredFinancements = this.filterFinancements(this.search,"input", false);
      },
      searchSelect: function() {
        this.search = this.searchSelect;
        this.filteredFinancements = this.filterFinancements(this.search,"select", true);
      },
    },
    computed: {
      countResultats() {
        return this.filteredFinancements.length;
      },
      countFinancements() {
        return this.financements.length;
      }
    },
    created: function () {
      this.load();
    },
    methods: {
      load: function () {
        this.$http
          .get('/explore/financements')
          .then(response => {
            this.financements = response.body;
            this.filteredFinancements = response.body;
            this.isLoading = false;
          });
      },
      setSearchTag: function (tag) {
        this.search = tag;
        this.filteredFinancements = this.filterFinancements(this.search,"tag", true);
      },
      filterFinancements: function (search, searchType, isCaseSensitive) {
        return this.financements.filter(financement => {
          if (search != "") {
            //replace all accents characters in the search string by their non-accented equivalent
            var searchWithoutAccents = search.normalize('NFD').replace(/[\u0300-\u036f]/g, "")
            //create a RegExp for the search string to be case-insensitive
            var searchRegExp;
            isCaseSensitive ? searchRegExp = new RegExp(searchWithoutAccents,"g") : searchRegExp = new RegExp(searchWithoutAccents,'ig')
            return searchType != "input" ? this.filterable("", financement.tags).match(searchRegExp) : this.filterable(financement.intitule, financement.tags).match(searchRegExp)
          }
          return true;
        })
      },
      filterable: function (intitule,tags) {
        //replace all accents characters in the search string by their non-accented equivalent
        return intitule.concat(tags.join(",")).normalize('NFD').replace(/[\u0300-\u036f]/g, "");
      },
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
