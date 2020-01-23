<template>
  <li>
    <div :class="{bold: isFolder}"  @dblclick="makeFolder">
      <div v-if="isFolder" @click="toggle">
        <div v-if="!rootElement">
          <span>{{ item.name }}</span>
          <span class="btn btn-outline-info pull-right" style="width:5%"><strong>{{ isOpen ? '-' : '+' }}</strong></span>
        </div>
      </div>
      <span v-else v-html="transform(item.name)" class="text-muted"></span>
    </div>
    <hr v-show="!rootElement">
    <ul v-show="isOpen || rootElement" v-if="isFolder">
      <TreeItem
        class="item"
        v-for="(child, index) in item.children"
        :key="index"
        :item="child"
        :rootElement="false"
        :rulePath="rulePath"
        @make-folder="$emit('make-folder', $event)"
        @add-item="$emit('add-item', $event)"
      ></TreeItem>
      <!-- li class="add" @click="$emit('add-item', item)">+</li -->
    </ul>
  </li>
</template>


<script>

export default {
  name: 'TreeItem',
  props: ['item','rootElement', 'rulePath'],
  methods: {
    toggle: function () {
      if (this.isFolder) {
        this.isOpen = !this.isOpen
      }
    },
    makeFolder: function () {
      if (!this.isFolder) {
        this.$emit('make-folder', this.item)
        this.isOpen = true
      }
    },
    transform: function(data) {
      return data.replace(/Si /g, '<span class="bold text-dark">Si </span>')
        .replace(/Soit /g, '<span class="bold text-dark">Soit </span>')
        .replace(/Quand /g, '<span class="bold text-dark">Quand </span>')
        .replace(/Scénario: /g, '<span class="bold text-dark">Scénario: </span>')
        .replace(/Ou /g, '<span class="bold text-dark">Ou </span>')
        .replace(/, ou /g, '<span class="bold text-dark">, ou </span>')
        .replace(/Et /g, '<span class="bold text-dark">Et </span>')
        .replace(/, et /g, '<span class="bold text-dark">, et </span>')
        .replace(/Alors /g, '<span class="bold text-dark">Alors </span>')
        .replace(/(#.+)/g, "<em class=\"comment\">$1</em>")
        .replace(/appliquer les règles «([^»]+?)(.rules)?»/g, 'appliquer les règles « <a href="'+this.rulePath+'#$1.rules" class="btn btn-outline-info" title="Ouvrir les règles" style="display:inline-block">$1</a> »')
        .replace(/(«.+»)/g, "<span class=\"string\">$1</span>")
        .replace(/,([^ ])/g, ", $1");
    },
  },
  computed: {
    isFolder: function() {
      return this.item.children &&
        this.item.children.length
    }
  },
  data: function() {
    return {
      isOpen: false
    }
  },
  created: function() {
  }
}

</script>

<style>
  .item {
    cursor: pointer;
  }
  .bold {
    font-weight: bold;
  }
  ul {
    padding-left: 1em;
    line-height: 1.5em;
    list-style-type: dot;
  }
  .rule-separator {
    width: 100vh;
  }
</style>
