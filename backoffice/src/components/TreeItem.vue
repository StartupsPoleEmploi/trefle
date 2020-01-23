<template>
  <li>
    <div :class="{bold: isFolder}"  @dblclick="makeFolder">
      <div v-if="isFolder" @click="toggle">
        <span>{{ item.name }}</span>
        <span class="btn btn-outline-info pull-right" style="width:5%"><strong>{{ isOpen ? '-' : '+' }}</strong></span>
      </div>
      <span v-else v-html="transform(item.name)"></span>
    </div>
    <hr class="">
    <ul v-show="isOpen" v-if="isFolder">
      <TreeItem
        class="item"
        v-for="(child, index) in item.children"
        :key="index"
        :item="child"
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
  props: {
    item: Object
  },
  components: {
  },
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
      return data.replace(/Si /g, '<span class="text-muted font-weight-light">Si </span>')
        .replace(/Soit /g, '<span class="text-muted font-weight-light">Soit </span>')
        .replace(/Quand /g, '<span class="text-muted font-weight-light">Quand </span>')
        .replace(/Scénario: /g, '<span class="text-muted font-weight-light">Scénario: </span>')
        .replace(/Ou /g, '<span class="text-muted font-weight-light">Ou </span>')
        .replace(/, ou /g, '<span class="text-muted font-weight-light">, ou </span>')
        .replace(/Et /g, '<span class="text-muted font-weight-light">Et </span>')
        .replace(/, et /g, '<span class="text-muted font-weight-light">, et </span>')
        .replace(/Alors /g, '<span class="text-muted font-weight-light">Alors </span>')
        .replace(/(#.+)/g, "<em class=\"comment\">$1</em>")
        .replace(/appliquer les règles «([^»]+?)(.rules)?»/g, 'appliquer les règles « <a href="#$1.rules" class="btn btn-outline-info" title="Ouvrir les règles" style="display:inline-block">$1</a> »')
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
