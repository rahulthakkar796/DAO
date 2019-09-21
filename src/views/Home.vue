<template>
  <DaoHome></DaoHome>
</template>

<script>
// const DaoHome = () => import("../components/DaoHome");
// import DaoHome from "../components/DaoHome";
export default {
  components: {
    // DaoHome
    DaoHome: () => import("../components/DaoHome")
  }
};
</script>
