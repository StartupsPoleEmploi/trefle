<template>
  <div id="SimulateurContext">
    <br>
    <table class="table-responsive table table-striped table-hover">
      <caption> Contexte de simulation </caption>
      <thead>
        <tr>
          <th>Nom</th>
          <th>Valeur</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(value, key) in this.context" :key="key">
          <td> {{ renderLabel(key) }} </td>
          <td> {{ renderValue(key,value,schema[key]) }} </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
  export default {
		name: 'SimulateurContext',		
    props: ['schema', 'context',],
    data: function () {
      return {
        test: [],
      }
    },
    methods: {
      renderValue: function (key, value, schema_tmp) {
        schema_tmp = schema_tmp || this.schema[key]
        if (schema_tmp['type'] === 'array') return value.map(v => this.renderValue(key, v, schema_tmp['items'])).join(', ')
        if (schema_tmp['type'] === "boolean") return value ? 'oui' : 'non'
        if (schema_tmp['format'] === 'date') return (new Date(value * 1000)).toLocaleDateString()
        if (schema_tmp['enum']) return schema_tmp === undefined ? schema_tmp['enum'][value]+' ('+value+')' : ''
        return value
      },
      renderLabel: function (key) {
        return this.schema[key]['label'].charAt(0).toUpperCase() + this.schema[key]['label'].slice(1)
      }
    }

  }
</script>

<style  scoped>

  td {
    width: 50%;
    max-width:50%;
  }

  table{
    width:100%;
    table-layout:fixed;
  }
</style>
