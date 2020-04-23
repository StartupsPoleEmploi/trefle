<template>
  <div id="SimulateurStepOne">
    <div class="row">
      <div class="col-md-12">
        <h4>Situation</h4>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 form-check">
        <input v-model="$parent.situation_inscrit" name="situation_inscrit" id="situation_inscrit1"  type="radio" value="1" class="form-check-input"/>
        <label for="situation_inscrit1" class="form-check-label">Vous êtes inscrit(e) comme demandeur d'emploi</label>
      </div>
    </div>
    <div v-if="$parent.situation_inscrit==1">
      <div class="row">
        <div class="col-md-12 group-indent1">
          <label for="situation_inscritcumuldureeinscriptionsur12mois">Depuis combien de temps êtes-vous inscrit à Pôle Emploi ?</label>&nbsp;
          <select v-model="$parent.situation_inscritcumuldureeinscriptionsur12mois" id="situation_inscritcumuldureeinscriptionsur12mois" class="form-control">
            <option value="-" selected>-</option>
            <option value="1">de 1 à 3 mois</option>
            <option value="3">de 3 à 6 mois</option>
            <option value="6">de 6 à 12 mois</option>
            <option value="12">12 mois et plus</option>
          </select>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 group-indent1">
          <label for="allocation_type">Type d'allocation</label>&nbsp;
          <select v-model="$parent.allocation_type" id="allocation_type" class="form-control">
            <option value="-" selected>-</option>
            <option value="non">Non indemnisé</option>
            <option value="are">Allocation d'aide au Retour à l'Emploi (ARE)</option>
            <option value="ass">Allocation de Solidarité Spécifique (ASS)</option>
            <option value="rsa">Revenu de Solidarité Active (RSA)</option>
            <option value="asr">Allocation Spécifique de Reclassement (ASR)</option>
            <option value="atp">Allocation de Transition Professionnelle (ATP)</option>
            <option value="asp">Allocation de Sécurisation Professionnelle (ASP)</option>
            <option value="aex">Allocation ex-employeur secteur public</option>
          </select>
        </div>
      </div>
    </div>
    <div v-if="$parent.allocation_type != 'non' && $parent.allocation_type != '-' && $parent.allocation_type != '' && $parent.situation_inscrit == 1">
      <div class="row">
        <div class="col-md-12">
            <div class="row">
              <div class="col-md-12 group-indent2">
                <label for="allocation_dateend">Date de fin estimée de votre indemnisation</label>&nbsp;
                <input v-model="$parent.allocation_dateend" id="allocation_dateend" type="text" value="" placeholder="JJ/MM/AAAA" pattern="^\d{1,2}/\d{1,2}/\d{4}$"  class="date form-control" :class="{input_format_error: badFormatAllocation_dateend, input_format_valid: goodFormatAllocation_dateend}"/>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 group-indent2">
                <label for="allocation_cost">Montant mensuel de votre allocation</label>&nbsp;
                <input v-model="$parent.allocation_cost" id="allocation_cost" type="number" value="" placeholder="arrondi à l'€ net / mois" min="0" class="form-control"/>
              </div>
            </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 form-check">
        <input v-model="$parent.situation_inscrit" name="situation_inscrit" id="situation_inscrit2" type="radio" value="2" required="required" class="form-check-input"/>&nbsp;
        <label for="situation_inscrit2"  class="form-check-label" >Vous êtes salarié(e) de droit privé</label>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurStepOne',
    computed: {
      badFormatAllocation_dateend: function () {
        if (this.$parent.allocation_dateend.length >= 10) {
          if(this.$parent.allocation_dateend.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) != null) {
            var today = new Date(),
            date_reformat = new Date(this.$parent.allocation_dateend.replace(/(\d{2})[-/](\d{2})[-/](\d+)/, "$2/$1/$3"));
            return date_reformat <= today;
          } return true;
        } return false;
      },
      goodFormatAllocation_dateend: function () {
        if(this.$parent.allocation_dateend.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) != null) {
          var today = new Date(),
          date_reformat = new Date(this.$parent.allocation_dateend.replace(/(\d{2})[-/](\d{2})[-/](\d+)/, "$2/$1/$3"));
          return date_reformat >= today;
        } return false;
      },
    }
  }
</script>
