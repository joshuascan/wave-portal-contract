// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;
  uint256 private seed;
  mapping(address => uint256) userWaveCount;
  mapping(address => uint256) public lastWavedAt;

  event NewWave(address indexed from, uint256 timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint256 timestamp;
  }

  Wave[] waves;

  constructor() payable {
    console.log("We have been constructed!");
    seed = (block.timestamp + block.difficulty) % 100;
  }

  function wave(string memory _message) public {
    require(
      lastWavedAt[msg.sender] + 5 minutes < block.timestamp,
      "Must wait 5 minutes before waiving again."
    );

    lastWavedAt[msg.sender] = block.timestamp;

    totalWaves += 1;
    userWaveCount[msg.sender] += 1;
    console.log("%s waved w/ message %s:", msg.sender, _message);

    waves.push(Wave(msg.sender, _message, block.timestamp));

    seed = (block.timestamp + block.difficulty + seed) % 100;

    if (seed < 50) {
      console.log("%s won!", msg.sender);

      uint256 prizeAmount = 0.0001 ether;
      require(
        prizeAmount <= address(this).balance,
        "Trying to withdraw more money than the contract has."
      );
      (bool success, ) = (msg.sender).call{value: prizeAmount}("");
      require(success, "Failed to withdraw money from contract.");
    }

    emit NewWave(msg.sender, block.timestamp, _message);

  }

  function getAllWaves() public view returns (Wave[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    return totalWaves;
  }

  function getUserWaveCount(address _userAddress) public view returns (uint) {
    return userWaveCount[_userAddress];
  }
}