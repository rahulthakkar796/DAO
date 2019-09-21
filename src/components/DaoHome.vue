<template>
  <div class="mt-5">
    <center>
      <v-btn v-if="!hasInjected" depressed dark style="border-radius:8px;" color="blue">
        <img class="mx-2" width="20px" height="20px" src="../assets/metamask.png">login into metamask
      </v-btn>

      <v-btn
        v-else-if="hasInjected && blocked==false"
        @click="showDaoForm"
        style="color:white"
        depressed
        color="blue"
      >
        <v-icon left>add</v-icon>Create a new DAO
      </v-btn>
    </center>

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
    <v-layout row wrap justify-center v-if="no>0 && detail.length>0">
      <v-flex xl12 lg12 xs12 md8 sm12>
        <h3 class="purple--text headline">All DAOs</h3>

        <v-divider></v-divider>
      </v-flex>
    </v-layout>
    <center>
      <div v-if="no==0" class="my-5">
        <v-layout row wrap justify-center>
          <v-flex lg6 sm8 md8 xl6 xs12>
            <v-card
              color="#fff"
              flat
              class="pa-2"
              style="border-radius:10px;border:3px solid #689BD6"
            >
              <v-icon class="font-weight-regular" color="#546E7A" size="320px">mood_bad</v-icon>
              <h1 class="font-weight-medium" style="font-size:30px;color:#546E7A">No DAOs found</h1>
            </v-card>
          </v-flex>
        </v-layout>
      </div>
    </center>

    <v-layout row wrap justify-center class="my-4">
      <v-flex xl4 lg4 md6 sm6 xs12 v-for="(detail,index) in details" :key="detail.address">
        <v-card
          style="border-radius:15px;border-bottom:0.5px solid #689BD6;border-left:0.5px solid #689BD6;border-right:0.5px solid #689BD6"
          class="ma-2"
          data-aos="fade-up"
          once="false"
          flat
          color="#fff"
          hover
          data-aos-once="false"
          data-aos-easing="ease-in-out"
        >
          <router-link
            :to="{name:'DAO',params:{contractAddress:detail.address,title:detail.title,active:detail.active,ended:detail.ended,blocked:blocked}}"
          >
            <v-card-text
              style="border-top-right-radius:15px;border-top-left-radius:15px;border:0.5px solid #689BD6"
              v-rainbow
              class="headline font-weight-medium white--text"
            >
              <v-layout row wrap justify-start class="pa-0 ma-0">
                <v-flex xs12 xl12 lg12 sm12 md12 style="text-align:right" class="pa-0 ma-0">
                  <p
                    v-if="detail.ended==false && detail.lastEnded==false"
                    style="text-align:left;font-size:15px"
                  >DAO ends in {{detail.days}}d:{{detail.hours}}h :{{detail.mins}}m :{{detail.secs}}s</p>
                  <p
                    v-else-if="detail.ended==true && detail.lastEnded==false && detail.totalInvestment>0"
                    style="text-align:left;font-size:15px"
                  >Deadline for owner to return the funds:{{detail.days}}d:{{detail.hours}}h :{{detail.mins}}m :{{detail.secs}}s</p>
                  <p
                    v-else-if="detail.ended==true  && detail.investment<=0"
                    style="text-align:left;font-size:15px"
                  >Nobody has participated in this DAO yet, therefore this DAO is inactive.</p>
                  <p v-else style="text-align:left;font-size:17px">DAO is ended</p>
                  <p
                    class="my-3"
                    v-if="detail.ended==true && detail.lastEnded==false && detail.owner==address && detail.totalInvestment>0 && detail.endedProposal>0"
                    style="text-align:left;font-size:13px"
                  >You are an owner of this DAO, please deposit {{detail.totalInvestment}} ETH in this DAO</p>
                </v-flex>
              </v-layout>
              {{detail.title}}
            </v-card-text>

            <v-divider></v-divider>
            <center>
              <v-card-text class="caption ma-0 pa-1 blue--text">Details</v-card-text>
            </center>

            <v-divider></v-divider>
            <center>
              <v-layout row wrap justify-center class="mx-4 py-4">
                <v-flex xs3 xl3 lg3 sm3 style="text-overflow: ellipsis;">
                  <div class="pa-0 ma-0">
                    <h2 style="color:black">{{detail.memberCount}}</h2>
                  </div>
                  <div style="text-overflow: ellipsis;">
                    <h3 class="grey--text darken-3">Participants</h3>
                  </div>
                </v-flex>
                <v-flex xs3 xl3 lg3 sm3 md3>
                  <div>
                    <h2 style="color:black">{{detail.proposals}}</h2>
                  </div>
                  <div>
                    <h3 class="grey--text darken-3">Proposals</h3>
                  </div>
                </v-flex>
                <v-flex xs3 xl3 lg3 sm3 md3>
                  <div>
                    <h2 style="color:black">{{detail.members}}</h2>
                  </div>
                  <div>
                    <h3 class="grey--text darken-3">Partcipants Limit</h3>
                  </div>
                </v-flex>
                <v-flex xs3 xl3 lg3 sm3 md3>
                  <div>
                    <h2 style="color:black">{{detail.interestRate}}</h2>
                  </div>
                  <div>
                    <h3 class="grey--text darken-3">Interest Rate(%)</h3>
                  </div>
                </v-flex>
              </v-layout>
            </center>
          </router-link>
          <v-divider v-if="detail.ended==false  && address==detail.owner && detail.active==true"></v-divider>
          <center v-if="detail.ended==false  && address==detail.owner && detail.active==true">
            <v-btn
              large
              class="pa-2 blue--text"
              style="border-radius:10px"
              depressed
              @click="showChangeOwnerForm(index)"
              color="#B2EBF2"
            >Change Owner</v-btn>
          </center>
          <v-divider v-if="detail.ended==true && detail.whitelist==true && detail.active==false"></v-divider>
          <v-divider v-else-if="detail.ended==true && address==detail.owner && detail.active==true"></v-divider>

          <center>
            <v-layout
              v-if="detail.ended==true && detail.lastEnded==false && address==detail.owner && detail.active==true"
              row
              justify-space-between
              class="my-1"
            >
              <v-flex xs6 xl6 lg6 sm6 md6>
                <v-btn
                  large
                  @click="endDao(index)"
                  class="pa-2 blue--text"
                  style="border-radius:10px"
                  depressed
                  color="#B2EBF2"
                >END DAO</v-btn>
              </v-flex>

              <v-flex xs6 xl6 lg6 sm6 md6>
                <v-btn
                  @click="showDeadlineForm(index)"
                  large
                  class="pa-2 white--text"
                  style="border-radius:10px"
                  depressed
                  color="blue"
                >Extend Deadline</v-btn>
              </v-flex>
            </v-layout>

            <v-layout
              row
              justify-center
              class="my-1"
              v-else-if="detail.ended==true && detail.lastEnded==true && detail.whitelist==true && detail.active==false"
            >
              <v-flex xs6 sm6 md6 lg6 xl6>
                <v-btn
                  large
                  class="pa-2 white--text"
                  style="border-radius:10px"
                  depressed
                  color="blue"
                  @click="claimDividend(index)"
                >Claim dividend</v-btn>
              </v-flex>
            </v-layout>
          </center>
        </v-card>
      </v-flex>
    </v-layout>
    <v-dialog persistent v-model="showForm" width="440px">
      <v-card class="pa-2" style="border-radius:12px">
        <v-form ref="form1" v-if="DaoForm">
          <v-card-title class="headline font-weight-medium">DAO Form</v-card-title>
          <v-text-field
            clearable
            :rules="titleRules"
            v-model="title"
            outline
            label="Enter Title of DAO"
          ></v-text-field>
          <v-text-field
            :rules="deadlineRules"
            clearable
            v-model.number="deadline"
            outline
            suffix="Days"
            label="Deadline"
            placeholder="Enter Deadline in days"
            hint="Additional 7 days will be added to your orginal deadline , to know more about it, please checkout FAQ section.Deadline can be extended later on but only after the given deadline is reached"
          ></v-text-field>
          <v-text-field
            clearable
            :rules="interestRules"
            v-model.number="interestRate"
            outline
            suffix="%"
            label="Interest Rate"
            placeholder="Interest rate of dividend to share with investors"
            hint="Rate should not contain decimals, it should be a whole Nummber.Ex:5"
          ></v-text-field>
          <v-text-field
            clearable
            :rules="memberRules"
            v-model.number="members"
            outline
            label="Enter number of members"
            placeholder="Enter number of members that can participate in your DAO"
          ></v-text-field>
          <v-card-actions>
            <v-btn @click="resetForm1">Cancel</v-btn>
            <v-btn @click="createDAO">Sumbit</v-btn>
          </v-card-actions>
        </v-form>

        <v-form ref="form2" v-if="extend">
          <v-card-title class="headline font-weight-medium">DAO Form</v-card-title>

          <v-text-field
            :rules="extenddeadlineRules"
            v-model.number="extenddeadline"
            outline
            suffix="Days"
            clearable
            label="Deadline"
            placeholder="Enter Deadline in days"
            hint="Deadline can be extended later on but only after the given deadline is reached"
          ></v-text-field>

          <v-card-actions>
            <v-btn @click="resetForm2">Cancel</v-btn>
            <v-btn @click="extendDeadline(index)">Sumbit</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>
    <v-dialog persistent class="ma-0 pa-0" v-model="changeOwner" width="440px">
      <v-card class="pa-2 ma-0" style="border-radius:10px;">
        <v-form ref="form3">
          <v-card-title class="headline font-weight-medium">DAO Form</v-card-title>

          <v-text-field
            :rules="addressRules"
            v-model="ethAddress"
            outline
            clearable
            label="ETH address"
            placeholder="Enter ETH address of new owner"
            hint="Owner can't be changed after DAO is ended"
          ></v-text-field>

          <v-card-actions>
            <v-btn @click="resetForm3">Cancel</v-btn>
            <v-btn @click="changeOwnerTo(index)">Sumbit</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>

    <v-snackbar v-model="snack" :color="color" vertical top :timeout="6000">
      {{text}}
      <router-link :to="{name:'FAQ'}">
        <v-btn color="white" flat>Take me to guide</v-btn>
      </router-link>
    </v-snackbar>

    <v-snackbar multi-line v-model="showAlert" :timeout="300000" :color="color">
      <v-icon x-large left color="white">{{icon}}</v-icon>
      {{text}}
      <v-btn flat @click="showAlert = false">Close</v-btn>
    </v-snackbar>
  </div>
