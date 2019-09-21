pragma solidity ^0.5.2;
import "./SafeMath.sol";


contract LockableToken{
    function totalSupply() public view returns (uint256);
    function balanceOf(address who) public view returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    function allowance(address owner, address spender) public view returns (uint256);
    function transferFrom(address from, address to, uint256 value) public returns (bool);
    function transferFromDAO(address _from,address to,uint256 amount) external returns(bool);
    function approve(address spender, uint256 value) public returns (bool);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function approveAndCall(address _spender, uint256 _value, bytes memory _data) public payable returns (bool);
    function transferAndCall(address _to, uint256 _value, bytes memory _data) public payable returns (bool);
    function transferFromAndCall(address _from, address _to, uint256 _value, bytes memory _data) public payable returns (bool);
    function decimals() public view returns (uint256);
    function increaseLockedAmount(address _owner, uint256 _amount) public returns (uint256);
    function decreaseLockedAmount(address _owner, uint256 _amount) public returns (uint256);
    function getLockedAmount(address _owner) view public returns (uint256);
    function getUnlockedAmount(address _owner) view public returns (uint256);
    function tokenBalance() public view returns(uint256);
      
}

contract FactoryDemo{
    function getReputation(address add) public view returns(uint);
    function setReputation(address user,address _contract) public ;
     function setSuccessDao(address add,address _contract) external ;
      function getSuccessDao(address add) public view returns(uint);
        function setBlacklist(address add) external;
         function getBlacklist(address add)public view returns(bool);
      function setTotalVotes(address add)external;
      
       function setSucessVotes(address add,bool increase) external;
    function setVoteReputation(address add) external;
    function setTotalProposals(address add) external;
    function setSuccessProposal(address add,bool increase) external;
    function setProposalReputation(address add)external;
    
     function getTotalVotes(address add)public view returns(uint);
    function getSuccessVotes(address add)public view returns(uint);
    
    function getVoteReputation(address add)public view returns(uint);
    function getTotalProposals(address add)public view returns(uint);
     function getSuccessProposals(address add)public view returns(uint);
     function getProposalReputation(address add)public view returns(uint);
      
}
contract Factory {
    DAO[] newContracts;
    uint counter=0;
    function createContract (address token ,string memory title,uint256 deadline,uint256 interestRatio,uint256 members) public {
        require(blacklist[msg.sender]==false);
 
        DAO newContract =new DAO(token,address(this),title,deadline,interestRatio,members);
        newContracts.push(newContract);
       
        counter++;
          newContracts[counter-1].setOwner(msg.sender);
          DaoOwner[getAddress()][msg.sender]=true;
         if(reputation[msg.sender]==0){
          reputation[msg.sender]=1;
         }
       
    }
     function getAddressIndex(uint index) public view  returns(address){
        return address(newContracts[index]);
    } 
    
    function getAddress() public view  returns(address){
        return address(newContracts[counter-1]);
    } 
    function getNumbers() public view returns(uint){
        return newContracts.length;
    }
    mapping(address=>bool) private blacklist;
    mapping(address=>uint) private reputation;
    mapping(address=>uint) private successDAO;
    mapping(address=>uint) private totalVotes;
    mapping(address=>uint) private successVotes;
    mapping(address=>uint )private voteReputation;
    mapping(address=>uint) private successProposals;
    mapping(address=>uint) private totalProposals;
    mapping(address=>uint) private proposalReputation;
  
  
    mapping(address=>mapping(address=>bool)) private DaoOwner;
    
    
     
    function setReputation(address add,address _contract) public {
        require(reputation[msg.sender]<5 && DaoOwner[_contract][add]==true && blacklist[add]==false);
        if(successDAO[add]<=2){
            reputation[add]=1;
        }
        else if(successDAO[add]>2 && successDAO[add]<=4){
            reputation[add]=2;
        }
         else if(successDAO[add]>4 && successDAO[add]<=6){
            reputation[add]=3;
        }
         else if(successDAO[add]>4 && successDAO[add]<=6){
            reputation[add]=4;
        }
         else if(successDAO[add]>6){
            reputation[add]=5;
        }
        
        
        
        
          
        
    }
    function getReputation(address add) public view returns(uint){
        return reputation[add];
    }
    
    function setSuccessDao(address add,address _contract) external {
         require(blacklist[add]==false && DaoOwner[_contract][add]==true);
        successDAO[add]+=1;
    }
    function getSuccessDao(address add) public view returns(uint){
        return successDAO[add];
    }
    function setBlacklist(address add) external{
         require(blacklist[add]==false);
        blacklist[add]=true;
    }
    function getBlacklist(address add)public view returns(bool){
        
         return blacklist[add];
    }
    function setTotalVotes(address add)external{
        totalVotes[add]+=1;
    }
    function setSucessVotes(address add,bool increase) external{
        if(increase==true){
        successVotes[add]+=1;
        }
        else if(increase==false){
            successVotes[add]-=1;
        }
    }
    function setVoteReputation(address add) external{
        require(voteReputation[add]<5);
         require(blacklist[add]==false);
        if(successVotes[add]<=5){
            voteReputation[add]=1;
        }else if(successVotes[add]>5 && successVotes[add]<=10){
            voteReputation[add]=2;
            
        }
        else if(successVotes[add]>10 && successVotes[add]<=15){
            voteReputation[add]=3;
            
        }
        else if(successVotes[add]>15 && successVotes[add]<=20){
            voteReputation[add]=4;
            
        }
        else if(successVotes[add]>20){
            voteReputation[add]=5;
            
        }
        
        
        
        
    }
    function setTotalProposals(address add) external{
         require(blacklist[add]==false);
        totalProposals[add]+=1;
        
    }
    function setSuccessProposal(address add,bool increase) external{
         require(blacklist[add]==false);
        if(increase==true){
        successProposals[add]+=1;
        }else if(increase==false){
              successProposals[add]-=1;
        }
    }
    function setProposalReputation(address add)external{
        require(proposalReputation[add]<5 && blacklist[add]==false);
         if(successProposals[add]<=3){
            proposalReputation[add]=1;
        }else if(successProposals[add]>3 && successProposals[add]<=6){
            proposalReputation[add]=2;
            
        }
        else if(successProposals[add]>6 && successProposals[add]<=9){
            proposalReputation[add]=3;
            
        }
        else if(successProposals[add]>9 && successProposals[add]<=12){
            proposalReputation[add]=4;
            
        }
        else if(successProposals[add]>12){
            proposalReputation[add]=5;
            
        }
       
    }
    function getTotalVotes(address add)public view returns(uint){
        return totalVotes[add];
    }
    function getSuccessVotes(address add)public view returns(uint){
        return successVotes[add];
    }
    
    function getVoteReputation(address add)public view returns(uint){
        return voteReputation[add];
    }
    function getTotalProposals(address add)public view returns(uint){
        return totalProposals[add];
    }
     function getSuccessProposals(address add)public view returns(uint){
        return successProposals[add];
    }
     function getProposalReputation(address add)public view returns(uint){
        return proposalReputation[add];
    }



}
contract DAO {
    using SafeMath for uint256;
  
    mapping(address=>bool) public whitelist;
    mapping(uint256=>mapping(address=>bool))public voters;
    mapping(address=>uint256)public investedAmount;
    mapping(address=>bool)private hasVoted;
    mapping(uint256=>mapping(address=>bool))public returned;
    mapping(uint256=>mapping(address=>bool))public hasVotedNo;
    mapping(uint256=>mapping(address=>bool))public hasVotedYes;
     mapping(uint256=>mapping(address=>bool))public hasIncreasedReputation;
    uint256 public whitelistedAccounts=0;
    string public title;
    uint256 public DaoDeadline;
    uint256 public members;
    uint256 public memberCount=0;
    uint256 public DaoTimestamp;
    uint256 public interestRatio;
    uint256 public totalInvestment=0;
    uint256 public finalInvestment=0;
    
    LockableToken public token;
    FactoryDemo public factory;
    bool public active=false;
    uint public tokenToWeiRatio=10000*10**18;
    address payable  public owner ;
    uint256 public daoFee=100;
    uint claimed=0;
    uint256 public whitelistfee= 10000000000000000; //0.01 ether
    uint256 public withdrawableByOwner=0;
    uint256 public whitelistedNumber=0;
    int256 public voteCount=0;
    int256 public tokenStaked=0;
    struct Proposal{
        string  title;
        string description;
        string url;
        bool executed;
        int256  currentResult;
        uint256 deadline;
        uint256 timestamp;
        uint256 id;
        uint256 target;
        uint256 totalVotes;
        uint256 yesVotes;
        uint256 noVotes;
        uint256 returnTokensCountYes;
        uint256 returnTokensCountNo;
        address submitter;
    }
  
    struct Vote{
        uint256 proposalID;
        bool inSupport;
        address voter;
        string justification;
        uint256 power;
        
    }
    Proposal[]  proposals;
     Vote[] public  votes;
    uint256 public proposalCount=0;
    uint256 activeProposalCount=0;
    uint256 public  endedProposalCount=0;
    modifier memberOnly(){
        require(whitelist[msg.sender]==true,"you are not whitelisted");
        _;
    }
     modifier tokenHoldersOnly(address owner) {
        require(token.balanceOf(owner) >= 10**token.decimals());
        _;
    }
    modifier onlyOwner{
        require(msg.sender==owner);
        _;
    }
    modifier DAOActive(){
        require(active==true);
        _;
    }
    modifier DeadlineReached(){
        require(now<DaoDeadline,"DAO is ended");
        _;
    }
    modifier memberRule(){
        require(memberCount<members,"members limit is reached");
        _;
    }
    modifier voterOnly(){
        require(hasVoted[msg.sender]==true);
        _;
    }
    
    constructor(address _token,address _factory,string memory _title,uint256 _deadline,uint256 _interestRatio,uint256 _members) public{
        require(_token!=address(0),"address can't be a null address");
        
        token=LockableToken(_token);
        factory=FactoryDemo(_factory);
     
        title=_title;
        interestRatio=_interestRatio;
        members=_members;
        DaoTimestamp=now;
        DaoDeadline=(_deadline*86400)+DaoTimestamp;
      
        active=true;
    }
    
    function setOwner(address payable _owner)external{
        owner=_owner;
    }
       function daoTokenBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }
    function createProposal(string memory title,string memory _desc,string memory _url,uint256 _target,uint256 _deadline) DAOActive onlyOwner DeadlineReached public returns(bool){
        require(factory.getBlacklist(msg.sender)==false);
   require(now+_deadline*86400 <DaoDeadline,"proposal deadline shouldn't be  longer than DAO's deadliner");
     if(factory.getReputation(owner)==1){
         require(_target<=2000);
     }else if(factory.getReputation(owner)==2){
         require(_target<=2000*2);
     }
     else if(factory.getReputation(owner)==3){
         require(_target<=2000*3);
     }
     else if(factory.getReputation(owner)==4){
         require(_target<=2000*4);
     }
        proposals.push(
            Proposal(
                title,
                _desc,
                _url,
                false,
                0,
              
                now+(_deadline *86400),
                now,
                proposals.length,
                _target,
                  0,
                0,
                0,
                0,
                0,
                msg.sender
                )
            
            )-1;
            proposalCount++;
            activeProposalCount++;
            factory.setTotalProposals(msg.sender);
            return true;
        
    }
    
    function voteProposal(uint256 _id,bool _vote,string memory _desc,uint256 _power)memberOnly DAOActive tokenHoldersOnly(msg.sender) DeadlineReached public{
         require(factory.getBlacklist(msg.sender)==false);
        ///require(memberCount<=members);
        require(_power>=50,"At leat some power must be given to the vote");
         require(_power <= token.balanceOf(msg.sender), "Voter must have enough tokens to cover the power cost.");
         Proposal storage p=proposals[_id];
         require(p.id==_id,"Id doesn't match");
         require(p.executed==false,"Already executed");
         require(p.deadline>now,"deadline is over");
         require(_power<=p.target && p.currentResult<int256(p.target) && p.currentResult+int256(_power)<=int256(p.target),"Target is reached");
         require(voters[_id][msg.sender]==false,"you have alrady voted");
         //uint256 voteId=votes.length;
        
         votes.push(
             Vote(
                 _id,
                 _vote,
                   msg.sender,
                 _desc,
                 _power
                 )
             )-1;
      
         voters[_id][msg.sender]=true;
         hasVoted[msg.sender]=true;
        if(_vote==true){
            p.yesVotes++;
            hasVotedYes[_id][msg.sender]=true;
        }else{
            hasVotedNo[_id][msg.sender]=true;
            p.noVotes++;
        }
         p.currentResult=(_vote) ? p.currentResult+int256(_power):p.currentResult-int256(_power);
         tokenStaked=tokenStaked+int256(_power);
       
         p.totalVotes++;
         voteCount++;
        token.increaseLockedAmount(msg.sender,_power);
         uint256 price=  1000000000000000000;
         uint256 amount=(_power*10**18).mul(price).div(tokenToWeiRatio);
           totalInvestment+=amount+(amount*interestRatio)/100;
        // msg.sender.transfer(amount);
         investedAmount[msg.sender]+=amount;
         factory.setTotalVotes(msg.sender);
           
       
    }
    function contractEthBalance()public view returns(uint256){
        return address(this).balance;
    }
    
    function buyTokensInternal(address _buyer, uint256 _wei)DAOActive DeadlineReached internal {
         require(factory.getBlacklist(msg.sender)==false);
       
        uint256 tokens = _wei.mul(tokenToWeiRatio).div(1 ether);
        if (token.tokenBalance() < tokens) {
            msg.sender.transfer(_wei);
        } else {
            token.transferFromDAO(address(token),_buyer, tokens);
        }
    }
    //  function buyTokensexternal(address _buyer, uint256 _wei) payable public {
       
    //     uint256 tokens = _wei.mul(tokenToWeiRatio).div(1 ether);
    //     if (daoTokenBalance() < tokens) {
    //         msg.sender.transfer(_wei);
    //     } else {
    //         token.transferFromDAO(address(this),_buyer, tokens);
    //     }
    // }
      function whitelistAddress(address _add,uint256 value)DAOActive DeadlineReached memberRule internal {
           require(factory.getBlacklist(msg.sender)==false);
        require(whitelist[_add]==false, "Candidate must not be whitelisted.");
      //  require(!blacklist[_add], "Candidate must not be blacklisted.");
        require(value >= whitelistfee, "Sender must send enough ether to cover the whitelisting fee.");
        withdrawableByOwner += value;
        whitelist[_add] = true;
        whitelistedNumber++;
         memberCount++;
     
        if (value > whitelistfee) {
            buyTokensInternal(_add,value.sub(whitelistfee)); 
        }
    }
    
    
    function exceuteProposal(uint _id) DAOActive  public{
         require(factory.getBlacklist(msg.sender)==false);
        Proposal storage p=proposals[_id];
        require(!p.executed);
        require(p.currentResult==int256(p.target));
        require(msg.sender==p.submitter);
          p.executed=true;
           factory.setSuccessProposal(owner,true);
           factory.setProposalReputation(owner);
        uint256 len=votes.length;
        for(uint i=0;i<len;i++){
            if(p.id==votes[i].proposalID && votes[i].inSupport==true){
              
           factory.setSucessVotes(votes[i].voter,true);
           factory.setVoteReputation(votes[i].voter);
            token.decreaseLockedAmount(votes[i].voter,votes[i].power);
            token.transferFromDAO(votes[i].voter,p.submitter,votes[i].power*10**18);
             uint256 price=  1000000000000000000;
                uint256 amount=(votes[i].power*10**18).mul(price).div(tokenToWeiRatio);
                finalInvestment+=amount+(amount*interestRatio)/100;
            
            }
              if(p.id==votes[i].proposalID && votes[i].inSupport==false){
                    token.decreaseLockedAmount(votes[i].voter,votes[i].power);
                    factory.setSucessVotes(votes[i].voter,false);
                     factory.setVoteReputation(votes[i].voter);
              }
            
        }
      
        activeProposalCount--;
        endedProposalCount++;
        
    }


    
    // function returnTokensToYesVoters(uint256 _id) public voterOnly memberOnly  tokenHoldersOnly(msg.sender){
    //      require(factory.getBlacklist(msg.sender)==false);
    //      require(voters[_id][msg.sender]==true);
    //       Proposal storage p=proposals[_id];
    //       require(p.deadline<now);
    //     //   require(p.executed==false);
    //       for(uint256 i=0;i<votes.length;i++){
    //           if(p.id==votes[i].proposalID && votes[i].voter==msg.sender){
    //               if(hasVotedYes[_id][msg.sender]==true){
    //              require(p.executed==false && returned[_id][msg.sender]==false &&  uint256(p.currentResult)<p.target);
                  
    //               //require(votes[i].voter==msg.sender && votes[i].inSupport==true && uint256(p.currentResult)<p.target && returned[_id][msg.sender]==false,"Something went wrong");
    //               returned[_id][msg.sender]=true;
    //               p.returnTokensCountYes++;
    //               uint256 loss=(votes[i].power*10)/100;
    //                uint256 price=  1000000000000000000;
    //      uint256 amount=(votes[i].power*10**18).mul(price).div(tokenToWeiRatio);
    //               totalInvestment-=amount;
    //               investedAmount[msg.sender]-=amount;
    //                 factory.setSucessVotes(votes[i].voter,false);
    //                 factory.setVoteReputation(votes[i].voter);
    //              token.decreaseLockedAmount(votes[i].voter,votes[i].power);
    //             // token.transferFromDAO(votes[i].voter,p.submitter,votes[i].power-loss);
    //             token.transferFromDAO(votes[i].voter,address(this),loss*10**18);
    //             if(p.returnTokensCountYes==p.yesVotes){
                   
    //                   factory.setSuccessProposal(p.submitter,false);
    //                   factory.setProposalReputation(p.submitter);
    //                   VoteAssign(_id);
                  
    //             }
                  
                 
    //           }else if(hasVotedNo[_id][msg.sender]==true){

    //            require(returned[_id][msg.sender]==false &&  uint256(p.currentResult) == p.target);
    //              returned[_id][msg.sender]=true;
    //               p.returnTokensCountNo++;
    //               uint256 loss=(votes[i].power*10)/100;
    //                uint256 price=  1000000000000000000;
    //      uint256 amount=(votes[i].power*10**18).mul(price).div(tokenToWeiRatio);
    //               totalInvestment-=amount;
    //               investedAmount[msg.sender]-=amount;
    //                 factory.setSucessVotes(votes[i].voter,false);
    //                 factory.setVoteReputation(votes[i].voter);
    //              token.decreaseLockedAmount(votes[i].voter,votes[i].power);
    //             // token.transferFromDAO(votes[i].voter,p.submitter,votes[i].power-loss);
    //             token.transferFromDAO(votes[i].voter,address(this),loss*10**18);
    //           }
    //       }
    // }
    // }

    function returnTokensToYesVoters(uint256 _id) public voterOnly memberOnly  tokenHoldersOnly(msg.sender){
         require(factory.getBlacklist(msg.sender)==false);
         require(voters[_id][msg.sender]==true);
          Proposal storage p=proposals[_id];
          //(p.deadline<now);
          require(p.executed==false);
          for(uint256 i=0;i<votes.length;i++){
              if(p.id==votes[i].proposalID){
                  if(votes[i].inSupport==false && p.returnTokensCountYes<p.yesVotes){
                  
                  require(votes[i].voter==msg.sender && votes[i].inSupport==true && uint256(p.currentResult)==p.target && returned[_id][msg.sender]==false,"Something went wrong");
                  returned[_id][msg.sender]=true;
                  p.returnTokensCountYes++;
                  uint256 loss=(votes[i].power*10)/100;
                   uint256 price=  1000000000000000000;
         uint256 amount=(votes[i].power*10**18).mul(price).div(tokenToWeiRatio);
                  totalInvestment-=amount;
                  investedAmount[msg.sender]-=amount;
                    factory.setSucessVotes(votes[i].voter,false);
                    factory.setVoteReputation(votes[i].voter);
                 token.decreaseLockedAmount(votes[i].voter,votes[i].power);
                // token.transferFromDAO(votes[i].voter,p.submitter,votes[i].power-loss);
                token.transferFromDAO(votes[i].voter,address(this),loss*10**18);
                if(p.returnTokensCountYes==p.yesVotes){
                   
                      factory.setSuccessProposal(p.submitter,false);
                      factory.setProposalReputation(p.submitter);
                      VoteAssign(_id);
                  
                }
                  
                 
              }
              }
          }
    }
    
    
    
    function VoteAssign(uint256 _id)private voterOnly memberOnly tokenHoldersOnly(msg.sender){
         require(factory.getBlacklist(msg.sender)==false);
          require(voters[_id][msg.sender]==true);
          Proposal storage p=proposals[_id];
          require(p.deadline<now);
          for(uint256 i=0;i<votes.length;i++){
              if(p.id==votes[i].proposalID){
                  if(votes[i].inSupport==false){
                      factory.setSucessVotes(votes[i].voter,true);
                      factory.setVoteReputation(votes[i].voter);
                  }
              }
          }
        
    }

    function voteAssignNo(uint256 _id)public voterOnly memberOnly tokenHoldersOnly(msg.sender){
          require(factory.getBlacklist(msg.sender)==false && hasIncreasedReputation[_id][msg.sender]==false);
          require(voters[_id][msg.sender]==true && hasVotedNo[_id][msg.sender]==true);
          Proposal storage p=proposals[_id];
          require(p.deadline<now && p.executed==false);
          hasIncreasedReputation[_id][msg.sender]=true;
          factory.setSucessVotes(msg.sender,true);
          factory.setVoteReputation(msg.sender);

    }
     function withdrawDividend() private memberOnly voterOnly  {
          require(factory.getBlacklist(msg.sender)==false);
        require(whitelist[msg.sender]==true  && now>DaoDeadline+(7*86400));
        //require(address(this).balance>=totalInvestment);
        if(address(this).balance<finalInvestment && endedProposalCount>0 ){
             factory.setBlacklist(owner);
        }
        else if(address(this).balance>=finalInvestment && endedProposalCount>0){
        uint256 amount=investedAmount[msg.sender]+(investedAmount[msg.sender]*interestRatio/100);
        finalInvestment-=amount;
          whitelist[msg.sender] = false;
        whitelistedNumber--;
        msg.sender.transfer(amount);
      
        claimed++;
        if(claimed==memberCount){
             factory.setSuccessDao(owner,address(this));
             factory.setReputation(owner,address(this));
            }
        }
        
        
     }

    function endDao() DAOActive onlyOwner public {
       // withdrawToOwner();
        require(factory.getBlacklist(msg.sender)==false  && now>DaoDeadline+(7*86400));
        active = false;
        DaoDeadline=0;
       
    }
    //  function withdrawToOwner()onlyOwner internal{
      
     
    //     owner.transfer(withdrawableByOwner);
    //     withdrawableByOwner = 0;
    // }
    function() external DAOActive DeadlineReached  payable{
        if(!whitelist[msg.sender]){
            
            whitelistAddress(msg.sender,msg.value);
        }
        else{
            buyTokensInternal(msg.sender,msg.value);
        }
    }
    
    function extendDeadline(uint256 _deadline)public DAOActive onlyOwner{
         require(factory.getBlacklist(msg.sender)==false);
        require(active==true && now<DaoDeadline+(7*86400),"You can't extend deadline until the given deadline is reached");
        DaoTimestamp=now;
        DaoDeadline=DaoTimestamp+_deadline*86400;
        
        
    }
    
    function changeOwner(address payable _owner) public DAOActive DeadlineReached onlyOwner{
         require(factory.getBlacklist(msg.sender)==false);
        owner=_owner;
    }

    
    // function getDividend(address add)public view returns(uint256){
    //     uint256 amount=investedAmount[add]*interestRatio/100;
    //     return amount;
    // }
    
      
    // function getDetails(uint256 _id) public view returns(string memory title,string memory desc,string memory url,uint256,address,uint256,uint256,uint256,uint256,uint256,int256){
    //     Proposal storage p=proposals[_id];
    //     return (p.title,p.description,p.url,p.target,p.submitter,p.timestamp,p.deadline,p.totalVotes,p.yesVotes,p.noVotes,p.currentResult);
        
    // }
    function getTitle(uint256 _id) public view returns(string memory s){
        
         Proposal storage p=proposals[_id];
         return (p.title);
    }
    function getDescription(uint256 _id)public  view returns(string memory s){
          Proposal storage p=proposals[_id];
         return (p.description);
    }
     function getURL(uint256 _id) public view returns(string memory s){
        
         Proposal storage p=proposals[_id];
         return (p.url);
    }
     function getTarget(uint256 _id) public view returns(uint256){
        
         Proposal storage p=proposals[_id];
         return (p.target);
    }
    function getSubmitter(uint256 _id) public view returns(address){
          Proposal storage p=proposals[_id];
         return (p.submitter);
    }
      function getTimestamp(uint256 _id) public view returns(uint256){
          Proposal storage p=proposals[_id];
         return (p.timestamp);
    }
    
    function getDeadline(uint256 _id) public view returns(uint256){
          Proposal storage p=proposals[_id];
         return (p.deadline);
    }
    function getTotalVotes(uint256 _id) public view returns(uint256){
         Proposal storage p=proposals[_id];
         return (p.totalVotes);
    }

     function getYesVotes(uint256 _id) public view returns(uint256){
         Proposal storage p=proposals[_id];
         return (p.yesVotes);
    }
     function getNoVotes(uint256 _id) public view returns(uint256){
         Proposal storage p=proposals[_id];
         return (p.noVotes);
    }
    function getCurrentResult(uint256 _id)public view returns(int256){
         Proposal storage p=proposals[_id];
         return (p.currentResult);
    }

    function getExecuted(uint256 _id) public view returns(bool){
           Proposal storage p=proposals[_id];
         return (p.executed);
    }

    function getHasVoted(address add)public view returns(bool){
        return hasVoted[add];
    }
    
    // function getReputation(address add)public view returns(uint){
    //    return factory.getRepountutation(add);
    // }
    // function getVoteCount() public view returns(uint256){
    //     return votes.length;
    // }
    
    function changeTokenContract(address _token) onlyOwner public{
        token=LockableToken(_token);
        
    }
    
         
    
}