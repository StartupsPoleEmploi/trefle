<template>
	<div id="Referentiel">
		<div id="ref-main-div">
			<div v-if="!this.isLoading">
				<div id="ref-header-row">
					<div class="container">
						<div class="row mb-4">
							<div id="ref-count-financements" class="col-md-6 col-sm-12 col-xs-12">
								<span id="ref-count-financements-number" class="ref-results-count-number ref-count-financements-text">{{ this.countFinancements }}</span>
								<span class="ref-count-financements-text" v-if="this.countFinancements < 2">&nbsp;financement</span>
								<span class="ref-count-financements-text" v-else>&nbsp;financements</span>
							</div>
							<div id="ref-create-financement" class="col-md-6 col-sm-12 col-xs-12 my-auto">
								<div class="form-inline pull-right">
									<div class="form-group mx-sm-3 mb-2">
										<input type="button" href="#" class="btn btn-outline-success form-control" value="Créer un financement"  disabled />
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
					<select id="financement-filter-select" class="form-control" name="financement-filter-select" :change="filtreSelect(selectedFilter)" v-model="selectedFilter">
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
				<hr class="ref-horizontal-separator">
				<div id="ref-result-row" class="container">
					<div class="row">
						<div id="ref-search-financement" class="col-md-6 col-sm-12 col-xs-12 my-auto">
							<span v-if="this.countFinancements < 2" class="ref-results-count">
								Résultat (<span class="ref-results-count-number">{{ this.countResultats }}</span>)
							</span>
							<span v-else class="ref-results-count">
								Résultats (<span class="ref-results-count-number">{{ this.countResultats }}</span>)
							</span>
						</div>
						<div id="ref-search-financement" class="col-md-6 col-sm-12 col-xs-12 my-auto">
							<div class="form-inline pull-right">
								<div class="form-group mx-sm-3 mb-2">
									<input class="form-control" id="financement-search-field" name="financement-search" placeholder="Rechercher" v-model="search">
								</div>
							</div>
						</div>
					</div>
					<div id="ref-results-list">
						<ul id="ul-ref-results-list">
							<li v-for="financement in this.filteredFinancements" :key="financement.id" class="mt-4 row">
							<span class="col-md-3 col-sm-12">
								<strong class="ref-fields">{{ financement.intitule }}</strong>
							</span>
							<span class="col-md-8 col-sm-11">
								<span v-for="tag in financement.tags" :key="tag.id" class="ref-results-tags" >
									<button class="btn btn-outline-info" href="#" v-on:click="filtreTag(tag); currentTagFilter = tag" :class="{currentTagFilter:tag == currentTagFilter}">
										{{ tag }}
									</button>
								</span>
							</span>
							<span class="col-md-1 col-sm-1 pull-right">          
								<button href="https://framagit.org/ybon/trefle/tree/master/trefle/config/financements.yml" target="_blank" class="text-dark btn btn-outline-light" disabled>
									<i class="icon" style="vertical-align: baseline;">edit</i>
								</button>
							</span>
							</li>        
						</ul>
					</div>
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
					this.isLoading = false;
				}).created;
			},
			filterable: function (intitule,tags) {
				//replace all accents characters in the search string by their non-accented equivalent
				return intitule.concat(tags.join("")).normalize('NFD').replace(/[\u0300-\u036f]/g, "");
			},
			filtreTag: function (tag) {
				this.search = tag;
			},
			filtreSelect: function(option) {
				this.search = option;
			}
		},
		data: function(){
			return {
				currentTagFilter: "",
				selectedFilter: "",
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

	.ref-results-count {
		color: #000; /* Fallback for older browsers */
		color: rgba(0, 0, 0, 0.5);
	}

	#ref-results-list {
		padding-top: 0.5rem;
	}

	.ref-results-tags {
		margin-right: 5px;
	}

	.ref-horizontal-separator {
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