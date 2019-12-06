<template>
    <div id="RulesMenu">
        <h4 @click="toggled = !toggled" style="cursor:pointer">{{ this.title }}</h4>
        <br>
        <ul v-show="this.toggled">
            <li v-for="(rule, id) in rules" :key="rule.id">
                <a :href="'#'+decodeURI(id)" :title="rule.id">{{ rule.name }}</a>
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
                    if(this.$parent.rules[rule].path.startsWith(this.namespace)) {
                        rules[rule]= this.$parent.rules[rule];
                    }
                }
                return rules;
            },
        },
        methods:{
            toggle: function(){
                this.toggled = !this.toggled
            }
        }
  }
</script>
