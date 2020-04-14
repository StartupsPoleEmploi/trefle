<template>
  <div id="SimulateurExplain">
    <br>
    <pre> {{ this.financements }} </pre>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurExplain',		
    props: ['', 'financements'],
    computed : {
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
