pragma solidity ^0.8.0;

interface Oracle {
    function updatePrice() external payable;
}

contract Wallet {

    address private oracleAddress;
    Oracle private oracleInstance;
        
    constructor(address _oracleAddress) {
        oracleAddress = _oracleAddress;
        oracleInstance = Oracle(_oracleAddress);
    }
    
    function getTokenPrice(string memory symbol) public view returns (uint256) {
        return oracleInstance.updatePrice(symbol);
    }

    address public owner;
    mapping(string => uint) public balances;


    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function depositRubles(string memory asset, uint amount) public payable {
        require(amount > 0, "Amount should be greater than zero");
        balances[asset] += amount;
    }

    function withdrawRubles(string memory asset, uint amount) public onlyOwner {
        require(balances[asset] >= amount, "Insufficient balance");
        balances[asset] -= amount;
    }

    function buyEuros()
}
