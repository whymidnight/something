// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "seedtosale/cultivation.sol";

contract seed_accountingTest is Test {
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
      "some",
      3
    );
  }

  function testGetSeed() public {
    hwMgmt.AddDevice(deviceSerial, device);
    seedAccountingInstance.RegisterSeed(
      deviceSerial,
      "some",
      3
    );
    (
      string memory strainName,
      uint64 plantedEpoch
    ) = seedAccountingInstance.GetSeed(deviceSerial);
    emit log_string(strainName);
    emit log_uint(plantedEpoch);
  }
}
