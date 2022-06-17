// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "seedtosale/Contract.sol";

contract ContractTest is Test {
  Contract contractInstance;

  address device =
    0xD343877a067533b14840416d40738A3D48bAC952;
  string deviceSerial = "some";
  uint8 stages;

  function setUp() public {
    contractInstance = new Contract();
    stages = contractInstance.Stages();
  }

  function testFailDeviceReEntrance() public {
    contractInstance.AddDevice(deviceSerial, device);
    contractInstance.AddDevice(deviceSerial, device);
  }

  function testRegisterSeed() public {
    contractInstance.AddDevice(deviceSerial, device);
    contractInstance.RegisterSeed(deviceSerial, "some");
  }

  function testStartAndCompleteGrowth() public {
    contractInstance.AddDevice(deviceSerial, device);
    contractInstance.RegisterSeed(deviceSerial, "some");
    contractInstance.StartGrowth(deviceSerial, 0);
    for (uint8 i = 0; i < stages; i++) {
      contractInstance.Advance(deviceSerial);
    }
  }

  function testFailStartGrowthWithoutSeed() public {
    contractInstance.AddDevice(deviceSerial, device);
    contractInstance.StartGrowth(deviceSerial, 0);
  }
}
