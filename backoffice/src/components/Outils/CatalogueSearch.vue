<template>
  <div id="CatalogueSearch">
    <div class="container mb-0 mt-0">
      <div class="row">
        <div class="col-md-12">
          <h2>Catalogue</h2>
          <input type="text" ref="intercarif" placeholder="Identifiant INTERCARIF" v-model="intercarif" class="form-control"><br>
          <input @click="search()" type="button" class="btn main-button pull-right" value="Chercher">
        </div>
      </div>
      <br>
      <div class="row">
        <div class="col-md-12 results">
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
    name: 'CatalogueSearch',
    data: function () {
			return {
        intercarif: "",
        results: {},
        resultsIsEmpty: false
			}
		},
		methods: {
			search: function () {
        this.$http
          .get('/explore/catalog?id='+this.intercarif)
          .then(response => {
            this.results = response.body;
            this.resultsIsEmpty = this.isEmpty(this.results);
          }, () => {
            this.resultsIsEmpty = this.isEmpty(this.results);
          });
			},
      isEmpty: function (obj) {
        for(var key in obj) {
          if(obj.hasOwnProperty(key)) return false;
        }
        return true;
      }
		}
  }
</script>
