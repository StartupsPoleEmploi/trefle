<template>
  <div id="Simulateur">
    <div class="container form-group pt-5">
      <div v-if="!resultats">
        <div class="row">
          <div class="col-md-12">
            <h2>Simuler un financement </h2>
          </div>
        </div>
        <hr class="simulateur-horizontal-separator">
        <!---------------- STEP FORMATION ---------------->
        <div class="formation-step step" :class="{step_completed_class: formation_step_completed}">
          <SimulateurStepFormation/>
        </div>
        <hr v-if="formation_step_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP ONE ---------------->
        <div v-if="formation_step_completed" class="form-step step-one" :class="{step_completed_class: step_one_completed}">
          <SimulateurStepOne id="SimulateurStepOne"/>
        </div>
        <hr v-if="step_one_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP TWO ---------------->
        <div v-if="step_one_completed" class="form-step step-two" :class="{step_completed_class: step_two_completed}">
          <SimulateurStepTwo id="SimulateurStepTwo"/>
        </div>
        <hr v-if="step_two_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP THREE ---------------->
        <div v-if="step_two_completed" class="form-step step-three" :class="{step_completed_class: step_three_completed}">
          <SimulateurStepThree id="SimulateurStepThree"/>
        </div>
        <hr v-if="step_three_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP FOUR ---------------->
        <div v-if="step_three_completed" class="form-step step-four" :class="{step_completed_class: step_four_completed}">
          <SimulateurStepFour id="SimulateurStepFour"/>
        </div>
        <hr v-if="step_four_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP FIVE ---------------->
        <div v-if="step_four_completed" class="form-step step-five" :class="{step_completed_class: step_five_completed}">
          <SimulateurStepFive id="SimulateurStepFive"/>
        </div>
        <!---------------- STEP FIVE ---------------->
        <div v-if="step_five_completed" class="form-step">
          <input type="button" class="btn main-button" value="Simuler" v-on:click="simulate()"/>
        </div>
      </div>
      <!------------------- RESULTATS --------------->
      <div v-else id="simulate-results">
        <div v-if="!isLoading" class="mt-5">
          <SimulateurResultats :schema="schema" :financements="financements" :financements_eligibles="financements_eligibles" :scenario="scenario" :context="context"></SimulateurResultats>
        </div>
        <div v-else class="text-center loading-gif">
          <img src="./../assets/images/loading.gif" alt="loading...">
        </div>
      </div>
    </div>
  </div>
