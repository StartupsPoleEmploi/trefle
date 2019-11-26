<template>
    <div id="Simulateur">

  <section>
      <h2 class="page-title">Simuler depuis un résultat de financement LBF <a v-if="opts.url" :href="opts.url"><i class=icon>link</i></a></h2>
  </section>
  <section v-if="Object.keys(this.errors).length && !Object.keys(this.context).length" class=results>
    <ul>
      <li v-for="error in this.errors" :key="error.id"><strong>{{ error.key }}</strong> {{ error.message }}</li>
    </ul>
  </section>
  <section class=results v-if="Object.keys(this.context).length">
    <h2>Financements</h2>
    <p class="filter">
        <span :click="this.filter()" class="label {eligible: this._tagsEligible.includes(tag)}" v-for="tag in this.tags" :key="tag.id">{{ tag }}</span>
    </p>
    <p v-if="this.currentFilter">
        <input type="checkbox" :click="this.checked=this.filter()" value="Tous les financements éligibles"/>
    </p>
    <p v-else>
        <input type="checkbox" :click="this.checked=this.toggleFailed()" value="Tous les financements"/>
    </p>
      <ul>
        <li v-for="financement in  this.financements" :key="financement.id" class="result:'result', visible: visible, hide: (!eligible && !this.currentFilter)">
          <h3 class="passed: eligible, failed: !eligible" :click="parent.toggle">{{ financement.intitule }}
              <label :click="this.filter()" class="label" v-for="tag in tags" :key="tag.id">{{ tag }}</label>
          </h3>
          <p><strong>Description</strong> {{ financement.description }}</p>
          <p><strong>Démarches</strong> {{ financement.demarches }}</p>
          <virtual v-if="eligible">
            <p><strong>Prise en charge</strong> {{ financement.prise_en_charge }}</p>
            <p v-if="prise_en_charge_texte"><strong>Prise en charge</strong> {{ prise_en_charge_texte }}</p>
            <p><strong>Plafond de prise en charge</strong> {{ plafond_prise_en_charge }}</p>
            <p><strong>Plafond de prix horaire</strong> {{ plafond_prix_horaire }}</p>
            <p><strong>Nombre d'heures prises en charge</strong> {{ heures }}</p>
            <p><strong>Rémunération</strong> {{ remuneration }}</p>
            <p v-if="remuneration_texte"><strong>Rémunération</strong> {{ remuneration_texte  }}</p>
            <p v-if="fin_remuneration"><strong>Fin de la rémunération</strong> {{ renderValue('financement.fin_remuneration', fin_remuneration) }}</p>
            <p v-if="rff"><strong>RFF</strong> {{ rff }}</p>
            <p v-if="debut_rff"><strong>Début de la RFF</strong> {{ renderValue('financement.debut_rff', debut_rff) }}</p>
            <p v-if="fin_rff"><strong>Fin de la RFF</strong> {{ renderValue('financement.fin_rff', fin_rff) }}</p>
            <p v-if="organisme"><strong>Organisme</strong> {{ organisme.nom }}</p>
          </virtual>
          <p>
            <strong>Règles de gestion</strong>
            <eligibilite conditions= {{ explain }}></eligibilite>
          </p>
        </li>
      </ul>
      <p v-if="!this.financements.length">Aucun financement trouvé.</p>
      <h2>Contexte</h2>
      <context :data="this.context"></context>
      <h2>Scénario de test</h2>
      <textarea :focus="this.selectScenario" v-model="this.scenario"></textarea>
    </section>
    <section class="results" v-else>
        <p>Vous devez faire une simulation sur LBF et cliquer sur le bouton "simuler sur trèfle"</p>
        <p> Pour voir le bouton sur le site de production glisser/déposer ce lien dans votre bookmark <a class="button" href="">LBF mode expert</a></p>
    </section>
    </div>
</template>
<script>
/*
export default {
  name: 'Simulateur',
  data: () => {
    return {
        financements = [],
        context = {},
        errors = {}
    }
  },
  created: () => {
    load();
  },
  methods: {
    load: () => {
      if (this.opts.url) this.simulate_url(this.opts.url)
    },
    onError: () => {
      this.errors = data
      this.update()
    },
    decodeLBFURL: (url, callback) => {
      request(`../explore/decode-lbf-url?url=${encodeURIComponent(url)}`)
      .then(callback, this.onError)
    },
    simulate: (data, tags = '') => {
      if (tags) tags = '&tags=' + tags.toString();
      request('/financement?context=1&scenario=1&explain=1' + tags, {
        method: 'post',
        body: JSON.stringify(data)
      })
      .then((data) => {
        this.financements = data.financements
        this.currentFilter = ''
        if (!tags) {
            var _tags = new Array()
            var _tagsEligible = new Array()
        }
        for (var i = 0; i < this.financements.length; i++) {
          // Riot sucks on `tags`…
          this.financements[i]['_tags'] = this.financements[i]['tags']
          if(_tags) _tags = _tags.concat(this.financements[i]['tags'])
          if(_tagsEligible && this.financements[i]['eligible']) _tagsEligible = _tagsEligible.concat(this.financements[i]['tags'])
        }
        if(_tags) this._tags = [...new Set(_tags)].sort()
        if(_tagsEligible) this._tagsEligible = [...new Set(_tagsEligible)]
        if(tags) this.currentFilter = tags
        this.context = data.context
        this.scenario = data.scenario
        this.update()
      }, this.onError)
    },
    simulate_url: (url) => {
      this.decodeLBFURL(url, this.simulate)
    },
    toggle: (e) => {
      var item = e.item
      item.visible = !item.visible
    },
    toggleFailed: () => {
      document.querySelectorAll('.failed').forEach((e) => { e.parentNode.classList.toggle('hide') })
    },
    filter: (e) => {
      var filterTag = ''
      if(typeof e.item !== 'undefined' && typeof e.item.tag  == 'string')
      {
          document.querySelectorAll('.filter .label').forEach((e) => { e.classList.remove('selected'); e.classList.add('lighten') })
          e.target.classList.add('selected');
          e.target.classList.remove('lighten');
          filterTag = e.item.tag
      }
      else
          document.querySelectorAll('.filter .label').forEach((e) => { e.classList.remove('selected'); e.classList.remove('lighten') })

      this.simulate ( this.context, filterTag )
    },
    selectScenario: (e) => {
      e.target.select()
    }
  }
}*/
</script>