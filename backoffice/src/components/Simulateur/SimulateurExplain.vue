<template>
  <div id="SimulateurExplain">
    <br>

    <div class="filter">
      <span v-for="(tag, i) in this.tags" :key="i" class="filter-tags label" :class="{eligible: tagsEligibles.includes(tag), selected: selectedTags.includes(tag)}" v-on:click="setFilter(tag)">
        {{tag}}
      </span>
    </div>
    <br>
    <div>
      <span v-if="this.showReinitFilterButton" v-on:click="initFilter();" class="btn main-button pull-right">Réinitialiser les filtres</span>
    </div>
    <br>
    <br>
    <ul>
      <li v-for="(financement, financement_id) in this.financements" :key="financement_id" class="result" :class="{hide:showFinancement(financement)}">
        <br>
        <h5 :class="{passed: financement.eligible, failed: !financement.eligible}" data-toggle="collapse" :data-target="'#details_'+financement_id" aria-expanded="false" aria-controls="explain" style="cursor:pointer;" >
          {{ financement.intitule }}
          <div class="pull-right">
            <label v-for="(tag, tag_id) in financement.tags" :key="tag_id" class="label">{{ tag }}</label>
          </div>
        </h5>
        <div :id="'details_'+financement_id" class="collapse">
          <p v-if="financement.description"><strong>Description :</strong> {{ financement.description }}</p>
          <p v-if="financement.demarches"><strong>Démarches :</strong> {{ financement.demarches }}</p>
          <div v-if="financement.eligible">
            <p v-if="financement.prise_en_charge"><strong>Prise en charge :</strong> {{ financement.prise_en_charge }}</p>
            <p v-if="financement.prise_en_charge_texte"><strong>Prise en charge :</strong> {{ financement.prise_en_charge_texte }}</p>
            <p v-if="financement.plafond_prise_en_charge"><strong>Plafond de prise en charge :</strong> {{ financement.plafond_prise_en_charge }}</p>
            <p v-if="financement.plafond_prix_horaire"><strong>Plafond de prix horaire :</strong> {{ financement.plafond_prix_horaire }}</p>
            <p v-if="financement.heures"><strong>Nombre d'heures prises en charge :</strong> {{ financement.heures }}</p>
            <p v-if="financement.remuneration"><strong>Rémunération :</strong> {{ financement.remuneration }}</p>
            <p v-if="financement.remuneration_texte"><strong>Rémunération :</strong> {{ financement.remuneration_texte }}</p>
            <p v-if="financement.fin_remuneration"><strong>Fin de la rémunération :</strong> {{ renderValue('financement.fin_remuneration', financement.fin_remuneration,schema) }}</p>
            <p v-if="financement.rff"><strong>RFF :</strong> {{ financement.rff }}</p>
            <p v-if="financement.debut_rff"><strong>Début de la RFF :</strong> {{ renderValue('financement.debut_rff', financement.debut_rff,schema) }}</p>
            <p v-if="financement.fin_rff"><strong>Fin de la RFF :</strong> {{ renderValue('financement.fin_rff', financement.fin_rff,schema) }}</p>
            <p v-if="financement.organisme"><strong>Organisme :</strong> {{ financement.organisme.nom }}</p>
          </div>
          <p>
            <strong>Règles de gestion :</strong><br><br>
            <eligibilite :conditions="financement.explain" :schema="schema"/>
          </p>
        </div>
        <br>
      </li>
    </ul>
  </div>
