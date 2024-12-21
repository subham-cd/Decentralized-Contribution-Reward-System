// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RnDReward {
    address public owner;
    uint256 public rewardPool;
    mapping(address => uint256) public contributions;

    constructor() {
        owner = msg.sender;
        rewardPool = 1000000;  // Initial reward pool
    }

    // Add contribution (simplified version)
    function contribute(address contributor, uint256 amount) public {
        require(msg.sender == owner, "Only owner can record contributions");
        contributions[contributor] += amount;
    }

    // Reward distribution based on contributions
    function distributeReward(address contributor) public {
        require(msg.sender == owner, "Only owner can distribute rewards");
        uint256 reward = contributions[contributor];
        require(reward > 0, "No contributions found");
        rewardPool -= reward;  // Deduct from the pool
        payable(contributor).transfer(reward);  // Transfer reward
    }

    // Fund the reward pool
    function fundPool() public payable {
        require(msg.sender == owner, "Only owner can fund the pool");
    }
}
