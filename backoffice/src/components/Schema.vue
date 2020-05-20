<template>
  <div id="Schema">
    <div id="schema-main-div">
      <div v-if="!this.isLoading">
        <div class="container ml-5 mr-2">
          <div class="row">
            <div :class="classCollapsedMenu">
              <div class="mb-3 pull-right">
                <button @click="collapsed = !collapsed" type="button" class="btn main-button mb-5">
                  <span v-show="collapsed"><span class="chevron-toggle">&#8594;</span>  Ouvrir le panneau</span>
                  <span v-show="!collapsed"><span class="chevron-toggle">&#8592;</span>  Fermer le panneau</span>
                </button>
              </div>
              <div v-show="!collapsed">
                <h2 class="mb-5">Catégories</h2>
                <ul>
                  <li v-for="(category_value, id) in categories" :key="id">
                    <a href="#" :class="{selected: category==id}" @click="setCategory(id);">
                      {{ category_value.charAt(0).toUpperCase() + category_value.slice(1) }}
                    </a>
                  </li>
                </ul>
              </div>
            </div>
            <div v-show="!collapsed" :class="classCollapsedSeparator">
              <hr class="schema-vertical-separator">
            </div>
            <div :class="classCollapsedContent">
              <div v-if="this.show">
                <h2 class="mb-5">{{ this.categories[category] }} </h2>
                <dl v-for="(schema_row,id) in this.filteredSchema" :key="id">
                  <dt v-if="schema_row.label"> {{schema_row.label.charAt(0).toUpperCase() + schema_row.label.slice(1)}} <a :href="'#schema/'+id" class=anchor>#</a></dt>
                  <dt v-else> {{ schema_row.description }} <a :href="'#schema/'+id" class=anchor>#</a></dt>
                  <dd v-if="schema_row.value"><strong>Valeur constante :</strong> {{ formatValue(schema_row.value) }}</dd>
                  <dd v-if="schema_row.description"><strong>Description :</strong> {{schema_row.description}}</dd>
                  <dd v-if="schema_row.source"><strong>Source :</strong> {{schema_row.source}}</dd>
                  <dd v-if="schema_row.xpath"><strong>LHEO :</strong> {{schema_row.xpath}}</dd>
                  <dd v-if="schema_row.url"><strong>Ressource externe :</strong> <a :href="schema_row.url">{{ schema_row.url }}</a></dd>
                  <dd v-if="schema_row.enum">
                    <strong>Valeurs possibles</strong>
                    <ul>
                      <li v-for="(enum_label, enum_key) in schema_row.enum" :key="enum_key">{{ enum_key }} : {{ enum_label }}</li>
                    </ul>
                  </dd>
                  <dd><strong>Clé interne :</strong> {{ id }}</dd>
                  <dd><strong>Type interne :</strong> {{ schema_row.type }}</dd>
                </dl>
              </div>
              <div v-else>
                <h2>Sélectionnez une catégorie dans le menu.</h2>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div v-else class="text-center loading-gif">
        <img src="./../assets/images/loading.gif" alt="loading...">
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'Schema',
    data : function () {
      return {
        isLoading: true,
        schema: {},
        category: "",
        categories: {
          aide: 'Propriétés d\'aides',
          constante: 'Propriétés constantes',
          beneficiaire: 'Propriétés du bénéficiaire',
          formation: 'Propriétés de la formation',
          financement: 'Propriétés du financement',
          remuneration: 'Propriétés de rémunération',
        },
        collapsed: false,
      }
    },
    computed: {
      show: function () {
        return this.category != ""
      },
      classCollapsedContent: function () {
        if(this.collapsed) return "col-md-12 col-sm-12 col-xs-12";
        return "col-md-8 col-sm-12 col-xs-12";
      },
      classCollapsedMenu: function () {
        if(this.collapsed) return "col-md-0 col-sm-0 col-xs-0";
        return "col-md-3 col-sm-12 col-xs-12";
      },
      classCollapsedSeparator: function () {
        if(this.collapsed) return "col-md-0 col-sm-0 col-xs-0";
        return "col-md-1 col-sm-0 col-xs-0";
      },
      filteredSchema: function () {
        var filteredSchema = [];
        if (this.show) {
          for(var i=0; i< Object.keys(this.schema).length; i++) {
            var schema_value = Object.keys(this.schema)[i];
            if (schema_value.split('.')[0]==this.category) filteredSchema.push(this.schema[schema_value]);
          }
        }
        return filteredSchema
      }
    },
    mounted: function () {
      this.load();
    },
    methods: {
      load : function () {
        this.$http.get('/explore/schema').then(response => {
          this.schema = response.body;
          this.isLoading=false;
        });
      },
      setCategory: function (category) {
        this.category = category;
      },
      formatValue: function (value) {
        if (Array.isArray(value)) return value.join(', ')
        return value
      }
    }
  }
</script>

<style scoped>
  #schema-main-div {
    padding-top: 3rem;
  }
  .schema-vertical-separator {
    border:         none;
    border-left:    1px solid #bfbfbf;
    height:         95%;
    width:          1px;
  }
  .selected {
    font-weight: bold;
  }
  .anchor {
    font-weight: normal;
    font-style: italic;
  }
  dl:target {
    background-color: #ddd;
  }
  dt {
    font-weight: bolder;
  }
  dt em {
    font-variant: normal;
  }
  dl {
    margin-top: 10px;
    font-size: 1.1em;
    padding: 5px;
  }
  dl:nth-child(even) {
    background: #f3f3f3;
  }
  dd {
    padding-left: 2.5rem;
  }
</style>
