
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0 ;

contract EtherStore {
    bool lock;
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function withdraw() public {
        require (lock == false,"Locked");
        lock = true;
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
        lock = false;
    }

    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}