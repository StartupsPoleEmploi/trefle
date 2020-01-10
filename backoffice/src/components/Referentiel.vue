<template>
  <div id="Referentiel">
    <div id="referentiel-main-div">
      <div v-if="!this.isLoading">
        <div id="referentiel-main-row">
          <div class="container">
            <div class="row">
              <div class="col-md-4">
                <h2>MENU</h2>
                <br>
                <RulesMenu title="Règles régionales" namespace="région" class="rules-menu"></RulesMenu>
                <RulesMenu title="Règles nationales" namespace="règles nationales" class="rules-menu"></RulesMenu>
                <RulesMenu title="Règles des organismes paritaires" namespace="organisme paritaire" class="rules-menu"></RulesMenu>
                <RulesMenu title="Règles de rémunérations" namespace="rémunération" class="rules-menu"></RulesMenu>
                <RulesMenu title="Règles de normalisation" namespace="normalisation" class="rules-menu"></RulesMenu>
              </div>
              <div class="col-md-1">
                <hr class="referentiel-vertical-separator">
              </div>
              <div class="col-md-7">
                <div v-if="this.show">
                  <br>
                  <h4> {{ this.ruleToShow.name }}</h4>
                  <br>
                  <div v-show="this.isEditMode">
                    <rule-editor ref="editor" :rawRule="ruleToEdit"></rule-editor>
                    <button @click="save">Enregistrer</button>
                    <!-- pre>{{ this.ruleToShow.data }}</pre -->
                  </div>
                  <div v-show="!this.isEditMode">
                    <button @click="edit">Edit</button>
                    <!-- the demo root element -->
                    <ul id="demo">
                    <tree-item
                                class="item"
                                :item="ruleTree"
                                @make-folder="makeFolder"
                                @add-item="addItem"
                    ></tree-item>
                    </ul>
                  </div>
                </div>
                <div v-else>
                  <h2>Sélectionnez une règle.</h2>
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
  import TreeItem from './TreeItem.vue';
  import RuleEditor from './RuleEditor.vue';

  function Node(name) {
    this.name = name;
    this.parent = null;
    this.children = [];
  }

function toTree(lines) { // eslint-disable-line no-unused-vars
  //var lines=rules['Guyane.rules']['data'].split('\n');
  //var lines=rules['Auvergne-Rhône-Alpes.rules']['data'].split('\n');
  var root= new Node('Règle');

  var currentIndent=-1;
  var currentNode=root;

  // we scan the rules line by line
  for (var i=0;i<lines.length;i++) {
    var line=lines[i];

    if (line.match(/^\s*$/)) continue; // Empty line, skip

    var indent=line.search(/\S|$/); // number of indenting spaces
    //debugger;

    var newNode= new Node(line.trim());

    if (indent>currentIndent) { // New child
      // Set the new node parent
      newNode.parent=currentNode;

      // attach the new node to its parent
      currentNode.children.push(newNode);

      // Set the new current node
      currentNode=newNode;

      currentIndent=indent;
      //debugger;
    } else if (indent<currentIndent){
      // Move up in the tree
      var level=currentIndent-indent;

      for (var j=0;j<level/4;j++) {
        // up one level
        //debugger;
        currentNode=currentNode.parent;
        //debugger;
        currentIndent=currentIndent-4;
        //debugger;
      }

      newNode.parent=currentNode.parent;
      currentNode.parent.children.push(newNode); // Add a sibbling
      currentNode=newNode;
      //debugger;
    } else {
      // Add as sibbling
      newNode.parent=currentNode.parent;
      currentNode.parent.children.push(newNode);
      currentNode=newNode;
      //debugger;
    }
  }
  return root;
}

  export default {
    name: 'Referentiel',
    components: {
      RulesMenu,
      TreeItem,
      RuleEditor
    },
    methods: {
      load: function () {
        this.$http.get('/explore/rules').then(response => {
          this.rules = response.body;
          this.isLoading = false;
        }).created;
      },
      toTree: toTree,
      edit: function () {
        return this.isEditMode=!this.isEditMode
      },
      save: function() {
        this.currentRuleContent = this.$refs.editor.content
        this.rules[this.getActiveRuleName()]['data'] = this.currentRuleContent
        return this.isEditMode=!this.isEditMode
      },
      getActiveRuleName: function() {
        return this.windowLocationHash.split('#')[1]
      }
      //makeFolder: function (item) {
      //  this.$set(item, 'children', [])
      //  this.addItem(item)
      //},
      //addItem: function (item) {
      //  item.children.push({
      //    name: 'new rule'
      //  });
      //}
    },
    computed: {
      show: function () {
        return (this.windowLocationHash !== '')
      },
      ruleToShow: function() {
        if(this.show) {
          return this.rules[this.getActiveRuleName()];
        } return null;
      },
      ruleTree: function() {
        if(this.show) {
          return this.toTree(this.currentRuleContent.split('\n'));
        } return null;
      },
      ruleToEdit: function() {
        if(this.show) {
          return this.currentRuleContent;
        } return null;
      }
    },
    data: function(){
      return {
        rules: [],
        currentRuleContent: '',
        updatedRule: '',
        isLoading: true,
        isEditMode: false,
        windowLocationHash: decodeURI(window.location.hash)
      }
    },
    created: function () {
      this.load();
      window.addEventListener('popstate', () => {
        this.windowLocationHash = decodeURI(window.location.hash);
        if(this.windowLocationHash !== '')
          this.currentRuleContent = this.rules[this.getActiveRuleName()]['data']
          this.isEditMode = false
      })
    },
  }

</script>

<style>
  #referentiel-main-row {
    padding-top: 3rem;
  }
  .referentiel-vertical-separator {
    border:         none;
    border-left:    1px solid #bfbfbf;
    height:         100%;
    width:          1px;
  }
</style>