</template>
<script>

  import SimulateurStepFormation from './SimulateurStepFormation.vue';
  import SimulateurStepOne from './SimulateurStepOne.vue';
  import SimulateurStepTwo from './SimulateurStepTwo.vue';
  import SimulateurStepThree from './SimulateurStepThree.vue';
  import SimulateurStepFour from './SimulateurStepFour.vue';
  import SimulateurStepFive from './SimulateurStepFive';
  import SimulateurResultats from './SimulateurResultats.vue';

	export default {
    name: 'Simulateur',
    components: {
      SimulateurResultats,
      SimulateurStepFormation,
      SimulateurStepOne,
      SimulateurStepTwo,
      SimulateurStepThree,
      SimulateurStepFour,
      SimulateurStepFive,
    },
		data: function () {
			return {
        // champs de formulaire
        // step formation
        id_formation : null,
        formationNotExists: null,
        intitule_formation : null,
        //flag permettant de detecter si la formation est eligible à un financement en cas de profil de salarié
        financement_accessible_salarie_formation: null,
        formation : {
          numero : null,
        },
        // step one
        situation_inscrit: undefined,
          // DE
          situation_inscritcumuldureeinscriptionsur12mois: '',
          allocation_type: '',
            // Indemnisé
            allocation_dateend: '',
            allocation_cost: '',
        // step two
        birthdate: '',
          // Salarié
          salaire: '',
          // DE
          commune_beneficiaire_autocomplete: '',
          niveauscolaire: '',
        // step 3
        situation_cpfconnu: '',
          // CPF connu
          situation_creditheurescpf: '',
        // step 4
          // salarié
          contrat: '',
            //cdd
            experience: '',
            moistravailleencdd: '',
            //cdi
            experienceannee: '',
            ancienneteentrepriseactuelle: '',

          // DE
          situation_contratapprentissage: false,
            // apprentissage
            situation_contratapprentissagetype: false,
            situation_rupturecontratapprentissage: false,
          situation_cdd: false,
            // CDD
            situation_cdd5years: false,
            // CDD 5 ans
            situation_cdd12months: false,
              // CDD 1 ans
              situation_salairebrutecdd: false,
          situation_contrataide: false,
            // CA
            situation_personneencourscontrataide: false,
          situation_6moissur12: false,
        // step 5
          // DE
            situation_th: false,
            situation_travailleurnonsal12dont6dans3ans: false,
            situation_parentisole: false,
            situation_mere3enfants: false,
            situation_divorceeveuve: false,
            situation_projetcreationentreprise: false,
            situation_vaepartiellemoins5ans: false,
          // Salarié
            naf: '',
            idcc: '',
            commune_entreprise_autocomplete: '',
        // TO DO input formation
        financements: [],
        financements_eligibles: [],
        scenario: '',
        resultats: false,
        isLoading: true,
        test: [],
        schema: {},
			}
    },
    mounted: function () {
      this.loadSchema();
    },
    computed: {
      formation_step_completed: function () {
        return this.formation.numero != null;
      },
      step_one_completed: function () {
        if (this.situation_inscrit == 1) {
          if (this.situation_inscritcumuldureeinscriptionsur12mois != '' && this.situation_inscritcumuldureeinscriptionsur12mois != '-') {
            if (this.allocation_type == 'non') return true
            else {
              if (this.allocation_dateend != '' && this.allocation_cost != '') return true
            }
          }
        } else if (this.situation_inscrit == 2) return true;
        return false;
      },
      step_two_completed: function () {
        if (this.step_one_completed) {
          if (this.birthdate.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) != null) {
            if (this.situation_inscrit == 1) {
              if (this.commune_beneficiaire != undefined && this.niveauscolaire != '' && this.niveauscolaire != '-') {
                return true;
              }
            } else if (this.situation_inscrit == 2) {
              if (this.salaire != '') return true;
            }
          }
        }
        return false;
      },
      step_three_completed: function () {
        if (this.step_two_completed) {
          if (this.situation_cpfconnu != '') {
            if (this.situation_cpfconnu == 'cpfconnu') {
              if (this.situation_creditheurescpf) return true;
            } else return true;
          }
        }
        return false
      },
      step_four_completed: function () {
        if (this.step_three_completed) {
          if (this.situation_inscrit == '1') return true;
          else if (this.situation_inscrit == '2') {
            if (this.contrat == 'cdd') {
              if (this.moistravailleencdd != '' && this.experience != '') return true;
            } else if (this.contrat == 'cdi') {
              if (this.ancienneteentrepriseactuelle != '' && this.experienceannee != '') return true;
            }
          }
        }
        return false
      },
      step_five_completed: function () {
        if (this.step_four_completed) {
          if (this.situation_inscrit == 1) return true;
          else if (this.situation_inscrit == 2) {
            if (this.idcc != '' && this.naf != '' && this.commune_entreprise != undefined) return true;
          }
        }
        return false;
      },
      age_beneficiaire : function () {
        if(this.birthdate.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) == null) {
          return null;
        } else {
          // birthday is a date
          var today = new Date(),
          birthdate_reformat = new Date(this.birthdate.replace(/(\d{2})[-/](\d{2})[-/](\d+)/, "$2/$1/$3"));
          if(today.getMonth - birthdate_reformat.getMonth < 0) {
            return today.getFullYear() - birthdate_reformat.getFullYear() - 1;
          } else if(today.getMonth() - birthdate_reformat.getMonth() == 0) {
            if (today.getDate() - birthdate_reformat.getDate() < 0) {
              return today.getFullYear() - birthdate_reformat.getFullYear() - 1;
            }
          }
          return today.getFullYear() - birthdate_reformat.getFullYear();
        }
      },
      commune_beneficiaire: function () {
        // getting insee code from input field
        return this.commune_beneficiaire_autocomplete.split('(').length < 2 ? undefined : this.commune_beneficiaire_autocomplete.split('(')[1].substr(0,this.commune_beneficiaire_autocomplete.split('(')[1].length-1).trim();
      },
      departement: function () {
        return this.commune_beneficiaire == undefined ? undefined : this.commune_beneficiaire.substr(0,2)
      },
      commune_entreprise: function () {
        return this.commune_entreprise_autocomplete.split('(').length < 2 ? undefined : this.commune_entreprise_autocomplete.split('(')[1].substr(0,this.commune_entreprise_autocomplete.split('(')[1].length-1).trim();
      },
      request: function () {
        return {
          beneficiaire : {
            droit_prive: this.situation_inscrit == 1 ? false : true,
            inscrit_pe: this.situation_inscrit == 2 ? false : true,
            solde_cpf: this.situation_creditheurescpf == '' ? 0 : this.situation_creditheurescpf,
            remuneration: this.salaire == '' ? 0 : this.salaire,
            allocation: this.allocation_cost == ''? 0 : this.allocation_cost,
            type_allocation: this.allocation_type,
            fin_allocation: this.allocation_dateend,
            naissance: this.birthdate,
            age: this.age_beneficiaire,
            parent_isole: this.situation_parentisole,
            mere_trois_enfants: this.situation_mere3enfants,
            veuve_ou_divorcee: this.situation_divorceeveuve,
            creation_entreprise: this.situation_projetcreationentreprise,
            contrat_aide_actuel: this.situation_personneencourscontrataide == 1 ? false : true,
            contrat_aide_passe: this.situation_contrataide,
            experience_professionnelle: this.experience,
            experience_professionnelle_5_dernieres_annees: this.situation_cdd5years,
            mois_travailles_en_cdd: this.situation_cdd12months,
            jours_travailes:'',
            heures_travaillees: '',
            contrat: this.contrat,
            mois_entreprise: null,
            heures_entreprise: null,
            commune: this.commune_beneficiaire,
            departement: this.departement,
            niveau_scolaire: this.niveauscolaire,
            th: this.sitation_th,
            a_travaille_six_mois: this.situation_6moissur12,
            a_travaille_douze_mois: this.situation_6moissur12,
            entreprise : {
              naf: this.naf.match(/^\d{2}\.?\d{2}[a-zA-Z]$/gi) == null ? null : this.naf.match(/^\d{2}\.?\d{2}[a-zA-Z]$/gi),
              idcc: this.idcc,
              commune: this.commune_entreprise,
              opco: null,
              opacif: null
            }
          },
          formation : this.formation
        }
      }

    },
		methods: {
      loadSchema: function () {
        fetch('/explore/schema')
        .then((response) => response.json())
        .then((data) => {
          this.schema = data
        })
      },
      simulate: function () {
        this.isLoading = true;
        if (this.situation_inscrit == 1) {
          if (this.allocation_type == 'non') {
            this.allocation_type = null;
            this.allocation_dateend = null;
          }
          this.salaire = null;
          this.moistravailleencdd = null;
          this.ancienneteentrepriseactuelle = null;
          this.experience = null;
          this.experienceannee = null;
          this.naf = '';
          this.idcc = '';
          this.commune_entreprise_autocomplete = '';

        } else if (this.situation_inscrit == 2) {
          this.allocation_type = null;
          this.allocation_dateend = null;
          this.situation_inscritcumuldureeinscriptionsur12mois = null;
          this.allocation_cost = null;
          this.commune_beneficiaire_autocomplete = '';
          this.niveauscolaire = null;

          if (this.contrat == 'cdi') {
            this.experience = null;
            this.moistravailleencdd = null;

          } else if (this.contrat == 'cdd') {
            this.experienceannee = null;
            this.ancienneteentrepriseactuelle = null;
          }

          this.situation_th = null;
          this.situation_travailleurnonsal12dont6dans3ans = null;
          this.situation_parentisole = null;
          this.situation_mere3enfants = null;
          this.situation_divorceeveuve = null;
          this.situation_projetcreationentreprise = null;
          this.situation_vaepartiellemoins5ans = null;
        }
        if (this.situation_cpfconnu != 'cpfconnu') this.situation_creditheurescpf = null;


        this.$http.post('/financement?context=1&explain=true&scenario=1', this.request).then(response => {
          if(this.objectIsEmpty(response.body) == false) {
            for(var i=0; i<response.body.financements.length-1; i++) {
              if(this.situation_cpfconnu=='cpfempty') {
                if(response.body.financements[i].type_lbf!='cpf') {
                  this.financements.push(response.body.financements[i])
                  if (response.body.financements[i].eligible) this.financements_eligibles.push(response.body.financements[i]);
                }
              } else {
                this.financements = response.body.financements;
                if (response.body.financements[i].eligible) this.financements_eligibles.push(response.body.financements[i]);
              }
            }
          }
          this.scenario = response.body.scenario;
          this.context = response.body.context;
          this.isLoading = false;
        }).created
        this.resultats = true;
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

<style>
  html {
    scroll-behavior: smooth;
  }
  .row {
    margin-bottom: 1rem;
  }
  .form-step {
    margin-bottom: 3rem;
  }
  .group-indent1 {
    padding-left: 3vw;
  }
  .group-indent2 {
    padding-left: 6vw;
  }
  .group-indent3 {
    padding-left: 9vw;
  }
  .simulateur-horizontal-separator {
    border: none;
    border-top: 1px solid #bfbfbf;
    height: 1px;
    width: 100%;
    position:relative;
  }
  .autocomplete {
    /*the container must be positioned relative:*/
    position: relative;
    display: inline-block;
  }
  .autocomplete-items {
    position: absolute;
    border: 1px solid #d4d4d4;
    border-bottom: none;
    border-top: none;
    z-index: 99;
    /*position the autocomplete items to be the same width as the container:*/
    top: 100%;
    left: 0;
    right: 0;
  }
  .autocomplete-items div {
    padding: 10px;
    cursor: pointer;
    background-color: #fff;
    border-bottom: 1px solid #d4d4d4;
  }
  .autocomplete-items div:hover {
    /*when hovering an item:*/
    background-color: #e9e9e9;
  }
  .block-description {
    background-color: #F1F1F1;
    border-radius: 5px 0px 0px 5px;
  }
  .block-cout-remu {
    background-color: #CAD6E6;
    border-radius: 0px 5px 5px 0px;
  }
  .form-step {
    padding-right: 1vw;
    padding-left: 2vw;
    transition: padding 0.2s 0s ease;
  }
  .step_completed_class {
    background-color: rgba(153, 255, 102, 0.1);
    padding-right: 3vw;
    padding-left: 3vw;
    padding-top: 3vh;
    padding-bottom: 3vh;
    border-radius: 10px;
    transition: padding 0.2s 0s linear;
  }
  .input_format_error {
    background-color: rgba(215, 44, 44, 0.2);
  }
  .input_format_valid {
    background-color: rgba(153, 255, 102, 0.1);
  }
</style>
