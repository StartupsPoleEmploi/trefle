<template>
  <div id="App">
    <Navbar></Navbar>
    <MainContent></MainContent>
  </div>
</template>
<script>

  // loading font awesome icons before rendering anything else
  (function() { var css = document.createElement('link'); css.href = 'https://use.fontawesome.com/releases/v5.1.0/css/all.css'; css.rel = 'stylesheet'; css.type = 'text/css'; document.getElementsByTagName('head')[0].appendChild(css); })();

  import Navbar from './components/Navbar.vue'
  import MainContent from './components/MainContent.vue'

  export default {
    name: 'App',
    components: {
      Navbar,
      MainContent
    }
  }
</script>
<style>
  @font-face {
    font-family: 'sans';
    src: url('./assets/fonts/sourcesanspro-it-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcesanspro-it-webfont.woff') format('woff');
    font-weight: normal;
    font-style: italic;

  }
  @font-face {
    font-family: 'sans';
    src: url('./assets/fonts/sourcesanspro-light-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcesanspro-light-webfont.woff') format('woff');
    font-weight: 300;
    font-style: normal;

  }
  @font-face {
    font-family: 'sans';
    src: url('./assets/fonts/sourcesanspro-regular-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcesanspro-regular-webfont.woff') format('woff');
    font-weight: normal;
    font-style: normal;

  }
  @font-face {
    font-family: 'sans';
    src: url('./assets/fonts/sourcesanspro-bold-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcesanspro-bold-webfont.woff') format('woff');
    font-weight: bold;
    font-style: normal;

  }
  @font-face {
    font-family: 'mono';
    src: url('./assets/fonts/sourcecodepro-regular-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcecodepro-regular-webfont.woff') format('woff');
    font-weight: normal;
    font-style: normal;

  }
  @font-face {
    font-family: 'mono';
    src: url('./assets/fonts/sourcecodepro-bold-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcecodepro-bold-webfont.woff') format('woff');
    font-weight: bold;
    font-style: normal;
  }
  @font-face {
    font-family: 'mono';
    src: url('./assets/fonts/sourcecodepro-semibold-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcecodepro-semibold-webfont.woff') format('woff');
    font-weight: 600;
    font-style: normal;
  }
  @font-face {
    font-family: 'mono';
    src: url('./assets/fonts/sourcecodepro-medium-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcecodepro-medium-webfont.woff') format('woff');
    font-weight: 500;
    font-style: normal;
  }
  @font-face {
    font-family: 'mono';
    src: url('./assets/fonts/sourcecodepro-it-webfont.woff2') format('woff2'),
      url('./assets/fonts/sourcecodepro-it-webfont.woff') format('woff');
    font-weight: normal;
    font-style: italic;
  }
  @font-face {
    font-family: 'icon';
    font-style: normal;
    font-weight: 400;
    src: url('./assets/fonts/material-icons.woff2') format('woff2');
  }
  html, body, a, p, div, li, dl {
    margin: 0;
    padding: 0;
    color: #222;
    font-family: 'Lato', 'sans', sans-serif;
  }
  html, body {
    width: 100%;
  }
  ul {
    padding: 0;
  }
  li {
    list-style: none;
  }
  a {
    text-decoration: none;
  }
  .full, .tools {
    margin: 0 auto;
    max-width: 1280px;
    display: block;
  }
  .tools {
    display: grid;
    grid-template-columns: 1fr 2fr;
  }
  main {
    padding: 1rem;
  }
  pre {
    padding: 5px;
    border: solid 1px #68c3a3;
    background-color: #eee;
    max-width: 1200px;
    font-family: 'mono';
    white-space: pre-wrap;
  }
  p {
    margin: 1rem 0;
  }
  .on {
    font-weight: bold;
  }


  /*** FORMS ***/
  input[type=text],
  input[type=url] {
    line-height: 3em;
    border: 1px solid #eee;
    padding: 0 .5rem;
    min-width: 300px;
  }
  input[type=submit],
  .button {
    background-color: #68c3a3;
    border: none;
    padding: 0 10px;
    line-height: 3em;
    cursor: pointer;
    color: #fff;
  }
  input[type=submit]:hover,
  .button:hover {
    background-color: #56bc98;
  }
  /** icons **/
  /** See https://material.io/tools/icons/ **/
  .icon {
    font-family: 'icon';
    font-weight: normal;
    font-style: normal;
    font-size: 1em;
    line-height: 1em;
    letter-spacing: normal;
    text-transform: none;
    display: inline-block;
    white-space: nowrap;
    word-wrap: normal;
    direction: ltr;
    font-variant: normal;
    vertical-align: baseline;
    /* Support for all WebKit browsers. */
    -webkit-font-smoothing: antialiased;
    /* Support for Safari and Chrome. */
    text-rendering: optimizeLegibility;
    /* Support for Firefox. */
    -moz-font-feature-settings: 'liga';
    -moz-osx-font-smoothing: grayscale;
    /* Support for IE. */
    font-feature-settings: 'liga';
  }
  textarea {
    width: 100%;
    border: 1px solid #f3f3f3;
    padding: 10px;
    min-height: 200px;
  }  
  .main-button {
    border: 1px solid #384EAA;
  }
  .main-button:hover {
    background-color : #384EAA;
    color: white;
  }
  .main-button:hover:disabled {
    border: 1px solid #384EAA;
    background-color : #BDBADE;
    color: black;
  }
  .main-button-primary {
    background-color : #384EAA;
    color: white;
  }
  .main-button-primary:hover {
    background-color : #0D0850;
    color: white;
  }
  .loading-gif {
    padding-top: 8rem;
  }
  ul.dash {
    list-style: none;
    margin-left: 0;
    padding-left: 1em;
  }
  ul.dash > li:before {
      display: inline-block;
      content: "-";
      width: 1em;
      margin-left: -1em;
  }

</style>
