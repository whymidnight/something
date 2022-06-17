// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "seedtosale/hardware_mgmt.sol";

contract hardwareMgmtTest is Test {
  hardwareMgmt hwMgmt;
  address device =
    0xD343877a067533b14840416d40738A3D48bAC952;
  string serial = "some";

  function setUp() public {
    hwMgmt = new hardwareMgmt();
  }

  function testAddDevice() public {
    hwMgmt.AddDevice(serial, device);
  }

  function testGetDevice() public {
    (address deviceAddress, ) = hwMgmt.GetDevice(serial);
    emit log_address(deviceAddress);
  }
}
