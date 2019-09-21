<template>
  <Guide></Guide>
</template>
<script>
export default {
  name: "GuideView",
  components: {
    Guide: () => import("../components/Guide.vue")
  }
};
</script>