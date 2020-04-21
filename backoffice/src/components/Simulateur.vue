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
        <!---------------- STEP ONE ---------------->
        <div class="formation-step step" :class="{step_completed_class: formation_step_completed}">
          <div class="row">
            <div class="col-md-12">
              <h4>Formation</h4>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <label for="id_formation">Identifiant de formation intercarif</label>
              <input v-model="id_formation" v-on:keydown="formationNotExists=null; formation.numero=null" id="id_formation" type="text" value="" placeholder="identifiant intercarif" class="form-control" /><br>
              <button class="btn main-button mr-5" v-on:click="searchCatalogue()">Chercher</button>
              <strong v-if="formationNotExists===false">{{ intitule_formation }}</strong>
              <span v-if="formationNotExists===true" style="color:red">Aucune formation trouvée pour l'identifiant renseigné</span><br>
            </div>
          </div>
        </div>
        <hr v-if="formation_step_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP ONE ---------------->
        <div v-if="formation_step_completed" class="form-step step-one" :class="{step_completed_class: step_one_completed}">
          <div class="row">
            <div class="col-md-12">
              <h4>Situation</h4>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12 form-check">
              <input v-model="situation_inscrit" name="situation_inscrit" id="situation_inscrit1"  type="radio" value="1" class="form-check-input"/>
              <label for="situation_inscrit1" class="form-check-label">Vous êtes inscrit(e) comme demandeur d'emploi</label>
            </div>
          </div>
          <div v-if="situation_inscrit==1">
            <div class="row">
              <div class="col-md-12 group-indent1">
                <label for="situation_inscritcumuldureeinscriptionsur12mois">Depuis combien de temps êtes-vous inscrit à Pôle Emploi ?</label>&nbsp;
                <select v-model="situation_inscritcumuldureeinscriptionsur12mois" id="situation_inscritcumuldureeinscriptionsur12mois" class="form-control">
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
                <select v-model="allocation_type" id="allocation_type" class="form-control">
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
          <div v-if="allocation_type != 'non' && allocation_type != '-' && allocation_type != '' && situation_inscrit == 1">
            <div class="row">
              <div class="col-md-12">
                  <div class="row">
                    <div class="col-md-12 group-indent2">
                      <label for="allocation_dateend">Date de fin estimée de votre indemnisation</label>&nbsp;
                      <input v-model="allocation_dateend" id="allocation_dateend" type="text" value="" placeholder="JJ/MM/AAAA" pattern="^\d{1,2}/\d{1,2}/\d{4}$"  class="date form-control" :class="{input_format_error: badFormatAllocation_dateend, input_format_valid: goodFormatAllocation_dateend}"/>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-12 group-indent2">
                      <label for="allocation_cost">Montant mensuel de votre allocation</label>&nbsp;
                      <input v-model="allocation_cost" id="allocation_cost" type="number" value="" placeholder="arrondi à l'€ net / mois" min="0" class="form-control"/>
                    </div>
                  </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12 form-check">
              <input v-model="situation_inscrit" name="situation_inscrit" id="situation_inscrit2" type="radio" value="2" required="required" class="form-check-input"/>&nbsp;
              <label for="situation_inscrit2"  class="form-check-label" >Vous êtes salarié(e) de droit privé</label>
            </div>
          </div>
        </div>
        <hr v-if="step_one_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP TWO ---------------->
        <div v-if="step_one_completed" class="form-step step-two" :class="{step_completed_class: step_two_completed}">
          <div v-if="situation_inscrit == 2 && financement__accessible_salarie_formation == false">
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
                <input v-model="birthdate" name="birthdate" id="birthdate" type="text" title="Format : JJ/MM/AAAA" required="required" placeholder="JJ/MM/AAAA" class="date form-control" :class="{input_format_error: badFormatBirthdate, input_format_valid: goodFormatBirthdate}"/>
              </div>
            </div>
            <div v-if="situation_inscrit == 1">
              <div class="row">
                <div class="col-md-12">
                  <h4>Domicile</h4>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12 autocomplete">
                  <b-form-input v-model="commune_beneficiaire_autocomplete" list="commune-beneficiaire-list" placeholder="Rentrez votre code postal"></b-form-input>
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
                  <select v-model="niveauscolaire" name="niveauscolaire" id="niveauscolaire" class="form-control">
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
            <div v-if="situation_inscrit == 2">
              <div class="row">
                <div class="col-md-12">
                  <h4>Votre rémunération mensuelle actuelle</h4>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <input v-model="salaire" name="salaire" id="salaire" type="number" value="" placeholder="salaire arrondi à l'€ net / mois" min="0" class="form-control"/>
                </div>
              </div>
            </div>
          </div>
        </div>
        <hr v-if="step_two_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP THREE ---------------->
        <div v-if="step_two_completed" class="form-step step-three" :class="{step_completed_class: step_three_completed}">
          <div class="row">
            <div class="col-md-12">
              <h4>Compte personnel de formation (CPF)</h4>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12 form-check">
              <input v-model="situation_cpfconnu" name="situation_cpfconnu" id="cpf1" type="radio" value="cpfconnu" class="form-check-input"/>
              &nbsp;<label for="cpf1" class="form-check-label">Vous connaissez vos droits à formation CPF en euros</label>
            </div>
          </div>
          <div v-if="situation_cpfconnu=='cpfconnu'" class="row">
            <div class="col-md-12 group-indent1">
              <input v-model="situation_creditheurescpf" name="situation_creditheurescpf" id="situation_creditheurescpf" type="number" placeholder="Votre crédit en euro" min="0" class="form-control"/>
            </div>
          </div>
          <div v-if="situation_creditheurescpf != ''" class="row">
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
              <input v-model="situation_cpfconnu" name="situation_cpfconnu" id="cpf2" type="radio" value="cpfinconnu" class="form-check-input"/>&nbsp;
              <label for="cpf2" class="form-check-label">Vous ne connaissez pas vos droits à formation CPF en euros</label>
            </div>
          </div>
          <div v-if="situation_cpfconnu == 'cpfinconnu'" class="row">
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
              <input v-model="situation_cpfconnu" name="situation_cpfconnu" id="cpf3" type="radio" value="cpfempty" class="form-check-input"/>&nbsp;
              <label for="cpf3" class="form-check-label">Vous n'avez pas de crédit de formation CPF</label>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
            </div>
          </div>
        </div>
        <hr v-if="step_three_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP FOUR ---------------->
        <div v-if="step_three_completed" class="form-step step-four" :class="{step_completed_class: step_four_completed}">
          <div v-if="situation_inscrit == 2">
            <div class="row">
              <div class="col-md-12">
                <h4>Type de contrat de travail</h4>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <select v-model="contrat" name="contrat" id="contrat" class="form-control">
                  <option value="">-</option>
                  <option value="cdd">Contrat à durée déterminée (CDD)</option>
                  <option value="cdi">Contrat à durée indéterminée (CDI)</option>
                </select>
              </div>
            </div>
            <div v-if="contrat == 'cdd'">
              <div class="row">
                <div class="col-md-12">
                  <label for="experience">
                    Nombre de mois travaillés sur les 5 dernières années
                  </label>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <input v-model="experience" name="experience" id="experience" type="number" value="" placeholder="Nombre de mois" min="0" max="60" class="form-control"/>
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
                  <input v-model="moistravailleencdd" name="moistravailleencdd" id="moistravailleencdd" type="number" value="" placeholder="Nombre de mois" min="0" max="12" class="form-control"/>
                </div>
              </div>
            </div>
            <div v-if="contrat == 'cdi'">
              <div class="row">
                <div class="col-md-12">
                  <label for="experienceannee">
                    Nombre d'années d'ancienneté dans votre vie professionnelle
                  </label>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <input v-model="experienceannee" name="experienceannee" id="experienceannee" type="number" value="" placeholder="Nombre d'années" min="0" class="form-control"/>
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
                  <input v-model="ancienneteentrepriseactuelle" name="ancienneteentrepriseactuelle" id="ancienneteentrepriseactuelle" type="number" placeholder="Nombre d'années" min="0" class="form-control"/>
                </div>
              </div>
            </div>
          </div>
          <div v-if="situation_inscrit==1">
            <div class="row">
              <div class="col-md-12">
                <h4>
                  Expérience professionnelle
                </h4>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_contratapprentissage" name="situation_contratapprentissage" id="situation_contratapprentissage" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_contratapprentissage" class="form-check-label">
                  Vous avez déjà réalisé un contrat d'apprentissage terminé après le 30/01/2019
                </label>
              </div>
            </div>
            <div v-if="situation_contratapprentissage != ''">
              <div class="row">
                <div class="col-md-12 group-indent1">
                  <label for="situation_contratapprentissagetype">...de niveau</label>&nbsp;
                  <select v-model="situation_contratapprentissagetype" name="situation_contratapprentissagetype" id="situation_contratapprentissagetype" class="form-control">
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
              <div v-if="situation_contratapprentissage != ''" class="row">
                <div class="col-md-12 form-check group-indent1">
                  <input v-model="situation_rupturecontratapprentissage" name="situation_rupturecontratapprentissage" id="situation_rupturecontratapprentissage" type="checkbox" class="form-check-input"/>&nbsp;
                  <label for="situation_rupturecontratapprentissage" class="form-check-label">
                    Ce contrat d'apprentissage a été rompu indépendamment de votre volonté
                  </label>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_cdd" name="situation_cdd" id="situation_cdd" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_cdd" class="form-check-label">
                  Vous avez terminé un contrat CDD depuis moins d'un an
                </label>
              </div>
            </div>
            <div v-if="situation_cdd == true">
              <div   class="row">
                <div class="col-md-12 group-indent1">
                  <input v-model="situation_cdd5years" name="situation_cdd5years" id="situation_cdd5years" type="checkbox" class="form-check-input"/>&nbsp;
                    <label for="situation_cdd5years" class="form-check-label">
                      ...et vous totalisez au moins 24 mois de travail depuis le 30/01/2015
                    </label>
                  </div>
                </div>
              <div v-if="situation_cdd5years">
                <div class="row">
                  <div class="col-md-12 group-indent2">
                    <input v-model="situation_cdd12months" name="situation_cdd12months" id="situation_cdd12months" type="checkbox" class="form-check-input"/>&nbsp;
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
                <div v-if="situation_cdd12months">
                  <div class="row">
                    <div class="col-md-12 group-indent3">
                      <label for="situation_salairebrutecdd">salaire moyen perçu au cours des 4 derniers mois du CDD :</label>&nbsp;
                      <input v-model="situation_salairebrutecdd" name="situation_salairebrutecdd" id="situation_salairebrutecdd" type="number" placeholder="€ brut / mois" min="0" class="form-control"/>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_contrataide" name="situation_contrataide" id="situation_contrataide" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_contrataide" class="form-check-label">
                  Vous bénéficiez ou avez déjà bénéficié d'un contrat aidé
                </label>
              </div>
            </div>
            <div v-if="situation_contrataide">
              <div class="row">
                <div class="col-md-12 form-check group-indent1 ">
                  <input v-model="situation_personneencourscontrataide" name="situation_personneencourscontrataide" id="contrataide1" type="radio" value="oui" class="form-check-input"/>&nbsp;
                  <label for="contrataide1" class="form-check-label">
                    Votre contrat aidé est en cours
                  </label>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12 form-check group-indent1 ">
                  <input v-model="situation_personneencourscontrataide" name="situation_personneencourscontrataide" id="contrataide2"  type="radio" value="non" class="form-check-input"/>&nbsp;
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
                <input v-model="situation_6moissur12" name="situation_6moissur12" id="situation_6moissur12" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_6moissur12" class="form-check-label">
                  Vous avez déjà travaillé pendant 6 mois sur une période de 12 mois ou pendant 12 mois sur 24 mois
                </label>
              </div>
            </div>
          </div>
        </div>
        <hr v-if="step_four_completed" class="simulateur-horizontal-separator">
        <!---------------- STEP FIVE ---------------->
        <div v-if="step_four_completed" class="form-step step-five" :class="{step_completed_class: step_five_completed}">
          <div v-if="situation_inscrit == 1">
            <div class="row">
              <div class="col-md-12">
                <h4>Situation particulière</h4>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_th" name="situation_th" id="situation_th" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_th" class="label-after">Vous êtes reconnu travailleur handicapé</label>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_travailleurnonsal12dont6dans3ans" name="situation_travailleurnonsal12dont6dans3ans" id="situation_travailleurnonsal12dont6dans3ans" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_travailleurnonsal12dont6dans3ans" class="label-after">
                  Vous êtes un travailleur non salarié et vous avez travaillé durant 12 mois, dont 6 mois consécutifs, dans les 3 ans précédant l’entrée en stage
                </label>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_parentisole" name="situation_parentisole" id="situation_parentisole" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_parentisole" class="label-after">Vous êtes parent isolé <span class="mini-info">*</span></label><br>
                <div v-if="situation_parentisole" class="text-muted group-indent1">
                  * Personnes veuves, divorcées, séparées, abandonnées ou célibataires assumant seules la charge effective et permanente d’un ou de plusieurs enfants résidant en France et Femmes seules enceintes ayant effectué la déclaration de grossesse et les examens prénataux prévus par la loi
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_mere3enfants" name="situation_mere3enfants" id="situation_mere3enfants" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_mere3enfants" class="label-after">Vous êtes mère de famille ayant eu au moins 3 enfants</label>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_divorceeveuve" name="situation_divorceeveuve" id="situation_divorceeveuve" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_divorceeveuve" class="label-after">Vous êtes une femme divorcée, veuve, ou séparée judiciairement depuis moins de 3 ans</label>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_projetcreationentreprise" name="situation_projetcreationentreprise" id="situation_projetcreationentreprise" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_projetcreationentreprise" class="label-after">Vous avez un projet de création d'entreprise qui nécessite cette formation</label>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12 form-check">
                <input v-model="situation_vaepartiellemoins5ans" name="situation_vaepartiellemoins5ans" id="situation_vaepartiellemoins5ans" type="checkbox" class="form-check-input"/>&nbsp;
                <label for="situation_vaepartiellemoins5ans" class="label-after">Vous souhaitez terminer cette formation pour laquelle vous avez obtenu, il y a moins de 5 ans, une certification partielle par un jury VAE</label>
              </div>
            </div>
          </div>
          <div v-if="situation_inscrit == 2">
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
                <input v-model="id_naf" v-on:keydown="nafNotExists=null; idcc=null" id="naf" type="text" value="" placeholder="identifiant naf" class="form-control" /><br>
                <button class="btn main-button mr-5" v-on:click="searchNAF()">Chercher</button>
                <span v-if="nafNotExists===false">Activité principale trouvée : <strong>{{ intitule_naf }}</strong></span>
                <span v-if="nafNotExists===true" style="color:red">Aucune activité principale trouvée avec l'identifiant {{ id_naf }} </span><br>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <label for="idcc">Secteur d'activité ou code IDCC</label>
                <input v-model="id_idcc" v-on:keydown="idccNotExists=null; idcc=null" id="idcc" type="text" value="" placeholder="identifiant idcc" class="form-control" /><br>
                <button class="btn main-button mr-5" v-on:click="searchIDCC()">Chercher</button>
                <strong v-if="idccNotExists===false">{{ intitule_idcc }}</strong>
                <span v-if="idccNotExists===true" style="color:red">Aucune convention collective trouvée avec l'identifiant {{ id_idcc }} </span><br>

              </div>
            </div>
            <div class="row">
              <div class="col-md-12 autocomplete">
                <label for="commune_entreprise">Commune de votre entreprise</label>&nbsp;
                <b-form-input v-model="commune_entreprise_autocomplete" list="commune-entreprise-list" placeholder="Rentrez le code postal de votre entreprise"></b-form-input>
                <datalist id="commune-entreprise-list" v-show="autocomplete_entreprise_opened">
                  <option v-for="commune in this.commune_entreprise_list" :key="commune.codeCommune">
                    {{ commune.nomCommune }} | {{ commune.codePostal }} ({{commune.codeCommune}})
                  </option>
                </datalist>
              </div>
            </div>
          </div>
        </div>
        <!---------------- STEP FIVE ---------------->
        <div v-if="step_five_completed" class="form-step">
          <input type="button" class="btn main-button" value="Simuler" v-on:click="simulate()"/>
        </div>
      </div>
      <!------------------- RESULTATS --------------->
      <div v-else id="simulate-results">
        <div class="row">
          <div class="col-md-12">
            <h2>Résultats de simulation de financement </h2>
          </div>
        </div>
        <hr class="simulateur-horizontal-separator">
        <div v-if="!isLoading" class="mt-5">
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
        </div>
        <div v-else class="text-center loading-gif">
          <img src="./../assets/images/loading.gif" alt="loading...">
        </div>
      </div>
    </div>
  </div>
