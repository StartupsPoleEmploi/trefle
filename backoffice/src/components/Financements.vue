<template>
	<div id="Financements">
		<h2 class="page-title">
			Liste des types de financements 
			<a href=https://framagit.org/ybon/trefle/tree/master/trefle/config/financements.yml target=_blank>
				<i class="icon" style="vertical-align: baseline;">edit</i>
			</a>
		</h2>
		<dl v-for="financement in this.financements" :key="financement.id">
			<dt>{{ financement.intitule }}</dt>
			<dd v-if="financement.racine.endsWith('.rules')"><strong>Règles racine</strong>: <a :href="'rules/#'+financement.racine">{{ financement.racine }}<i class="icon">arrow_forward</i></a></dd>
			<dd v-else><strong>Règles racine</strong>: {{ financement.racine }}</dd>
			<dd><strong>Catégories</strong>: {{ financement.tags }}</dd>
			<dd v-if="financement.type_lbf"><strong>Type LBF</strong>: {{ financement.type_lbf }}</dd>
			<dd v-if="financement.ressources"><strong>Ressources</strong>:
				<ul>
				<li v-for="ressource in financement.ressources" :key="ressource.id"><a v-bind:href="ressource">{{ ressource }}</a></li>
				</ul>
			</dd>
		</dl>
	</div>
</template>
<script>
	export default {
		name: 'Financements',
		methods: {
			load: function () {
				this.$http.get(process.env.VUE_APP_TREFLE_URL+process.env.VUE_APP_API_VERSION+'/explore/financements').then(response => {
					this.financements = response.body;
				});
			}
		},
		data: function(){
			return {
				financements:[]
			}
		},
		mounted: function () {
			this.load();
		}
	}
</script>
<style>
</style>