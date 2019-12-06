<template>
    <div id="Simulateur">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h2>Depuis un résultat de financement LBF
						<a v-if="Object.keys(this.url).length" :href="this.url">
							<i class="icon">link</i>
						</a>
					</h2>
				</div>
				<div class="col-md-6">
					<div v-if="Object.keys(this.errors).length && !Object.keys(this.context).length" class="results">
						<ul>
							<li v-for="(message, key) in this.errors" :key="key">
								<strong>{{ key }}</strong> 
								{{ message }}
							</li>
						</ul>
					</div>
					<div class="results" v-else>
						<p>Vous devez faire une simulation sur LBF et cliquer sur le bouton "simuler sur trèfle"</p>
						<p> 
							Pour voir le bouton sur le site de production glisser/déposer ce lien dans votre bookmark
							<a class=button :href="href()">
								LBF mode expert
							</a>
						</p>
					</div>
					<div class="results" v-if="Object.keys(this.context).length">
						<h2>Financements</h2>
						<p class="filter">
							<span @click="this.filter()" :class="'label'+ {eligible: this.tagsEligible.includes(tag)}" v-for="(tag, i) in this.tags" :key="i">
								{{tag}}
							</span>
						</p>
						<p v-if="!this.currentFilter">
							<label for="fin_checkbox">Tous les financements</label>
							<input name="fin_checkbox"  type="checkbox" @click="this.checked=toggleFailed"/>
						</p>
						<p v-else>
							<label for="fin_eligibles_checkbox">Tous les financements éligibles</label>
							<input name="fin_eligibles_checkbox" type="checkbox" @click="this.checked=this.filter"/>
						</p>
							<ul>
								<li v-for="financement in this.financements" :key="financement.id" :class="'result visible'+{hide:(!financement.eligible && !this.currentFilter)}">
										<h3 @click="this.$parent.toggle">
											{{ financement.intitule }}
											<label @click="this.filter()" class="label" v-for="(tag, i) in financement.tags" :key="i">
												{{ tag }}
											</label>
										</h3>
										<p>
											<strong>Description</strong>
											{{ financement.description }}
										</p>
										<p>
											<strong>Démarches</strong>
											{{ financement.demarches }}
										</p>
										<virtual v-if="financement.eligible">
											<p>
												<strong>Prise en charge</strong>
												{{ financement.prise_en_charge  }}
											</p>
											<p v-if="financement.prise_en_charge_texte">
												<strong>Prise en charge</strong>
												{{ financement.prise_en_charge_texte  }}
											</p>
											<p>
												<strong>Plafond de prise en charge</strong>
												{{ financement.plafond_prise_en_charge }}
											</p>
											<p>
												<strong>Plafond de prix horaire</strong>
												{{ financement.plafond_prix_horaire }}
											</p>
											<p>
												<strong>Nombre d'heures prises en charge</strong>
												{{ financement.heures }}
											</p>
											<p>
												<strong>Rémunération</strong>
												{{ financement.remuneration }}
											</p>
											<p v-if="financement.remuneration_texte">
												<strong>Rémunération</strong>
												{{ financement.remuneration_texte  }}
											</p>
											<p v-if="financement.fin_remuneration">
												<strong>Fin de la rémunération</strong>
												{{ renderValue('financement.fin_remuneration', financement.fin_remuneration) }}
											</p>
											<p v-if="financement.rff"  }}>
												<strong>RFF</strong>
												{{ financement.rff  }}
											</p>
											<p v-if="financement.debut_rff"  }}>
												<strong>Début de la RFF</strong>
												{{ renderValue('financement.debut_rff', financement.debut_rff) }}
											</p>
											<p v-if="financement.fin_rff"  }}>
												<strong>Fin de la RFF</strong>
												{{ renderValue('financement.fin_rff', financement.fin_rff) }}
											</p>
											<p v-if="financement.organisme"  }}>
												<strong>Organisme</strong>
												{{financement.organisme.nom }}
											</p>
										</virtual>
										<p>
											<strong>Règles de gestion</strong>
											<eligibilite conditions={ explain }></eligibilite>
										</p>
									</li>
								</ul>
							<p v-if="!this.financements.length">Aucun financement trouvé.</p>
							<h2>Contexte</h2>
							<context :data="this.context"></context>
							<h2>Scénario de test</h2>
							<textarea @focus="this.selectScenario()" v-model="this.scenario"/>
					</div>
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
				financements: [],
				currentFilter: '',
				context: {},
				scenario: {},
				errors: {},
				tags: {},
				tagsEligibles: {},
				toggled: "",
				url: {}
			}
		},
		methods: {
			load: function () {
			},
			decodeLBFURL: function (url, callback) {				
				this.$http.get('/explore/decode-lbf-url?url='+encodeURIComponent(url))
				.then(callback, this.onError()).created;
			},
			simulate_url: function (url) {
				this.decodeLBFURL(url, this.simulate())
			},
			simulate: function (data,tags = '') {
				if (tags) tags = '&tags=' + tags.toString();
				this.$http.get('/financement?context=1&scenario=1&explain=1' + tags, {
					method: 'post',
					body: JSON.stringify(data)
				}) 
				.then(data => {
					this.financements = data.financements
					this.currentFilter = ''
					if (!tags) {
						var tags = []
						var tagsEligibles = []
					}
					for (var i = 0; i < this.financements.length; i++) {
						if (tags) tags = tags.concat(this.financements[i]['tags'])
						if (tagsEligibles && this.financements[i]['eligible']) tagsEligibles = tagsEligibles.concat(this.financements[i]['tags'])
					}
					if (tags) this.tags = [...new Set(tags).sort()]
					if (tagsEligibles) this.tagsEligibles = [...new Set(tagsEligibles)]
					this.context = data.context
					this.scenario = data.scenario
				}, this.onError()).created;

			},
			onError: function (data) {
				this.errors = data
			},
            toggle: function(){
                this.toggled = !this.toggled
            },
			toggleFailed: function () {

			},
			filter: function (e) {
				var test = e
				return test
			},
			selectScenario: function (e) {
				e.target.select();
			},
			href: function () {
				if(document.cookie == 'mode-expert=1; max-age=43200;') location.reload();
			}
		}
	}
</script>

<style scoped>
	.failed {
		color: #c0392b;
	}
	.sub:before {
		content: '';
	}
	li li {
		padding-left: 10px;
	}
	li ul, li.sub {
		display: inline;
		padding-left: 0;
	}
	.connective {
		color: #222;
		font-style: italic;
	}
</style>