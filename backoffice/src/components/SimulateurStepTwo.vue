<template>
  <div id="SimulateurStepTwo">
    <div v-if="$parent.situation_inscrit == 2 && $parent.financement__accessible_salarie_formation == false">
      <h5 style="color:red;">Seules les personnes inscrites comme « demandeur d'emploi » peuvent bénéficier d'une aide financière pour cette formation.</h5>
    </div>
    <div v-else>
      <div class="row">
        <div class="col-md-12">
          <h4>Date de naissance</h4>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <input v-model="$parent.birthdate" name="birthdate" id="birthdate" type="text" title="Format : JJ/MM/AAAA" required="required" placeholder="JJ/MM/AAAA" class="date form-control" :class="{input_format_error: badFormatBirthdate, input_format_valid: goodFormatBirthdate}"/>
        </div>
      </div>
      <div v-if="$parent.situation_inscrit == 1">
        <div class="row">
          <div class="col-md-12">
            <h4>Domicile</h4>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 autocomplete">           
            <b-form-input v-model="$parent.commune_beneficiaire_autocomplete" list="commune-beneficiaire-list" placeholder="Rentrez votre code postal"></b-form-input>
            <datalist id="commune-beneficiaire-list">
              <option v-for="commune in this.commune_beneficiaire_list" :key="commune.codeCommune">
                {{ commune.nomCommune }} | {{ commune.codePostal }} ({{ commune.codeCommune }})
              </option>
            </datalist>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <h4>Votre niveau d'étude</h4>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <select v-model="$parent.niveauscolaire" name="niveauscolaire" id="niveauscolaire" class="form-control">
              <option value="-" selected>-</option>
              <option value="2">Sans dipl&ocirc;me (VI)</option>
              <option value="3">Préqualification (V bis)</option>
              <option value="4">CAP, BEP, CFPA du premier degré (V)</option>
              <option value="5">BP, BT, baccalauréat professionnel ou technologique (IV)</option>
              <option value="5.1">Baccalauréat général (IV)</option>
              <option value="6">BTS, DUT (III)</option>
              <option value="7">Licence ou master 1 (II)</option>
              <option value="8">Supérieur ou égal à master 2 (I)</option>
              <option value="1">Sans niveau spécifique</option>
            </select>
          </div>
        </div>
      </div>
      <div v-if="$parent.situation_inscrit == 2">
        <div class="row">
          <div class="col-md-12">
            <h4>Votre rémunération mensuelle actuelle</h4>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <input v-model="$parent.salaire" name="salaire" id="salaire" type="number" value="" placeholder="salaire arrondi à l'€ net / mois" min="0" class="form-control"/>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurStepTwo',
    computed: {
      //flags checking if dates are well-formated
      badFormatBirthdate: function () {
        if (this.$parent.birthdate.length >= 10) {
          return this.$parent.birthdate.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) == null
        } return false;
      },
      goodFormatBirthdate: function () {
        return this.$parent.birthdate.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) != null;
      },
      commune_beneficiaire_list: function () {
        const codesPostaux = require('codes-postaux');
        if(this.$parent.commune_beneficiaire_autocomplete.match(/^(([0-8][0-9])|(9[0-5]))[0-9]{3}$/gi) == null) return [];
        return codesPostaux.find(this.$parent.commune_beneficiaire_autocomplete.match(/^(([0-8][0-9])|(9[0-5]))[0-9]{3}$/gi));
      },
    }
  }
</script>
