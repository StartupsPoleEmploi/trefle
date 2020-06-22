<template>
  <div id="Eligibilite">
    <ul>
      <li v-for="(props, id) in this.conditions" :key="id" :class="{passed: props.status, failed: !props.status}">
        <span v-html="transformData(props.condition)"/>
        <span v-if="props.children">
          <eligibilite :conditions="props.children"/>
        </span>
      </li>
    </ul>
  </div>
</template>
<script>
  export default {
		name: 'Eligibilite',
    props: ['conditions', 'schema'],
    methods: {
      transformData: function (data) {
        return data
          .replace(/Ou /g, '<span style="font-style: italic">&nbsp;Ou&nbsp; </span>')
          .replace(/OU /g, '<span style="font-style: italic">&nbsp;OU&nbsp; </span>')
          .replace(/, ou /g, '<span style="font-style: italic">&nbsp;, ou&nbsp; </span>')
          .replace(/Et /g, '<span style="font-style: italic">&nbsp;Et&nbsp; </span>')
          .replace(/ET /g, '<span style="font-style: italic">&nbsp;ET&nbsp; </span>')
          .replace(/, et /g, '<span style="font-style: italic">&nbsp;, et&nbsp; </span>');
      }
    }
  }
</script>

<style scoped>
  .failed:before {
    content: '✗';
    color: crimson;
  }
  .passed:before {
    content: '✔';
    color: forestgreen;
  }
  li li {
    padding-left: 1.5rem;
  }
  li ul, li.sub {
    display: inline;
    padding-left: 0;
  }
  .connective {
    font-style: italic !important;
  }
</style>