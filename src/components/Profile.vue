<template>
  <div>
    <div class="ma-0 pa-0" style="background:rgba(131, 193, 242,1.5)">
      <center>
        <h1 style="z-index:5;position:relative" class="white--text font-weight-bold pt-1">Profile</h1>

        <v-avatar class="my-4" tile size="150px">
          <v-gravatar
            :email="$route.params.ethAddress"
            class="mt-1 pa-0 mx-0"
            style="border:10px solid white;border-radius:10px"
            alt="Nobody"
            :size="200"
            default-img="retro"
          />
        </v-avatar>
        <div>
          <h2
            style="z-index:5;position:relative;display:inline-block"
            class="white--text hidden-xs-only"
          >{{$route.params.ethAddress}}</h2>

          <span style="display:inline-block;">
            <v-btn
              v-clipboard="$route.params.ethAddress"
              flat
              depressed
              @success="success"
              @error="failed"
            >
              <v-icon class="ma-0" color="white">content_copy</v-icon>
            </v-btn>
          </span>
          <h5
            style="z-index:5;position:relative; font-size:14px"
            class="white--text hidden-sm-and-up"
          >{{$route.params.ethAddress}}</h5>
        </div>
        <div>
          <center>
            <v-card-text>
              <span
                class="white--text font-weight-medium"
                style="display:inline-block;position:relative;bottom:4px;font-size:17px"
              >Overall Reputation: ({{getOverallReputation}})</span>
              <span style="display:inline-block;position:relative">
                <v-rating
                  class="ma-0 pa-0"
                  :value="getOverallReputation"
                  background-color="white"
                  color="yellow accent-4"
                  dense
                  readonly
                  half-increments
                  hover
                  size="25"
                ></v-rating>
              </span>
              <span style="display:inline-block;position:relative;bottom:5px;left:5px">
                <v-btn
                  class="font-weight-bold"
                  flat
                  depressed
                  @click="showAll=true"
                  color="white"
                >Know more</v-btn>
              </span>
            </v-card-text>
          </center>
        </div>
      </center>
      <v-dialog class="mt-5 pa-0" style="border-radius:15px" width="500px" v-model="showAll">
        <v-card class="pa-2 ma-0" flat style="border-radius:12px;text-align:justify">
          <center style="text-align:center">
            <div style="justify-content:center">
              <span
                class="font-weight-medium"
                style="display:inline-block;position:relative;bottom:4px;font-size:35px;right:4px;color:#689BD6"
              >{{getOverallReputation}}</span>
              <span style="display:inline-block;position:relative;">
                <v-rating
                  dark
                  class="ma-0 pa-0"
                  :value="getOverallReputation"
                  background-color="grey"
                  color="yellow accent-4"
                  dense
                  readonly
                  half-increments
                  hover
                  size="35"
                ></v-rating>
              </span>

              <v-divider class="my-2"></v-divider>
              <v-layout row wrap justify-center class="ma-0 pb-0">
                <v-flex
                  xs3
                  lg4
                  sm4
                  md4
                  xl4
                  style="text-align:left;white-space: pre;text-indent: 0px;"
                  class="mt-4"
                >
                  <p
                    style="bottom:4px;font-size:20px;overflow-x:scroll;color:#689BD6"
                    class="font-weight-medium;"
                  >DAO creator</p>

                  <!-- <span
                    class="font-weight-medium hidden-sm-and-up"
                    style="bottom:0px;font-size:15px;right:4px"
                  >DAO creator</span>-->
                </v-flex>
                <v-flex lg2 xl2 xs2 md2 sm2 style="text-align:right" class="mt-4">
                  <v-icon class="mt-1 ml-2">arrow_forward</v-icon>
                </v-flex>
                <v-flex xs7 lg6 sm6 md6 xl6 style="text-align:right" class="mt-4">
                  <span
                    class="font-weight-medium"
                    style="display:inline-block;position:relative;bottom:2px;font-size:20px;right:4px;color:#689BD6"
                  >({{getDaoReputation}})</span>
                  <span
                    class="font-weight-medium"
                    style="display:inline-block;position:relative;font-size:20px;right:4px"
                  >
                    <v-rating
                      dark
                      class="ma-0 pa-0"
                      :value="getDaoReputation"
                      background-color="grey"
                      color="yellow accent-4"
                      dense
                      readonly
                      half-increments
                      hover
                      size="25"
                    ></v-rating>
                  </span>
                </v-flex>
              </v-layout>
              <v-divider class="my-2"></v-divider>
              <v-layout row wrap justify-center class="ma-0 pb-0">
                <v-flex
                  xs3
                  lg4
                  sm4
                  md4
                  xl4
                  style="text-align:left;white-space: pre;text-indent: 0px;"
                  class="mt-4"
                >
                  <p
                    style="bottom:4px;font-size:20px;overflow-x:scroll;color:#689BD6"
                    class="font-weight-medium"
                  >Proposal creator</p>

                  <!-- <span
                    class="font-weight-medium hidden-sm-and-up"
                    style="bottom:0px;font-size:15px;right:4px"
                  >DAO creator</span>-->
                </v-flex>
                <v-flex lg2 xl2 xs2 md2 sm2 style="text-align:right" class="mt-4">
                  <v-icon class="mt-1 ml-2">arrow_forward</v-icon>
                </v-flex>
                <v-flex xs7 lg6 sm6 md6 xl6 style="text-align:right" class="mt-4">
                  <span
                    class="font-weight-medium"
                    style="display:inline-block;position:relative;bottom:2px;font-size:20px;right:4px;color:#689BD6"
                  >({{getProposalReputation}})</span>
                  <span
                    class="font-weight-medium"
                    style="display:inline-block;position:relative;font-size:20px;right:4px"
                  >
                    <v-rating
                      dark
                      class="ma-0 pa-0"
                      :value="getProposalReputation"
                      background-color="grey"
                      color="yellow accent-4"
                      dense
                      readonly
                      half-increments
                      hover
                      size="25"
                    ></v-rating>
                  </span>
                </v-flex>
              </v-layout>
              <v-divider class="my-2"></v-divider>
              <v-layout row wrap justify-center class="ma-0 pb-0">
                <v-flex
                  xs3
                  lg4
                  sm4
                  md4
                  xl4
                  style="text-align:left;white-space: pre;text-indent: 0px;"
                  class="mt-4"
                >
                  <p
                    style="bottom:4px;font-size:20px;overflow-x:scroll;color:#689BD6"
                    class="font-weight-medium"
                  >Voter</p>

                  <!-- <span
                    class="font-weight-medium hidden-sm-and-up"
                    style="bottom:0px;font-size:15px;right:4px"
                  >DAO creator</span>-->
                </v-flex>
                <v-flex lg2 xl2 xs2 md2 sm2 style="text-align:right" class="mt-4">
                  <v-icon class="mt-1 ml-2">arrow_forward</v-icon>
                </v-flex>
                <v-flex xs7 lg6 sm6 md6 xl6 style="text-align:right" class="mt-4">
                  <span
                    class="font-weight-medium"
                    style="display:inline-block;position:relative;bottom:2px;font-size:20px;right:4px;color:#689BD6"
                  >({{getVoteReputation}})</span>
                  <span
                    class="font-weight-medium"
                    style="display:inline-block;position:relative;font-size:20px;right:4px"
                  >
                    <v-rating
                      dark
                      class="ma-0 pa-0"
                      :value="getVoteReputation"
                      background-color="grey"
                      color="yellow accent-4"
                      dense
                      readonly
                      half-increments
                      hover
                      size="25"
                    ></v-rating>
                  </span>
                </v-flex>
              </v-layout>
              <!-- <span
                class="font-weight-medium"
                style="display:inline-block;position:relative;bottom:4px;font-size:20px;right:4px"
              >DAO creator: ({{getDaoReputation}})</span>
              <span style="display:inline-block;position:relative">
                <v-rating
                  dark
                  class="ma-0 pa-0"
                  :value="getDaoReputation"
                  background-color="grey"
                  color="yellow accent-4"
                  dense
                  readonly
                  half-increments
                  hover
                  size="25"
                ></v-rating>
              </span>
              <v-divider></v-divider>
              <span
                class="font-weight-medium mt-2"
                style="display:inline-block;position:relative;bottom:4px;font-size:20px;right:4px"
              >Proposal creator: ({{getProposalReputation}})</span>
              <span style="display:inline-block;position:relative">
                <v-rating
                  dark
                  class="ma-0 pa-0"
                  :value="getProposalReputation"
                  background-color="grey"
                  color="yellow accent-4"
                  dense
                  readonly
                  half-increments
                  hover
                  size="25"
                ></v-rating>
              </span>
              <v-divider></v-divider>
              <span
                class="font-weight-medium mt-2"
                style="display:inline-block;position:relative;bottom:4px;font-size:20px;right:4px"
              >Voter: ({{getVoteReputation}})</span>
              <span style="display:inline-block;position:relative">
                <v-rating
                  dark
                  class="ma-0 pa-0"
                  :value="getVoteReputation"
                  background-color="grey"
                  color="yellow accent-4"
                  dense
                  readonly
                  half-increments
                  hover
                  size="25"
                ></v-rating>
              </span>-->
            </div>
          </center>
        </v-card>
      </v-dialog>

      <!-- <v-card color="purple" dark>
            <v-card-title primary class="title">Lorem</v-card-title>
            <v-card-text>Lorem ipsum dolor sit amet consectetur adipisicing elit. Perspiciatis dolor maxime, nesciunt, rerum quis et ea fuga cupiditate officia dolores, culpa necessitatibus autem magni accusantium asperiores illum. Nisi, qui quae.</v-card-text>
      </v-card>-->

      <!-- <v-flex lg4 xl4 d-flex xs12 sm6 md4>
          <v-layout row wrap>
            <v-flex d-flex>
              <v-card color="indigo" dark>
                <v-card-text>{{ lorem.slice(0, 70) }}</v-card-text>
              </v-card>
            </v-flex>
            <v-flex d-flex>
              <v-layout row wrap>
                <v-flex v-for="n in 2" :key="n" d-flex xs12>
                  <v-card color="red lighten-2" dark>
                    <v-card-text>{{ lorem.slice(0, 40) }}</v-card-text>
                  </v-card>
                </v-flex>
              </v-layout>
            </v-flex>
          </v-layout>
      </v-flex>-->
    </div>
    <div>
      <center>
        <h1 style="color:#689BD6;z-index:5;" class="headline font-weight-bold">History of User</h1>
      </center>
      <v-layout
        row
        justify-center
        class="px-0 mx-0 mt-4"
        style="text-align:center;z-index:99;position:relative"
      >
        <v-flex lg2 xl2 md2 sm2 xs3>
          <h4 class="font-weight-medium hidden-xs-only">Successfull DAOs</h4>
          <h4 class="font-weight-medium hidden-sm-and-up">DAOs</h4>
        </v-flex>
        <v-flex lg2 xl2 md2 sm2 xs3>
          <h4 class="font-weight-medium hidden-xs-only">Successfull Proposals</h4>
          <h4
            class="font-weight-medium hidden-sm-and-up"
            style=" word-break: break-word;
