<template>
  <div id="Catalogue">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
            <h2>Catalogue</h2>
            <input type="text" ref="intercarif" placeholder="Identifiant INTERCARIF" v-model="intercarif">
            <input @click="search()" type="button" class="btn main-button ml-4" value="Chercher">
            <p>Plus d'info sur le format du catalogue: <a href="http://lheo.gouv.fr/langage">http://lheo.gouv.fr/langage</a>.</p>
        </div>
        <div class="col-md-6">
          <div class=results v-if="Object.keys(this.results).length">
            <h2>Formation</h2>
            <pre v-if="this.results">{{ this.results }}</pre>
            <p v-if="this.intercarif && !this.results">
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
        results: {}
			}
		},
		methods: {
			search: function () {
        this.$http.get('/explore/catalog?id='+this.intercarif).then(response => {
          this.results = response.body;
        }).created;

			}
		}    
  }
</script>
