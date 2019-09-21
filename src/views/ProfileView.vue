<template>
  <Profile></Profile>
</template>
<script>
export default {
  name: "ProfileView",
  components: {
    Profile: () => import("../components/Profile.vue")
  }
};
</script>
