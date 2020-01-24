<template>
  <div id="IDCCSearch">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
					<h2>Recherche IDCC</h2>
						<input type="text" ref="idcc" placeholder="Chercher une convention collective" v-model="idcc">
						<input @click="search()" type="button" class="btn main-button ml-4" value="Chercher">
        </div>
        <div class="col-md-6">
          <div class="results" v-if="Object.keys(this.results).length">
            <h2>Conventions collectives</h2>
            <ul v-if="Object.keys(this.results).length">
              <li v-for="(result,code) in this.results" :key="code">
                {{ result['convention collective'] }}
                <strong>({{ code }})</strong>
              </li>
            </ul>
            <p v-if="this.idcc && !Object.keys(this.results).length">
              Aucune convention collective trouvée pour la recherche «{{ this.idcc }}».</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
		name: 'IDCCSearch',
		data: function () {
			return {
        idcc: "",
        results: {}
			}
		},
		methods: {
			search: function () {
        this.$http.get('/idcc?q='+this.idcc).then(response => {
          this.results = response.body;
        }).created;

			}
		}    
  }
</script>