</template>
<script>
import { Factory } from "../../embarkArtifacts/contracts";
import { TNStoken } from "../../embarkArtifacts/contracts";

export default {
  name: "DaoHome",
  components: {},
  data() {
    return {
      icon: null,
      showAlert: false,
      changeOwner: false,
      hasInjected: false,
      showForm: false,
      showText: false,
      title: "",
      index: null,
      DaoForm: false,
      extend: false,
      loading: false,
      snack: false,
      blocked: false,
      color: "",
      text: "",
      ethAddress: "",
      deadline: null,
      members: null,
      extenddeadline: null,
      interestRate: null,
      address: "",
      titleRules: [v => !!v || "Please enter title"],
      deadlineRules: [
        v => !!v || "Please enter deadline",
        v => /^[1-9]/.test(v) || "Only numeric value from 1 to 9 is allowed",
        v => v > 1 || "Deadline must be greater than 1 day"
      ],
      memberRules: [
        v => !!v || "Please enter number of members",
        v => /^[1-9]/.test(v) || "Only numeric value from 1 to 9 is allowed"
      ],
      extenddeadlineRules: [
        v => !!v || "Please enter deadline",
        v => /^[1-9]/.test(v) || "Only numeric value from 1 to 9 is allowed"
      ],

      interestRules: [
        v => !!v || "Please enter interest rate",
        v => /^[1-9]/.test(v) || "Only numeric value from 1 to 9  is allowed"
      ],
      addressRules: [
        v => !!v || "Please enter ethereum address",
        v =>
          /^0x[a-fA-F0-9]{40}$/g.test(v) ||
          "Please enter valid Ethereum address"
      ],
      no: null,
      detail: new Array()
    };
  },
  asyncComputed: {
    // async detailss() {
    //   this.no = await Factory.methods.getNumbers().call();
    //   // //console.log("No:" + this.no);

    //   for (let i = 0; i < this.no; i++) {
    //     let add = await Factory.methods.getAddressIndex(i).call();
    //     ////console.log("adresss:" + add);

    //     this.detail.push({ address: add });
    //   }
    //   //console.log(this.detail);
    //   for (let i = 0; i < this.no; i++) {
    //     // //console.log(this.details[i].address);
    //     let contract = new web3.eth.Contract(, this.detail[i].address);
    //     let title = await contract.methods.title().call();
    //     //console.log("Title:" + title);
    //     let proposals = await contract.methods.activeProposalCount().call();
    //     let noParticipants = await contract.methods.whitelistedNumber().call();
    //     //console.log("Participants:" + noParticipants);
    //     let tokenStaked = await contract.methods.tokenStaked().call();
    //     //console.log("Tokens:" + tokenStaked);
    //     let arr = [title, noParticipants, tokenStaked];
    //     this.detail[i] = {
    //       address: this.detail[i].address,
    //       title: title,
    //       proposals: proposals,
    //       participants: noParticipants,
    //       tokenStaked: tokenStaked
    //     };
    //     // this.detail[i][2] = noParticipants;
    //     // this.detail[i][3] = tokenStaked;
    //     ////console.log("details:" + this.details[0].address);
    //   }
    //   return this.detail;
    // },

    async details() {
      return this.detail;
    }
  },
  methods: {
    showDaoForm() {
      this.showForm = true;
      this.DaoForm = true;
      this.extend = false;
    },
    showDeadlineForm(index) {
      this.showForm = true;
      this.extend = true;
      this.DaoForm = false;
      this.index = index;
    },
    showChangeOwnerForm(index) {
      this.changeOwner = true;
      this.index = index;
    },
    async getNumbers() {
      this.no = await Factory.methods.getNumbers().call();
      return this.no;
    },
    details() {
      //console.log("Details in method:" + this.detailss[0].tokenStaked);
      return this.detailss;
    },
    async getNetwork() {
      let network = await web3.eth.net.getNetworkType();
      let address = await web3.eth.getAccounts();
      // console.log("network:"+network)
      if (network != "private" || (address != "" && address != "undefined")) {
        this.hasInjected = true;
      }
      // console.log("injected:" + this.hasInjected);
    },
    async changeOwnerTo(index) {
      if (this.$refs.form3.validate()) {
        let add = await Factory.methods.getAddressIndex(index).call();
        ////console.log("adresss:" + add);
        let contract = new web3.eth.Contract(this.$store.state.abi, add);
        try {
          this.loading = true;
          await contract.methods
            .changeOwner(this.ethAddress)
            .send({ from: this.address });
          this.details[index].owner = this.ethAddress;
          this.loading = false;
          this.$store.state.snack = true;
          this.$store.state.text = "Owner has been changed successfully";
          this.$store.state.color = "green";
          this.resetForm3();
        } catch (err) {
          this.loading = false;

          this.$store.state.snack = true;
          this.$store.state.text = "Something went wrong";
          this.$store.state.color = "red";
          this.resetForm3();
        }
      }
    },
    async claimDividend(index) {
      let add = await Factory.methods.getAddressIndex(index).call();
      ////console.log("adresss:" + add);
      let contract = new web3.eth.Contract(this.$store.state.abi, add);
      try {
        this.loading = true;
        await contract.methods.withdrawDividend().send({ from: this.address });
        this.loading = false;
        this.$store.state.snack = true;
        this.$store.state.text = "Dividend has been claimed successfully";
        this.$store.state.color = "green";
      } catch (err) {
        this.loading = false;
        this.$store.state.snack = true;
        this.$store.state.text = "Something went wrong";

        this.$store.state.color = "red";
      }
    },
    async extendDeadline(index) {
      if (this.$refs.form2.validate()) {
        let add = await Factory.methods.getAddressIndex(index).call();
        ////console.log("adresss:" + add);
        let contract = new web3.eth.Contract(this.$store.state.abi, add);
        try {
          this.loading = true;
          this.showText = true;
          await contract.methods
            .extendDeadline(this.extenddeadline)
            .send({ from: this.address });

          let totalTime = await contract.methods.DaoDeadline().call();
          this.details[index].ended = false;
          this.timer(index, totalTime);
          this.resetForm2();
          this.loading = false;
          this.showText = false;
          this.$store.state.snack = true;
          this.$store.state.color = "green";
          this.$store.state.text = "Deadline has been extended successfully";
        } catch (err) {
          this.loading = false;
          this.showText = false;
          this.$store.state.snack = true;
          this.$store.state.color = "red";
          this.$store.state.text = "Something went wrong";
        }
      }
    },
    async endDao(index) {
      let add = await Factory.methods.getAddressIndex(index).call();
      ////console.log("adresss:" + add);
      let contract = new web3.eth.Contract(this.$store.state.abi, add);
      try {
        this.loading = true;
        this.showText = true;
        await contract.methods.endDao().send({ from: this.address });
        let active = await contract.methods.active().call();
        this.details[index].active = active;
        this.loading = false;
        this.showText = false;
        this.$store.state.snack = true;
        this.$store.state.color = "green";
        this.$store.state.text = "DAO has been ended successfully";
      } catch (err) {
        this.loading = false;
        this.showText = false;
        console.log(err);
        this.$store.state.snack = true;
        this.$store.state.color = "red";
        this.$store.state.text = "Something went wrong";
      }
    },
    async createDAO() {
      if (this.$refs.form1.validate()) {
        try {
          this.loading = true;
          this.showText = true;
          await Factory.methods
            .createContract(
              TNStoken.address,
              this.title,
              this.deadline,
              this.interestRate,
              this.members
            )
            .send();
          let address = await Factory.methods.getAddress().call();
          this.resetForm1();
          //console.log("Contract address:" + address);
          //this.showForm = false;

          await this.pushDetails();
          await this.$store.dispatch("fetchDaoReputation", this.address);

          await this.$store.dispatch("fetchProposalReputation", this.address);
          await this.$store.dispatch("fetchVoteReputation", this.address);
          this.loading = false;
          this.showText = false;
          this.$store.state.snack = true;
          this.$store.state.text = "DAO has been created successfully";
          this.$store.state.color = "green";
        } catch (e) {
          //console.log(e);

          this.loading = false;
          this.showText = false;
          this.showForm = false;
          this.$store.state.snack = true;
          this.$store.state.text = "Something went wrong";
          this.$store.state.color = "red";
        }
      }
    },

    async pushDetails() {
      this.no = await Factory.methods.getNumbers().call();
      let add = await Factory.methods.getAddressIndex(this.no - 1).call();
      ////console.log("adresss:" + add);
      let contract = new web3.eth.Contract(this.$store.state.abi, add);
      let title = await contract.methods.title().call();
      //console.log("Title:" + title);
      let proposals = await contract.methods.proposalCount().call();
      let noParticipants = await contract.methods.whitelistedNumber().call();
      //console.log("Participants:" + noParticipants);
      let tokenStaked = await contract.methods.tokenStaked().call();
      //console.log("Tokens:" + tokenStaked);
      let totalTime =
        parseInt(await contract.methods.DaoDeadline().call()) + 7 * 86400;
      let active = await contract.methods.active().call();

      let owner = await contract.methods.owner().call();
      let whitelist = await contract.methods.getHasVoted(this.address).call();
      let interestRate = await contract.methods.interestRatio().call();
      let members = await contract.methods.members().call();
      let memberCount = await contract.methods.memberCount().call();
      this.details.push({
        address: add,
        title: title,
        proposals: proposals,
        participants: noParticipants,
        tokenStaked: tokenStaked,
        ended: false,
        days: 0,
        active: active,
        mins: 0,
        hours: 0,
        secs: 0,
        owner: owner,
        whitelist: whitelist,
        interestRate: interestRate,
        members: members,
        memberCount: memberCount,
        lastEnded: false
      });
      this.timer(this.no - 1, totalTime);
    },

    async getDetails() {
      this.no = await Factory.methods.getNumbers().call();

      this.$store.state.showGuide = true;
      if (this.no > 0) {
        this.loading = true;
      }
      // //console.log("No:" + this.no);

      for (let i = 0; i < this.no; i++) {
        let add = await Factory.methods.getAddressIndex(i).call();
        ////console.log("adresss:" + add);
        let contract = new web3.eth.Contract(this.$store.state.abi, add);
        let title = await contract.methods.title().call();
        //console.log("Title:" + title);
        let proposals = await contract.methods.proposalCount().call();
        let noParticipants = await contract.methods.whitelistedNumber().call();
        //console.log("Participants:" + noParticipants);
        let tokenStaked = await contract.methods.tokenStaked().call();
        let totalTime = parseInt(await contract.methods.DaoDeadline().call());

        //console.log("Tokens:" + tokenStaked);
        let owner = await contract.methods.owner().call();
        let active = await contract.methods.active().call();
        let whitelist = await contract.methods.getHasVoted(this.address).call();
        let interestRate = await contract.methods.interestRatio().call();
        let members = await contract.methods.members().call();
        let memberCount = await contract.methods.memberCount().call();
        let totalInvestment = await contract.methods.finalInvestment().call();
        let investment = await contract.methods.totalInvestment().call();
        let endedProposal = await contract.methods.endedProposalCount().call();
        let balance = await web3.utils.fromWei(totalInvestment, "ether");
        balance = parseFloat(balance).toFixed(4);
        totalInvestment = balance;
        console.log("final investment:" + totalInvestment);
        // console.log("whitelist:" + whitelist);
        //console.log("owner:" + owner);
        // console.log("Active:" + typeof active);
        this.details.push({
          address: add,
          title: title,
          proposals: proposals,
          participants: noParticipants,
          tokenStaked: tokenStaked,
          ended: false,
          days: 0,
          mins: 0,
          hours: 0,
          secs: 0,
          active: active,
          owner: owner,
          whitelist: whitelist,
          interestRate: interestRate,
          members: members,
          memberCount: memberCount,
          lastEnded: false,
          totalInvestment: totalInvestment,
          investment: investment,
          endedProposal: endedProposal
        });
        await this.timer(i, totalTime + 7 * 86400);
        // console.log("Ended dao:" + this.details[i].ended);
        if (
          totalTime * 1000 < new Date().getTime() &&
          this.details[i].lastEnded == false &&
          this.address == owner &&
          endedProposal > 0
        ) {
          // console.log("hm");
          this.text =
            "Total Investment made in DAO named " +
            title +
            " is " +
            this.details[i].totalInvestment +
            " ETH , please deposit the same amount in this Ethereum address: " +
            add;
          this.color = "warning";
          this.icon = "info";
          this.showAlert = true;
        }
        // console.log("Ended:" + typeof this.details[i].ended);
      }
      this.loading = false;
      if (this.blocked) {
        this.text =
          "You have been blacklisted, therefore you can't participate in any DAO";
        this.showAlert = true;
        this.color = "red";
        this.icon = "warning";
      }
    },
    timer: async function(index, totalTime) {
      let mins = 0;
      let hour = 0;
      let secs = 0;
      let day = 0;
      if (totalTime * 1000 > new Date().getTime()) {
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

          hour = parseInt(
            (remainTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
          );
          //console.log("hour:" + hour);

          mins = parseInt((remainTime % (1000 * 60 * 60)) / (1000 * 60));
          //console.log("mins:" + mins);

          secs = parseInt((remainTime % (1000 * 60)) / 1000);
          //console.log("secs of " + index + ":" + secs);
          // console.log("secs:" + this.secs);
          if (
            remainTime > 0 &&
            day < 7 &&
            this.details[index].ended == false &&
            this.details[index].lastEnded == false
          ) {
            this.details[index].ended = true;
            // this.details[index].lastEnded=true
            //console.log("Time's up!"); console.log("hour:" + hour);
          }
          // else if(remainTime<=-1 && totalTime*100 < new Date().getTime() && this.details[index].ended==true && this.details[index].lastEnded==true){
          //   lastEnded=false
          //   clearInterval(timee);
          // }
          if (remainTime <= -1) {
            clearInterval(timee);
            this.details[index].lastEnded = true;
            day = -1;
            mins = -1;
            secs = -1;
            hours = -1;
          }

          this.details[index].days = day;
          this.details[index].mins = mins;
          this.details[index].secs = secs;
          this.details[index].hours = hour;
        }, 1000);
      } else {
        this.details[index].ended = true;
      }
    },
    async fetchContractbalance() {
      let balance = await web3.eth.getBalance(
        this.$route.params.contractAddress
      );
      // balance = web3.utils.fromWei(balance, "ether");
      balance = balance / 1000000000000000000;
      balance = parseFloat(balance).toFixed(2);
      this.$store.state.contractBalance = balance;
      // let interval=setInterval(async function(){
      //   let bal= await web3.eth.getBalance(this.$route.params.contractAddress);
      //   bal=bal/1000000000000000000
      //     // bal = parseFloat(balance).toFixed(2);
      //     if(bal!==balance){
      //        this.$store.state.contractBalance = bal;
      //        window.location.reload();
      //     }
      // },300)
      // console.log("Contract balance:" + this.$store.state.contractBalance);
    },
    //console.log(this.detail);

    // //console.log(this.details[i].address);

    async getAddress() {
      let add = await web3.eth.getAccounts();
      this.address = add[0];
      // console.log()
      this.blocked = await Factory.methods.getBlacklist(add[0]).call();
      // console.log("blocked:"+this.blocked)

      // console.log("Your add:" + this.address);
    },
    resetForm1() {
      this.$refs.form1.reset();
      this.$refs.form1.resetValidation();
      // this.$refs.form2.reset();
      // this.$refs.form2.resetValidation();
      this.DaoForm = false;
      // this.extend=false
      this.showForm = false;
    },
    resetForm2() {
      this.$refs.form2.reset();
      this.$refs.form2.resetValidation();
      // this.$refs.form2.reset();
      // this.$refs.form2.resetValidation();
      this.extend = false;
      // this.extend=false
      this.showForm = false;
    },
    resetForm3() {
      this.$refs.form3.reset();
      this.$refs.form3.resetValidation();
      // this.$refs.form2.reset();
      // this.$refs.form2.resetValidation();

      // this.extend=false
      this.changeOwner = false;
    }
  },
  //  watch: {
  //   hasInjected: function(newValue, oldValue) {

  //       window.location.reload();
  //     }
  //   },

  async created() {
    await this.getNetwork();
    this.no = await Factory.methods.getNumbers().call();
    await this.getAddress();
    this.snack = true;
    this.text = "Welcome to DAO";

    await this.getDetails();
    await this.fetchContractbalance();

    // await this.getNumbers();
    // let address = await Factory.methods.getAddress().call();
    // //console.log("Contract address:" + address);
    // await this.getAddress();
    // await this.getDAOdetails();

    // this.detail[i][3] = tokenStaked;
    ////console.log("details:" + this.details[0].address);

    // //console.log("Detail:" + this.detail);
    // //console.log("type:" + typeof this.detail);
    // let network = await web3.version.getNetwork();
  }
};
</script>
<style>
a {
  text-decoration: none;
  color: black;
  border-radius: 10px;
}

/* .bgImg {
  background-color: yellow;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100%25' height='100%25' %3E%3Cdefs%3E%3ClinearGradient id='a' x1='0' x2='0' y1='0' y2='1' gradientTransform='rotate(360,0.5,0.5)'%3E%3Cstop offset='0' stop-color='%23552277'/%3E%3Cstop offset='1' stop-color='%23000'/%3E%3C/linearGradient%3E%3C/defs%3E%3Cpattern id='a' width='21' height='21' patternUnits='userSpaceOnUse'%3E%3Ccircle fill='%23000000' cx='10.5' cy='10.5' r='10.5'/%3E%3C/pattern%3E%3Crect width='100%25' height='100%25' fill='url(%23a)'/%3E%3Crect width='100%25' height='100%25' fill='url(%23b)' fill-opacity='0.38'/%3E%3C/svg%3E");
  background-attachment: fixed;
  background-size: cover;
} */
</style>
