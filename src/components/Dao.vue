<template>
  <div
    v-if="!$router.currentRoute.name.includes('proposal') && !$router.currentRoute.name.includes('history') "
  >
    <center
      v-if="detail.length>0 && owner==currentAccount && $route.params.active.toString()=='true' && $route.params.ended.toString()=='false'  && $route.params.blocked.toString()=='false'"
    >
      <v-btn @click="checkWhitelist" class="white--text" color="blue" depressed>
        <v-icon left>add</v-icon>Create a new proposal
      </v-btn>
    </center>
    <center v-if="detail.length>0 && memberCount==members">
      <h2
        v-if="memberCount==members"
        style="color:#546E7A;z-index:99"
        class="font-weight-medium my-4"
      >Participants limit is exceeded, Please don't send ETH to this contract to get whitelisted and participate.</h2>
    </center>
    <div class="mt-4" v-if="no==0 ">
      <v-container class="mt-5">
        <v-layout row justify-center>
          <v-flex lg8 xl8 md8 sm12 xs12>
            <v-card
              color="white"
              class
              style="border-radius:15px;margin-top:5%;padding-top:10%;padding-bottom:10%;border:3px solid #689BD6"
            >
              <center>
                <v-icon size="250px">mood_bad</v-icon>
                <h1 class="font-weight-medium" style="color:#546E7A">No Proposals found</h1>
                <v-btn
                  large
                  @click="checkWhitelist"
                  class="white--text mt-4"
                  color="blue"
                  v-if="$route.params.active.toString()=='true' && $route.params.ended.toString()=='false' && memberCount<members &&  $route.params.blocked.toString()=='false' && owner==currentAccount"
                  depressed
                >
                  <v-icon left>add</v-icon>Create a new proposal
                </v-btn>
                <!-- <h2 v-if="memberCount==members" class="font-weight-medium my-2">Participants limit is exceeded</h2> -->
              </center>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </div>

    <div v-if="loading" class="ma-0">
      <loading
        :active.sync="loading"
        background-color="#050505"
        color="#007bff"
        loader="dots"
        transition="fade"
        height="180"
        width="180"
        is-full-page
      ></loading>
    </div>
    <!-- <BounceLoader
        v-if="detail.length<=0"
        style="margin-top:20%;"
        loading="loading"
        color="blue"
        size="85"
      
    ></BounceLoader>-->

    <div v-if="detail.length>0">
      <v-container class="mt-4">
        <v-divider style=" color:#9aa9b5;"></v-divider>
        <center>
          <h2
            class="font-weight-medium mt-4"
            style=" color:#9aa9b5;z-index:99"
          >Regular Proposals ({{getRegular.length}})</h2>
        </center>
        <v-layout row wrap justify-center class="mt-5">
          <v-flex xl5 lg5 xs12 sm6 md6 v-for="(detail,index) in getRegular" :key="index">
            <v-card
              class="pt-2 pb-0 mx-2 ma-2 CardBorder"
              color="#FAFAFA"
              data-aos="fade-up"
              data-aos-offset="0"
              once="false"
              flat
              @click="toProposal(detail.index)"
              hover
            >
              <v-card-title
                v-if="detail.ended==false"
                class="mb-2 pb-0 pt-0 mr-2 pl-1 ml-0"
                style="text-align:left;font-size:15px;font:#E0E0E0;color:#9ABBE1"
              >{{detail.days}}d:{{detail.hours}}h :{{detail.mins}}m :{{detail.secs}}s</v-card-title>

              <v-card-title
                v-else-if="detail.ended==true"
                class="mb-2 pb-0 pt-0 mr-2 pl-1 ml-0"
                style="text-align:left;font-size:15px;font:#E0E0E0;color:#9ABBE1"
              >Proposal ended</v-card-title>
              <v-layout row wrap justify-start style="overflow-wrap:break-word;" class="px-0 mx-0">
                <v-flex xs1 xl1 lg1 sm1 md1 class="pl-3 mr-0 pr-0">
                  <!-- <v-card-text class="pb-2 pt-1 mx-2 mt-2" style="overflow-wrap:break-word;"> -->

                  <v-gravatar
                    :email="detail.submitter"
                    class="mt-1 pa-0 mx-0"
                    alt="Nobody"
                    :size="16"
                    default-img="retro"
                  />
                </v-flex>
                <v-flex xs11 xl10 lg10 sm11 md11 style="text-align:center;margin-top:3px;">
                  <span
                    class="header font-weight-bold mt-1 ml-1 text-xs-justify"
                  >{{detail.submitter}}</span>
                </v-flex>

                <!-- </v-card-text> -->
              </v-layout>
              <h2 class="ml-3 my-1">{{detail.title}}</h2>
              <v-divider class></v-divider>
              <v-layout row justify-center>
                <v-flex xs5 xl5 lg5 sm5 md5>
                  <v-progress-circular
                    :rotate="-90"
                    :size="50"
                    :width="4"
                    v-if="detail.currentResult>=0"
                    :value="detail.currentResult"
                    color="teal"
                    style=" margin: 1rem;margin-left:80px;font-size:10px"
                  >{{ detail.currentResult }}</v-progress-circular>
                  <v-progress-circular
                    :rotate="-90"
                    :size="50"
                    :width="4"
                    v-else-if="detail.negativeResult!=null"
                    :value="detail.negativeResult"
                    color="red"
                    style=" margin: 1rem;margin-left:80px;font-size:10px"
                  >{{ detail.negativeResult }}</v-progress-circular>
                </v-flex>
                <v-flex lg2 xl2 xs1 md1 sm1 class="ma-0 pa-0">
                  <center>
                    <hr color="#E0E0E0" class="hr">
                  </center>
                </v-flex>
                <v-flex xl5 lg5 xs6 md6 sm6>
                  <div
                    style="text-align:right;margin-top:10px; margin-right:65px;margin-bottom:5px;"
                  >
                    <v-icon color="#9AA9B5" v-if="detail.yesVotes==0"  style="margin-right:30px;" left>thumb_up</v-icon>
                      <v-icon color="#9AA9B5" v-else-if="detail.yesVotes>0"   left>thumb_up</v-icon>
                    <span style="color:#506176" v-if="detail.yesVotes==0">0.00%</span>
                    <span
                      style="color:#506176"
                      v-if="detail.yesVotes>0"
                    >{{detail.yesVotes.toFixed(2)}}%</span>
                  </div>
                  <div style="text-align:right;margin-right:65px;">
                    <v-icon color="#9AA9B5" v-if="detail.noVotes==0" style="margin-right:30px;" left>thumb_down</v-icon>
                     <v-icon color="#9AA9B5" v-else-if="detail.noVotes>0"  left>thumb_down</v-icon>
                    <span style="color:#506176" v-if="detail.noVotes==0">0.00%</span>
                    <span
                      style="color:#506176"
                      v-if="detail.noVotes>0"
                    >{{detail.noVotes.toFixed(2)}}%</span>
                  </div>
                </v-flex>
              </v-layout>
            </v-card>
          </v-flex>
        </v-layout>

        <v-divider class="mt-3" style=" color:#9aa9b5;"></v-divider>
        <center>
          <h2
            style=" color:#9aa9b5;"
            class="font-weight-medium mt-4"
          >Passed Proposals ({{getPassed.length}})</h2>
        </center>
        <v-layout row wrap justify-center class="mt-5">
          <v-flex lg5 xl5 xs12 sm6 md6 v-for="(detail,index) in getPassed" :key="index">
            <v-card
              class="pt-2 pb-0 ma-2 CardBorder"
              color="#FAFAFA"
              data-aos="fade-up"
              data-aos-offset="0"
              flat
              @click="toProposal(detail.index)"
              hover
            >
              <v-card-title
                v-if="detail.ended==false"
                class="mb-2 pb-0 pt-0 mr-2 pl-1 ml-0"
                style="text-align:left;font-size:15px;font:#E0E0E0;color:#9ABBE1"
              >{{detail.days}}d:{{detail.hours}}h :{{detail.mins}}m :{{detail.secs}}s</v-card-title>

              <v-card-title
                v-else-if="detail.ended==true"
                class="mb-2 pb-0 pt-0 mr-2 pl-1 ml-0"
                style="text-align:left;font-size:15px;font:#E0E0E0;color:#9ABBE1"
              >Proposal ended</v-card-title>
              <v-layout row wrap justify-start style="overflow-wrap:break-word;" class="px-0 mx-0">
                <v-flex xs1 xl1 lg1 sm1 md1 class="pl-3 mr-0 pr-0">
                  <!-- <v-card-text class="pb-2 pt-1 mx-2 mt-2" style="overflow-wrap:break-word;"> -->

                  <v-gravatar
                    :email="detail.submitter"
                    class="mt-1 pa-0 mx-0"
                    alt="Nobody"
                    :size="16"
                    default-img="retro"
                  />
                </v-flex>
                <v-flex xs11 xl10 lg10 sm11 md11 style="text-align:center;margin-top:3px;">
                  <span
                    class="header font-weight-bold mt-1 ml-1 text-xs-justify"
                  >{{detail.submitter}}</span>
                </v-flex>

                <!-- </v-card-text> -->
              </v-layout>
              <h2 class="ml-3 my-1">{{detail.title}}</h2>
              <v-divider class></v-divider>
              <v-layout row justify-center>
                <v-flex xs5 xl5 lg5 sm5 md5>
                  <v-progress-circular
                    :rotate="-90"
                    :size="50"
                    :width="4"
                    v-if="detail.currentResult>=0"
                    :value="detail.currentResult"
                    color="teal"
                    style=" margin: 1rem;margin-left:80px;font-size:10px"
                  >{{ detail.currentResult}}</v-progress-circular>
                  <v-progress-circular
                    :rotate="-90"
                    :size="50"
                    :width="4"
                    v-else-if="detail.negativeResult!=null"
                    :value="detail.negativeResult"
                    color="red"
                    style=" margin: 1rem;margin-left:80px;font-size:10px"
                  >{{ detail.negativeResult }}</v-progress-circular>
                </v-flex>
                <v-flex lg2 xl2 xs1 md1 sm1 class="ma-0 pa-0">
                  <center>
                    <hr color="#E0E0E0" class="hr">
                  </center>
                </v-flex>
                <v-flex lg5 xl5 xs6 md6 sm6>
                  <div
                    style="text-align:right;margin-top:10px; margin-right:65px;margin-bottom:5px;"
                  >
                      <v-icon color="#9AA9B5" v-if="detail.yesVotes==0"  style="margin-right:30px;" left>thumb_up</v-icon>
                      <v-icon color="#9AA9B5" v-else-if="detail.yesVotes>0"   left>thumb_up</v-icon>
                    <span style="color:#506176" v-if="detail.yesVotes==0">0.00%</span>
                    <span
                      style="color:#506176"
                      v-if="detail.yesVotes>0"
                    >{{detail.yesVotes.toFixed(2)}}%</span>
                  </div>
                  <div style="text-align:right;margin-right:65px;">
                   <v-icon color="#9AA9B5" v-if="detail.noVotes==0" style="margin-right:30px;" left>thumb_down</v-icon>
                     <v-icon color="#9AA9B5" v-else-if="detail.noVotes>0"  left>thumb_down</v-icon>
                    <span style="color:#506176" v-if="detail.noVotes==0">0.00%</span>
                    <span
                      style="color:#506176"
                      v-if="detail.noVotes>0"
                    >{{detail.noVotes.toFixed(2)}}%</span>
                  </div>
                </v-flex>
              </v-layout>
            </v-card>
          </v-flex>
        </v-layout>

        <v-divider class="mt-3" style=" color:#9aa9b5;"></v-divider>
        <center>
          <h2
            class="font-weight-medium mt-4"
            style=" color:#9aa9b5;"
          >Failed Proposals ({{getFailed.length}})</h2>
        </center>
        <v-layout row wrap justify-center class="mt-5">
          <v-flex lg5 xl5 xs12 sm6 md6 v-for="(detail,index) in getFailed" :key="index">
            <v-card
              class="pt-2 pb-0 ma-2 CardBorder"
              color="#FAFAFA"
              data-aos="fade-up"
              data-aos-offset="0"
              flat
              @click="toProposal(detail.index)"
              hover
            >
              <v-card-title
                v-if="detail.ended==false"
                class="mb-2 pb-0 pt-0 mr-2 pl-1 ml-0"
                style="text-align:left;font-size:15px;font:#E0E0E0;color:#9ABBE1"
              >{{detail.days}}d:{{detail.hours}}h :{{detail.mins}}m :{{detail.secs}}s</v-card-title>

              <v-card-title
                v-else-if="detail.ended==true"
                class="mb-2 pb-0 pt-0 mr-2 pl-1 ml-0"
                style="text-align:left;font-size:15px;font:#E0E0E0;color:#9ABBE1"
              >Proposal ended</v-card-title>
              <v-layout row wrap justify-start style="overflow-wrap:break-word;" class="px-0 mx-0">
                <v-flex xs1 xl1 lg1 sm1 md1 class="pl-3 mr-0 pr-0">
                  <!-- <v-card-text class="pb-2 pt-1 mx-2 mt-2" style="overflow-wrap:break-word;"> -->

                  <v-gravatar
                    :email="detail.submitter"
                    class="mt-1 pa-0 mx-0"
                    alt="Nobody"
                    :size="16"
                    default-img="retro"
                  />
                </v-flex>
                <v-flex xs11 xl10 lg10 sm11 md11 style="text-align:center;margin-top:3px;">
                  <span
                    class="header font-weight-bold mt-1 ml-1 text-xs-justify"
                  >{{detail.submitter}}</span>
                </v-flex>

                <!-- </v-card-text> -->
              </v-layout>
              <h2 class="ml-3 my-1">{{detail.title}}</h2>
              <v-divider class></v-divider>
              <v-layout row justify-center>
                <v-flex xs5 xl5 lg5 sm5 md5>
                  <v-progress-circular
                    :rotate="-90"
                    :size="50"
                    :width="4"
                    :value="detail.currentResult"
                    color="teal"
                    v-if="detail.currentResult>=0"
                    style=" margin: 1rem;margin-left:80px;font-size:10px"
                  >{{ (detail.currentResult) }}</v-progress-circular>
                  <v-progress-circular
                    :rotate="-90"
                    :size="50"
                    :width="4"
                    :value="detail.negativeResult"
                    color="red"
                    v-else-if="detail.negativeResult!=null"
                    style=" margin: 1rem;margin-left:80px;font-size:10px"
                  >{{ (detail.negativeResult) }}</v-progress-circular>
                </v-flex>
                <v-flex lg2 xl2 xs1 md1 sm1 class="ma-0 pa-0">
                  <center>
                    <hr color="#E0E0E0" class="hr">
                  </center>
                </v-flex>
                <v-flex lg5 xl5 xs6 md6 sm6>
                  <div
                    style="text-align:right;margin-top:10px; margin-right:65px;margin-bottom:5px;"
                  >
                      <v-icon color="#9AA9B5" v-if="detail.yesVotes==0"  style="margin-right:30px;" left>thumb_up</v-icon>
                      <v-icon color="#9AA9B5" v-else-if="detail.yesVotes>0"   left>thumb_up</v-icon>
                    <span style="color:#506176" v-if="detail.yesVotes==0">0.00%</span>
                    <span
                      style="color:#506176"
                      v-if="detail.yesVotes>0"
                    >{{detail.yesVotes.toFixed(2)}}%</span>
                  </div>
                  <div style="text-align:right;margin-right:65px;">
                   <v-icon color="#9AA9B5" v-if="detail.noVotes==0" style="margin-right:30px;" left>thumb_down</v-icon>
                     <v-icon color="#9AA9B5" v-else-if="detail.noVotes>0"  left>thumb_down</v-icon>
                    <span style="color:#506176" v-if="detail.noVotes==0">0.00%</span>
                    <span
                      style="color:#506176"
                      v-if="detail.noVotes>0"
                    >{{detail.noVotes.toFixed(2)}}%</span>
                  </div>
                </v-flex>
              </v-layout>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
    <v-dialog
      style="border-top-left-radius:15px;border-top-right-radius:15px;"
      v-model="showForm"
      class="pa-0 ma-0"
      width="700px"
    >
      <v-card
        flat
        class="pa-0 ma-0"
        style="border-top-left-radius:12px;border-top-right-radius:12px;"
      >
        <v-card-title
          class="mb-4 pa-2 white--text"
          style="background-color:#1A237E;font-size:20px;"
        >
          <v-icon class="white--text ml-1">add</v-icon>New Proposal
        </v-card-title>
        <v-form ref="form">
          <v-text-field
            v-model="title"
            box
            class="mx-4"
            :rules="titleRules"
            required
            outline
            label="Title"
          ></v-text-field>
          <v-textarea
            class="mx-4"
            counter
            v-model="description"
            :rules="descriptionRules"
            placeholder="Describe your proposal in detail"
            outline
            label="Description"
            rows="3"
          ></v-textarea>
          <v-text-field
            class="mx-4"
            required
            :rules="URLRules"
            v-model="url"
            persistent-hint
            hint="This URL can be for longer descriptions,pics,docs and etc."
            outline
            label="URL"
          ></v-text-field>
          <v-layout row wrap>
            <v-flex xs6 xl6 lg6 sm6 md6>
              <v-text-field
                class="mx-4"
                outline
                :rules="targetRules"
                v-model.number="target"
                label="Target"
                placeholder="Enter target in tokens"
             
              ></v-text-field>
            </v-flex>
            <v-flex xs6 lg6 xl6 sm6 md6>
              <v-text-field
                class="mx-4"
                :rules="durationRules"
                v-model.number="duration"
                outline
                label="Duration"
                placeholder="Enter duration in days"
              ></v-text-field>
            </v-flex>
          </v-layout>
          <v-card-actions class="justify-end pb-3">
            <v-btn
              @click="reset"
              class="mr-3 blue--text lighten-3"
              style="border-radius:15px;"
              color="#B2EBF2"
            >Cancel</v-btn>
            <v-btn
              class="mr-3"
              style="border-radius:15px;"
              @click="createProposal"
              color="blue white--text"
            >Sumbit Proposal</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>
    <v-dialog class="py-4 my-4" width="400px" v-model="whitelistError">
      <v-card class="pa-1" style="border-radius:15px;">
        <v-card-text
          class="headline font-weight-medium"
          style="text-align:center"
        >You are not whitelisted</v-card-text>
        <v-card-text
          class="body-2 font-weight-regular"
        >Please send 0.01ETH to following address to get whitelisted, and if you wanna buy tokens then you can send more ETH, price is 1ETH=10K carati as of now.</v-card-text>
        <v-card-text class="font-weight-black mt-0 pt-0">{{this.$route.params.contractAddress}}</v-card-text>
        <center>
          <v-btn
            v-clipboard="$route.params.contractAddress"
            class="py-0 my-0"
            @success="success"
            @error="failed"
            depressed
            flat
            large
            color="primary"
          >Copy</v-btn>
        </center>
      </v-card>
    </v-dialog>
  </div>
  <div v-else>
    <keep-alive>
      <router-view :key="$route.fullPath"></router-view>
    </keep-alive>
  </div>
