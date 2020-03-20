<template>
  <div id="SimulateurStepFive">
    <div v-if="$parent.situation_inscrit == 1">
      <div class="row">
        <div class="col-md-12">
          <h4>Situation particulière</h4>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_th" name="situation_th" id="situation_th" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_th" class="label-after">Vous êtes reconnu travailleur handicapé</label>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_travailleurnonsal12dont6dans3ans" name="situation_travailleurnonsal12dont6dans3ans" id="situation_travailleurnonsal12dont6dans3ans" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_travailleurnonsal12dont6dans3ans" class="label-after">
            Vous êtes un travailleur non salarié et vous avez travaillé durant 12 mois, dont 6 mois consécutifs, dans les 3 ans précédant l’entrée en stage
          </label>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_parentisole" name="situation_parentisole" id="situation_parentisole" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_parentisole" class="label-after">Vous êtes parent isolé <span class="mini-info">*</span></label><br>
          <div v-if="$parent.situation_parentisole" class="text-muted group-indent1">
            * Personnes veuves, divorcées, séparées, abandonnées ou célibataires assumant seules la charge effective et permanente d’un ou de plusieurs enfants résidant en France et Femmes seules enceintes ayant effectué la déclaration de grossesse et les examens prénataux prévus par la loi
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_mere3enfants" name="situation_mere3enfants" id="situation_mere3enfants" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_mere3enfants" class="label-after">Vous êtes mère de famille ayant eu au moins 3 enfants</label>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_divorceeveuve" name="situation_divorceeveuve" id="situation_divorceeveuve" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_divorceeveuve" class="label-after">Vous êtes une femme divorcée, veuve, ou séparée judiciairement depuis moins de 3 ans</label>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_projetcreationentreprise" name="situation_projetcreationentreprise" id="situation_projetcreationentreprise" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_projetcreationentreprise" class="label-after">Vous avez un projet de création d'entreprise qui nécessite cette formation</label>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_vaepartiellemoins5ans" name="situation_vaepartiellemoins5ans" id="situation_vaepartiellemoins5ans" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_vaepartiellemoins5ans" class="label-after">Vous souhaitez terminer cette formation pour laquelle vous avez obtenu, il y a moins de 5 ans, une certification partielle par un jury VAE</label>
        </div>
      </div>
    </div>        
    <div v-if="$parent.situation_inscrit == 2">
      <div class="row">
        <div class="col-md-12">
          <h4>Votre entreprise</h4>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <span id="info"><br/>&nbsp;Munissez-vous de votre&nbsp;<span class="highlight">bulletin de paie</span>&nbsp;pour renseigner les informations qui suivent :<br/>&nbsp;Le code <span class="highlight">ape/naf</span> ou <span class="highlight">idcc</span> doit être composé de 4 chiffres et être éventuellement terminé par une lettre<br/></span>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <label for="naf">Code APE/NAF</label>
          <input v-model="id_naf" v-on:keydown="nafNotExists=null; idcc=null" id="naf" type="text" value="" placeholder="identifiant naf" class="form-control" :class="{input_format_error: nafNotExists===true, input_format_valid: nafNotExists===false}"/><br>
          <button class="btn main-button mr-5" v-on:click="searchNAF()">Chercher</button>
          <span v-if="nafNotExists===false">Activité principale trouvée : <strong>{{ intitule_naf }}</strong></span>
          <span v-if="nafNotExists===true" style="color:red">Aucune activité principale trouvée avec l'identifiant {{ id_naf }} </span><br>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <label for="idcc">Secteur d'activité ou code IDCC</label>
          <input v-model="id_idcc" v-on:keydown="idccNotExists=null; idcc=null" id="idcc" type="text" value="" placeholder="identifiant idcc" class="form-control" :class="{input_format_error: idccNotExists===true, input_format_valid: idccNotExists===false}"/><br>
          <button class="btn main-button mr-5" v-on:click="searchIDCC()">Chercher</button>
          <span v-if="idccNotExists===false">Convention collective trouvée : <strong>{{ intitule_idcc }}</strong></span>
          <span v-if="idccNotExists===true" style="color:red">Aucune convention collective trouvée avec l'identifiant {{ id_idcc }} </span><br>
          
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 autocomplete">
          <label for="commune_entreprise">Commune de votre entreprise</label>&nbsp;          
          <b-form-input v-model="$parent.commune_entreprise_autocomplete" list="commune-entreprise-list" placeholder="Rentrez le code postal de votre entreprise"></b-form-input>
          <datalist id="commune-entreprise-list">
            <option v-for="commune in this.commune_entreprise_list" :key="commune.codeCommune">
              {{ commune.nomCommune }} | {{ commune.codePostal }} ({{commune.codeCommune}})
            </option>
          </datalist>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurStepFive',		
    props:[],
    data: function () {
      return {
        id_naf: null,
        nafNotExists: null,
        intitule_naf: null,
        id_idcc: null,
        idccNotExists: null,
        intitule_idcc: null,
      }
    },
    computed: {
      commune_entreprise_list: function () {
        const codesPostaux = require('codes-postaux');
        if(this.$parent.commune_entreprise_autocomplete.match(/^(([0-8][0-9])|(9[0-5]))[0-9]{3}$/gi) == null) return [];
        return codesPostaux.find(this.$parent.commune_entreprise_autocomplete.match(/^(([0-8][0-9])|(9[0-5]))[0-9]{3}$/gi));
      },
    },
    methods: {
			searchNAF: function () {
        this.$http.get('/naf?q='+this.id_naf).then(response => {
          this.$parent.naf = this.objectIsEmpty(response.body) ? null:this.id_naf;
          this.intitule_naf = this.objectIsEmpty(response.body) ? null:response.body[this.id_naf].name;
          this.nafNotExists = this.objectIsEmpty(response.body);
        }, (response) => {
          this.nafNotExists = this.objectIsEmpty(response.body);
        }).created;
      },
			searchIDCC: function () {
        this.$http.get('/idcc?q='+this.id_idcc).then(response => {
          this.$parent.idcc = this.objectIsEmpty(response.body) ? null:this.id_idcc;
          this.intitule_idcc = this.objectIsEmpty(response.body) ? null:response.body[this.id_idcc]['convention collective'];
          this.idccNotExists = this.objectIsEmpty(response.body);
        }, (response) => {
          this.idccNotExists = this.objectIsEmpty(response.body);
        }).created;
      },
      objectIsEmpty: function (obj) {
        for(var key in obj) {
          if(obj.hasOwnProperty(key))
            return false;
        }
        return true;
      },    
    }
  }
</script>
