<template>
  <li style="">
    <div :class="{bold: isFolder}" class=""  @dblclick="makeFolder"  style="margin-left:2.5%">
      <div v-if="isFolder" @click="toggle">
        <div v-if="!rootElement" class="form-inline rules-line">
          <div v-html="transform(item.name)" style="width:95%"/>
          <div class="main-button btn pull-right" style="width:5%"><strong>{{ isOpen ? '-' : '+' }}</strong></div>
        </div>
      </div>
      <div v-else v-html="transform(item.name)" :class="{alors: isAlorsLine}" class="text-muted rules-line"/>
    </div>
    <hr v-show="!rootElement" style="padding:0px; margin:0px;">
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
    data: function() {
      return {
        isOpen: false
      }
    },
    computed: {
      isFolder: function() {
        return this.item.children &&
          this.item.children.length
      },
      isAlorsLine: function () {
        return this.item.name.match(/Alors+ .*/gi);
      }
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
        return data
          .replace(/Si /g, '<span class="bold text-dark">Si </span>')
          .replace(/Soit /g, '<span class="bold text-dark">Soit </span>')
          .replace(/Quand /g, '<span class="bold text-dark">Quand </span>')
          .replace(/Scénario: /g, '<span class="bold text-dark">Scénario: </span>')
          .replace(/Ou /g, '<span class="bold text-dark">Ou </span>')
          .replace(/, ou /g, '<span class="bold text-dark">, ou </span>')
          .replace(/Et /g, '<span class="bold text-dark">Et </span>')
          .replace(/, et /g, '<span class="bold text-dark">, et </span>')
          .replace(/Alors+ .*/gi, "<div class='text-dark'>$&</div>")
          .replace(/(#.+)/g, "<em class=\"comment\">$1</em>")
          .replace(/appliquer les règles «([^»]+?)(.rules)?»/g, '<span class="rules-line"> appliquer les règles « <a href="'+this.rulePath+'#$1.rules" class="btn main-button" title="Ouvrir les règles" style="display:inline-block">$1</a> »</span>')
          .replace(/(«.+»)/g, "<span class=\"string\">$1</span>")
          .replace(/,([^ ])/g, "<span class=\"string\">, $1</span>");
      },
    },
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
  .alors {
    background-color: rgba(153, 255, 102, 0.2);
    transition: padding 0.2s 0s linear;
    height:100%;
    border-radius:5px;
  }
  .rules-line {
    padding-top:1vh;
    padding-bottom:1vh;
  }
</style>