"
          >Proposals</h4>
        </v-flex>
        <v-flex lg2 xl2 md2 sm2 xs3 style="word-break:break-word">
          <h4 class="font-weight-medium hidden-xs-only">Total Proposals</h4>
          <h4
            class="font-weight-medium hidden-sm-and-up"
            style="word-break:break-word"
          >Total Proposals</h4>
        </v-flex>
        <!-- <v-spacer class="hidden-xs-only"></v-spacer> -->
        <v-flex lg2 xl2 md2 sm2 xs3>
          <h4 class="font-weight-medium hidden-xs-only">Successfull Votes</h4>
          <h4 class="font-weight-medium hidden-sm-and-up">Votes</h4>
        </v-flex>
        <v-flex lg2 xl2 md2 sm2 xs3>
          <h4 class="font-weight-medium">Total Votes</h4>
        </v-flex>

        <!-- <v-flex lg2 xl2 md2 sm2 xs2>
          <h3 class="caption mr-3">My Actions</h3>
        </v-flex>-->
      </v-layout>
      <v-layout
        row
        justify-center
        class="pa-0 mt-4 mb-2 mx-1"
        style="text-align:center;z-index:5;position:relative"
      >
        <v-flex
          lg2
          xl2
          md2
          sm2
          xs3
          class="text-truncate"
          style="overflow-wrap:break-word;background-color:white;border-radius:12px 0px 0px 12px;"
        >
          <h3 class="header my-3 font-weight-regular" style="color:#506176">{{getSuccessDao}}</h3>
        </v-flex>
        <v-flex
          lg2
          xl2
          md2
          sm2
          xs3
          style="overflow-wrap:break-word;color:#9AA9B5;background-color:white;"
        >
          <h3 class="header my-3 font-weight-regular" style="color:#506176">{{getSuccessProposals}}</h3>
        </v-flex>
        <v-flex lg2 xl2 md2 sm2 xs3 style="background-color:white">
          <h3 class="header my-3 font-weight-regular" style="color:#506176">{{getTotalProposals}}</h3>
        </v-flex>

        <v-flex lg2 xl2 md2 sm2 xs3 style="background-color:white;">
          <!-- <h3 class="caption">Votes</h3> -->
          <h3 class="header my-3 font-weight-regular" style="color:#506176">{{getSuccessVotes}}</h3>
        </v-flex>
        <v-flex lg2 xl2 md2 sm2 xs3 style="background-color:white;border-radius:0px 12px 12px 0px;">
          <h3 class="header my-3 font-weight-regular" style="color:#506176">{{getTotalVotes}}</h3>
        </v-flex>
      </v-layout>
    </div>
  </div>
