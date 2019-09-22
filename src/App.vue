<template>
  <v-app style="background-color:#e5ebf2" class="app">
    <!-- #17182f;#e5ebf2 -->
    <template>
      <!-- #0277BD -->
      <v-toolbar class="lighten-2" prominent flat clipped-right color="#0277BD
">
        <v-toolbar-side-icon
          v-if="$router.currentRoute.name=='DAO' || $router.currentRoute.name=='proposal' || $router.currentRoute.name=='history'"
          class="white--text"
          @click="drawer=!drawer"
        ></v-toolbar-side-icon>

        <!-- <v-icon
          v-if="$router.currentRoute.name!='DAO' && $router.currentRoute.name!='proposal' && $router.currentRoute.name!='history'"
          height="40px"
          @click="toHome"
        >home</v-icon>-->

        <v-spacer></v-spacer>
        <v-icon
          v-if="$router.currentRoute.name!=='home'"
          size="40"
          color="white"
          style="margin-left:40%; margin-right:43%"
          @click="toHome"
          class="hidden-lg-and-up"
        >home</v-icon>
        <v-icon
          v-if="$router.currentRoute.name!=='home'"
          size="40"
          color="white"
          style="margin-left:40%; margin-right:43%"
          @click="toHome"
          class="hidden-md-and-down"
        >home</v-icon>
        <v-menu
          v-if="hasInjected==true"
          offset-y
          origin="center center"
          transition="slide-y-transition"
          open-on-hover
          class="mr-1 mt-5"
          style="background-color:#1A237E"
          nudge-bottom
        >
          <template class="mt-5" style="margin-right:5%" v-slot:activator="{ on }">
            <router-link
              :to="{name:'Profile',params:{ethAddress:currentAccount}}"
              active-class="color:transparent"
            >
              <v-gravatar
                :email="currentAccount"
                class="my-1 pa-0 hidden-xs-only"
                alt="Nobody"
                style="border-radius:5px;border:white solid 2px;"
                :size="35"
                v-on="on"
                default-img="retro"
              />
              <v-gravatar
                :email="currentAccount"
                class="pa-0 hidden-sm-and-up"
                alt="Nobody"
                style="border-radius:5px;border:white solid 2px;margin-right:10%"
                :size="30"
                v-on="on"
                default-img="retro"
              />
            </router-link>
          </template>
          <v-list class="mt-0" style="background-color:#1A237E;color:white;">
            <v-list-tile
              :to="{name:'Profile',params:{ethAddress:currentAccount}}"
              active-class="color:transparent"
            >
              <v-list-tile-title>ETH: {{this.getMyBalance}}</v-list-tile-title>
            </v-list-tile>
            <v-divider dark></v-divider>
            <v-list-tile
              :to="{name:'Profile',params:{ethAddress:currentAccount}}"
              active-class="color:transparent"
            >
              <v-list-tile-title>24CAR: {{this.getMyTokenBalance}}</v-list-tile-title>
            </v-list-tile>
            <v-divider dark></v-divider>
            <v-list-tile
              :to="{name:'Profile',params:{ethAddress:currentAccount}}"
              active-class="color:transparent"
            >
              <v-list-tile-title>ETH address: {{currentAccount}}</v-list-tile-title>
            </v-list-tile>
            <v-divider dark></v-divider>
            <v-list-tile
              :to="{name:'Profile',params:{ethAddress:currentAccount}}"
              active-class="color:transparent"
            >
              <v-list-tile-title class="mr-0 pr-0">Overall Reputation:</v-list-tile-title>
              <v-list-tile-title class="pa-0 ma-0" style="text-align:left">
                <span
                  class="hidden-xs-only"
                  style="display:inline-block;position:relative;bottom:4px;color:white;font-size:18px;right:1.5px;"
                >({{getOverallReputation}})</span>
                <span
                  class="hidden-sm-and-up"
                  style="display:inline-block;position:relative;bottom:2px;color:white;font-size:14px;right:1.5px;"
                >({{getOverallReputation}})</span>
                <span style="display:inline-block;position:relative;">
                  <v-rating
                    class="ma-0 pa-0 hidden-xs-only"
                    :value="getOverallReputation"
                    background-color="white"
                    color="yellow accent-4"
                    dense
                    readonly
                    half-increments
                    hover
                    size="25"
                  ></v-rating>
                  <v-rating
                    class="ma-0 pa-0 hidden-sm-and-up"
                    :value="getOverallReputation"
                    background-color="white"
                    color="yellow accent-4"
                    dense
                    readonly
                    half-increments
                    hover
                    size="19"
                  ></v-rating>
                </span>
              </v-list-tile-title>
            </v-list-tile>
            <!-- <v-list-tile>
              <v-list-tile-title>Reputation as a DAO owner:</v-list-tile-title>
              <v-list-tile-sub-title class="pa-0 ma-0">
                <v-rating
                  class="ma-0"
                  v-model="getDaoReputation"
                  background-color="white"
                  color="yellow accent-4"
                  dense
                  readonly
                  half-icon
                  half-increments
                  hover
                  size="25"
                ></v-rating>
              </v-list-tile-sub-title>
            </v-list-tile>-->
            <!-- <v-divider dark></v-divider>
            <v-list-tile>
              <v-list-tile-title>Reputation as a Proposal creator:</v-list-tile-title>
              <v-list-tile-sub-title class="pa-0 ma-0">
                <v-rating
                  class="ma-0"
                  v-model="getProposalReputation"
                  background-color="white"
                  color="yellow accent-4"
                  dense
                  readonly
                  half-icon
                  half-increments
                  hover
                  size="25"
                ></v-rating>
              </v-list-tile-sub-title>
            </v-list-tile>-->
            <!-- <v-divider dark></v-divider>
            <v-list-tile>
              <v-list-tile-title>Reputation as a Voter:</v-list-tile-title>
              <v-list-tile-sub-title class="pa-0 ma-0">
                <v-rating
                  class="ma-0"
                  v-model="getVoteReputation"
                  background-color="white"
                  color="yellow accent-4"
                  dense
                  readonly
                  half-icon
                  half-increments
                  hover
                  size="25"
                ></v-rating>
              </v-list-tile-sub-title>
            </v-list-tile>-->
          </v-list>
        </v-menu>
      </v-toolbar>
      <v-navigation-drawer
        v-model="drawer"
        v-if="$router.currentRoute.name=='DAO' ||$router.currentRoute.name=='history' || $router.currentRoute.name=='proposal'"
        width="260px"
        dark
        floating
        style="background-color:#607D8B
