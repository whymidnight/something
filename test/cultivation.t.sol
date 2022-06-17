// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "seedtosale/cultivation.sol";
import "seedtosale/hardware_mgmt.sol";

contract seedAccountingTest is Test {
  address device =
    0xD343877a067533b14840416d40738A3D48bAC952;
  string deviceSerial = "some";
  seedAccounting seedAccountingInstance;
  hardwareMgmt hwMgmt;

  function setUp() public {
    seedAccountingInstance = new seedAccounting();
    hwMgmt = new hardwareMgmt();
  }

  function testRegisterSeed() public {
    hwMgmt.AddDevice(deviceSerial, device);
    seedAccountingInstance.RegisterSeed(
      deviceSerial,
      "some"
    );
  }

  function testGetSeed() public {
    hwMgmt.AddDevice(deviceSerial, device);
    seedAccountingInstance.RegisterSeed(
      deviceSerial,
      "some"
    );
    (string memory strainName, ) = seedAccountingInstance
      .GetSeed(deviceSerial);
    emit log_string(strainName);
  }
}

contract cultivationTest is Test {
  address device =
    0xD343877a067533b14840416d40738A3D48bAC952;
  string deviceSerial = "some";
  seedAccounting seedAccountingInstance;
  hardwareMgmt hwMgmt;
  cultivationAccounting cultivationAccting;
  uint8 stages;

  function setUp() public {
    seedAccountingInstance = new seedAccounting();
    hwMgmt = new hardwareMgmt();
    cultivationAccting = new cultivationAccounting();
    stages = cultivationAccting.Stages();
  }

  function testStartGrowth() public {
    cultivationAccting.StartGrowth(deviceSerial, 0);
  }

  function testStartAndCompleteGrowth() public {
    cultivationAccting.StartGrowth(deviceSerial, 0);
    for (uint8 i = 0; i < stages; i++) {
      cultivationAccting.Advance(deviceSerial);
    }
  }

  function testFailStartAndExceedGrowth() public {
    cultivationAccting.StartGrowth(deviceSerial, 0);
    for (uint8 i = 0; i <= stages; i++) {
      cultivationAccting.Advance(deviceSerial);
    }
  }
}

