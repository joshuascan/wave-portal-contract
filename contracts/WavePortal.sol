// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;
  mapping(address => uint) userWaveCount;

  event NewWave(address indexed from, uint256 timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint256 timestamp;
  }

  Wave[] waves;

  constructor() {
    console.log("Yo yo, I am a contract and I am smart");
  }

  function wave(string memory _message) public {
    totalWaves += 1;
    userWaveCount[msg.sender] += 1;
    console.log("%s waved w/ message %s", msg.sender, _message);

    waves.push(Wave(msg.sender, _message, block.timestamp));

    emit NewWave(msg.sender, block.timestamp, _message);
  }

  function getAllWaves() public view returns (Wave[] memory) {
    return waves;
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