"
        app
        hide-overlay
      >
        <!-- #3078CA; -->
        <v-list class="pt-0">
          <div class="mt-4">
            <!-- <h2
              v-if="$router.currentRoute.name=='DAO' && $route.params.ended.toString()=='false'"
              style="color:white;font-size:20px;text-align:justify"
              class="mt-1 font-weight-regular"
            >Only DAO owner can make a proposal to the DAO!</h2>
            <h2
              v-else-if="$router.currentRoute.name=='DAO' && $route.params.ended.toString()=='true'"
              style="color:white;font-size:20px;text-align:justify"
              class="mt-1 font-weight-regular"
            >This DAO is ended therefore Proposal creation is disabled</h2>
            </div>-->
            <center></center>
            <center>
              <h1
                class="font-weight-medium mt-2 pa-3"
                style="font-size:22px;"
              >{{this.$route.params.title}}</h1>
            </center>
          </div>

          <v-divider class="mt-5"></v-divider>
          <v-subheader style="marging-left:50px;">Menu</v-subheader>
          <center>
            <v-list-tile
              v-for="item in items"
              :key="item.title"
              router
              :to="item.to"
              hover
              active-class="transaparent"
            >
              <v-list-tile-action hover>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-tile-action>

              <v-list-tile-content>
                <v-list-tile-title class="align-end">
                  {{
                  item.title
                  }}
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>

            <v-divider></v-divider>
            <v-subheader>DAO Holdings</v-subheader>
            <v-list-tile>
              <v-list-tile-content>
                <v-list-tile-title class="mb-2">ETH: {{this.$store.state.contractBalance}}</v-list-tile-title>

                <v-list-tile-title class="mt-1">24CAR: {{this.getTokenBalance}}</v-list-tile-title>
                <!-- <v-list-tile-title>Total Investment: {{this.$store.state.contractBalance}}</v-list-tile-title> -->
              </v-list-tile-content>
            </v-list-tile>

            <v-list-tile class="pa-0 ma-0">
              <v-list-tile-content class="pa-0 ma-0">
                <v-list-tile-title
                  class="pa-0 ma-0"
                >Total Investment: {{$store.state.totalInvestment}} ETH</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
            <v-divider></v-divider>
          </center>
        </v-list>
      </v-navigation-drawer>
    </template>

    <v-content>
      <particlesJS/>
      <transition id="test" name="page" mode="out-in">
        <keep-alive exclude="DaoView,ProfileView">
          <router-view
            id="test"
            v-if="$router.currentRoute.name!='404' && $router.currentRoute.name!='FAQ' && $router.currentRoute.name!='Profile'"
            class="ma-4"
          ></router-view>
          <router-view id="test" v-else></router-view>
        </keep-alive>
      </transition>
    </v-content>
    <v-snackbar
      v-model="$store.state.snack"
      :color="$store.state.color"
      vertical
      top
      :timeout="6000"
    >
      {{$store.state.text}}
      <v-btn color="white" flat @click="$store.state.snack = false">Close</v-btn>
    </v-snackbar>

    <v-footer v-if="$router.currentRoute.name=='home'" dark height="auto">
      <v-card class="flex" flat>
        <v-card-actions class="darken-3 justify-center">
            <v-tooltip lazy top>
            <template v-slot:activator="{ on }">
          <a v-on="on" href="https://github.com/rahulthakkar796/DAO" target="_blank">
            <i target="_blank" style="font-size:35px;color:white" class="fa fa-github pa-1 ml-3"></i>
          </a>
            </template>
               <span>Click here to open repository</span>
          </v-tooltip>
        </v-card-actions>
      </v-card>
    </v-footer>
  </v-app>
