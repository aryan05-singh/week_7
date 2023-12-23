// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;



contract UnsafeBank {
    mapping(address => uint256) public balances;

    // allow depositing on other's behalf
    function deposit(address to) public payable  {
        balances [to] += msg.value ;
    }

    function withdraw(address from, uint256 amount) public {
        require(balances[from] >= amount, "insufficient balance");

        balances [from] -= amount;
    
    }
}