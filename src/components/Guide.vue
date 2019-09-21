<template>
  <div>
    <!-- <v-layout row justify-center class="ml-4">
      <v-flex x12 lg12 sm12 md12 xl10>
       
      </v-flex>
    </v-layout>-->
    <v-layout row wrap justify-center style="opacity:0.5" class="ma-0">
      <v-flex xs12 lg12 xl12 md12 sm12>
        <v-card color="blue" class="py-5 ma-0">
          <v-card-text>
            <center>
              <h1
                class="font-weight-bold white--text my-5"
                style="font-size:55px;"
              >Frequently Asked Questions</h1>
            </center>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
    <v-layout class="mb-1" row wrap justify-center>
      <v-flex xs12 lg12 xl12 sm12 md12>
        <v-expansion-panel style="opacity:1;z-index:999;position:relative;" v-model="panel" expand>
          <v-expansion-panel-content
            style="background-color:#ECEFF1"
            class="pb-0 ma-0"
            v-for="(item, i) in items"
            :key="i"
          >
            <template class="py-2" v-slot:header>
              <div class="py-3 font-weight-medium" style="font-size:20px;">{{ item.que }}</div>
            </template>
            <v-card class="grey lighten-2 py-2">
              <v-card-text style="font-size:18px;text-align:justify">
                {{
                item.ans
                }}
              </v-card-text>
              <!-- <v-card-text>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</v-card-text> -->
            </v-card>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-flex>
    </v-layout>
  </div>
</template>
<script>
export default {
  name: "Guide",
  data() {
    return {
      items: [
        {
          que: "What is MetaMask?",
          ans:
            'MetaMask is a wallet that runs as a self-contained application inside your browser as an extension. It allows you to interact with Decentralized Applications or "dApps". MetaMask makes accessing the Ethereum & Ropsten blockchains very easy and provides you with wallet addresses.Install & Configure Go to: metamask.io and install the browser extension in Chrome or Firefox.After installing the MetaMask extension, open the extension by clicking on the MetaMask Fox icon. If prompted to use the New Look, do so.Create a new vault.You will be presented with a 12-word mnemonic phrase; copy that phrase down in a very secure location that only you can access. Change the network selection from Main Ethereum Network to the Ropsten Test Network.Fund your address with Ether In order to obtain Ropsten ETH, follow the steps below: Go to the Ropsten Ether Faucet Paste your address into the text field Click the "Send me test Ether" button Go back to the MetaMask extension to validate the balance. Now you have ETH to play with!'
        },
        {
          que: "What are the requirements to use  DAO?",
          ans:
            "You must have metmask installed in your browser and you must be using goerli testnet to test and access the  DAO.You must know how to use metamask and also how to add custom tokens and etc. Make sure you have enough ether to cover the transaction costs"
        },
        {
          que: "How to make a DAO?",
          ans:
            "Anyone can make a DAO just by clicking  'Create a new DAO' button and filling required details."
        },
        {
          que: "Who decides the interest rate of dividend?",
          ans:
            "Owner of the DAO decideds the ineterest rate, he/she should define it during the creation of DAO, Please note that it can't be changed later on. "
        },
        {
          que: "What is whitelisting and how to get whitelisted?",
          ans:
            "Whitelisting means you wanna be a part of any specific DAO,so to get whitelisted you just need to send 0.01 ETH to any specific DAO address and if you send more than 0.01 ETH then you will get tokens of remaining ETH, as for now price ratio of tokens is 1 ETH=10K 24CAR"
        },
        {
          que: "How to create a proposal?",
          ans:
            "To create a proposal , you must be an owner of that specific DAO which means only an owner can create a proposal.And you can decide the target depending upon your reputation as a proposal creator, with the reputation of 1 you can set target upto 2000 tokens and everytime your reputaion increases by 1 the target limit will be extended by the 2x of the previous target limit."
        },
        {
          que: "How to get  Carati tokens?",
          ans:
            "As of now, users who wanna get carati(24CAR) tokens will need to send test ETH to that DAO contract, as for now rate is 1 ETH= 10K 24CAR tokens, which will be changed later on after exchange listing(as for now it's on testing mode and deployed on goerli testnet) or you can get 24Car token by cliking on the logo C left barr , you will get in to Bitcratic decentilized exchange where Carati token are for trade(after deployment to the main net)."
        },
        {
          que: "How to vote for a  proposal?",
          ans:
            "user can vote as many proposal as he want to, there are two types of voting, Upvote and Disvote, Upvote means the vote is in the support of proposal whereas Disvote is against the proposal. in both types of voting , user need to vote with minimum of 50 as a power, and that power is a number of tokens he/she wants to spend. Note that this tokens will be locked so you won't be able to transfer that tokens."
        },
        {
          que: "What if proposal fails?",
          ans:
            "If proposal fails then those who have upvoted a proposal will get the refund with 10% less amount of orginal amount, whereas those who have divoted a proposal will not get refund. "
        },
        {
          que: "How to claim dividend?",
          ans:
            "If you are a participant then you will be able to claim the dividend after the specific DAO ends(includes additional 7 days deadline), you will be displayed with the button to claim the dividend."
        },
        {
          que: "How much dividend will i get?",
          ans:
            "You will get the dividend depending on your total investment amount,for exmaple if interest rate is 4% and you have invested 0.2 ETH then you will get 0.008 ETH. "
        },
        {
          que: "what to do in the case of interface related issues?",
          ans:
            "It happens mostly in chrome so if you are facing interface issues then set zoom level to 90% by pressing ctrl and - (subtraction) together."
        },
        {
          que: "How deadline is adjusted?",
          ans:
            "Additional 7 days will be added to your orginal deadline,for example if you set deadline for 10 days then it will be displayed as 17 days, these additional 7 days are for DAO owner to extend or end DAO which also includes return of investment to participants."
        },
        {
          que: "Whats is reputation?",
          ans:
            "Reputation system is developed to increase the genuine behavoir of all the users . using this reputation system user can decide if he/she should vote for any specifi proposal or not. It's calculated at the scale of 5 and displayed as a stars."
        },
        {
          que: "How reputation is calculated?",
          ans:
            "So the ratio is as follows, for every 2 successfull DAO you create, your reputation as a DAO creator will be increased by 1, but if you create even 1 unsuccssfull DAO which means if you don't return funds to participants then you will be banned from using DAO.now  reputaion as a proposal creator is calculated as follows, for every 3 successfull proposals you create , your reputation as a proposal creator will be increase by 1 which means target defined in proposal must reach and it's considered as a successfull proposal.And reputation as a voter is calculated as follows, for every 5 successfull votes your reputaion as a voter will be increased by 1. which means decision of proposal must be the same as you have voted so if you have upvoted proposal and if it passes then it's considered as a successfull vote. Please note that at your very first DAO,proposal and vote you will have 1 reputation by default for all of them. "
        }
      ],
      panel: []
    };
  }
};
</script>