</template>
<script>
import { Factory } from "../../embarkArtifacts/contracts";
export default {
  name: "Profile",
  data() {
    return {
      lorem: "hahhahaahahhahahahahahaahhahahahh",
      showAll: false
    };
  },
  asyncComputed: {
    async getDaoReputation() {
      let rep = 0;
      return parseInt(rep);
    },
    async getVoteReputation() {
      let rep = 0;
      return parseInt(rep);
    },
    async getProposalReputation() {
      let rep = 0;
      return parseInt(rep);
    },
    async getOverallReputation() {
      let rep =
        (parseInt(this.getDaoReputation) +
          parseInt(this.getVoteReputation) +
          parseInt(this.getProposalReputation)) /
        3;
      // console.log(rep);
      return rep.toFixed(1);
    },
    async getTotalProposals() {
      let rep = 0;
      return rep;
    },
    async getSuccessProposals() {
      let rep = 0;
      return rep;
    },
    async getTotalVotes() {
      let rep = 0;
      return rep;
    },
    async getSuccessVotes() {
      let rep = 0;
      return rep;
    },
    async getSuccessDao() {
      let rep = 0;
      return rep;
    }
  },
  methods: {
    success() {
      this.$store.state.snack = true;
      this.$store.state.text = "Copied to clipboard";
      this.$store.state.color = "green";
    },
    failed() {
      this.$store.state.snack = true;
      this.$store.state.text = "Couldn't copy";
      this.$store.state.color = "red";
    },
    async fetchDaoReputation() {
      this.getDaoReputation = await Factory.methods
        .getReputation(this.$route.params.ethAddress)
        .call();
    },
    async fetchVoteReputation() {
      this.getVoteReputation = await Factory.methods
        .getVoteReputation(this.$route.params.ethAddress)
        .call();
    },
    async fetchProposalReputation() {
      this.getProposalReputation = await Factory.methods
        .getProposalReputation(this.$route.params.ethAddress)
        .call();
      console.log("Proposal rep:" + this.getProposalReputation);
    },
    async fetchTotalProposals() {
      this.getTotalProposals = await Factory.methods
        .getTotalProposals(this.$route.params.ethAddress)
        .call();
    },
    async fetchSuccessProposals() {
      this.getSuccessProposals = await Factory.methods
        .getSuccessProposals(this.$route.params.ethAddress)
        .call();
    },

    async fetchTotalVotes() {
      this.getTotalVotes = await Factory.methods
        .getTotalVotes(this.$route.params.ethAddress)
        .call();
    },
    async fetchSuccessVotes() {
      this.getSuccessVotes = await Factory.methods
        .getSuccessVotes(this.$route.params.ethAddress)
        .call();
    },
    async fetchSuccessDao() {
      this.getSuccessDao = await Factory.methods
        .getSuccessDao(this.$route.params.ethAddress)
        .call();
    }
  },
  created() {
    this.fetchDaoReputation();
    this.fetchVoteReputation();
    this.fetchProposalReputation();
    this.fetchTotalProposals();
    this.fetchSuccessProposals();
    this.fetchTotalVotes();
    this.fetchSuccessVotes();
    this.fetchSuccessDao();
  }
};
</script>
<style scoped>
span {
  text-align: justify;
}
::-webkit-scrollbar {
  width: 0px;
  background: transparent;
}
</style>
