<template>
  <div id="SimulateurScenario">
    <br>
    <pre v-html="this.transformed_scenario"/>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurScenario',
    props: ['', 'scenario'],
    computed : {
      /*plainExplanation : function () {
        for (var condition in this.explain) {
          condition
        }
      }*/
      transformed_scenario: function() {
        return this.scenario
          .replace(/Scénario: Donne-moi un nom/g, 'Scénario :\n')
          .replace(/Si /g, '<span class="bold text-dark">Si </span>')
          .replace(/ {4}Soit /g, '<span class="bold text-dark">Soit </span>')
          .replace(/Quand /g, '<span class="bold text-dark">\nQuand </span>')
          .replace(/Scénario: /g, '<span class="bold text-dark">Scénario: </span>')
          .replace(/Ou /g, '<span class="bold text-dark">Ou </span>')
          .replace(/, ou /g, '<span class="bold text-dark">, ou </span>')
          .replace(/Et /g, '<span class="bold text-dark">Et </span>')
          .replace(/, et /g, '<span class="bold text-dark">, et </span>')
          .replace(/Alors /g, '<span class="bold text-dark">Alors </span>')
          .replace(/vaut/g, '<u>vaut</u>')
          .replace(/' {4}'/g,'&nbsp&nbsp')
          .replace(/(«.+»)/g, "<span class=\"string\">$1</span>")
          .replace(/,([^ ])/g, ", $1");
      },
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
</style>
