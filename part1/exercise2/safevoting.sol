// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract SafeBallot {

    uint256 public proposal1VoteCount;
    uint256 public proposal2VoteCount;
    mapping(address => bool) public alreadyVoted; 
    IERC20 immutable private governanceToken;

    constructor(IERC20 _governanceToken) {
        governanceToken = _governanceToken;
    }

    function voteFor1() external notAlreadyVoted {
        proposal1VoteCount += 1;
    }

    function voteFor2() external notAlreadyVoted {
        proposal2VoteCount += 1; 
    }

  
    modifier notAlreadyVoted() {
        require(!alreadyVoted[msg.sender], "Already voted");
        _;
        alreadyVoted[msg.sender] = true;
    }
}