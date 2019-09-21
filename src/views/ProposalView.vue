<template>
  <Proposal></Proposal>
</template>
<script>
// import Proposal from "../components/Proposal";
export default {
  name: "ProposalView",
  components: {
    Proposal: () => import("../components/Proposal")
  }
};
</script>
