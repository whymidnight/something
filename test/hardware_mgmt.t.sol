// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "seedtosale/hardware_mgmt.sol";

contract hardware_mgmtTest is Test {
    hardwareMgmt hwMgmt;

    function setUp() public {
        hwMgmt = new hardwareMgmt();
    }

    function testAddDevice() public {
        address device = 0xD343877a067533b14840416d40738A3D48bAC952;
        hwMgmt.AddDevice(device, "some");

        string memory deviceInventory = hwMgmt.inventory(device);
        emit log_string(deviceInventory);

    }
}
