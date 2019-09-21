<template>
  <History></History>
</template>
<script>
// import History from "../components/History";

export default {
  name: "HistoryView",
  components: {
    // History
    History: () => import("../components/History")
  }
};
</script>