</template>
<script>
	export default {
		name: 'Simulateur',
		data: function () {
			return {
        // champs de formulaire
        // step formation
        id_formation : null,
        formationNotExists: null,
        intitule_formation : null,
        //flag permettant de detecter si la formation est eligible à un financement en cas de profil de salarié
        financement__accessible_salarie_formation: null,
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
            id_naf: null,
            nafNotExists: null,
            intitule_naf: null,
            idcc: '',
            id_idcc: null,
            idccNotExists: null,
            intitule_idcc: null,
            commune_entreprise_autocomplete: '',
            autocomplete_entreprise_opened: true,
        // TO DO input formation
        financements : [],
        resultats: false,
        isLoading: false,
        test: [],
			}
    },
    computed: {
      //flags checking if dates are well-formated
      badFormatBirthdate: function () {
        if (this.birthdate.length >= 10) {
          return this.birthdate.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) == null
        } return false;
      },
      goodFormatBirthdate: function () {
        return this.birthdate.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) != null;
      },
      badFormatAllocation_dateend: function () {
        if (this.allocation_dateend.length >= 10) {
          return this.allocation_dateend.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) == null
        } return false;
      },
      goodFormatAllocation_dateend: function () {
        return this.allocation_dateend.match(/^\s*(3[01]|[12][0-9]|0?[1-9])\/(1[012]|0?[1-9])\/((?:19|20)\d{2})\s*$/gi) != null;
      },
      formation_step_completed: function () {
        return this.formation.numero != null
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
              if (this.commune_beneficiaire != undefined && this.niveauscolaire != '') {
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
      commune_beneficiaire_list: function () {
        const codesPostaux = require('codes-postaux');
        if(this.commune_beneficiaire_autocomplete.match(/^(([0-8][0-9])|(9[0-5]))[0-9]{3}$/gi) == null) return [];
        return codesPostaux.find(this.commune_beneficiaire_autocomplete.match(/^(([0-8][0-9])|(9[0-5]))[0-9]{3}$/gi));
      },
      commune_beneficiaire: function () {
        // getting insee code from input field
        return this.commune_beneficiaire_autocomplete.split('(').length < 2 ? undefined : this.commune_beneficiaire_autocomplete.split('(')[1].substr(0,this.commune_beneficiaire_autocomplete.split('(')[1].length-1).trim();
      },
      departement: function () {
        return this.commune_beneficiaire == undefined ? undefined : this.commune_beneficiaire.substr(0,2)
      },
      commune_entreprise_list: function () {
        const codesPostaux = require('codes-postaux');
        if(this.commune_entreprise_autocomplete.match(/^(([0-8][0-9])|(9[0-5]))[0-9]{3}$/gi) == null) return [];
        return codesPostaux.find(this.commune_entreprise_autocomplete.match(/^(([0-8][0-9])|(9[0-5]))[0-9]{3}$/gi));
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
			searchCatalogue: function () {
        this.$http
          .get('/explore/catalog?id='+this.id_formation)
          .then(response => {
            this.formation.numero = response.body.uid;
            this.intitule_formation  = response.status != 200 ? null:response.body.intitule;
            if(response.status != 200) {
              this.financement__accessible_salarie_formation = null
            } else {
              for(var i=0; i<response.body.sessions.length; i++) {
                var session = response.body.sessions[i]
                for (var j=0; j<session.financeurs.length; j++) {
                  this.financement__accessible_salarie_formation = (session.financeurs[j].code == 0 || session.financeurs[j].code == 5 || session.financeurs[j].code == 10)
                }
              }
            }
            this.formationNotExists = response.status != 200;
          }, (response) => {
            this.formationNotExists = response.status != 200;
          })
          .created;
      },
			searchIDCC: function () {
        this.$http
          .get('/idcc?q='+this.id_idcc)
          .then(response => {
            this.idcc = response.body;
            this.intitule_idcc = response.status != 200 ? null:response.body['convention collective'];
            this.idccNotExists = response.status != 200;
          }, (response) => {
            this.idccNotExists = response.status != 200;
          })
          .created;
      },
			searchNAF: function () {
        this.$http
          .get('/naf?q='+this.id_naf)
          .then(response => {
            this.naf = response.body.code;
            this.intitule_naf = this.objectIsEmpty(response.body) ? null:response.body[this.id_naf].name;
            this.nafNotExists = this.objectIsEmpty(response.body);
          }, (response) => {
            this.nafNotExists = response.status != 200;
          })
          .created;
      },
      objectIsEmpty: function (obj) {
        for(var key in obj) {
          if(obj.hasOwnProperty(key))
            return false;
        }
        return true;
      },
      selectLocation : function () {
        this.autocomplete_opened=false;
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


        this.$http.post('/financement?eligible=true&explain=true', this.request).then(response => {
          if(this.situation_cpfconnu=='cpfempty') {
            if(this.objectIsEmpty(response.body)) {
              this.financements = [];
            } else {
              this.financements = [];
              for(var i=0; i<response.body.financements.length; i++){
                if(response.body.financements[i].type_lbf!='cpf') this.financements.push(response.body.financements[i])
              }
            }
          } else this.financements = response.body.financements;
          this.isLoading = false;
        }).created
        this.resultats = true;
        this.isLoading = false;
      }
		}
	}
</script>

<style scoped>
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
