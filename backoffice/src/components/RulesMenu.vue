<template>
  <div id="RulesMenu">
    <span v-if="this.toggled" @click="toggled = !toggled" style="cursor:pointer" class="rules-menu-title">
      <h5>
        {{ this.title }}
        <i class="fas fa-chevron-up rules-menu-chevron fa-sm"></i>
      </h5>
    </span>
    <span v-if="!this.toggled" @click="toggled = !toggled" style="cursor:pointer" class="rules-menu-title">
      <h5>
        {{ this.title }}
        &nbsp;
        <i class="fas fa-chevron-down rules-menu-chevron fa-sm"></i>
      </h5>
    </span>
      <br>
    <ul v-show="this.toggled">
      <li v-for="(rule, id) in rules" :key="rule.id">
        <a :href="'#'+decodeURI(id)" :title="rule.id" @click="$parent.forceRerender()">{{ rule.name }}</a>
      </li>
    </ul>
  </div>
</template>
<script>
  export default {
    name: 'RulesMenu',
    props: ['title', 'namespace'],
    data: function() {
      return {
        toggled: false
      }
    },
    computed: {
      rules: function () {
        var rules = {};
        for (var rule in this.$parent.rules) {
          if(this.$parent.rules[rule].path.startsWith(this.namespace)) rules[rule]= this.$parent.rules[rule];
        }
        return rules;
      },
    }
  }
</script>
<style scoped>
  .rules-menu-chevron {
    vertical-align: -5%;
    margin-left: 10px;
  }
</style>
