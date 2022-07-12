// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract ERC20JVD{

    string  public  name;
    string  public  symbol;
    uint8   public  decimals;
    uint256 totalSupply_;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    event Transfer(address from, address to, uint256 value);
    event Approval(address owner, address spender, uint256 value);


    constructor()  {
        name = "Javad";
        symbol = "JVD";
        decimals = 1;
        totalSupply_ = 10000;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 amount) payable public returns (bool) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender]-amount;
        balances[receiver] = balances[receiver]+amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function approve(address delegate, uint256 amount) public returns (bool) {
        allowed[msg.sender][delegate] = amount;
        emit Approval(msg.sender, delegate, amount);
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 amount) payable public returns (bool) {
        require(amount <= balances[owner]);
        require(amount <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner]-amount;
        allowed[owner][msg.sender] = allowed[owner][msg.sender]-amount;
        balances[buyer] = balances[buyer]+amount;
        emit Transfer(owner, buyer, amount);
        return true;
    }
}
