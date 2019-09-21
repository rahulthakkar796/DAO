import { Factory } from '../embarkArtifacts/contracts'
import Vuex from 'vuex'
import Vue from 'vue'
import router from './router'
Vue.use(Vuex)
Vue.use(router)
export const store = new Vuex.Store({
  state: {
    no: 0,
    tokens: 0,
    showGuide: false,
    arr: new Array(),
    contractBalance: 0,
    snack: false,
    daoReputation: null,
    totalInvestment: 0,
    proposalReputation: null,
    voteReputation: null,
    text: '',
    color: '',
    abi: [
      {
        constant: true,
        inputs: [],
        name: 'active',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getYesVotes',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'totalInvestment',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'memberCount',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'withdrawableByOwner',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: '_owner',
            type: 'address'
          }
        ],
        name: 'setOwner',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getExecuted',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'whitelistedNumber',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'daoFee',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getTotalVotes',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '',
            type: 'uint256'
          },
          {
            name: '',
            type: 'address'
          }
        ],
        name: 'hasVotedYes',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: '_deadline',
            type: 'uint256'
          }
        ],
        name: 'extendDeadline',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getNoVotes',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getDescription',
        outputs: [
          {
            name: 's',
            type: 'string'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'title',
        outputs: [
          {
            name: '',
            type: 'string'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'daoTokenBalance',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'tokenStaked',
        outputs: [
          {
            name: '',
            type: 'int256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: '_token',
            type: 'address'
          }
        ],
        name: 'changeTokenContract',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'DaoTimestamp',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'contractEthBalance',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        name: 'votes',
        outputs: [
          {
            name: 'proposalID',
            type: 'uint256'
          },
          {
            name: 'inSupport',
            type: 'bool'
          },
          {
            name: 'voter',
            type: 'address'
          },
          {
            name: 'justification',
            type: 'string'
          },
          {
            name: 'power',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'whitelistedAccounts',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: 'add',
            type: 'address'
          }
        ],
        name: 'getHasVoted',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '',
            type: 'uint256'
          },
          {
            name: '',
            type: 'address'
          }
        ],
        name: 'hasIncreasedReputation',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          },
          {
            name: '_vote',
            type: 'bool'
          },
          {
            name: '_desc',
            type: 'string'
          },
          {
            name: '_power',
            type: 'uint256'
          }
        ],
        name: 'voteProposal',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '',
            type: 'uint256'
          },
          {
            name: '',
            type: 'address'
          }
        ],
        name: 'hasVotedNo',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getDeadline',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getURL',
        outputs: [
          {
            name: 's',
            type: 'string'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'whitelistfee',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'owner',
        outputs: [
          {
            name: '',
            type: 'address'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: 'title',
            type: 'string'
          },
          {
            name: '_desc',
            type: 'string'
          },
          {
            name: '_url',
            type: 'string'
          },
          {
            name: '_target',
            type: 'uint256'
          },
          {
            name: '_deadline',
            type: 'uint256'
          }
        ],
        name: 'createProposal',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'exceuteProposal',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getTitle',
        outputs: [
          {
            name: 's',
            type: 'string'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'voteAssignNo',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '',
            type: 'address'
          }
        ],
        name: 'whitelist',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'endedProposalCount',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '',
            type: 'uint256'
          },
          {
            name: '',
            type: 'address'
          }
        ],
        name: 'voters',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'finalInvestment',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: '_owner',
            type: 'address'
          }
        ],
        name: 'changeOwner',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getSubmitter',
        outputs: [
          {
            name: '',
            type: 'address'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getTimestamp',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'returnTokensToYesVoters',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'members',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '',
            type: 'uint256'
          },
          {
            name: '',
            type: 'address'
          }
        ],
        name: 'returned',
        outputs: [
          {
            name: '',
            type: 'bool'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'factory',
        outputs: [
          {
            name: '',
            type: 'address'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'voteCount',
        outputs: [
          {
            name: '',
            type: 'int256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'interestRatio',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '',
            type: 'address'
          }
        ],
        name: 'investedAmount',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: false,
        inputs: [],
        name: 'endDao',
        outputs: [],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getCurrentResult',
        outputs: [
          {
            name: '',
            type: 'int256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'proposalCount',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [
          {
            name: '_id',
            type: 'uint256'
          }
        ],
        name: 'getTarget',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'tokenToWeiRatio',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'DaoDeadline',
        outputs: [
          {
            name: '',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        constant: true,
        inputs: [],
        name: 'token',
        outputs: [
          {
            name: '',
            type: 'address'
          }
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function'
      },
      {
        inputs: [
          {
            name: '_token',
            type: 'address'
          },
          {
            name: '_factory',
            type: 'address'
          },
          {
            name: '_title',
            type: 'string'
          },
          {
            name: '_deadline',
            type: 'uint256'
          },
          {
            name: '_interestRatio',
            type: 'uint256'
          },
          {
            name: '_members',
            type: 'uint256'
          }
        ],
        payable: false,
        stateMutability: 'nonpayable',
        type: 'constructor'
      },
      {
        payable: true,
        stateMutability: 'payable',
        type: 'fallback'
      }
    ]
  },
  mutations: {
    getAddress: (state, data) => {
      state.arr = data
      // console.log('store details' + state.arr)
    },
    getContractBalance: (state, data) => {
      state.contractBalance = data
      // console.log('Contrac balance store:' + state.contractBalance)
    },
    getDaoReputation: (state, data) => {
      state.daoReputation = data
      // console.log('Dao reputation:' + state.daoReputation)
    },
    getProposalReputation: (state, data) => {
      state.proposalReputation = data
    },
    getVoteReputation: (state, data) => {
      state.voteReputation = data
    }
  },
  actions: {
    fetchContractBalance: (context, address) => {
      // console.log('This address:' + address)
      web3.eth.getBalance(address).then(balance => {
        balance = web3.utils.fromWei(balance, 'ether')
        context.commit('getContractBalance', balance)
      })
    },
    fetchDaoReputation: (context, address) => {
      Factory.methods
        .getReputation(address)
        .call()
        .then(res => {
          // console.log('Dao rep:' + res)
          context.commit('getDaoReputation', res)
        })
    },
    fetchProposalReputation: (context, address) => {
      Factory.methods
        .getProposalReputation(address)
        .call()
        .then(res => {
          // console.log('Proposal rep:' + res)
          context.commit('getProposalReputation', res)
        })
    },
    fetchVoteReputation: (context, address) => {
      Factory.methods
        .getVoteReputation(address)
        .call()
        .then(res => {
          // console.log('Vote rep:' + res)
          context.commit('getVoteReputation', res)
        })
    }
  }
})
