pragma solidity ^0.5.2;


library SafeMath {
    function add(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function sub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract TNStoken{

    using SafeMath for uint256;

    mapping(address => uint256) balances;
    mapping(address => uint256) locked;
    mapping(address => bool) tokenHolders;
    mapping (address => mapping (address => uint256)) internal allowed;
    uint256 totalSupply_;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Locked(address indexed owner, uint256 indexed amount);

    string public name;
    string public symbol;
    uint8 public decimals;
    address public owner;
modifier onlyOwner(){
    require(msg.sender==owner);
    _;
}

modifier tokenHolder(address _owner){
    require(tokenHolders[_owner]==true);
    _;
}
    constructor() public {
        name = "Carati";
        symbol = "24CAR";
        decimals = 18;
        totalSupply_ = 100000000*10**18;
        balances[address(this)] = totalSupply_;
        owner=msg.sender;
    }

    function increaseLockedAmount(address _owner, uint256 _amount) public returns (uint256) {
        require(tokenHolders[_owner]==true);
        uint256 amt=_amount*10**18;
      
        uint256 lockingAmount = locked[_owner].add(amt);
      //  require(balances[msg.sender] >= lockingAmount, "Locking amount must not exceed balance");
        locked[_owner] = lockingAmount;
        emit Locked(_owner, lockingAmount);
        return lockingAmount;
    }

    function decreaseLockedAmount(address _owner, uint256 _amount)  public returns (uint256) {
          require(tokenHolders[_owner]==true);
        uint256 amt = _amount * 10 ** 18;
        require(locked[_owner] > 0, "Cannot go negative. Already at 0 locked tokens.");
        if (amt > locked[_owner]) {
            amt = locked[_owner];
        }
        uint256 lockingAmount = locked[_owner].sub(amt);
        locked[_owner] = lockingAmount;
        emit Locked(_owner, lockingAmount);
        return lockingAmount;
    }

    function getLockedAmount(address _owner) view public returns (uint256) {
        return locked[_owner];
    }

    function getUnlockedAmount(address _owner) view public returns (uint256) {
        return balances[_owner].sub(locked[_owner]);
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }
    function tokenBalance()public view returns(uint256){
        return balances[address(this)];
    }

    function transfer(address _to, uint256 _value)onlyOwner public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[msg.sender] - locked[msg.sender]);
       
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        tokenHolders[_to]=true;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    function transferFromDAO(address from,address to,uint256 amount) external returns(bool){
        require(to!=address(0) && from!=address(0));
        
        require(amount <= balances[from] - locked[from]);
     
        balances[from]=balances[from].sub(amount);
        balances[to] = balances[to].add(amount);
        tokenHolders[to]=true;
         emit Transfer(from, to, amount);
        return true;
    }
    // function transferExceution(address _from,address to,uint256 amount) public returns(bool){
    //     require(to!=address(0) && _from!=address(0));
    //     amount=amount*10**18;
    //     require(amount <= balances[_from] - locked[_from]);
     
    //     balances[_from]=balances[_from].sub(amount);
    //     balances[to] = balances[to].add(amount);
    //     tokenHolders[to]=true;
    //      emit Transfer(_from, to, amount);
    //     return true;
    // }


    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
    

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool) {
        require(_to != address(0));
        require(_value <= balances[_from] - locked[_from]);
        require(_value <= allowed[_from][msg.sender] - locked[_from]);

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    function increaseApproval(address _spender, uint _addedValue) tokenHolder(msg.sender) public returns (bool) {
        allowed[msg.sender][_spender] = (
        allowed[msg.sender][_spender].add(_addedValue));
        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }

    function decreaseApproval(address _spender, uint _subtractedValue) tokenHolder(msg.sender) public returns (bool) {
        uint oldValue = allowed[msg.sender][_spender];
        if (_subtractedValue > oldValue) {
            allowed[msg.sender][_spender] = 0;
        } else {
            allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
        }
        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }

    function approveAndCall(address  _spender, uint256 _value, bytes calldata _data) external payable returns (bool) {
        require(_spender != address(this));
        this.approve(_spender, _value);
        // solium-disable-next-line security/no-call-value
       // require(_spender.call.value(msg.value)(_data));
        return true;
    }

    function transferAndCall(address _to, uint256 _value, bytes memory _data) public payable returns (bool) {
        require(_to != address(this));
        this.transfer(_to, _value);
        // solium-disable-next-line security/no-call-value
       // require(_to.call.value(msg.value));
        return true;
    }

    function transferFromAndCall(address _from, address _to, uint256 _value, bytes memory _data ) public payable returns (bool) {
        require(_to != address(this));
        this.transferFrom(_from, _to, _value);
        // solium-disable-next-line security/no-call-value
        //require(_to.call.value(msg.value)(_data));
        return true;
    }

    function increaseApprovalAndCall(address _spender, uint _addedValue, bytes memory _data) public payable returns (bool) {
        require(_spender != address(this));
        this.increaseApproval(_spender, _addedValue);
        // solium-disable-next-line security/no-call-value
       // require(_spender.call.value(msg.value)(_data));
        return true;
    }

    function decreaseApprovalAndCall(address _spender, uint _subtractedValue, bytes memory _data) public payable returns (bool) {
        require(_spender != address(this)); 
        this.decreaseApproval(_spender, _subtractedValue);
        // solium-disable-next-line security/no-call-value
       // require(_spender.call.value(msg.value)(_data));
        return true;
    }
}
