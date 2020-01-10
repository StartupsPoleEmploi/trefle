<template>
  <div id="Rule">
    <h2> {{ this.name.toUpperCase() }}</h2>
    <br>
    <pre v-html="transform(this.data)"/>
  </div>
</template>
<script>
  export default {
    name: 'Rule',
    props: ['name', 'data'],
    methods: {
      transform: function(data) {
        return data.replace(/Si /g, '<strong>Si </strong>')
          .replace(/Soit /g, '<strong>Soit </strong>')
          .replace(/Quand /g, '<strong>Quand </strong>')
          .replace(/Scénario: /g, '<strong>Scénario: </strong>')
          .replace(/Ou /g, '<strong>Ou </strong>')
          .replace(/, ou /g, '<strong>, ou </strong>')
          .replace(/Et /g, '<strong>Et </strong>')
          .replace(/, et /g, '<strong>, et </strong>')
          .replace(/Alors /g, '<strong>Alors </strong>')
          .replace(/(#.+)/g, "<em class=\"comment\">$1</em>")
          .replace(/appliquer les règles «([^»]+?)(.rules)?»/g, 'appliquer les règles «<a href="#$1.rules" title="Ouvrir les règles"><i class="icon">arrow_forward</i> $1</a>»')
          .replace(/(«.+»)/g, "<span class=\"string\">$1</span>")
          .replace(/,([^ ])/g, ", $1");
      }
    }
  }
</script>
<style scoped>

  pre strong {
    font-family: 'mono';
    font-weight: bold;
  }
  pre .comment {
    font-family: 'mono';
    font-style: italic;
    color: #666;
  }
  pre .keyword {
    font-family: 'mono';
    font-weight: 600;
  }
  pre .constant {
    font-family: 'mono';
    font-weight: 600;
    text-decoration: underline dotted;
    cursor: help;
  }
  pre a,
  pre .string,
  pre .number {
    font-family: 'mono';
    font-weight: 600;
  }
  pre code {
    display: block;
    padding-left: 1em;
    font-family: mono;
  }
  a.line {
    display: none;
  }
  :scope.with-lines a.line {
    display: inline-block;
    background-color: #ddd;
    cursor: pointer;
    text-align: center;
    vertical-align: middle;
  }
  :scope.with-lines a:target, :scope.with-lines a:target + code {
    font-weight: bold;
    background-color: #ccc;
  }
  :scope.with-lines pre {
    display: grid;
    grid-template-columns: 2em auto;
  }
  .tooltip .tooltip-content:after {
    /* Why? */
    bottom: -27px;
  }
</style>
