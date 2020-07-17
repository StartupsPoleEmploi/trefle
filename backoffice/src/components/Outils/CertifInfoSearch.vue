<template>
  <div id="CertifInfoSearch">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
					<h2>Certif Info</h2>
          <input type="text" ref="certifinfo" placeholder="Code Certif Info" v-model="certifinfo" class="form-control"><br>
          <input @click="search()" type="button" class="btn main-button pull-right" value="Chercher">
        </div>
      </div>
      <br>
      <div class="row">
        <div class="col-md-12 results">
          <div v-if="this.certifinfo && Object.keys(this.results).length">
            <ul class="dash">
              <li v-for="(result,code) in this.results" :key="code">
                {{ result.text }}
              </li>
            </ul>
          </div>
          <div v-if="this.certifinfo && this.resultsIsEmpty">
            <p> Aucune certification trouvée avec l'identifiant «{{ this.certifinfo }}».</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
		name: 'CertifInfoSearch',
		data: function () {
			return {
        certifinfo: "",
        results: {},
        resultsIsEmpty: false,
			}
		},
		methods: {
			search: function () {
        this.$http
          .get('/certifinfo?q='+this.certifinfo)
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
