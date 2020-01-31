<template>
  <div id="Rule">
    <div class="mb-5">
      <div class="row mb-3">
        <div  class="col-md-6 col-sm-12 col-xs-12">
          <h5>
            <span  style="vertical-align:-30%" >{{ this.displayedName }}</span>
          </h5>
          <span v-if="this.modification_count">({{ this.modification_count }} modification<span v-if="this.modification_count > 1">s</span> en cours)</span>
        </div>
        <div class="col-md-6 col-sm-12 col-xs-12">
          <h4 v-if="isEditMode" class="pull-right"><em>Modification de la règle</em></h4>
          <input  v-else @click="edit" type="button" class="main-button btn pull-right" value="Soumettre une modification"/>
          <!-- TODO: show gitlab link of modification if exists -->
        </div>
      </div>
      <div v-show="!isEditMode" class="row">
        <div class="col-md-12">
          <span v-html="printRulePath"></span>
        </div>
      </div>
    </div>
    <div v-show="!isEditMode">
      <ul>
        <TreeItem class="item" :item="this.ruleTree" :rootElement="true" :rulePath="this.rulePath"></TreeItem>
      </ul>
    </div>
    <div v-show="isEditMode">
      <div class="container">
        <div class="row mb-3">
          <label for="content"><u>Contenu de la règle</u></label>
          <textarea id="content" v-model="content" rows="15" class="rule-modification-text" :class="{editErrorClass: notModified}"></textarea>
          <span v-if="notModified" class="text-danger font-weight-light">Aucune modification n'a été renseignée</span>
        </div>
        <div class="row mb-3">
          <label for="comment" class="mb-2"><u>Résumé de la modification</u> * </label>
          <textarea id="comment" v-model="comment" rows="3"></textarea>
        </div>
        <div class="row mb-3">
          <div class="col-md-12 pl-0">
            <label for="contributor_email" class="pb-2"><u>Votre email</u> *</label>
          </div>
          <div class="col-md-12 pl-0">
            <input id="contributor_email" v-model="contributor_email" type="text" :class="{editErrorClass: badUser}"/><br>
            <span v-if="badUser" class="text-danger font-weight-light">Cet utilisateur n'est pas autorisé à soumettre des modifications</span>
          </div>
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
    props: ['name', 'data', 'path', 'printRulePath', 'rulePath'],
    data: function(){
      return {
        ruleData: this.data,
        content: '',
        comment: '',
        contributor_email: '',
        auth: '',
        isEditMode: '',
        modification_list: [],
        badUser: false,
        notModified: false,
      }
    },
    computed: {
      displayedName: function () {
        return this.name.split('.')[0];
      },
      modification_count: function () {
        return this.modification_list.length;
      },
      modification_key: function() {
        // TODO récupération de la clé niveau serveur
        return "clé";
      },
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
        this.auth = "";
        this.isEditMode=!this.isEditMode;
      },
      save: function() {
        this.ruleData = this.content
        const postData = {
          author_email:this.contributor_email,
          author_name:this.contributor_email.split("@")[0],
          title: this.displayedName,
          comment: this.comment,
          content: this.content,
          filename: 'trefle/config/rules/' + this.path
        }

        this.$http
          .post('/source/save', postData)
          .then(response => {
            var commit = {}
            commit.url = 'https://beta.pole-emploi.fr/open-source/trefle/commit/' + response.id
            commit.title = response.title
            this.$parent.rules[this.name]['data'] = this.data
            this.$parent.rules[this.name]['gitlab'] = {'commit': commit}
            return this.isEditMode=!this.isEditMode
          }, response => {
              if(response.status == 304){
                this.notModified = true;
                this.badUser = false;
              } 
              else if (response.status == 401) {
                this.badUser = true;
                this.notModified = false;
              }
              return false;
          });
      },
      toTree: function (lines) { // eslint-disable-line no-unused-vars
        var root= new Node(this.name.split('.')[0]);
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
.editErrorClass {
  color: #dc3545;
  border: 1px solid #dc3545;
  border-radius:3px;
}
.rule-modification-text {
  font-family: 'Courier New', Courier, monospace;
}
</style>
