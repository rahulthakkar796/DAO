import EmbarkJS from '../embarkjs';
let FactoryDemoJSONConfig = {"contract_name":{"className":"FactoryDemo","args":[],"code":"","runtimeBytecode":"","realRuntimeBytecode":"","linkReferences":{},"swarmHash":"","gasEstimates":null,"functionHashes":{"getBlacklist(address)":"5d77d8d0","getProposalReputation(address)":"81b67d84","getReputation(address)":"9c89a0e2","getSuccessDao(address)":"617369e6","getSuccessProposals(address)":"76856ac8","getSuccessVotes(address)":"8bc8169e","getTotalProposals(address)":"4d9c1f13","getTotalVotes(address)":"9d3c259a","getVoteReputation(address)":"11b269f1","setBlacklist(address)":"4e054a67","setProposalReputation(address)":"a8717d09","setReputation(address,address)":"ce067b3f","setSuccessDao(address,address)":"9d3bcb63","setSuccessProposal(address,bool)":"3eb9a3f4","setSucessVotes(address,bool)":"66aba3be","setTotalProposals(address)":"4e966ac7","setTotalVotes(address)":"ea6df5f6","setVoteReputation(address)":"1e163026"},"abiDefinition":[{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getVoteReputation","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setVoteReputation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"},{"name":"increase","type":"bool"}],"name":"setSuccessProposal","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getTotalProposals","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setBlacklist","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setTotalProposals","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getBlacklist","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getSuccessDao","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"},{"name":"increase","type":"bool"}],"name":"setSucessVotes","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getSuccessProposals","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getProposalReputation","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getSuccessVotes","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getReputation","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"},{"name":"_contract","type":"address"}],"name":"setSuccessDao","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getTotalVotes","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setProposalReputation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"user","type":"address"},{"name":"_contract","type":"address"}],"name":"setReputation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setTotalVotes","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}],"filename":"/home/keval/Desktop/DAO/demo/.embark/contracts/DAO.sol","originalFilename":"contracts/DAO.sol","path":"/home/keval/Desktop/DAO/demo/contracts/DAO.sol","gas":"auto","type":"file","deploy":false,"_gasLimit":6000000,"error":false},"code":"","runtime_bytecode":"","real_runtime_bytecode":"","swarm_hash":"","gas_estimates":null,"function_hashes":{"getBlacklist(address)":"5d77d8d0","getProposalReputation(address)":"81b67d84","getReputation(address)":"9c89a0e2","getSuccessDao(address)":"617369e6","getSuccessProposals(address)":"76856ac8","getSuccessVotes(address)":"8bc8169e","getTotalProposals(address)":"4d9c1f13","getTotalVotes(address)":"9d3c259a","getVoteReputation(address)":"11b269f1","setBlacklist(address)":"4e054a67","setProposalReputation(address)":"a8717d09","setReputation(address,address)":"ce067b3f","setSuccessDao(address,address)":"9d3bcb63","setSuccessProposal(address,bool)":"3eb9a3f4","setSucessVotes(address,bool)":"66aba3be","setTotalProposals(address)":"4e966ac7","setTotalVotes(address)":"ea6df5f6","setVoteReputation(address)":"1e163026"},"abi":[{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getVoteReputation","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setVoteReputation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"},{"name":"increase","type":"bool"}],"name":"setSuccessProposal","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getTotalProposals","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setBlacklist","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setTotalProposals","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getBlacklist","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getSuccessDao","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"},{"name":"increase","type":"bool"}],"name":"setSucessVotes","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getSuccessProposals","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getProposalReputation","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getSuccessVotes","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getReputation","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"},{"name":"_contract","type":"address"}],"name":"setSuccessDao","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"add","type":"address"}],"name":"getTotalVotes","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setProposalReputation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"user","type":"address"},{"name":"_contract","type":"address"}],"name":"setReputation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"add","type":"address"}],"name":"setTotalVotes","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]};
let FactoryDemo = new EmbarkJS.Blockchain.Contract(FactoryDemoJSONConfig);
export default FactoryDemo;