<template>
  <div id="SimulateurStepFormation">
    <div class="row">
      <div class="col-md-12">
        <h4>Formation</h4>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <label for="id_formation">Identifiant de formation intercarif</label>
        <input v-model="id_formation" v-on:keydown="formationNotExists=null; $parent.formation.numero=null" id="id_formation" type="text" value="" placeholder="identifiant intercarif" class="form-control" /><br>
        <button class="btn main-button mr-5" v-on:click="searchCatalogue()">Chercher</button>
        <strong v-if="formationNotExists===false">{{ intitule_formation }}</strong>
        <span v-if="formationNotExists===true" style="color:red">Aucune formation trouvée pour l'identifiant renseigné</span><br>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurStepFormation',
    props:["id_formation"],
    data: function () {
      return {
        formationNotExists: null,
        intitule_formation : null,
      }
    },
    methods : {
			searchCatalogue: function () {
        this.$http.get('/explore/catalog?id='+this.id_formation).then(response => {
          this.$parent.formation.numero = response.body.uid;
          this.intitule_formation  = response.status != 200 ? null:response.body.intitule;
          if(response.status != 200) {
            this.$parent.financement__accessible_salarie_formation = null
          } else {
            for(var i=0; i<response.body.sessions.length; i++) {
              var session = response.body.sessions[i]
              for (var j=0; j<session.financeurs.length; j++) {
                this.$parent.financement__accessible_salarie_formation = (session.financeurs[j].code == 0 || session.financeurs[j].code == 5 || session.financeurs[j].code == 10)
              }
            }
          }
          this.formationNotExists = response.status != 200;
        }, (response) => {
          this.formationNotExists = response.status != 200;
        }).created;
      },
    }
  }
</script>
