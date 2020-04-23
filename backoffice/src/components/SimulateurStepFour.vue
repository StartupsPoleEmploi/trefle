<template>
  <div id="SimulateurStepFour">
    <div v-if="$parent.situation_inscrit == 2">
      <div class="row">
        <div class="col-md-12">
          <h4>Type de contrat de travail</h4>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <select v-model="$parent.contrat" name="contrat" id="contrat" class="form-control">
            <option value="">-</option>
            <option value="cdd">Contrat à durée déterminée (CDD)</option>
            <option value="cdi">Contrat à durée indéterminée (CDI)</option>
          </select>
        </div>
      </div>
      <div v-if="$parent.contrat == 'cdd'">
        <div class="row">
          <div class="col-md-12">
            <label for="experience">
              Nombre de mois travaillés sur les 5 dernières années
            </label>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <input v-model="$parent.experience" name="experience" id="experience" type="number" value="" placeholder="Nombre de mois" min="0" max="60" class="form-control"/>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 label">
            <label for="moistravailleencdd">
              Nombre de mois travaillés sur un contrat CDD sur les 12 derniers mois
            </label>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <input v-model="$parent.moistravailleencdd" name="moistravailleencdd" id="moistravailleencdd" type="number" value="" placeholder="Nombre de mois" min="0" max="12" class="form-control"/>
          </div>
        </div>
      </div>
      <div v-if="$parent.contrat == 'cdi'">
        <div class="row">
          <div class="col-md-12">
            <label for="experienceannee">
              Nombre d'années d'ancienneté dans votre vie professionnelle
            </label>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <input v-model="$parent.experienceannee" name="experienceannee" id="experienceannee" type="number" value="" placeholder="Nombre d'années" min="0" class="form-control"/>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <label for="ancienneteentrepriseactuelle">
              Nombre d'années d'ancienneté dans l'entreprise actuelle
            </label>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <input v-model="$parent.ancienneteentrepriseactuelle" name="ancienneteentrepriseactuelle" id="ancienneteentrepriseactuelle" type="number" placeholder="Nombre d'années" min="0" class="form-control"/>
          </div>
        </div>
      </div>
    </div>
    <div v-if="$parent.situation_inscrit==1">
      <div class="row">
        <div class="col-md-12">
          <h4>
            Expérience professionnelle
          </h4>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_contratapprentissage" name="situation_contratapprentissage" id="situation_contratapprentissage" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_contratapprentissage" class="form-check-label">
            Vous avez déjà réalisé un contrat d'apprentissage terminé après le 30/01/2019
          </label>
        </div>
      </div>
      <div v-if="$parent.situation_contratapprentissage != ''">
        <div class="row">
          <div class="col-md-12 group-indent1">
            <label for="situation_contratapprentissagetype">...de niveau</label>&nbsp;
            <select v-model="$parent.situation_contratapprentissagetype" name="situation_contratapprentissagetype" id="situation_contratapprentissagetype" class="form-control">
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
        <div v-if="$parent.situation_contratapprentissage != ''" class="row">
          <div class="col-md-12 form-check group-indent1">
            <input v-model="$parent.situation_rupturecontratapprentissage" name="situation_rupturecontratapprentissage" id="situation_rupturecontratapprentissage" type="checkbox" class="form-check-input"/>&nbsp;
            <label for="situation_rupturecontratapprentissage" class="form-check-label">
              Ce contrat d'apprentissage a été rompu indépendamment de votre volonté
            </label>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_cdd" name="situation_cdd" id="situation_cdd" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_cdd" class="form-check-label">
            Vous avez terminé un contrat CDD depuis moins d'un an
          </label>
        </div>
      </div>
      <div v-if="$parent.situation_cdd == true">
        <div class="row">
          <div class="col-md-12 group-indent1">
            <input v-model="$parent.situation_cdd5years" name="situation_cdd5years" id="situation_cdd5years" type="checkbox" class="form-check-input"/>&nbsp;
              <label for="situation_cdd5years" class="form-check-label">
                ...et vous totalisez au moins 24 mois de travail depuis le 30/01/2015
              </label>
            </div>
          </div>
        <div v-if="$parent.situation_cdd5years">
          <div class="row">
            <div class="col-md-12 group-indent2">
              <input v-model="$parent.situation_cdd12months" name="situation_cdd12months" id="situation_cdd12months" type="checkbox" class="form-check-input"/>&nbsp;
              <label for="situation_cdd12months" class="form-check-label">
                ...dont au moins 4 mois de travail de CDD depuis le 30/01/2019
              </label>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12 group-indent2">
              <span id="situation_cdd5years_label" class="text-muted">
                hors contrats d'apprentissage, de professionnalisation, d'accompagnement dans l'emploi (CAE),<br>
                contrats d'avenir, et hors contrats conclus au cours des cursus scolaires
              </span>
            </div>
          </div>
          <div v-if="$parent.situation_cdd12months">
            <div class="row">
              <div class="col-md-12 group-indent3">
                <label for="situation_salairebrutecdd">salaire moyen perçu au cours des 4 derniers mois du CDD :</label>&nbsp;
                <input v-model="$parent.situation_salairebrutecdd" name="situation_salairebrutecdd" id="situation_salairebrutecdd" type="number" placeholder="€ brut / mois" min="0" class="form-control"/>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_contrataide" name="situation_contrataide" id="situation_contrataide" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_contrataide" class="form-check-label">
            Vous bénéficiez ou avez déjà bénéficié d'un contrat aidé
          </label>
        </div>
      </div>
      <div v-if="$parent.situation_contrataide">
        <div class="row">
          <div class="col-md-12 form-check group-indent1 ">
            <input v-model="$parent.situation_personneencourscontrataide" name="situation_personneencourscontrataide" id="contrataide1" type="radio" value="oui" class="form-check-input"/>&nbsp;
            <label for="contrataide1" class="form-check-label">
              Votre contrat aidé est en cours
            </label>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 form-check group-indent1 ">
            <input v-model="$parent.situation_personneencourscontrataide" name="situation_personneencourscontrataide" id="contrataide2"  type="radio" value="non" class="form-check-input"/>&nbsp;
            <label for="contrataide2" class="form-check-label">
              Votre contrat aidé est achevé
            </label>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 group-indent1 ">
            <span id="situation_personneencourscontrataide_label" class="text-muted">
              Contrat d’accompagnement dans l’emploi (CUI-CAE) ou contrat initiative emploi (CUI-CIE) ou emploi d'avenir
            </span>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 form-check">
          <input v-model="$parent.situation_6moissur12" name="situation_6moissur12" id="situation_6moissur12" type="checkbox" class="form-check-input"/>&nbsp;
          <label for="situation_6moissur12" class="form-check-label">
            Vous avez déjà travaillé pendant 6 mois sur une période de 12 mois ou pendant 12 mois sur 24 mois
          </label>
        </div>
      </div>      
    </div>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurStepFour',
  }
</script>
