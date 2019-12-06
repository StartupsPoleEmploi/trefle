<template>
	<div id="Referentiel">
		<div id="ref-main-div">
			<div v-if="!this.isLoading">
				<div id="ref-header-row">
					<div class="container">
						<div class="row">
							<div class="col-md-4">	
								<br>							
								<RulesMenu title="Règles régionales" namespace="région"></RulesMenu>
								<RulesMenu title="Règles nationales" namespace="règles nationales"></RulesMenu>
								<RulesMenu title="Règles des organismes paritaires" namespace="organisme paritaire"></RulesMenu>
								<RulesMenu title="Règles de rémunérations" namespace="rémunération"></RulesMenu>
								<RulesMenu title="Règles de normalisation" namespace="normalisation"></RulesMenu>
							</div>
							<div class="col-md-8">
								<div v-if="this.show">
									<br>
									<h4> {{ this.ruleToShow.name }}</h4>
									<br>
									<pre>{{ this.ruleToShow.data }}</pre>
								</div>
								<div v-else>
									<br>
									<h4>Sélectionnez une règle.</h4>
									<br>									
								</div>
							</div>
						</div>				
					</div>
				</div>
			</div>
			<div v-else class="text-center">
				<img src="./../assets/images/loading.gif" align="center" alt="loading...">
			</div>
		</div>
	</div>
</template>
<script>
	import RulesMenu from './RulesMenu.vue'

	export default {
		name: 'Referentiel',
		components: {
			RulesMenu
		},
		methods: {
			load: function () {
				this.$http.get('/explore/rules').then(response => {
					this.rules = response.body;
					this.isLoading = false;
				}).created;
			}
		},
		computed: {
			show: function () {
				return (this.windowLocationHash !== '')
			},
			ruleToShow: function() {
				if(this.show) {		
					return this.rules[this.windowLocationHash.split('#')[1]];
				} return null;
			}
		},
		data: function(){
			return {
				rules:[],
				isLoading: true,
				windowLocationHash: decodeURI(window.location.hash)
			}
		},
		created: function () {
			this.load();
			window.addEventListener('popstate', () => {
				this.windowLocationHash = decodeURI(window.location.hash);
			})
		},
	}
</script>
<style>
    :scope.tools {
      min-width: 1200px;
      grid-template-columns: 1fr 4fr;
    }
    h3 {
      font-variant: small-caps;
    }
</style>
