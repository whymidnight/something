// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "seedtosale/Contract.sol";

contract ContractTest is Test {
  address device =
    0xD343877a067533b14840416d40738A3D48bAC952;
  string deviceSerial = "some";
  Contract contractInstance;

  function setUp() public {
    contractInstance = new Contract();
  }

  function testFailDeviceReEntrance() public {
    contractInstance.AddDevice(deviceSerial, device);
    contractInstance.AddDevice(deviceSerial, device);
  }

  function testRegisterSeed() public {
    contractInstance.AddDevice(deviceSerial, device);
    contractInstance.RegisterSeed(deviceSerial, "some", 4);
  }
}
