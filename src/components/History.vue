<template>
  <div style="margin-top:3%;" v-if="no>0">
    <v-layout row wrap justify-center class="ml-2 mt-5">
      <v-flex xs12 xl12 lg12 md12 sm12>
        <div>
          <h1 style="color:#689BD6;">History</h1>
        </div>
        <v-divider></v-divider>
      </v-flex>
    </v-layout>
    <v-layout row wrap justify-start class="ml-2 mt-4">
      <v-flex lg2 xl2 md2 sm2 xs2>
        <h3 class="caption">Proposed By</h3>
      </v-flex>
      <v-flex lg2 xl2 md2 sm2 xs2>
        <h3 class="caption">End date</h3>
      </v-flex>
      <v-flex lg2 xl2 md2 sm2 xs2>
        <h3 class="caption">Title</h3>
      </v-flex>
      <v-spacer></v-spacer>
      <v-flex lg1 xl1 md1 sm2 xs2>
        <h3 class="caption">Votes</h3>
      </v-flex>
      <v-flex lg1 xl1 md1 sm2 xs2>
        <h3 class="caption">Status</h3>
      </v-flex>

      <v-flex lg2 xl2 md2 sm2 xs2 style="text-align:right;">
        <h3 class="caption mr-3">My Actions</h3>
      </v-flex>
    </v-layout>

    <v-layout row wrap justify-start class="ml-2 mt-4">
      <v-flex lg12 xl12 xs12 md12 sm12>
        <v-card flat class="mt-2 py-2" color="white" v-for="(detail,index) in detail" :key="index">
          <v-layout row wrap justify-start>
            <v-flex lg2 xl2 md2 sm2 xs2 class="text-truncate" style="overflow-wrap:break-word">
              <span class="text-truncate">
                <v-gravatar
                  hash="detail.submitter"
                  class="my-2 ml-1 pa-0 mx-0 px-0"
                  alt="Nobody"
                  :size="40"
                  default-img="retro"
                ></v-gravatar>
              </span>
              <span
                style="display:inline-block;position:relative; bottom:20px;"
                class="ml-2 text-truncate hidden-xs-only"
              >{{detail.submitter.slice(0,7)}}...</span>
              <p
                class="ml-2 text-truncate hidden-sm-and-up"
                style="overflow-wrap:break-word"
              >{{detail.submitter}}</p>
            </v-flex>
            <v-flex lg2 xl2 md2 sm2 xs2 style="overflow-wrap:break-word;color:#9AA9B5">
              <h3 class="header my-3 font-weight-regular">{{detail.date}}</h3>
            </v-flex>
            <v-flex lg2 xl2 md2 sm2 xs2>
              <h3 class="header my-3 font-weight-regular" style="color:#506176">{{detail.title}}</h3>
            </v-flex>
            <v-spacer></v-spacer>
            <v-flex lg1 xl1 md1 sm2 xs2>
              <!-- <h3 class="caption">Votes</h3> -->
              <div class="my-1" style="color:#9AA9B5">
                <v-icon color="#9AA9B5" left size="20px">thumb_up</v-icon>
                <span
                  v-if="detail.yesVotes<=0"
                  style="display:inline-block;position:relative;"
                >0.00%</span>
                <span
                  v-if="detail.yesVotes>0"
                  style="display:inline-block;position:relative;"
                >{{detail.yesVotes}}%</span>
              </div>
              <div>
                <v-icon color="#9AA9B5" left size="20px">thumb_down</v-icon>
                <span
                  v-if="detail.noVotes<=0"
                  style="display:inline-block;position:relative;color:#9AA9B5"
                >0.00%</span>
                <span
                  v-if="detail.noVotes>0"
                  style="display:inline-block;position:relative;color:#9AA9B5"
                >{{detail.noVotes}}%</span>
              </div>
            </v-flex>
            <v-flex lg1 xl1 md1 sm2 xs2>
              <!-- <h3 class="caption">Status</h3> -->
              <div class="my-1" v-if="detail.currentResult==100">
                <v-icon left size="20px">thumb_up</v-icon>
                <span style="display:inline-block;position:relative;font-size:17px">Passed</span>
                <h3 class="font-weight-regular" style="color:#9AA9B5">Relative Majority</h3>
              </div>

              <div class="my-1" v-else-if="detail.currentResult<100 && detail.ended==true">
                <v-icon left size="20px">thumb_down</v-icon>
                <span style="display:inline-block;position:relative;font-size:17px">Failed</span>
                <h3 class="font-weight-regular" style="color:#9AA9B5">Relative Majority</h3>
              </div>
              <div v-else>
                <h3 class="font-weight-regular my-3" style="color:#9AA9B5">Active</h3>
              </div>
            </v-flex>

            <v-flex lg2 xl2 md2 sm2 xs2 style="text-align:right;">
              <h3 class="my-3 mr-1" style="color:#9AA9B5" v-if="detail.hasVoted==false">No Actions</h3>
               <h3 class="my-3 mr-1" style="color:#9AA9B5" v-else-if="detail.hasVoted==true">Voted</h3>
            </v-flex>
          </v-layout>
        </v-card>
      </v-flex>
    </v-layout>
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
  </div>
  <div v-else-if="no==0">
    <center class="my-2">
      <h1 class="font-weight-regular" style="color:#506176;font-size:30px">No history found</h1>
    </center>
  </div>
