<template>
  <div id="Navbar">
    <!-- Vertical navbar -->
    <div class="vertical-nav bg-white" id="sidebar">
      <ul class="nav flex-column bg-white mt-4">
        <li class="nav-item bg-white">
          <a href="" id="nav-title" class="nav-link text-dark">☘</a>
        </li>
        <li class="nav-item mt-5">
          <router-link to="/" name="accueil" class="nav-link" exact>            
            <svg class="nav-icon">
              <use xlink:href="#accueil_icon" />
            </svg>
            Accueil
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/referentiel" name="referentiel" class="nav-link">            
            <svg class="nav-icon">
              <use xlink:href="#referentiel_icon" />
            </svg>
            Référentiel
          </router-link>
        </li>
        <li class="nav-item">
        <router-link to="/financements" name="financements" class="nav-link">            
            <svg class="nav-icon">
              <use xlink:href="#financements_icon" />
            </svg>
            Financements
        </router-link>
        </li>
        <!--<li class="nav-item">
          <router-link to="/simulateur" name="simulateur" class="nav-link">            
            <svg class="nav-icon">
              <use xlink:href="#simulateur_icon" />
            </svg>
            Simulateur
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/scenarios" name="scenarios" class="nav-link">            
            <svg class="nav-icon">
              <use xlink:href="#scenarios_icon" />
            </svg>
            Scénarios
          </router-link>
        </li>-->
        <li class="nav-item">
          <router-link to="/outils" name="outils" class="nav-link">            
            <svg class="nav-icon">
              <use xlink:href="#outils_icon" />
            </svg>
            Outils
          </router-link>
        </li>
      </ul>
    </div>
    <div id="svg_icons">
      <svg display="none">
        <symbol id="accueil_icon" width="19px" height="17px" viewBox="0 0 19 17">
          <path d="M7.19785197,15.655 L7.19785197,10.655 L11.197852,10.655 L11.197852,15.655 C11.197852,16.205 11.647852,16.655 12.197852,16.655 L15.197852,16.655 C15.747852,16.655 16.197852,16.205 16.197852,15.655 L16.197852,8.655 L17.897852,8.655 C18.357852,8.655 18.577852,8.085 18.227852,7.785 L9.86785197,0.255 C9.48785197,-0.085 8.90785197,-0.085 8.52785197,0.255 L0.167851974,7.785 C-0.172148026,8.085 0.0378519742,8.655 0.497851974,8.655 L2.19785197,8.655 L2.19785197,15.655 C2.19785197,16.205 2.64785197,16.655 3.19785197,16.655 L6.19785197,16.655 C6.74785197,16.655 7.19785197,16.205 7.19785197,15.655" id="Fill-1"></path>
        </symbol>

        <symbol id="referentiel_icon" width="18px" height="18px" viewBox="0 0 18 18">
          <g id="Welcome" stroke="none" stroke-width="1" fill-rule="evenodd"><g id="Ecran_Ref_1_Hover" transform="translate(-36.000000, -162.000000)"><g id="Navigation" transform="translate(0.000000, 65.000000)"><g id="Icone_Referentiel" transform="translate(36.000000, 97.000000)"><path d="M2,16 L16,16 L16,2 L2,2 L2,16 Z M17,0 L1,0 C0.45,0 0,0.45 0,1 L0,17 C0,17.55 0.45,18 1,18 L17,18 C17.55,18 18,17.55 18,17 L18,1 C18,0.45 17.55,0 17,0 L17,0 Z M4,14 L6,14 L6,12 L4,12 L4,14 Z M4,10 L6,10 L6,8 L4,8 L4,10 Z M4,6 L6,6 L6,4 L4,4 L4,6 Z M9,14 L13,14 C13.55,14 14,13.55 14,13 C14,12.45 13.55,12 13,12 L9,12 C8.45,12 8,12.45 8,13 C8,13.55 8.45,14 9,14 L9,14 Z M9,10 L13,10 C13.55,10 14,9.55 14,9 C14,8.45 13.55,8 13,8 L9,8 C8.45,8 8,8.45 8,9 C8,9.55 8.45,10 9,10 L9,10 Z M9,6 L13,6 C13.55,6 14,5.55 14,5 C14,4.45 13.55,4 13,4 L9,4 C8.45,4 8,4.45 8,5 C8,5.55 8.45,6 9,6 L9,6 Z" id="Fill-1"></path></g></g></g></g>
        </symbol>

        <symbol id="financements_icon" x="0px" y="0px" width="30px" height="30px" viewBox="0 0 30 30" style="enable-background:new 0 0 30 30;">
            <path d="M15,0C6.729,0,0,6.729,0,15c0,8.271,6.729,15,15,15c8.271,0,15-6.729,15-15C30,6.729,23.271,0,15,0z M15,27.777 C7.956,27.777,2.223,22.046,2.223,15S7.956,2.223,15,2.223S27.777,7.954,27.777,15S22.044,27.777,15,27.777z"/><path d="M15,3.5C8.66,3.5,3.5,8.659,3.5,15S8.66,26.5,15,26.5S26.5,21.341,26.5,15S21.34,3.5,15,3.5z M19.145,10.677 c-0.754-0.593-1.61-0.89-2.568-0.89c-0.741,0-1.395,0.239-1.957,0.718c-0.563,0.479-0.963,1.116-1.199,1.912h4.309v1.891h-4.611 c-0.027,0.397-0.041,0.674-0.041,0.829c0,0.184,0.007,0.381,0.02,0.598h4.63v1.922h-4.328c0.506,1.699,1.514,2.548,3.024,2.548 c0.95,0,1.856-0.304,2.72-0.911v2.488c-0.795,0.484-1.832,0.728-3.115,0.728c-1.516,0-2.753-0.42-3.71-1.259 s-1.591-2.038-1.901-3.595H9.182v-1.923h0.971c-0.014-0.168-0.021-0.367-0.021-0.597c0-0.12,0.014-0.396,0.041-0.829H9.182v-1.891 h1.285c0.37-1.558,1.072-2.768,2.103-3.63c1.032-0.863,2.316-1.295,3.853-1.295c1.126,0,2.032,0.186,2.72,0.557v2.629H19.145z"/>
        </symbol>

        <symbol id="simulateur_icon" width="17px" height="13px" viewBox="0 0 17 13">  
          <path d="M5.1725,10.1626 L1.7025,6.6926 C1.3125,6.3026 0.6825,6.3026 0.2925,6.6926 C-0.0975,7.0826 -0.0975,7.7126 0.2925,8.1016 L4.4725,12.2826 C4.8625,12.6726 5.4925,12.6726 5.8825,12.2826 L16.4625,1.7026 C16.8525,1.3126 16.8525,0.6826 16.4625,0.2926 C16.0725,-0.0974 15.4425,-0.0974 15.0525,0.2926 L5.1725,10.1626 Z"></path>
        </symbol>

        <symbol id="scenarios_icon" x="0px" y="0px" width="20px" height="16px" viewBox="0 0 20 16">
          <path d="M17,14.0002 L3,14.0002 C2.45,14.0002 2,13.5502 2,13.0002 L2,5.0002 C2,4.4502 2.45,4.0002 3,4.0002 L17,4.0002 C17.55,4.0002 18,4.4502 18,5.0002 L18,13.0002 C18,13.5502 17.55,14.0002 17,14.0002 M18,2.0002 L10,2.0002 L8.59,0.5902 C8.21,0.2102 7.7,0.0002 7.17,0.0002 L2,0.0002 C0.9,0.0002 0.01,0.9002 0.01,2.0002 L0,14.0002 C0,15.1002 0.9,16.0002 2,16.0002 L18,16.0002 C19.1,16.0002 20,15.1002 20,14.0002 L20,4.0002 C20,2.9002 19.1,2.0002 18,2.0002"></path>
        </symbol>

        <symbol id="outils_icon" width="24" height="24" viewBox="0 0 24 24">
          <path fill="none" d="M0 0h24v24H0V0z"/><path d="M22.61 18.99l-9.08-9.08c.93-2.34.45-5.1-1.44-7C9.79.61 6.21.4 3.66 2.26L7.5 6.11 6.08 7.52 2.25 3.69C.39 6.23.6 9.82 2.9 12.11c1.86 1.86 4.57 2.35 6.89 1.48l9.11 9.11c.39.39 1.02.39 1.41 0l2.3-2.3c.4-.38.4-1.01 0-1.41zm-3 1.6l-9.46-9.46c-.61.45-1.29.72-2 .82-1.36.2-2.79-.21-3.83-1.25C3.37 9.76 2.93 8.5 3 7.26l3.09 3.09 4.24-4.24-3.09-3.09c1.24-.07 2.49.37 3.44 1.31 1.08 1.08 1.49 2.57 1.24 3.96-.12.71-.42 1.37-.88 1.96l9.45 9.45-.88.89z"/>
        </symbol>

      </svg>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'Navbar',
    data: function () {
      return {
      }
    },
    computed: {
      activePage: function() {
        return decodeURI(window.location).split('explorer/')[1].split('#')[0];
      },
      tabReferentielActive: function () {
        if (this.activePage == 'referentiel') return true
        return false
      }
    },
    methods: {
      isActive: function(page) {
        switch (page) {
          case this.activePage:
            return true;
          default:
            return false;
        }
      }
    }
  }
</script>
<style scoped>
  .vertical-nav {
    min-width: 14vw;
    width: 14vw;
    min-height: 100vh;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.1);
    transition: all 0.4s;
    z-index: 3;
  }

  #nav-title {
    font-size: 3em;
    margin-bottom: 1vh;
    margin-top: .5vh;
    padding: .3vw 3vw;
  }

  .vertical-nav .nav-link {
    min-width: 14vw;
    width: 14vw;
    font-size: 16px;
    padding: 1vw 3vw;
  }

  .nav-icon {
    padding-right: .4vw;
    padding-bottom: .3vh;
    width: 23px;
    height:23px;
  }

  svg {
    width: 23px;
    height: 23px;
  }

  .nav-link:hover {
    color:black;
  }
  .router-link-active {
    background-color : #384EAA;
    color: white;
    border-radius: 0% 7px 7px 0%;
    fill: white;
  }
  .router-link-active:hover {
    color:white;
  }
</style>
