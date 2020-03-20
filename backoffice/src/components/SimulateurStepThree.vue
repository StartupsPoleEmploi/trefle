<template>
  <div id="SimulateurStepThree">
    <div class="row">
      <div class="col-md-12">
        <h4>Compte personnel de formation (CPF)</h4>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 form-check">
        <input v-model="$parent.situation_cpfconnu" name="situation_cpfconnu" id="cpf1" type="radio" value="cpfconnu" class="form-check-input"/>
        &nbsp;<label for="cpf1" class="form-check-label">Vous connaissez vos droits à formation CPF en euros</label>
      </div>
    </div>
    <div v-if="$parent.situation_cpfconnu=='cpfconnu'" class="row">
      <div class="col-md-12 group-indent1">
        <input v-model="$parent.situation_creditheurescpf" name="situation_creditheurescpf" id="situation_creditheurescpf" type="number" placeholder="Votre crédit en euro" min="0" class="form-control"/>
      </div>
    </div>
    <div v-if="$parent.situation_creditheurescpf != ''" class="row">
      <div class="col-md-12 group-indent1">
        <span id="situation_cpfconnu_label" class="text-muted">
          Attention : assurez-vous bien d'avoir 
          <a href="https://www.moncompteformation.gouv.fr/espace-prive/html/#/compte-utilisateur/connexion" target="_blank" class="text-muted" rel="noopener noreferrer">
            <u>activé votre Compte Personnel Formation</u>
          </a> 
          pour pouvoir mobiliser vos heures CPF
        </span>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 form-check">
        <input v-model="$parent.situation_cpfconnu" name="situation_cpfconnu" id="cpf2" type="radio" value="cpfinconnu" class="form-check-input"/>&nbsp;
        <label for="cpf2" class="form-check-label">Vous ne connaissez pas vos droits à formation CPF en euros</label>
      </div>
    </div>
    <div v-if="$parent.situation_cpfconnu == 'cpfinconnu'" class="row">
      <div class="col-md-12">
        <span id="situation_creditheurescpfconnu_label" class="text-muted">
          Activez votre 
          <a href="https://www.moncompteformation.gouv.fr/espace-prive/html/#/compte-utilisateur/connexion" target="_blank" class="text-muted" rel="noopener noreferrer">
            <u>Compte Personnel Formation (CPF)</u>
          </a>.
        </span>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 form-check">
        <input v-model="$parent.situation_cpfconnu" name="situation_cpfconnu" id="cpf3" type="radio" value="cpfempty" class="form-check-input"/>&nbsp;
        <label for="cpf3" class="form-check-label">Vous n'avez pas de crédit de formation CPF</label>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
      </div>
    </div>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurStepThree',
  }
</script>
