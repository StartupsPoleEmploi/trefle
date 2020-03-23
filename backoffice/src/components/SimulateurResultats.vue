<template>
  <div id="SimulateurResultats">
    <div class="row">
      <div class="col-md-12">
        <h2>
          Résultats de simulation de financement
          <button v-on:click="newSimulation();" class="btn main-button-primary pull-right"><span class="mr-1">Nouvelle simulation</span><i class="ml-1 fas fa-redo"></i></button>
        </h2>
      </div>
      
    </div>
    <hr class="simulateur-horizontal-separator">
    <div class="row">
      <div class="col-md-12 text-center mb-3">
        <h3>
          <span v-if="this.financements.length == 0">
            Aucun financement n'est disponible pour ce profil
          </span>
          <span v-else>
            Nous avons trouvé {{this.financements.length }} financement<span v-if="this.financements.length > 1">s</span> pour réaliser votre formation
          </span>
        </h3>
      </div>
    </div>
    <div v-for="(financement, id) in this.financements" :key="id" class="mb-5">
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
    <span data-toggle="collapse" data-target="#explain" aria-expanded="false" aria-controls="explain" style="cursor:pointer;">
      <button class="btn main-button-primary">Voir le scénario de simulation</button>
    </span>
    <div id="explain" class="collapse">
      <div class="row">
        <div class="col-md-12">
          <SimulateurExplain :scenario="scenario"></SimulateurExplain>
        </div>
      </div>
    </div>    
  </div>
</template>
<script>

  import SimulateurExplain from './SimulateurExplain.vue';

  export default {
    name: 'SimulateurResultats',
    components: {
      SimulateurExplain,
    },
    props: ['financements', 'scenario', 'isLoading'],
    methods: {
      newSimulation : function () {
        location.reload();
      }
    }

  }
</script>
