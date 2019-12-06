<template>
  <div id="Navbar">
    <!-- Horizontal navbar -->
    <div class="horizontal-nav bg-white" id="sidebar">
      <ul class="nav bg-white mb-0">
        <li class="nav-item bg-white">
        </li>
      </ul>
    </div>
    <!-- End horizontal navbar -->

    <!-- Vertical navbar -->
    <div class="vertical-nav bg-white" id="sidebar">
      <ul class="nav flex-column bg-white mb-0">
        <li class="nav-item bg-white">
          <a href="" id="nav-title" class="nav-link text-dark">☘</a>
        </li>
        <li class="nav-item">
          <router-link to="/" name="accueil" class="nav-link text-dark bg-white">
            <img src="./../assets/images/Icone_Home.svg" width="23" height="23" class="d-inline-block nav-icon" alt="">
            Accueil
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/referentiel" name="referentiel" class="nav-link text-dark bg-white">
            <img src="./..//assets/images/Icone_Referentiel.svg" width="23" height="23" class="d-inline-block nav-icon" alt="">
            Référentiel
          </router-link>
        </li>
        <li class="nav-item">
        <router-link to="/financements" name="financements" class="nav-link text-dark bg-white">
          <img src="./../assets/images/Icone_Financement.svg" width="23" height="23" class="d-inline-block nav-icon" alt="">
          Financements
        </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/simulateur" name="simulateur" class="nav-link text-dark bg-white">
            <img src="./../assets/images/Icone_Simulateur.svg" width="23" height="23" class="d-inline-block nav-icon" alt="">
            Simulateur
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/scenarios" name="scenarios" class="nav-link text-dark bg-white">
            <img src="./../assets/images/Icone_Scenarios.svg" width="23" height="23" class="d-inline-block nav-icon" alt="">
            Scénarios
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/outils" name="outils" class="nav-link text-dark bg-white">
            <img src="./../assets/images/Icone_Outils.svg" width="23" height="23" class="d-inline-block nav-icon" alt="">
            Outils
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'Navbar'
  }
</script>
<style scoped>
  .horizontal-nav {
    min-width: 100vw;
    width: 100vw;
    height: 5rem;
    min-height: 5rem;
    position: fixed;
    top: 0;
    left: 0;
    transition: all 0.4s;
    box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.1);
    z-index: 2;
  }

  .vertical-nav {
    min-width: 14rem;
    width: 14rem;
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
    margin-bottom: 1rem;
    margin-top: .5rem;
    padding: .3rem 3rem;
  }

  .vertical-nav .nav-link {
    min-width: 14rem;
    width: 14rem;
    font-size: 16px;
    padding: 1rem 3rem;
  }

  .horizontal-nav .nav-link {
    min-width: 1rem;
    width: 5rem;
    font-size: 16px;
    padding: .5rem 1rem;
  }

  .nav-icon {
    padding-right: .4rem;
    padding-bottom: .3rem;
  }
</style>