</template>
<script>
  import Eligibilite from './Eligibilite.vue';

  export default {
		name: 'SimulateurExplain',
    props: ['schema', 'financements', 'financements_eligibles'],
    components: {
      Eligibilite,
    },
    data : function () {
      return {
        tags: [],
        tagsEligibles: [],
        selectedTags : [],
        showReinitFilterButton: [],
      }
    },
    mounted : function () {
      this.initFilter();
    },
    methods: {
      initFilter : function () {
        this.filteredFinancements = this.financements;
        for (var i = 0; i < this.financements.length; i++) {
          this.tags = this.tags.concat(this.financements[i]['tags']);
          if(this.financements[i]['eligible']) this.tagsEligibles = this.tagsEligibles.concat(this.financements[i]['tags']);
        }
        if(this.tags) this.tags = [...new Set(this.tags)].sort()
        if(this.tagsEligibles) this.tagsEligibles = [...new Set(this.tagsEligibles)]
        this.selectedTags = this.tags
        this.showReinitFilterButton=false;
      },
      setFilter: function (tag) {
        var tag_array = [tag]
        this.selectedTags=tag_array;
        this.showReinitFilterButton = true;
        this.filteredFinancements = this.filterFinancements(tag);
      },
      filterFinancements: function (tag) {
        return this.financements.filter(financement => {
          if (tag != "") {
            //replace all accents characters in the search string by their non-accented equivalent
            var searchWithoutAccents = tag.normalize('NFD').replace(/[\u0300-\u036f]/g, "")
            //create a RegExp for the search string to be case-insensitive
            var searchRegExp = new RegExp(searchWithoutAccents,'ig')
            return this.filterable(financement.tags).match(searchRegExp);
          }
          return true
        })
      },
      filterable: function (tags) {
        //replace all accents characters in the search string by their non-accented equivalent
        return "".concat(tags.join(",")).normalize('NFD').replace(/[\u0300-\u036f]/g, "");
      },
      showFinancement: function (financement) {
        if (this.selectedTags != this.tags) {
          for(var i = 0; i< financement.tags.length; i++) {
            if (this.selectedTags.includes(financement.tags[i])) return false;
          }
          return true;
        } else {
          return !financement.eligible;
        }
      },
      renderValue: function (key, value, schema_tmp) {
        schema_tmp = schema_tmp || this.schema[key]
        if (schema_tmp['type'] === 'array') return value.map(v => this.renderValue(key, v, schema_tmp['items'])).join(', ')
        if (schema_tmp['type'] === "boolean") return value ? 'oui' : 'non'
        if (schema_tmp['format'] === 'date' && value != null && value != "") return (new Date(value * 1000)).toLocaleDateString("fr")
        if (schema_tmp['enum']) return schema_tmp == undefined ? schema_tmp['enum'][value]+' ('+value+')' : ''
        return value
      },
      renderLabel: function (key) {
        return this.schema[key]['label'].charAt(0).toUpperCase() + this.schema[key]['label'].slice(1)
      }
    }
  }
</script>

<style scoped>

  pre {
    padding: 1rem;
    border-radius: 5px;
    border: solid 2px #CAD6E6;
    background-color: #F1F1F1;
    max-width: 1200px;
    font-family: 'mono';
    white-space: pre-wrap;
  }
  .results {
    padding: 10px;
    border-left: 1px solid #ddd;
  }
  .result {
    border-bottom: 1px solid #eee;
  }
  .result.hide {
    display: none;
  }
  .result.visible p {
    display: block;
  }
  .result.visible {
    border: 1px solid #eee;
    padding: 5px;
  }
  .result h3 {
    font-weight: normal;
  }
  .label {
    color: white;
    font-size: small;
    display: inline-block;
    background-color: slategray;
    border-radius: 0.25em;
    padding: 0.2em;
    margin: 0.2em 0.2em;
    cursor: pointer;
  }
  .filter-tags {
    opacity: 0.5;
  }
  .selected {
    opacity: 1 !important;
  }
  .filter .eligible {
    background-color: forestgreen !important;
  }
  .filter .eligible {
    background-color: forestgreen !important;
  }
  .filter .label {
    background-color: crimson;
  }
  .failed:before {
    content: '✗';
    color: crimson;
  }
  .passed:before {
    content: '✔';
    color: forestgreen;
  }
</style>
