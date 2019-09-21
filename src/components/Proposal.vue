<template>
  <div style="margin-top:2%;">
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

    <!-- <h2
          v-if="showText"
          class="white--text font-weight-medium"
          style="font-size:20px;margin-top:24%"
    >Transaction is being processed</h2>-->
    <center>
      <v-chip
        v-if="ended && currentResult != 100"
        class="font-weight-medium"
        label
        depressed
        style="color:red;border:1px solid #90A4AE;background-color:transparent;font-size:17px;"
      >
        <v-icon left color="red">keyboard_arrow_down</v-icon>Failed
      </v-chip>
      <v-chip
        v-else-if="ended || !ended && currentResult >= 100"
        class="font-weight-medium mb-4 mt-0"
        label
        depressed
        style="color:green;border:1px solid #90A4AE;background-color:transparent;font-size:17px;"
      >
        <v-icon left color="green">keyboard_arrow_up</v-icon>Passed
      </v-chip>
      <v-chip
        v-else-if="!ended && currentResult<100"
        class="font-weight-medium"
        label
        depressed
        style="color: #90A4AE;border:1px solid #90A4AE;background-color:transparent;font-size:17px;"
      >Regular</v-chip>
    </center>
    <v-layout data-aos="fade-up" once="false" row wrap justify-center class="ml-2 mt-1">
      <v-flex xs12 lg6 xl6 md10 sm10>
        <div>
          <h1 style="margin-left:65px;color:#689BD6;">{{this.getData.title}}</h1>
        </div>
        <v-divider inset></v-divider>
        <div style="text-align:right" class="mt-2" v-if="!ended">
          <span class="mx-3 body font-weight-medium" style="color:#546E7A">Proposal ends in:</span>
          <span
            class="font-weight-bold"
            style="color:#546E7A;font-size:18px;"
          >{{this.getData.days}}d : {{this.getData.hours}}h : {{this.getData.mins}}m : {{this.getData.secs}}s</span>
        </div>

        <div v-else style="text-align:right" class="mt-2">
          <span class="mx-3 font-weight-bold" style="color:#546E7A;font-size:17px">Proposal ended</span>
        </div>
        <div style="overflow-wrap:break-word">
          <v-layout row wrap justify-start>
            <v-flex xs6 xl4 lg4 sm6 md6 style="overflow-word:break-word">
              <span :to="{name:'Profile',params:{ethAddress:getData.submitter}}">
                <router-link
                  :key="getData.submitter"
                  :to="{name:'Profile',params:{ethAddress:getData.submitter}}"
                >
                  <v-gravatar
                    class="mt-2"
                    style="margin-left:70px;border:#78909C solid 5px;border-radius:12px"
                    :to="{name:'Profile',params:{ethAddress:getData.submitter}}"
                    :email="getData.submitter"
                    alt="Nobody"
                    :size="42"
                    default-img="retro"
                  />
                </router-link>
              </span>

              <span
                style="display:inline-block;position:relative; bottom:30px;left:130px;"
                class="text-truncate hidden-xs-only font-weight-bold"
              >{{getData.submitter}}</span>

              <span style="display:inline-block;position:relative; bottom:80px;left:130px;">
                <v-rating
                  class="ma-0 pa-0 hidden-xs-only"
                  :value="getOverallReputation"
                  background-color="grey"
                  color="orange"
                  dense
                  readonly
                  half-increments
                  hover
                  size="25"
                ></v-rating>
              </span>
            </v-flex>
            <v-flex
              class="mt-3 ml-0 pl-0 text-md-left hidden-sm-and-up"
              xs9
              sm8
              xl6
              lg6
              md9
              style="text-align:center"
            >
              <!-- <span
                style="margin-bottom:10px;overflow-wrap:break-word"
                class="mt-3 mr-5 header text-md-right font-weight-bold hidden-xs-only"
              >{{this.getData.submitter}}</span>-->

              <span class="header font-weight-bold hidden-sm-and-up ml-4">{{this.getData.submitter}}</span>
            </v-flex>
          </v-layout>
          <h3
            style="margin-left:70px; margin-top:20px;font-size:18px;text-align:justify"
            class="font-weight-medium"
          >{{this.getData.desc}}</h3>
          <v-flex xs12 lg12 xl12 md12 sm12>
            <v-card flat style="margin-left:70px;" class="my-4 pa-0">
              <v-layout row wrap justify-start class="pa-0 ma-0">
                <v-flex lg4 xl4 xs6 md4 sm3 class="pa-0">
                  <v-card-text style="font-size:18px;color:#5D707F">
                    {{this.getData.target}} CAR
                    <span class="ml-1" style="color:black"></span>
                  </v-card-text>
                </v-flex>
                <v-flex
                  xs6
                  lg8
                  xl8
                  sm9
                  md7
                  style="text-align:left;"
                  class="pa-0 ml-0 text-truncate"
                >
                  <router-link
                    :key="getData.submitter"
                    :to="{name:'Profile',params:{ethAddress:getData.submitter}}"
                  >
                    <v-gravatar
                      style="margin-top:20px;"
                      :email="getData.submitter"
                      alt="Nobody"
                      :to="{name:'Profile',params:{ethAddress:getData.submitter}}"
                      :size="18"
                      default-img="retro"
                    ></v-gravatar>
                  </router-link>

                  <span
                    class="ml-2 mb-4 pb-2 hidden-xs-only"
                    style="font-size:16px;display:inline-block;position:relative;bottom:3px"
                  >{{this.getData.submitter}}</span>

                  <span
                    class="ml-2 mb-4 pb-2 hidden-sm-and-up"
                    style="font-size:16px;display:inline-block;position:relative;bottom:3px"
                  >{{this.getData.submitter.slice(0,7)}}...</span>
                </v-flex>
              </v-layout>
            </v-card>
          </v-flex>
          <a @click="toURL">
            <v-icon color="#0071FF" style="margin-left:70px; margin-top:40px;">attachment</v-icon>

            <span
              style="margin-bottom:20px;color:#0071FF;margin-left:3px"
              color="blue"
              class="mb-2 font-weight-medium"
            >Attachment ></span>
          </a>
          <p
            style="margin-left:70px;font-size:12px"
          >* Open this attachment to see more details about this proposal</p>
        </div>
        <div
          style="margin-top:50px;"
          v-if="!ended && getData.hasVoted==false && getData.memberCount<=getData.members && $route.params.blocked.toString()=='false' && currentResult<100 "
        >
          <h3 style="margin-left:70px;">Vote:</h3>
          <v-layout row class="mb-4">
            <v-flex xs3 mg3 md3 sm3 style="margin-left:10%;margin-right:3%;margin-top:3%;">
              <v-btn
                @click="vote"
                large
                color="green"
                style="border-radius:15px;color:white"
                depressed
              >
                <v-icon left>thumb_up</v-icon>Vote
              </v-btn>
            </v-flex>
            <v-flex xs3 mg3 md3 sm3 style="margin-left:15%;margin-top:3%;">
              <v-btn
                @click="DisVote"
                large
                color="red"
                style="border-radius:15px;color:white"
                depressed
              >
                <v-icon left>thumb_down</v-icon>Disvote
              </v-btn>
            </v-flex>
          </v-layout>
        </div>
        <div v-else-if="ended || currentResult>=100" style="margin-top:50px">
          <center>
            <h2 style="color:#546E7A">Voting is disabled for this proposal</h2>
          </center>
        </div>
        <div v-else-if="getData.hasVoted" style="margin-top:50px">
          <center>
            <h2 style="color:#546E7A">You have already voted for this proposal</h2>
          </center>
        </div>
        <div
          v-else-if="getData.memberCount==getData.members && whitelisted==false"
          style="margin-top:50px"
        >
          <center>
            <h2 style="color:#546E7A">Participants limit is exceeded</h2>
          </center>
        </div>
        <div
          v-if="ended && currentResult<100 && getData.hasVoted && getData.hasVotedNo==false && inSupport && getData.returned==false && $route.params.ended.toString()=='false'"
        >
          <center>
            <v-btn
              class="mt-3 mb-3"
              @click="returnTokensYes"
              depressed
              color="blue"
              outline
            >Take back tokens</v-btn>
          </center>
        </div>

        <!-- <div
          v-if="ended && currentResult==100 && getData.hasVoted && getData.hasVotedNo==true && inSupport==false && getData.returned==false && $route.params.ended.toString()=='false'"
        >
          <center>
            <v-btn
              class="mt-3 mb-3"
              @click="returnTokensNo"
              depressed
              color="blue"
              outline
            >Take back tokens</v-btn>
          </center>
        </div>-->
        <div v-else-if="ended && getData.returned">
          <center>
            <h2 style="color:#546E7A">Tokens have been refunded to you</h2>
          </center>
        </div>
        <div
          v-if="currentResult==100 && getData.submitter==currentAddress && getData.executed==false"
        >
          <center>
            <v-btn
              class="mt-3 mb-3"
              @click="executeProposal"
              depressed
              color="blue"
              outline
            >Claim Tokens</v-btn>
          </center>
        </div>
        <div
          v-else-if="currentResult==100 && getData.submitter==currentAddress && getData.executed==true"
        >
          <center>
            <h2 style="color:#546E7A">You have claimed your tokens</h2>
          </center>
        </div>
        <div
          v-if="ended && getData.hasVotedNo==true && yesVotes==0 && noVotes>0 && getData.hasIncreasedReputation==false"
        >
          <center>
            <v-btn
              class="mt-3 mb-3"
              @click="increaseReputation"
              depressed
              color="blue"
              outline
            >Boost your reputation as a voter</v-btn>
          </center>
        </div>
      </v-flex>
      <v-flex class="hidden-sm-and-down" lg3 xl3 md6 sm8 xs4 style="margin-left:80px;">
        <v-card flat class="pa-1 cardBorder">
          <v-tooltip lazy top>
            <template v-slot:activator="{ on }">
              <v-card-title v-on="on" @click="voteList=true" style="color:#689BD6">
                <h2>Votes</h2>
                <v-divider class="mx-3" vertical></v-divider>
                <h4>{{totalVotes}} votes ></h4>
              </v-card-title>
            </template>
            <span>Click to see voters</span>
          </v-tooltip>

          <v-divider color="#E0E0E0"></v-divider>
          <v-card-text>
            <v-layout row wrap justify-space-between class="pa-2 mt-2">
              <v-flex lg5 xl5 xs6 md6 sm6>
                <div>
                  <center>
                    <div>
                      <v-icon left color="#9AA9B5">thumb_up</v-icon>
                      <span style="margin-bottom:20px;color:#9AA9B5" class="font-weight-medium">For</span>
                      <div>
                        <span
                          style="margin-left:62px;font-size:17px;color:#506176"
                          class="font-weight-bold"
                          v-if="yesVotes>0"
                        >{{yesVotes}}%</span>

                        <span
                          style="margin-left:62px;font-size:17px;color:#506176"
                          class="font-weight-bold"
                          v-if="yesVotes<=0"
                        >0.00%</span>
                      </div>
                    </div>
                    <div>
                      <div class="mt-3">
                        <v-icon class="ml-3" left color="#9AA9B5">thumb_down</v-icon>
                        <span
                          style="margin-bottom:20px;color:#9AA9B5"
                          class="font-weight-medium"
                        >Against</span>
                        <div>
                          <span
                            style="margin-left:62px;font-size:17px;color:#506176"
                            class="font-weight-bold"
                            v-if="noVotes<=0"
                          >0.00%</span>
                          <span
                            style="margin-left:62px;font-size:17px;color:#506176"
                            class="font-weight-bold"
                            v-if="noVotes>0"
                          >{{noVotes}}%</span>
                        </div>
                      </div>
                    </div>
                  </center>
                </div>
              </v-flex>

              <v-flex lg4 xl4 md6 sm6 xs6>
                <v-progress-circular
                  v-if="currentResult>=0"
                  :rotate="-90"
                  :size="110"
                  :width="7"
                  :value="currentResult"
                  color="teal"
                  class="mt-0"
                  style=" margin: 1rem;text-align:right;color:black;"
                >{{ currentResult }}%</v-progress-circular>

                <v-progress-circular
                  v-else-if="negativeResult!=null"
                  :rotate="-90"
                  :size="110"
                  :width="7"
                  :value="negativeResult"
                  color="red"
                  class="mt-0"
                  style=" margin: 1rem;text-align:right;color:black;"
                >{{ this.negativeResult }}%</v-progress-circular>
              </v-flex>
            </v-layout>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
    <v-layout class="hidden-md-and-up mt-5" row wrap justify-center>
      <v-flex xs11 sm8>
        <v-card flat class="pa-1 mb-3 cardBorder">
          <v-tooltip lazy top>
            <template v-slot:activator="{ on }">
              <v-card-title v-on="on" @click="voteList=true" style="color:#689BD6">
                <h2>Votes</h2>
                <v-divider class="mx-3" vertical></v-divider>
                <h4>{{totalVotes}} votes ></h4>
              </v-card-title>
            </template>
            <span>Click to see voters</span>
          </v-tooltip>
          <v-divider color="#E0E0E0"></v-divider>
          <v-card-text>
            <v-layout row wrap justify-space-between class="pa-2 mt-2">
              <v-flex xl4 lg4 xs6 md6 sm6>
                <div>
                  <center>
                    <div>
                      <v-icon left color="#9AA9B5">thumb_up</v-icon>
                      <span style="margin-bottom:20px;color:#9AA9B5" class="font-weight-medium">For</span>
                      <div>
                        <span
                          style="margin-left:62px;font-size:17px;color:#506176"
                          class="font-weight-bold"
                          v-if="yesVotes>0"
                        >{{yesVotes}}%</span>

                        <span
                          style="margin-left:62px;font-size:17px;color:#506176"
                          class="font-weight-bold"
                          v-if="yesVotes<=0"
                        >0.00%</span>
                      </div>
                    </div>
                    <div>
                      <div class="mt-3">
                        <v-icon class="ml-4" left color="#9AA9B5">thumb_down</v-icon>
                        <span
                          style="margin-bottom:20px;color:#9AA9B5"
                          class="font-weight-medium"
                        >Against</span>
                        <div>
                          <span
                            style="margin-left:62px;font-size:17px;color:#506176"
                            class="font-weight-bold"
                            v-if="noVotes<=0"
                          >0.00%</span>
                          <span
                            style="margin-left:62px;font-size:17px;color:#506176"
                            class="font-weight-bold"
                            v-if="noVotes>0"
                          >{{noVotes}}%</span>
                        </div>
                      </div>
                    </div>
                  </center>
                </div>
              </v-flex>

              <v-flex xl4 lg4 md6 sm6 xs6>
                <v-progress-circular
                  :rotate="-90"
                  :size="110"
                  :width="7"
                  :value="currentResult"
                  color="teal"
                  class="mt-0"
                  v-if="currentResult>=0"
                  style=" margin: 1rem;text-align:right;color:black;"
                >{{ this.currentResult }}%</v-progress-circular>
                <v-progress-circular
                  :rotate="-90"
                  :size="110"
                  :width="7"
                  :value="negativeResult"
                  color="red"
                  class="mt-0"
                  v-else-if="negativeResult!=null"
                  style=" margin: 1rem;text-align:right;color:black;"
                >{{ this.negativeResult }}%</v-progress-circular>
              </v-flex>
            </v-layout>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
    <!-- <v-layout row justify-center class="ml-2">
      <v-flex xs10 sm10 md5 lg5>
        <h5 style>Address</h5>
      </v-flex>
    </v-layout>-->
    <v-dialog class="py-4 my-4" width="400px" v-model="whitelistError">
      <v-card class="pa-1" style="border-radius:15px;">
        <v-card-text class="headline font-weight-medium" style="text-align:center">{{title}}</v-card-text>
        <v-card-text class="body-2 font-weight-regular">{{content}}</v-card-text>
        <v-card-text class="font-weight-black mt-0 pt-0">{{this.$route.params.contractAddress}}</v-card-text>
        <center>
          <v-btn
            v-clipboard="$route.params.contractAddress"
            @success="success"
            @error="failed"
            class="py-0 my-0"
            depressed
            flat
            large
            color="primary"
          >Copy</v-btn>
        </center>
      </v-card>
    </v-dialog>

    <v-dialog
      style="border-top-left-radius:15px;border-top-right-radius:15px;"
      v-model="showVote"
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
          <v-icon left class="white--text ml-1">edit</v-icon>Voting details
        </v-card-title>
        <v-form ref="form" t>
          <v-text-field
            v-model="Justification"
            box
            class="mx-4"
            :rules="titleRules"
            required
            outline
            label="Justification"
          ></v-text-field>

          <v-text-field
            class="mx-4"
            outline
            :rules="targetRules"
            v-model.number="power"
            label="Power"
          
            placeholder="Enter power in tokens"
          ></v-text-field>

          <v-card-actions class="justify-end pb-3">
            <v-btn
              @click="reset"
              class="mr-3 blue--text lighten-3"
              style="border-radius:15px;"
              color="#B2EBF2"
            >Cancel</v-btn>
            <v-btn
              v-if="upVote==true"
              class="mr-3"
              style="border-radius:15px;"
              @click="vote"
              color="blue white--text"
            >Sumbit</v-btn>
            <v-btn
              v-if="disVote==true"
              class="mr-3"
              style="border-radius:15px;"
              @click="DisVote"
              color="blue white--text"
            >Sumbit</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>
    <v-snackbar v-model="lessBalance" :color="color" :timeout="2000">
      {{text}}
      <v-btn dark flat @click="copySucceeded = false">Close</v-btn>
    </v-snackbar>
   
    <v-dialog
      style="border-top-left-radius:15px;border-top-right-radius:15px;"
      v-model="voteList"
      persistent
      class="pa-0 ma-0"
      width="700px"
    >
      <v-layout row justify-center>
        <v-flex xs12 md12 sm12 lg12 xl12>
          <v-card
            flat
            class="pa-0 ma-0"
            style="border-top-left-radius:15px;border-top-right-radius:15px;"
          >
            <v-card-title
              class="pa-2 white--text font-weight-medium"
              style="background-color:#1A237E;font-size:20px;"
            >{{totalVotes}} Votes</v-card-title>
            <center>
              <v-card-text>
                <v-layout class="mt-2" row wrap justify-space-between>
                  <v-flex xs4 sm4 md4 lg4 xl4 fill-height>
                    <v-icon small color="#9AA9B5">thumb_up</v-icon>
                    <span style="color:#9AA9B5;font-size:18px" class="font-weight-medium ml-1">For</span>
                    <div>
                      <span
                        style="font-size:17px;color:#506176"
                        class="font-weight-bold"
                        v-if="yesVotes>0"
                      >{{yesVotes}}%</span>

                      <span
                        style="font-size:17px;color:#506176"
                        class="font-weight-bold"
                        v-if="yesVotes<=0"
                      >0.00%</span>
                    </div>
                  </v-flex>
                  <v-flex xl4 lg4 md4 sm4 xs4>
                    <v-progress-circular
                      :rotate="-90"
                      :size="85"
                      :width="7"
                      :value="currentResult"
                      color="teal"
                      class="mt-0"
                      v-if="currentResult>=0"
                      style=" margin: 1rem;color:black;"
                    >{{ this.currentResult}} %</v-progress-circular>
                    <v-progress-circular
                      :rotate="-90"
                      :size="85"
                      :width="7"
                      :value="negativeResult"
                      color="red"
                      class="mt-0"
                      v-else-if="negativeResult!=null"
                      style=" margin: 1rem;color:black;"
                    >{{ this.negativeResult }} %</v-progress-circular>
                  </v-flex>
                  <v-flex xs4 sm4 md4 lg4 xl4>
                    <v-icon small color="#9AA9B5">thumb_down</v-icon>
                    <span
                      style="color:#9AA9B5;font-size:18px"
                      class="font-weight-medium ml-1"
                    >Against</span>
                    <div>
                      <span
                        style="font-size:17px;color:#506176"
                        class="font-weight-bold"
                        v-if="noVotes<=0"
                      >0.00%</span>
                      <span
                        style="font-size:17px;color:#506176"
                        class="font-weight-bold"
                        v-if="noVotes>0"
                      >{{noVotes}}%</span>
                    </div>
                  </v-flex>
                </v-layout>
                <v-divider class="my-4"></v-divider>
                <v-layout row wrap justify-start>
                  <v-flex v-for="(detail,index) in fetchYesVotes" :key="index" xs6 lg6 md6 sm6 xl6>
                    <div>
                      <router-link
                        :key="getData.submitter"
                        :to="{name:'Profile',params:{ethAddress:detail[2]}}"
                      >
                        <span>
                          <v-gravatar
                            class="mt-2 mr-2"
                            style="margin-left:70px;"
                            :email="detail[2]"
                            alt="Nobody"
                            :size="20"
                            default-img="retro"
                          />
                        </span>
                        <span
                          class="mr-4"
                          style="display:inline-block;bottom:6px;position:relative;"
                        >{{detail[2].slice(0,7)}}...</span>
                      </router-link>
                      <span
                        style="display:inline-block;bottom:6px;position:relative"
                      >{{(detail[4])}} tokens</span>
                    </div>
                  </v-flex>

                  <v-flex v-for="(detail,index) in fetchNoVotes" :key="index" xs6 lg6 md6 sm6 xl6>
                    <div>
                      <router-link
                        active-class="color:transparent"
                        :to="{name:'Profile',params:{ethAddress:detail[2]}}"
                      >
                        <span>
                          <v-gravatar
                            class="mt-2 mr-2"
                            style="margin-left:70px;"
                            :email="detail[2]"
                            alt="Nobody"
                            :size="20"
                            default-img="retro"
                          />
                        </span>
                        <span
                          style="display:inline-block;bottom:6px;position:relative"
                          class="mr-4"
                        >{{detail[2].slice(0,7)}}...</span>
                      </router-link>
                      <span
                        style="display:inline-block;bottom:6px;position:relative"
                      >{{(detail[4])}} tokens</span>
                    </div>
                  </v-flex>
                </v-layout>
              </v-card-text>
            </center>
            <v-divider></v-divider>
            <center>
              <v-btn
                color="blue"
                class="my-2"
                @click="voteList=false"
                style="border-radius:15px;text-align:right;color:white"
              >Close</v-btn>
            </center>
          </v-card>
        </v-flex>
      </v-layout>
    </v-dialog>
  </div>
