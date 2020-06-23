<template>
  <div id="SimulateurResultats">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h2>
            Résultats de simulation de financement
            <div class="pull-right inline">
              <button v-on:click="editSimulation();" class="btn main-button-primary mr-3"><span class="mr-1">Editer la simulation</span><i class="ml-1 fas fa-edit"></i></button>
              <button v-on:click="newSimulation();" class="btn main-button-primary"><span class="mr-1">Nouvelle simulation</span><i class="ml-1 fas fa-redo"></i></button>
            </div>
          </h2>
        </div>
      </div>
      <hr class="simulateur-horizontal-separator">
      <div class="row">
        <div class="col-md-12 text-center mb-3">
          <h3>
            <span v-if="this.financements_eligibles.length == 0">
              Aucun financement n'est disponible pour ce profil
            </span>
            <span v-else>
              Nous avons trouvé {{this.financements_eligibles.length }} financement<span v-if="this.financements_eligibles.length > 1">s</span> pour réaliser votre formation
            </span>
          </h3>
        </div>
      </div>
      <div v-for="(financement, id) in this.financements_eligibles" :key="id" class="mb-5">
        <div id="financements" class="row">
          <div class="col-md-12 col-sm-12 droits">
            <div data-type="FORMATION FINANCEE" class="row">
              <div class="col-md-8 block-description">
                <div class="row mt-3">
                  <div class="col-md-12">
                    <h3 class="financement">{{ financement.intitule }}</h3>
                  </div>
                </div>
                <div class="row explication">
                  <div class="col-md-12">
                    <div class="row">
                      <div class="col-md-12">
                        <strong>Je souhaite bénéficier de ce financement :</strong><br/>
                        {{ financement.demarches }}
                        <a rel="nofollow noopener noreferrer" target="_blank" href="https://www.moncompteactivite.gouv.fr">moncompteactivite.gouv.fr</a><br/>
                      </div>
                    </div>
                    <div class="row explication">
                      <div class="col-md-12">
                        <span class="savoir-plus" data-toggle="collapse" :data-target="'#more-explication-'+id" aria-expanded="false" aria-controls="moreexplication">
                          <strong style="cursor:pointer; text-decoration:underline">En savoir plus&nbsp;</strong><strong>&gt;</strong>
                        </span>
                      </div>
                    </div>
                    <div class="row collapse" :id="'more-explication-'+id">
                      <div class="col-md-12">
                        {{ financement.description }}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-4 block-cout-remu">
                <div class="mt-3">
                  <div class="cout"></div>
                  <div class="priseencharge remu">
                    <strong>Prise en charge</strong><br/>
                    {{ financement.prise_en_charge_texte }}
                  </div>
                  <div v-if="financement.plafond_prise_en_charge != 0" class="plafondpriseencharge remu">
                    <strong>Plafond de prise en charge</strong><br/>
                    {{ financement.plafond_prise_en_charge}}
                  </div>
                  <div class="remu">
                    <strong>Rémunération mensuelle</strong>
                    <br/>
                    <span v-if="financement.remuneration == 0">
                      Vous ne percevez pas de rémunération pendant la formation
                    </span>
                    <span v-else>
                      {{ financement.remuneration }} €
                    </span>
                  </div>
                  <div class="remu"></div>
                  <div class="organisme remu">
                  </div>
                  <div class="aides-a-la-formation">
                    <a rel="noopener noreferrer" href="https://clara.pole-emploi.fr/aides/detail/aides-a-la-formation" target="_blank" style="color:blue;">Aides possibles à la formation</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <hr class="simulateur-horizontal-separator">
      </div>
    </div>
    <div id="explainCollapseGroup">
      <div class="row" id="explainButtonsGroup">
        <div class="col-md-4">
          <span class="ml-5" data-toggle="collapse" data-target="#scenario" aria-expanded="false" aria-controls="scenario" style="cursor:pointer;" v-on:click="scenarioToggled=!scenarioToggled">
            <button v-if="!scenarioToggled" class="btn main-button-primary">Voir le scénario de simulation</button>
            <button v-else class="btn main-button-primary">Masquer le scénario de simulation</button>
          </span>
        </div>
        <div class="col-md-4">
          <span class="ml-5" data-toggle="collapse" data-target="#context" aria-expanded="false" aria-controls="context" style="cursor:pointer;" v-on:click="contextToggled=!contextToggled">
            <button v-if="!contextToggled" class="btn main-button-primary">Voir le contexte de simulation</button>
            <button v-else class="btn main-button-primary">Masquer le contexte de simulation</button>
          </span>
        </div>
        <div class="col-md-4">
          <span class="ml-5" data-toggle="collapse" data-target="#explain" aria-expanded="false" aria-controls="explain" style="cursor:pointer;" v-on:click="explainToggled=!explainToggled">
            <button v-if="!explainToggled" class="btn main-button-primary">Voir l'explication de simulation</button>
            <button v-else class="btn main-button-primary">Masquer l'explication de simulation</button>
          </span>
        </div>
      </div>
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div id="scenario" data-parent="#explainCollapseGroup" class="collapse">
              <SimulateurScenario :scenario="scenario"></SimulateurScenario>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div id="context" data-parent="#explainCollapseGroup" class="collapse">
              <SimulateurContext :schema="schema" :context="context"></SimulateurContext>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div id="explain" data-parent="#explainCollapseGroup" class="collapse">
              <SimulateurExplain :schema="schema" :financements="financements"></SimulateurExplain>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>

  import SimulateurScenario from './SimulateurScenario.vue';
  import SimulateurExplain from './SimulateurExplain.vue';
  import SimulateurContext from './SimulateurContext.vue';

  export default {
    name: 'SimulateurResultats',
    components: {
      SimulateurScenario,
      SimulateurExplain,
      SimulateurContext
    },
    props: ['schema','financements', 'financements_eligibles', 'scenario', 'context', 'isLoading', 'id_formation'],
    data : function () {
      return {
        scenarioToggled:false,
        contextToggled:false,
        explainToggled:false,
      }
    },
    methods: {
      newSimulation : function () {
        location.reload();
      },
      editSimulation: function () {
        this.$parent.resultats = false;
        this.$parent.financements_eligibles = [];
        this.$parent.formation.numero = this.id_formation;
      }
    }

  }
</script>
<style scoped>
  #explainButtonsGroup {
    position: -webkit-sticky; /* Safari */
    position: sticky;
    top: 0;
    z-index:2;
    background: white;
    padding-bottom: 1.5rem;
    padding-top: 1.5rem;
    margin:0;
  }
</style>