</template>
<script>
import { Factory } from "../../embarkArtifacts/contracts";
export default {
  name: "DAO",
  data() {
    return {
      whitelistError: false,
      showText: false,
      whitelisted: false,
      ended: false,
      showForm: false,
      showText: false,
      owner: "",
      currentAccount: "",
      title: "",
      loading: false,
      contract: null,
      no: null,
      details: [],
      description: "",
      target: null,
      targetLimit: 0,
      reputation: 0,
      members: 0,
      memberCount: 0,
      url: "",
      day: 0,
      duration: null,
      titleRules: [v => !!v || "Please enter title"],
      descriptionRules: [v => !!v || "Please enter description"],
      URLRules: [
        v =>
          /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/.test(
            v
          ) || "URL is not valid"
      ],
      targetRules: [
        v => !!v || "Please enter target",
        v => /^[0-9]/.test(v) || "Only numeric value is allowed",
        v =>
          v <= this.targetLimit ||
          "Your reputation as a proposal creator is " +
            this.reputation +
            " so target limit for you is " +
            this.targetLimit +
            " tokens"
      ],
      durationRules: [
        v => !!v || "Please enter duration",
        v =>
          /^[1-9]/.test(v) ||
          "Please enter numeric value. value should be greater than 0",
        v =>
          parseInt(Date.now() / 1000) + v * 86400 < this.day ||
          "deadline should be less than the deadline of DAO"
      ]
    };
  },
  components: {},
  asyncComputed: {
    async detail() {
      return this.details;
    },
    async getRegular() {
      let i = 0;
      return this.detail.filter(function(detail, index) {
        if (detail.currentResult < 100 && detail.ended == false) {
          // console.log("index:" + index);
          detail.index = index;
          return detail;
        }
      });
    },
    async getPassed() {
      console.log("passed")
      return this.detail.filter(function(detail, index) {
       
        if (detail.currentResult >= 100) {
          detail.index = index;
         
          return detail;
        }
      });
    },
    async getFailed() {
      return this.detail.filter(function(detail, index) {
        if (detail.currentResult < 100 && detail.ended == true) {
          detail.index = index;
          return detail;
        }
      });
    },
    async tokens() {
      let bal = await this.contract.methods.daoTokenBalance().call();
      bal = bal / 10 ** 18;
      this.$store.state.tokens = bal;
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
    checkWhitelist() {
      if (this.whitelisted == true) {
        this.showForm = true;
      } else {
        this.whitelistError = true;
      }
    },
    reset() {
      this.$refs.form.reset();
      this.$refs.form.resetValidation();
      this.showForm = false;
      // this.title = "";
      // (this.description = ""), (this.url = ""), (this.target = null);
      // this.duration = null;
      // this.showForm = false;
    },
    async createProposal() {
      if (this.whitelisted == true) {
        if (this.$refs.form.validate()) {
          let contract = new web3.eth.Contract(
            this.$store.state.abi,
            this.$route.params.contractAddress
          );

          try {
            this.loading = true;
            this.showText = true;
            this.showForm = false;
            await contract.methods
              .createProposal(
                this.title,
                this.description,
                this.url,
                this.target,
                this.duration
              )
              .send({ from: this.currentAccount });

            // console.log("Proposal:" + no);
            await this.pushDetails();
         
            this.loading = false;
            this.showText = false;
            this.reset();
            this.$store.state.snack = true;
            this.$store.state.text = "Proposal has been created successfully";
            this.$store.state.color = "green";
            //this.reset();
          } catch (err) {
            console.log("Err:" + err);
            this.loading = false;
            this.showText = false;
            this.$store.state.snack = true;
            this.$store.state.text = "Something went wrong";
            this.$store.state.color = "red";
          }
        }
      } else {
        this.whitelistError = true;
      }
    },
    async getAccount() {
      let add = await web3.eth.getAccounts();
      //console.log("address:" + add);
      this.currentAccount = add[0];
    },
    async pushDetails() {
      this.no = await this.contract.methods.proposalCount().call();
      let i = await this.contract.methods.proposalCount().call();
      i = i - 1;
      let title = await this.contract.methods.getTitle(i).call();
      let description = await this.contract.methods.getDescription(i).call();
      let url = await this.contract.methods.getURL(i).call();
      let target = await this.contract.methods.getTarget(i).call();
    
      let submitter = await this.contract.methods.getSubmitter(i).call();
      let deadline = await this.contract.methods.getDeadline(i).call();
      this.members = await this.contract.methods.members().call();
      this.memberCount = await this.contract.methods.memberCount().call();
      this.day = parseInt(await this.contract.methods.DaoDeadline().call());
      //  let hasVoted = await this.contract.methods
      //           .voters(i, this.currentAddress)
      //           .call();
      let totalVotes = await this.contract.methods.getTotalVotes(i).call();
      let yesVotes = await this.contract.methods.getYesVotes(i).call();
      let noVotes = await this.contract.methods.getNoVotes(i).call();
      let currentResult = await this.contract.methods
        .getCurrentResult(i)
        .call();
      yesVotes = ((yesVotes * 100) / totalVotes).toFixed(2);
      noVotes = ((noVotes * 100) / totalVotes).toFixed(2);
      currentResult = ((currentResult * 100) / target).toFixed(3);
      let finalYesVotes = yesVotes > 0 ? yesVotes : 0;
      let finalNoVotes = noVotes > 0 ? noVotes : 0;
      let finalCurrentResult = currentResult;
      let negativeResult = currentResult < 0 ? Math.abs(currentResult) : null;
      this.detail.push({
        title: title,
        desc: description,
        url: url,
        target: target,
        submitter: submitter,
        ended: false,
        days: 0,
        hours: 0,
        mins: 0,
        secs: 0,
        noVotes: finalNoVotes.toFixed(2),
        yesVotes: finalYesVotes.toFixed(2),
        currentResult: finalCurrentResult,
        negativeResult: negativeResult
        // hasVoted:hasVoted
      });
      this.timer(i);
    },
    async getDetails() {
      this.contract = new web3.eth.Contract(
        this.$store.state.abi,
        this.$route.params.contractAddress
      );

      // let detail=await this.contract.methods.getDetails(0).call({from:this.currentAccount})
      // console.log('details:'+detail)
      this.no = await this.contract.methods.proposalCount().call();
      this.members = await this.contract.methods.members().call();
      this.memberCount = await this.contract.methods.memberCount().call();

      this.day = parseInt(await this.contract.methods.DaoDeadline().call());
      //  console.log("day:"+this.day)
      if (this.no > 0) {
        this.loading = true;
      }
      //console.log("Proposal:" + this.no);
      for (let i = 0; i < this.no; i++) {
        let title = await this.contract.methods.getTitle(i).call();
        let description = await this.contract.methods.getDescription(i).call();
        let url = await this.contract.methods.getURL(i).call();
        let target = await this.contract.methods.getTarget(i).call();
        let submitter = await this.contract.methods.getSubmitter(i).call();
        let deadline = await this.contract.methods.getDeadline(i).call();
  console.log("target:"+target)
        //  let hasVoted = await this.contract.methods
        //         .voters(i, this.currentAddress)
        //         .call();
        let totalVotes = await this.contract.methods.getTotalVotes(i).call();
        let yesVotes = await this.contract.methods.getYesVotes(i).call();
        let noVotes = await this.contract.methods.getNoVotes(i).call();
        let currentResult = await this.contract.methods
          .getCurrentResult(i)
          .call();

          console.log("current reached:"+currentResult)
        yesVotes = (yesVotes * 100) / totalVotes;
        noVotes = (noVotes * 100) / totalVotes;
        currentResult = ((currentResult * 100) / target).toFixed(3);
        let finalYesVotes = yesVotes > 0 ? yesVotes : 0;
        let finalNoVotes = noVotes > 0 ? noVotes : 0;
        let finalCurrentResult = currentResult;
        let negativeResult = currentResult < 0 ? Math.abs(currentResult) : null;
        // console.log("Yes votes:" + finalYesVotes);
        this.detail.push({
          title: title,
          desc: description,
          url: url,
          target: target,
          submitter: submitter,
          ended: false,
          days: 0,
          hours: 0,
          mins: 0,
          secs: 0,
          noVotes: finalNoVotes,
          yesVotes: finalYesVotes,
          currentResult: finalCurrentResult,
          negativeResult: negativeResult

          // hasVoted:hasVoted
        });
        // console.log("Deadline:" + deadline);
        this.timer(i);
        let whitelist = await this.contract.methods
          .whitelist(this.currentAccount)
          .call();
        // console.log("Whitelisted:" + whitelist);
        console.log("tite:" + this.detail[i].title);
      }

      this.owner = await this.contract.methods.owner().call();
      this.loading = false;

      //console.log("Details:" + this.detail[0]);
    },
    timer: async function(index) {
      let mins = 0;
      let hour = 0;
      let secs = 0;
      let day = 0;

      let totalTime = await this.contract.methods.getDeadline(index).call();
      // console.log(index + ":" + totalTime);
      let timee = setInterval(() => {
        let min = new Date().getTime();

        //console.log("total time of " + index + ":" + totalTime);
        //min = parseInt(min / 1000);
        let remainTime = totalTime * 1000 - min;
        // console.log(index+":"+remainTime)
        //remainTime=parseInt(remainTime/1000);
        //console.log(parseInt(min / 1000));
        day = parseInt(remainTime / (1000 * 60 * 60 * 24));
        //console.log("day:" + day);

        hour = parseInt(
          (remainTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
        );
        //console.log("hour:" + hour);

        mins = parseInt((remainTime % (1000 * 60 * 60)) / (1000 * 60));
        //console.log("mins:" + mins);

        secs = parseInt((remainTime % (1000 * 60)) / 1000);
        //console.log("secs of " + index + ":" + secs);
        // console.log("secs:" + this.secs);
        if (remainTime <= -1) {
          this.detail[index].ended = true;

          //console.log("Time's up!"); console.log("hour:" + hour);
          mins = -1;
          secs = -1;
          hour = -1;
          clearInterval(timee);
        }

        this.detail[index].days = day;
        this.detail[index].mins = mins;
        this.detail[index].secs = secs;
        this.detail[index].hours = hour;
      }, 1000);
    },
    toProposal(index) {
      this.$router.push({ name: "proposal", params: { index: index } });
      // window.location.reload();
    },
    async getWhitelist() {
      let whitelist = await this.contract.methods
        .whitelist(this.currentAccount)
        .call();
      this.whitelisted = whitelist;
      // console.log("Whitelist:" + whitelist);
    },
    async fetchContractbalance() {
      let balance = await web3.eth.getBalance(
        this.$route.params.contractAddress
      );
      balance = web3.utils.fromWei(balance.toString(), "ether");
      this.$store.state.contractBalance = balance;
      // console.log("Contract balance:" + this.$store.state.contractBalance);
    },
    async fetchReputation() {
      this.reputation = await Factory.methods
        .getProposalReputation(this.currentAccount)
        .call();
      let rep = this.reputation;
      if (rep <= 1) {
        this.targetLimit = 2000;
      } else if (rep == 2) {
        this.targetLimit = 4000;
      } else if (rep == 3) {
        this.targetLimit = 6000;
      } else if (rep == 4) {
        this.targetLimit = 4000;
      } else if (rep > 4) {
        this.targetLimit = 6000;
      }
    }
  },
  async created() {
    this.contract = new web3.eth.Contract(
      this.$store.state.abi,
      this.$route.params.contractAddress
    );
    this.no = await this.contract.methods.proposalCount().call();
    console.log("No:"+this.no)
    this.getAccount();
    // console.log("contract:" + this.$route.params.contractAddress);
    this.$store.dispatch(
      "fetchContractBalance",
      this.$route.params.contractAddress
    );

    await this.getDetails();
    await this.getWhitelist();
    await this.fetchReputation();
    let totalInvestment = parseInt(
      await this.contract.methods.totalInvestment().call()
    );

    let balance = await web3.utils.fromWei(totalInvestment.toString(), "ether");
    if(balance>0){
        balance = parseFloat(balance).toFixed(4);
    }
    this.$store.state.totalInvestment = balance;

    // console.log('params:'+typeof this.$route.params.active)
    //await this.fetchContractbalance();
    //console.log("Details:" + this.detail[0].title);
  }
};
</script>
<style>
.CardBorder {
  border-top-left-radius: 0px;
  border-top-right-radius: 15px;
  border-bottom-left-radius: 15px;
  border-bottom-right-radius: 15px;
}
.hr {
  width: 0.1px;
  height: 70px;
  display: flex;
  color: grey;
}
.overlay01 {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 2;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.7);
  opacity: 0;
  visibility: hidden;
  transition: 0.3s linear;
}

.text {
  position: absolute;
  top: 50%;
  left: 50%;

  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
}
</style>