</template>
<script>
import { TNStoken } from "../../embarkArtifacts/contracts";
import { Factory } from "../../embarkArtifacts/contracts";
export default {
  name: "Proposal",
  components: {},
  data() {
    return {
      totalVotes: 0,
      yesVotes: 0,
      noVotes: 0,
      voteList: false,
      text: "",
      upVote: false,
      disVote: false,
      inSupport: false,
      title: "",
      content: "",
      Justification: null,
      power: 0,
      loading: false,
      showVote: false,
      showText: false,
      tokenBalance: 0,
      lessBalance: false,
      contractAddress: this.$route.params.contractAddress,
      copySucceeded: false,
      currentAddress: "",
      whitelisted: false,
      whitelistError: false,
      currentResult: 0,
      negativeResult: null,
      yesVotesList: [],
      noVotesList: [],
      totalTokens: 0,

      ended: false,
      titleRules: [v => !!v || "Please enter Justification"],
      targetRules: [
        v => !!v || "Please enter power",
        v => /^[0-9]/.test(v) || "Only numeric value is allowed",
        v => v >= 50 || "Power must be greater than or equal to 50",
        v =>
          v + this.totalTokens <= this.getData.target || "Target exceeded, max you can vote with "+(this.getData.target-this.totalTokens).toString()
          // "Target is excceded, collected funds can't be more than a target, max you can vote with " +this.getData.target -Math.abs(this.totalTokens) +" tokens."
      ],

      contract: null,
      detail: null
    };
  },
  asyncComputed: {
    async getData() {
      return this.detail;
    },
    async fetchYesVotes() {
      return this.yesVotesList;
    },
    async fetchNoVotes() {
      return this.noVotesList;
    },
    async getOverallReputation() {
      let rep = 0;
      return rep;
    }

    // async getAccount(){
    //   let acc=await web3.eth.getAccounts()
    //   return acc[0]

    // }
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
    async executeProposal() {
      try {
        this.loading = true;
        await this.contract.methods
          .exceuteProposal(this.$route.params.index)
          .send({ from: this.currentAddress });
        let executed = await this.contract.methods
          .getExecuted(this.$route.params.index)
          .call();
        this.getData.executed = executed;
        await this.$store.dispatch("fetchDaoReputation", this.currentAddress);
        await this.$store.dispatch(
          "fetchProposalReputation",
          this.currentAddress
        );
        await this.$store.dispatch("fetchVoteReputation", this.currentAddress);
        this.loading = false;
        this.$store.state.snack = true;
        this.$store.state.text =
          "Tokens claimed successfully, refresh to see in your assets section";
        this.$store.state.color = "green";
      } catch (err) {
        this.loading = false;
        this.$store.state.snack = true;
        this.$store.state.text = err;
        this.$store.state.color = "red";
      }
    },
    async returnTokensYes() {
      try {
        this.loading = true;
        await this.contract.methods
          .returnTokensToYesVoters(this.$route.params.index)
          .send({ from: this.currentAddress });
        this.loading = false;
        this.$store.state.snack = true;
        this.$store.state.color = "green";
        this.$store.state.text = "Tokens refunded successfully";
        this.getData.returned = await this.contract.methods
          .returned(index, this.currentAddress)
          .call();
        let totalInvestment = parseInt(
          await this.contract.methods.totalInvestment().call()
        );

        let balance = await web3.utils.fromWei(totalInvestment, "ether");
        balance = parseFloat(balance).toFixed(4);
        this.$store.state.totalInvestment = balance;
      } catch (err) {
        this.loading = false;
        this.$store.state.snack = true;
        this.$store.state.color = "red";
        this.$store.state.text = "Something went wrong";
      }
    },

    // async returnTokensNo() {
    //   try {
    //     this.loading = true;
    //     await this.contract.methods
    //       .returnTokensToNoVoters(this.$route.params.index)
    //       .send({ from: this.currentAddress });
    //     this.loading = false;
    //     this.$store.state.snack = true;
    //     this.$store.state.color = "green";
    //     this.$store.state.text = "Tokens refunded successfully";
    //     this.getData.returned = await this.contract.methods
    //       .returned(index, this.currentAddress)
    //       .call();
    //     let totalInvestment = await this.contract.methods
    //       .totalInvestment()
    //       .call();
    //     this.$store.state.totalInvestment = totalInvestment;
    //   } catch (err) {
    //     this.loading = false;
    //     this.$store.state.snack = true;
    //     this.$store.state.color = "red";
    //     this.$store.state.text = "Something went wrong";
    //   }
    // },
    async whitelist() {
      let ans = await this.contract.methods
        .whitelist(this.currentAddress)
        .call();
      // console.log(ans);
      this.whitelisted = ans;
    },
    async fetchReputation() {
      let dao = parseInt(
        await Factory.methods.getReputation(this.getData.submitter).call()
      );
      let proposal = parseInt(
        await Factory.methods
          .getProposalReputation(this.getData.submitter)
          .call()
      );
      let vote = parseInt(
        await Factory.methods.getVoteReputation(this.getData.submitter).call()
      );

      this.getOverallReputation = ((dao + proposal + vote) / 3).toFixed(1);

      //console.log("reputation:"+this.getOverallReputation)

      // console.log("reputaion:"+this.getOverallReputation)
    },
    reset() {
      this.$refs.form.reset();
      this.$refs.form.resetValidation();
      this.showVote = false;
      // this.title = "";
      // (this.description = ""), (this.url = ""), (this.target = null);
      // this.duration = null;
      // this.showForm = false;
    },

    async vote() {
      await this.whitelist();

      if (this.whitelisted == true && this.getData.hasVoted == false) {
        this.showVote = true;
        this.disVote = false;
        this.upVote = true;
        if (this.$refs.form.validate()) {
          await this.getTokenBalance();
          if (this.power <= this.tokenBalance) {
            try {
              this.loading = true;
              this.showText = true;
              await this.contract.methods
                .voteProposal(
                  this.$route.params.index,
                  true,
                  this.Justification,
                  this.power
                )
                .send({ from: this.currentAddress });
              this.reset();
              await this.getCurrentResult();

              await this.getTotalVotes();
              await this.getYesVotes();
              await this.getNoVotes();
              let hasVoted = await this.contract.methods
                .voters(this.$route.params.index, this.currentAddress)
                .call();

              let memberCount = await this.contract.methods
                .memberCount()
                .call();
              let totalInvestment = await this.contract.methods
                .totalInvestment()
                .call();
              let balance = await web3.utils.fromWei(totalInvestment, "ether");
              balance = parseFloat(balance).toFixed(4);
              this.$store.state.totalInvestment = balance;

              this.getData.hasVoted = hasVoted;
              this.getData.memberCount = memberCount;
              this.loading = false;
              this.showText = false;
              this.$store.state.snack = true;
              this.$store.state.text = "Vote has been submitted successfully";
              this.$store.state.color = "green";
              await this.fetchVotes();
            } catch (e) {
              this.loading = false;
              this.$store.state.snack = true;
              this.$store.state.text = "Something went wrong";
              this.$store.state.color = "red";
            }
          } else {
            this.whitelistError = true;
            this.title = "Insufficient Balance";
            this.content =
              "You don't have enough tokens to vote, Your current balanace is " +
              this.tokenBalance +
              " Carati, please send 0.01 or more ETH to following address.";
            this.reset();
          }
        }
      } else if (this.whitelisted == false) {
        this.whitelistError = true;
        this.title = "You are not whitelisted";
        this.content =
          "Please send 0.01ETH to following address to get whitelisted, and if you wanna buy tokens then you can send more ETH, price is 1ETH=10K carati as of now";
      }
    },

    async DisVote() {
      await this.whitelist();

      if (this.whitelisted == true && this.getData.hasVoted == false) {
        this.showVote = true;
        this.upVote = false;
        this.disVote = true;
        if (this.$refs.form.validate()) {
          await this.getTokenBalance();
          if (this.power <= this.tokenBalance) {
            try {
              this.loading = true;
              this.showText = true;
              await this.contract.methods
                .voteProposal(
                  this.$route.params.index,
                  false,
                  this.Justification,
                  this.power
                )
                .send({ from: this.currentAddress });
              this.reset();
              await this.getCurrentResult();

              await this.getTotalVotes();
              await this.getYesVotes();
              await this.getNoVotes();
              let hasVoted = await this.contract.methods
                .voters(this.$route.params.index, this.currentAddress)
                .call();
              let hasVotedNo = await this.contract.methods
                .hasVotedNo(this.$route.params.index, this.currentAddress)
                .call();
              let memberCount = await this.contract.methods
                .memberCount()
                .call();
              let totalInvestment = await this.contract.methods
                .totalInvestment()
                .call();
              let balance = await web3.utils.fromWei(totalInvestment, "ether");
              balance = parseFloat(balance).toFixed(4);
              this.$store.state.totalInvestment = balance;
              this.getData.hasVoted = hasVoted;
              this.getData.memberCount = memberCount;
              this.getData.hasVotedNo = hasVotedNo;
              this.loading = false;
              this.showText = false;
              this.$store.state.snack = true;
              this.$store.state.text = "Vote has been submitted successfully";
              this.$store.state.color = "green";
              await this.fetchVotes();
            } catch (e) {
              this.loading = false;
              this.$store.state.snack = true;
              this.$store.state.text = "Something went wrong";
              this.$store.state.color = "red";
            }
          } else {
            this.whitelistError = true;
            this.title = "Insufficient Balance";
            this.content =
              "You don't have enough tokens to vote, Your current balanace is " +
              this.tokenBalance +
              " Carati, please send 0.01 or more ETH to following address.";
            this.reset();
          }
        }
      } else if (this.whitelisted == false) {
        this.whitelistError = true;
        this.title = "You are not whitelisted";
        this.content =
          "Please send 0.01ETH to following address to get whitelisted";
      }
    },
    async getTokenBalance() {
      let bal = await TNStoken.methods.balanceOf(this.currentAddress).call();
      this.tokenBalance = bal / 10 ** 18;
    },
    async getDetail() {
      this.loading = true;
      let index = this.$route.params.index;
      this.contract = new web3.eth.Contract(
        this.$store.state.abi,
        this.$route.params.contractAddress
      );

      let title = await this.contract.methods.getTitle(index).call();
      let description = await this.contract.methods
        .getDescription(index)
        .call();
      let url = await this.contract.methods.getURL(index).call();
      let target = await this.contract.methods.getTarget(index).call();
      let submitter = await this.contract.methods.getSubmitter(index).call();
      let deadline = await this.contract.methods.getDeadline(index).call();
      let hasVoted = await this.contract.methods
        .voters(this.$route.params.index, this.currentAddress)
        .call();
      let executed = await this.contract.methods
        .getExecuted(this.$route.params.index)
        .call();
      let returned = await this.contract.methods
        .returned(index, this.currentAddress)
        .call();
      let members = await this.contract.methods.members().call();
      let memberCount = await this.contract.methods.memberCount().call();

      let totalInvestment = await this.contract.methods
        .totalInvestment()
        .call();
      let balance = await web3.utils.fromWei(totalInvestment, "ether");
      balance = parseFloat(balance).toFixed(4);
      balance=balance<=0?0:balance;
      this.$store.state.totalInvestment = balance;

      let hasVotedNo = await this.contract.methods
        .hasVotedNo(this.$route.params.index, this.currentAddress)
        .call();
      let hasIncreasedReputation = await this.contract.methods
        .hasIncreasedReputation(this.$route.params.index, this.currentAddress)
        .call();
      this.getData = {
        title: title,
        desc: description,
        url: url,
        target: target,
        submitter: submitter,
        days: 0,
        hours: 0,
        mins: 0,
        secs: 0,
        hasVoted: hasVoted,
        returned: returned,
        members: members,
        memberCount: memberCount,
        executed: executed,
        hasVotedNo: hasVotedNo,
        hasIncreasedReputation: hasIncreasedReputation
      };
      this.whitelisted = await this.contract.methods
        .whitelist(this.currentAddress)
        .call();
      this.timer(index);
      // console.log("details:" + this.getData.title);
      // console.log("whitelisted:" + this.whitelisted);

      this.loading = false;
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
          this.ended = true;
          //console.log("Time's up!"); console.log("hour:" + hour);
          mins = -1;
          secs = -1;
          hour = -1;
          clearInterval(timee);
        }
        this.getData.days = day;
        this.getData.mins = mins;
        this.getData.secs = secs;
        this.getData.hours = hour;
      }, 1000);
    },
    async hasIncreasedReputation() {
      try {
        this.loading = true;
        await this.contract.methods
          .voteAssignNo(this.$route.params.index)
          .send({ from: this.currentAddress });
        let rep = await this.contract.methods
          .hasIncreasedReputation(this.$route.params.index, this.currentAddress)
          .call();
        this.getData.hasIncreasedReputation = rep;
        await this.$store.dispatch("fetchDaoReputation", this.currentAddress);
        await this.$store.dispatch(
          "fetchProposalReputation",
          this.currentAddress
        );
        await this.$store.dispatch("fetchVoteReputation", this.currentAddress);
        this.loading = false;
        this.$store.state.snack = true;
        this.$store.state.text = "Your Reputaion as a voter has been updated.";
        this.$store.state.color = "green";
      } catch (err) {
        this.loading = false;
        this.$store.state.snack = true;
        this.$store.state.text = "Something went wrong";
        this.$store.state.color = "red";
      }
    },
    toURL() {
      window.open(this.getData.url, "_blank");
    },
    async getVoters() {
      for (let i = 0; i < this.totalVotes; i++) {
        let arr = await this.contract.methods.votes(i).call();
        // console.log("Voters:" + arr[1]);
      }
    },
    async getTotalVotes() {
      this.totalVotes = await this.contract.methods
        .getTotalVotes(this.$route.params.index)
        .call();

      // console.log("Total votes:" + this.totalVotes);
    },
    async getYesVotes() {
      this.yesVotes = await this.contract.methods
        .getYesVotes(this.$route.params.index)
        .call();

      this.yesVotes = (this.yesVotes * 100) / this.totalVotes;
      this.yesVotes = this.yesVotes > 0 ? this.yesVotes.toFixed(3) : 0.0;
    },

    async getNoVotes() {
      this.noVotes = await this.contract.methods
        .getNoVotes(this.$route.params.index)
        .call();

      this.noVotes = (this.noVotes * 100) / this.totalVotes;

      this.noVotes = this.noVotes > 0 ? this.noVotes.toFixed(3) : 0.0;
    },
    async getCurrentResult() {
      this.currentResult = await this.contract.methods
        .getCurrentResult(this.$route.params.index)
        .call();
      
     
      if (this.currentResult < 0) {
         this.totalTokens = 0
         console.log("total tokens:"+this.totalTokens)
        this.negativeResult = Math.abs(
          ((this.currentResult * 100) / this.getData.target).toFixed(3)
        );
        // console.log("negative:" + this.negativeResult);
      } else {
         this.totalTokens = Math.abs(this.currentResult);
        // console.log("current result:" + this.currentResult);
        this.currentResult = (
          (this.currentResult * 100) /
          this.getData.target
        ).toFixed(3);
        // console.log("Current:" + this.currentResult);
      }
    },
    async fetchVotes() {
      let totalVotes = await this.contract.methods.voteCount().call();
      for (let i = 0; i < totalVotes; i++) {
        let arr = await this.contract.methods.votes(i).call();
        // console.log("vote no:" + arr[0] + " type :" + arr[1]);
        if (arr[0] == this.$route.params.index && arr[1] == true) {
          console.log("positive voter:"+arr[2])
          if (arr[2] == this.currentAddress) {
            this.inSupport = true;
          }

          this.fetchYesVotes.push(arr);
        }
        if (arr[0] == this.$route.params.index && arr[1] == false) {
          console.log("negative voter:"+arr[2])
          this.fetchNoVotes.push(arr);
        }
      }
      // console.log("Votes:" + this.fetchNoVotes[1]);
    }
  },
  async mounted() {
    //await this.$loadScript("https://cdn.jsdelivr.net/npm/jdenticon@2.1.1");
  },
  async created() {
    this.loading=true
    let add = await web3.eth.getAccounts();
    this.currentAddress = add[0];
    // console.log("Current address:" + this.currentAddress);
    await this.getTokenBalance();
    // console.log("Balance:" + this.tokenBalance);
    await this.getDetail();
    await this.fetchReputation();
    // console.log("address::" + this.$route.params.contractAddress);
    await this.getCurrentResult();
    await this.getTotalVotes();
    await this.getYesVotes();
    await this.getNoVotes();
    await this.getVoters();
    await this.fetchVotes();
    this.reset();
  }
};
</script>
<style scoped>
.cardBorder {
  border-top-left-radius: 0px;
  border-top-right-radius: 15px;
  border-bottom-left-radius: 15px;
  border-bottom-right-radius: 15px;
}
</style>