</template>
  

<script>
import { TNStoken } from "./../embarkArtifacts/contracts";
import particlesJS from "./components/particlesJS";
import router from "./router";
import { Factory } from "./../embarkArtifacts/contracts";
export default {
  name: "App",
  components: { particlesJS },
  data() {
    return {
      drawer: true,
      items: [
        {
          title: "Home",
          icon: "home",
          // to:
          //   "/DAO/" +
          //   this.$route.params.contractAddress +
          //   "&" +
          //   this.$route.params.title
          to: { name: "DAO" }
        },
        { title: "History", icon: "history", to: { name: "history" } },

        { title: "FAQ", icon: "error_outline", to: { name: "FAQ" } }
        // {
        //   title: "Feedback",
        //   icon: "feedback"
        // }
      ],
      right: null,
      contractAddress: this.$route.params.contractAddress,
      contractBalance: 0,
      currentAccount: "",
      hasInjected: false,
      myBalance: 0,
      tokenBalance: 0,
      proposalReputation: null,
      voteReputation: null
    };
  },
  asyncComputed: {
    async getContractbalance() {
      return this.$store.state.contractBalance;
    },
    async getTokenBalance() {
      return this.$store.state.tokens;
    },

    async getMyBalance() {
      return this.myBalance;
    },
    async getMyTokenBalance() {
      return this.tokenBalance;
    },
    async getDaoReputation() {
      return this.$store.state.daoReputation;
    },
    async getProposalReputation() {
      return this.$store.state.proposalReputation;
    },
    async getVoteReputation() {
      return this.$store.state.voteReputation;
    },
    async getOverallReputation() {
      let rep =
        (parseInt(this.getDaoReputation) +
          parseInt(this.getProposalReputation) +
          parseInt(this.getVoteReputation)) /
        3;
      // console.log("overall rep:" + rep);
      return rep.toFixed(1);
    },
    async getTotalInvestment() {
      balance = await web3.utils.fromWei(
        this.$store.state.totalInvestment,
        "ether"
      );
      balance = parseFloat(balance).toFixed(2);
      return balance;
    }
  },

  methods: {
    toHome() {
      this.$router.push("/");
    },
    async getNetwork() {
      let network = await web3.eth.net.getNetworkType();
      let address = await web3.eth.getAccounts();
      if (network != "private" || (address != "" && address != "undefined")) {
        this.hasInjected = true;
        //console.log("Injected:" + this.hasInjected);
      }
    },
    async getToken() {
      let bal = await TNStoken.methods
        .getUnlockedAmount(this.currentAccount)
        .call();
      bal = bal / 10 ** 18;
      this.getMyTokenBalance = bal;
      // console.log("computed:" + this.getMyTokenBalance);
    },

    async fetchMyBalance() {
      console.log("current route:" + this.$router.currentRoute.name);
      let balance = await web3.eth.getBalance(this.currentAccount);
      let cmp = balance;
      balance = await web3.utils.fromWei(balance, "ether");
      balance = parseFloat(balance).toFixed(2);
      console.log("My balance:" + balance);
      // this.getMyBalance = await web3.utils.fromWei(balance, "ether");
      this.getMyBalance = balance;

      var interval = setInterval(async function() {
        let account = await web3.eth.getAccounts();
        let bal = await web3.eth.getBalance(account[0]);

        //bal = parseFloat(balance).toFixed(2);
        if (bal !== cmp) {
          //alert("balance changed");
          bal = await web3.utils.fromWei(bal, "ether");
          this.getMyBalance = parseFloat(bal).toFixed(2);
          if (router.currentRoute.name != "home") {
            window.location.reload();
          }
        }
      }, 300);
    },
    async getCurrentAccount() {
      // this.currentAccount = acc[0];
      let account = await web3.eth.getAccounts();
      this.currentAccount = account[0];
      var accountInterval = setInterval(async function() {
        let acc = await web3.eth.getAccounts();
        if (acc[0] !== account[0]) {
          // MetaMask account is changed
          this.currentAccount = acc[0];
          window.location.reload();
        }
      }, 300);
    }

    //console.log(network);
  },
  async created() {
    await this.getCurrentAccount();

    this.$store.dispatch("fetchDaoReputation", this.currentAccount);
    this.$store.dispatch("fetchProposalReputation", this.currentAccount);
    this.$store.dispatch("fetchVoteReputation", this.currentAccount);
    //this.$store.dispatch('fetchContractBalance',this.$route.params.contractBalance)
    // await this.fetchContractbalance();
  },
  async mounted() {
    await this.getNetwork();
    await this.fetchMyBalance();
    await this.getToken();
  }
  // async updated() {
  //   let acc = await web3.eth.getAccounts();
  //   this.currentAccount = acc[0];
  //   await this.getNetwork();
  //   await this.fetchContractbalance();
  //   await this.fetchMyBalance();
  // }
};
</script>
<style scoped>
@import url("https://fonts.googleapis.com/css?family=Roboto&display=swap");
.page-enter-active,
.page-leave-active {
  transition: opacity 0.5s, transform 0.2s;
}
.page-enter,
.page-leave-to {
  opacity: 0;
  transform: translateX(-30%);
}
#test {
  z-index: 5;
}
#particles-js {
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  left: 0;
}
#app {
  /* font-family: "Muli", sans-serif; */
}
</style>

