<template>
  <div id="IDCCSearch">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
					<h2>IDCC</h2>
          <input type="text" ref="idcc" placeholder="Chercher une convention collective" v-model="idcc" class="form-control"><br>
          <input @click="search()" type="button" class="btn main-button pull-right" value="Chercher">
        </div>
      </div>
      <br>
      <div class="row">
        <div class="col-md-12 results">
          <div v-if="this.idcc && Object.keys(this.results).length">
            <ul class="dash">
              <li v-for="(result,code) in this.results" :key="code">
                {{ result['convention collective'] }}
                <strong>({{ code }})</strong>
              </li>
            </ul>
          </div>
          <div v-if="this.idcc && this.resultsIsEmpty">
              <p>Aucune convention collective trouvée avec l'identifiant «{{ this.idcc }}».</p>
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
        results: {},
        resultsIsEmpty: false
			}
    },
		methods: {
			search: function () {
        this.$http
          .get('/idcc?q='+this.idcc)
          .then(response => {
            this.results = response.body;
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
