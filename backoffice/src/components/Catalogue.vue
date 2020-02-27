<template>
  <div id="Catalogue">
    <div class="container mb-0 mt-0">
      <div class="row">
        <div class="col-md-6">
            <h2>Recherche Catalogue</h2>
            <input type="text" ref="intercarif" placeholder="Identifiant INTERCARIF" v-model="intercarif">
            <input @click="search()" type="button" class="btn main-button ml-4" value="Chercher">
            <p>Plus d'info sur le format du catalogue: <a href="http://lheo.gouv.fr/langage">http://lheo.gouv.fr/langage</a>.</p>
        </div>
        <div class="col-md-6 results">
          <div v-if="this.intercarif && Object.keys(this.results).length">
            <pre>{{ this.results }}</pre>
          </div>
          <div v-if="this.intercarif && this.resultsIsEmpty">
            <p>
              Aucune formation trouvée avec l'identifiant «{{ this.intercarif }}».
            </p>
          </div>
        </div>
      </div>
    </div>
</div>
</template>
<script>
  export default {
    data: function () {
			return {
        intercarif: "",
        results: {},
        resultsIsEmpty: false
			}
		},
		methods: {
			search: function () {
        this.$http.get('/explore/catalog?id='+this.intercarif).then(response => {
          this.results = response.body;
          this.resultsIsEmpty = this.isEmpty(this.results);
        }, () => {
          this.resultsIsEmpty = this.isEmpty(this.results);
        }).created;
			},
      isEmpty: function (obj) {
        for(var key in obj) {
            if(obj.hasOwnProperty(key))
                return false;
        }
        return true;
      }
		}    
  }
</script>
