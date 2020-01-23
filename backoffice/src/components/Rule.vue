<template>
  <div id="Rule">
    <div class="mb-5">
      <div class="row">
        <div  class="col-md-6 col-sm-12 col-xs-12">
          <h4>
            <span>{{ this.name }}</span>
          </h4>
        </div>
        <div class="col-md-6 col-sm-12 col-xs-12">
          <h4 v-show="isEditMode" class="pull-right"><em>Édition de la règle</em></h4>
          <input  v-show="!isEditMode" @click="edit" type="button" class="btn btn-outline-success pull-right" value="Soumettre une modification"/>
          <!-- TODO: show gitlab link of modification if exists -->
        </div>
      </div>
    </div>
    <div v-show="!isEditMode">
      <!-- the demo root element -->
      <ul id="demo">
        <TreeItem class="item" :item="this.ruleTree"></TreeItem>
      </ul>
    </div>
    <div v-show="isEditMode">
      <!-- rule-editor ref="editor" :rawRule="ruleToEdit"></rule-editor -->
      <div class="container">
        <div class="row mb-3">
          <label for="comment" class="mb-2"><u>Résumé de la modification</u></label>
          <textarea v-model="comment"></textarea>
        </div>
        <div class="row mb-3">
          <label for="content"><u>Contenu de la règle</u></label>
          <textarea v-model="content" class="mb-3"></textarea>
        </div>
        <div class="row mb-3">
          <div class="col-md-6 pl-0">
            <input @click="closeEdit" type="button" class="btn btn-outline-danger pull-left" value="Annuler"/>
          </div>
          <div class="col-md-6 pr-0">
            <input @click="save" type="button" class="btn btn-outline-success pull-right" value="Enregistrer"/>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>
<script>
  import TreeItem from './TreeItem.vue';

  function Node(name) {
    this.name = name;
    this.parent = null;
    this.children = [];
  }

  export default {
    name: 'Rule',
    components: {
      TreeItem,
    },
    props: ['name', 'data'],
    data: function(){
      return {
        ruleData: this.data,
        content: '',
        comment: '',
        isEditMode: false,
      }
    },
    computed: {
      ruleTree: function() {
        return this.toTree(this.ruleData.split('\n'));
      },
      ruleToEdit: function() {
        return this.ruleData;
      },
    },
    methods: {
      edit: function () {
        this.content = this.ruleToEdit;
        this.isEditMode=!this.isEditMode;
      },
      closeEdit: function () {
        this.content = this.ruleToEdit;
        this.comment = "";
        this.isEditMode=!this.isEditMode;
      },
      save: function() {
        this.ruleData = this.content
        const postData = {
          title: this.name,
          comment: this.comment,
          content: this.content,
          filename: 'trefle/config/rules/' + this.data.path
        }

        this.$http
          .post('/source/save', postData)
          .then(response => {
              var commit = {}
              commit.url = 'https://beta.pole-emploi.fr/open-source/trefle/commit/' + response.id
              commit.title = response.title
              this.rules[this.activeRuleName]['data'] = this.data
              this.rules[this.activeRuleName]['gitlab'] = {'commit': commit}
              return this.isEditMode=!this.isEditMode
          });
      },
      toTree: function (lines) { // eslint-disable-line no-unused-vars
        var root= new Node('Règle');
        var currentIndent=-1;
        var currentNode=root;
        // we scan the rules line by line
        for (var i=0;i<lines.length;i++) {
          var line=lines[i];
          if (line.match(/^\s*$/)) continue; // Empty line, skip
          var indent=line.search(/\S|$/); // number of indenting spaces
          var newNode= new Node(line.trim());
          if (indent>currentIndent) { // New child
            // Set the new node parent
            newNode.parent=currentNode;
            // attach the new node to its parent
            currentNode.children.push(newNode);
            // Set the new current node
            currentNode=newNode;
            currentIndent=indent;
          } else if (indent<currentIndent){
            // Move up in the tree
            var level=currentIndent-indent;
            for (var j=0;j<level/4;j++) {
              // up one level
              currentNode=currentNode.parent;
              currentIndent=currentIndent-4;
            }
            newNode.parent=currentNode.parent;
            currentNode.parent.children.push(newNode); // Add a sibbling
            currentNode=newNode;
          } else {
            // Add as sibbling
            newNode.parent=currentNode.parent;
            currentNode.parent.children.push(newNode);
            currentNode=newNode;
          }
        }
        return root;
      }
    },
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
