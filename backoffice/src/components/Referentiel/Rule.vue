<template>
  <div id="Rule">
    <div v-if="!isLoading">
      <div class="mb-5">
        <div class="row mb-3">
          <div  class="col-md-6 col-sm-12 col-xs-12">
            <h5>
              <span style="vertical-align:-30%" >{{ displayedName }}</span>
            </h5>
            <div v-if="this.modifiedHashFlag">
              <a :href="'#'+name" v-if="this.modification_count" @click="displayList()" id="modification_link">Voir la règle</a>
            </div>
            <div v-else>
              <a :href="'#'+name+'#modified'" v-if="this.modification_count" @click="displayModification()" id="modification_link">({{ this.modification_count }} modification<span v-if="this.modification_count > 1">s</span> en cours)</a>
            </div>
          </div>
          <div class="col-md-6 col-sm-12 col-xs-12">
            <h4 v-if="isEditMode" class="pull-right"><em>Modification de la règle</em></h4>
            <input v-else-if="this.modifiedHashFlag | this.newModification" v-b-modal.auth-modal type="button" class="main-button-primary btn pull-right" value="Soumettre une modification"/>
            <!-- TODO: show gitlab link of modification if exists -->
            <div v-else v-show="ruleComment != ''">
              <span class="float-right" data-toggle="collapse" data-target="#rule-comment" aria-expanded="false" aria-controls="explain" style="cursor:pointer;" v-on:click="ruleCommentToggled=!ruleCommentToggled">
                <button v-if="!ruleCommentToggled" class="btn main-button">Consulter la note de bas de page</button>
                <button v-else class="btn main-button">Masquer la note</button>
              </span>
            </div>
          </div>
        </div>
        <div v-show="!isEditMode" class="row">
          <div class="col-md-12">
            <span v-html="printRulePath"></span>
          </div>
        </div>
      </div>
      <div v-if="viewModification">
        <ul v-for="modification in modification_list" :key="modification.id">
          <Modification :modification="modification"/>
        </ul>
      </div>
      <div v-show="!isEditMode && !viewModification">
        <div v-show="ruleComment != ''">
          <div id="rule-comment" class="mt-3 card collapse">
            <div class="card-body">
              <pre id="rule_comment_pre" v-html="this.ruleComment"></pre>
            </div>
          </div>
        </div>
        <ul class="mt-5">
          <TreeItem class="item" :item="this.ruleTree" :rootElement="true" :rulePath="this.rulePath"></TreeItem>
        </ul>
      </div>
      <div v-show="isEditMode">
        <div v-if="content!=null">
          <div class="container">
            <div class="row mb-3">
              <div class="col-md-6 pl-0">
                <input @click="closeEdit" type="button" class="btn btn-outline-danger pull-left" value="Annuler"/>
              </div>
              <div class="col-md-6 pr-0">
                <button v-b-modal.mail-modal class="btn main-button-primary pull-right">Enregistrer</button>
              </div>
            </div>
            <div class="row mb-3">
              <label for="content"><u>Contenu de la règle</u></label>
              <TextAreaAutosize id="content" v-model="content" class="rule-modification-text" :class="{editErrorClass: error_flags.notModified }" v-focus/>
              <span v-if="error_flags.notModified" class="text-danger font-weight-light">Aucune modification n'a été renseignée</span>
            </div>
            <div class="row mb-3">
              <div class="col-md-6 pl-0">
                <input @click="closeEdit" type="button" class="btn btn-outline-danger pull-left" value="Annuler"/>
              </div>
              <div class="col-md-6 pr-0">
                <button v-b-modal.mail-modal class="btn main-button-primary pull-right">Enregistrer</button>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="text-center loading-gif">
          <img src="@/assets/images/loading.gif" alt="loading...">
        </div>
        <b-modal id="auth-modal" title="Authentifiez-vous pour soumettre une modification">
          <label for="contributor_email" class="pb-2"><u>Votre email</u> *</label><br>
          <input id="contributor_email" v-model="auth.email" type="text" :class="{editErrorClass: (error_flags.badUser || error_flags.noUser)}" class="form-control" style="border: 1px solid #bfbfbf; border-radius: 2px;"/><br>
          <span v-if="error_flags.noUser" class="mt-0 text-danger font-weight-light">Ce champ est obligatoire</span><br>
          <label for="contributor_passwd" class="pb-2"><u>Votre mot de passe</u> *</label><br>
          <input id="contributor_passwd" v-model="auth.password" type="password" :class="{editErrorClass: (error_flags.badUser || error_flags.noPass)}" class="form-control" style="border: 1px solid #bfbfbf; border-radius: 2px;"/><br>
          <span v-if="error_flags.badUser" class="text-danger font-weight-light">Cet utilisateur n'est pas autorisé à soumettre des modifications<br></span>
          <span v-if="error_flags.noPass" class="text-danger font-weight-light">Ce champ est obligatoire<br></span>
          <span v-if="!error_flags.noUser && !error_flags.noPass" class="font-weight-light">* Champs obligatoires<br></span>
          <template v-slot:modal-footer>
            <input @click="auth_to_edit" type="button" class="btn main-button-primary pull-right" value="Suivant"/>
          </template>
        </b-modal>

        <b-modal id="mail-modal" title="Soumettre votre modification">
          <label for="modificationComment" class="mb-2"><u>Résumé de la modification</u> * </label>
          <textarea id="modificationComment" v-model="modificationComment" :class="{editErrorClass: error_flags.noResume}" rows="3"></textarea>
          <span v-if="error_flags.noResume" class="text-danger font-weight-light">Ce champ est obligatoire</span>
          <span v-if="!error_flags.noUser && !error_flags.noResume" class="font-weight-light">* Champ obligatoire</span>
          <template v-slot:modal-footer>
            <input @click="save" type="button" class="btn main-button-primary pull-right" value="Enregistrer"/>
          </template>
        </b-modal>

      </div>
    </div>
    <div v-else class="text-center loading-gif">
      <img src="@/assets/images/loading.gif" alt="loading...">
    </div>
  </div>