</template>

<script>
export default {
  name: "History",
  components: {},
  data() {
    return {
      details: [],
      contract: null,
      loading: false,
      no: null,
      currentAddress:''
    };
  },
  asyncComputed: {
    async detail() {
      return this.details;
    }
  },
  methods: {
    async getDetails() {
      this.contract = new web3.eth.Contract(
        this.$store.state.abi,
        this.$route.params.contractAddress
      );
      this.no = await this.contract.methods.proposalCount().call();
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
         let hasVoted = await this.contract.methods
        .voters(i, this.currentAddress)
        .call();
        let totalVotes = await this.contract.methods.getTotalVotes(i).call();
        let yesVotes = await this.contract.methods.getYesVotes(i).call();
        let noVotes = await this.contract.methods.getNoVotes(i).call();
        let currentResult = await this.contract.methods
          .getCurrentResult(i)
          .call();
        yesVotes = (yesVotes * 100) / totalVotes;
        noVotes = (noVotes * 100) / totalVotes;
        currentResult = (currentResult * 100) / target;
        let finalYesVotes = yesVotes > 0 ? yesVotes : 0;
        let finalNoVotes = noVotes > 0 ? noVotes : 0;
        let finalCurrentResult = currentResult > 0 ? currentResult : 0;
        let date = this.DateFormat(deadline);
        let ended = deadline * 1000 < (new Date().getTime()) ? true : false;
        // console.log("Yes votes:" + finalYesVotes);
        this.detail.push({
          title: title,
          desc: description,
          url: url,
          target: target,
          submitter: submitter,
          ended: ended,
          days: 0,
          hours: 0,
          mins: 0,
          secs: 0,
          date: date,
          noVotes: finalNoVotes,
          yesVotes: finalYesVotes,
          currentResult: finalCurrentResult,
          hasVoted:hasVoted
        });
        // console.log("Deadline:" + deadline);
        // this.timer(i);
        // let whitelist = await this.contract.methods
        //   .whitelist(this.currentAccount)
        //   .call();

        // console.log("Whitelisted:" + whitelist);
      }

      this.owner = await this.contract.methods.owner().call();
      this.loading = false;

      //console.log("Details:" + this.detail[0]);
    },
    DateFormat(s) {
      let date = new Date(s * 1000);

      let month = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ];
      // console.log("Day:" + date.getDate());
      return (
        date.getDate() + " " + month[date.getMonth()] + " " + date.getFullYear()
      );
      // var b = s.split(/\D+/);
      // let d = new Date(Date.UTC(b[0], --b[1], b[2], b[3], b[4], b[5], b[6]));
      // let day = d.getUTCDate() < 10 ? "0" + d.getUTCDate() : d.getUTCDate();
      // let month =
      //   d.getUTCMonth() < 10 ? "0" + d.getUTCMonth() : d.getUTCMonth();
      // let year = d.getUTCFullYear();
      // let hour = d.getHours() < 10 ? "0" + d.getHours() : d.getHours();
      // let mins = d.getMinutes() < 10 ? "0" + d.getMinutes() : d.getMinutes();
      // let secs = d.getSeconds() < 10 ? "0" + d.getSeconds() : d.getSeconds();
      // return (
      //   day + "-" + month + "-" + year + " " + hour + ":" + mins + ":" + secs
      // );
    },
    async getAddress(){
      let add = await web3.eth.getAccounts();
    this.currentAddress = add[0];
    }
  },
  async created() {
    this.contract = new web3.eth.Contract(
      this.$store.state.abi,
      this.$route.params.contractAddress
    );

    this.no = await this.contract.methods.proposalCount().call();
    await this.getAddress()
    await this.getDetails();
  }
};
</script>