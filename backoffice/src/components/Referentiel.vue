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
                  <!-- pre>{{ this.ruleToShow.data }}</pre -->

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
  import TreeItem from './TreeItem.vue';

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
      TreeItem
    },
    methods: {
      load: function () {
        this.$http.get('/explore/rules').then(response => {
        this.rules = response.body;
        this.isLoading = false;
        }).created;
      },
      toTree: toTree,
      makeFolder: function (item) {
        this.$set(item, 'children', [])
        this.addItem(item)
      },
      addItem: function (item) {
        item.children.push({
          name: 'new rule'
        });
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
      },
      ruleTree: function() {
        if(this.show) {
          return this.toTree(this.rules[this.windowLocationHash.split('#')[1]]['data'].split('\n'));
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
