<template>
  <div id="SimulateurContext">
    <br>
    <label for="filterContext">
      <strong>
        Filtrer les entrées du tableau :
      </strong>
    </label>
    <br>
    <input class="form-control" type="text" id="filterContext" name="filterContext" v-model="filterContext" placeholder="Filtre..."/>
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
        <tr v-for="(value, key) in this.filteredContext" :key="key">
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
        filterContext: "",
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
      },
    },
    computed: {
      filteredContext : function () {
        if (this.filterContext == "") return this.context;
        else {
          return Object.keys(this.context)
            .filter(key => this.renderLabel(key).toLowerCase().includes(this.filterContext.toLowerCase()))
            .reduce((obj, key) => {
              obj[key] = this.context[key];
              return obj;
            }, {});
        }
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
