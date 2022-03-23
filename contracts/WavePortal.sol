// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;
  mapping(address => uint) userWaveCount;

  constructor() {
    console.log("Yo yo, I am a contract and I am smart");
  }

  function wave() public {
    totalWaves += 1;
    userWaveCount[msg.sender] += 1;
    console.log("%s has waved!", msg.sender);
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves!", totalWaves);
    return totalWaves;
  }

  function getUserWaveCount(address _userAddress) public view returns (uint) {
    console.log("%s has waved %d times!", _userAddress, userWaveCount[_userAddress]);
    return userWaveCount[_userAddress];
  }
}