</template>
<script>
  import TreeItem from './TreeItem.vue';
  import Modification from './Modification.vue';
  import TextAreaAutosize from "./TextAreaAutosize.vue";

  function Node(name) {
    this.name = name;
    this.parent = null;
    this.children = [];
  }

  export default {
    name: 'Rule',
    components: {
      TreeItem,
      Modification,
      TextAreaAutosize
    },
    props: ['name', 'data', 'path', 'printRulePath', 'rulePath', 'ruleComment'],
    data: function(){
      return {
        windowLocationHash: '',
        modifiedHashFlag: decodeURI(window.location.hash).split('#').pop() == "modified",
        isLoading: true,
        ruleCommentToggled: false,
        ruleData: this.data,
        modification_list: {},
        commit_id: '',
        content: null,
        modificationComment: '',
        filename: 'trefle/config/rules/' + this.path,
        isEditMode: '',
        viewModification: false,
        auth: {
          email: '',
          password: '',
          file: this.path
        },
        error_flags: {
          badUser: false,
          notModified: false,
          noUser: false,
          noPass: false,
          noResume: false,
        },
      }
    },
    watch: {
      isEditMode: function () {
        this.$parent.isEditMode=this.isEditMode;
      }
    },
    computed: {
      displayedName: function () {
        return this.name.split('.')[0];
      },
      modification_count: function () {
        return Object.keys(this.modification_list).length;
      },
      ruleTree: function() {
        return this.toTree(this.ruleData.split('\n'));
      },
      ruleToEdit: function() {
        return this.ruleData;
      },
      newModification: function() {
        return Boolean(!this.modification_count)
      }
    },
    directives: {
      focus: {
        inserted: function (el) {
          el.focus();
        },
      }
    },
    created: function() {
      this.loadInProgressModification();
      this.updateLayout();
      window.addEventListener('popstate', () => {
        this.updateLayout();
      })
    },
    methods: {
      preventScrolling: function (e) {
        e.preventDefault();
      },
      updateLayout: function() {
        this.windowLocationHash = decodeURI(window.location.hash);
        this.modifiedHashFlag = decodeURI(window.location.hash).split('#').pop() == "modified";
        if (this.modifiedHashFlag) {
          this.currentRuleName = decodeURI(window.location.hash).split('#')[1];
          this.displayModification();
        } else {
          this.currentRuleName = decodeURI(window.location.hash).split('#').pop();
          this.viewModification = false;
        }
      },
      loadInProgressModification: function () {
        this.$http
          .get('/source/modified?branch='+encodeURIComponent(this.displayedName))
          .then(response => {
            this.modification_list = response.body;
            if(Object.keys(this.modification_list).length) this.commit_id = this.modification_list[Object.keys(this.modification_list)[0]].id;
            this.isLoading = false;
            return true;
          }, response => {
            if(response.status == 500) this.modification_list = {};
            return false;
          })
      },
      getContentRule: function(){
        if(this.commit_id) {
          let data_param = {
            'file': this.filename,
            'commit_id': this.commit_id,
          }
          this.$http
            .get('/source/file', {params: data_param})
            .then(response => {
              this.content = response.body;
              return true;
            }, response => {
              if(response.status == 500) this.content = '';
              return false;
            })
         } else this.content = this.ruleData;
      },
      auth_to_edit: function () {
        this.error_flags.noUser = false;
        this.error_flags.noPass = false;

        if (this.auth.email== '' ) this.error_flags.noUser = true;
        if (this.auth.password== '' ) {
          this.error_flags.noPass = true;
          return false;
        }
        this.$http
          .post('/authentification', this.auth)
          .then(() => {
            this.viewModification = false;
            this.$parent.collapsed = true;
            this.getContentRule();
            this.isEditMode=!this.isEditMode;
            this.$bvModal.hide("auth-modal");
          }, error => {
            if (error.status == 401) {
              this.error_flags.badUser = true;
              this.error_flags.noUser = false;
              this.error_flags.noResume = false;
            }
            else if (error.status == 400) {
              if (error.body.args == "`user` est vide") {
                this.error_flags.noUser = true;
                this.error_flags.badUser = false;
              } else if (error.body.args == "`pass` est vide") {
                this.error_flags.noResume = true;
                this.error_flags.noUser = false;
              }
              this.error_flags.badUser = false;
            }
          });
      },
      closeEdit: function () {
        this.content = this.ruleToEdit;
        this.modificationComment = "";
        this.auth = {
          email: '',
          password: '',
          file: this.path
        };
        this.isEditMode=false;
        if(this.modification_count!=0) this.viewModification = true;
        this.error_flags = {
          badUser: false,
          notModified: false,
          noUser: false,
          noPass: false,
          noResume: false,
        };
      },
      save: function() {
        this.$parent.isLoading = true;
        this.$parent.modificationInProgress = true;
        this.ruleData = this.content
        if (this.modificationComment == '') {
          this.error_flags.noResume = true;
          return false;
        }
        let commitId = (this.commit_id != '') ? {"commit_id" : this.commit_id} : {}
        const prePostData = {
          author_email:this.auth.email,
          author_name:this.auth.email.split("@")[0],
          title: this.displayedName,
          comment: this.modificationComment,
          content: this.content,
          filename: this.filename
        }
        let postData = {...prePostData, ...commitId}


        this.$http
          .post('/source/save', postData)
          .then(response => {
            var commit = {}
            commit.url = 'https://beta.pole-emploi.fr/open-source/trefle/commit/' + response.id
            commit.title = response.title
            this.$parent.rules[this.name]['data'] = this.data
            this.$parent.rules[this.name]['gitlab'] = {'commit': commit}
            this.$bvModal.hide("mail-modal");
            return this.isEditMode=!this.isEditMode
          }, error => {
              if(error.status == 304) {
                this.error_flags.notModified = true;
                this.error_flags.noUser = false;
                this.error_flags.noResume = false;
                this.error_flags.badUser = false;
                this.$bvModal.hide("mail-modal");
              }
              else if (error.status == 401) {
                this.error_flags.badUser = true;
                this.error_flags.noUser = false;
                this.error_flags.notModified = false;
                this.error_flags.noResume = false;
              }
              else if (error.status == 400) {
                if (error.body.args == "`author_email` est vide") {
                  this.error_flags.noUser = true;
                  this.error_flags.badUser = false;
                } else if (error.body.args == "`modificationComment` est vide") {
                  this.error_flags.noResume = true;
                  this.error_flags.noUser = false;
                }
                this.error_flags.badUser = false;
                this.error_flags.notModified = false;
              }
              return false;
          })
          .then(()=> {
            this.$parent.isLoading = false;
            this.$parent.modificationInProgress = false;
            location.reload();
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
      },
      displayModification: function () {
        this.viewModification = true;
        this.$parent.collapsed = true;
        this.isEditMode = false;
      },
      displayList: function () {
        if(this.isEditMode == true)
        {
          this.closeEdit();
        }
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
  font-size: 12px;
}

textarea {
  border: 1px solid #bfbfbf;
  border-radius: 2px;
}

#modification_link {
  cursor:pointer;
  color:blue;
}

#modification_link:hover {
  text-decoration: underline;
}

#content {
  overflow-y: scroll;
  scroll-behavior: smooth;
}

#rule_comment_pre {
  border:none;
  background-color: transparent;
}

</style>
