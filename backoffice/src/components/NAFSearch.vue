<template>
  <div id="NAFSearch">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
					<h2>NAF</h2>
          <input type="text" ref="naf" placeholder="Code NAF" v-model="naf" class="form-control"><br>
          <input @click="search()" type="button" class="btn main-button pull-right" value="Chercher">
        </div>
      </div>
      <br>
      <div class="row">
        <div class="col-md-12 results">
          <div v-if="this.naf && Object.keys(this.results).length">
            <ul class="dash">
              <li v-for="(result,code) in this.results" :key="code">
                {{ result.name }}
              </li>
            </ul>
          </div>
          <div v-if="this.naf && this.resultsIsEmpty">
            <p> Aucune activité principale trouvée avec l'identifiant «{{ this.naf }}».</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
		name: 'NAFSearch',
		data: function () {
			return {
        naf: "",
        results: {},
        resultsIsEmpty: false,
			}
		},
    computed: {
    },
		methods: {
			search: function () {
        this.$http.get('/naf?q='+this.naf).then(response => {
          this.results = response.body;
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
