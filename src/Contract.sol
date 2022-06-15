// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "seedtosale/cultivation.sol";
import "seedtosale/hardware_mgmt.sol";

contract Contract is hardwareMgmt, seedAccounting {
  hardwareMgmt hwMgmt = new hardwareMgmt();
  seedAccounting seedAccting = new seedAccounting();

  modifier RegisteredDevice(string memory serial) {
    (
      string memory deviceSerial,
      address device,
      bool registered
    ) = hwMgmt.inventory(serial);
    require(registered, "not registered");
    _;
  }

  modifier UnusedSerial(string memory serial) {
    (
      string memory deviceSerial,
      address device,
      bool registered
    ) = hwMgmt.inventory(serial);
    require(!registered, "already registered");
    _;
  }

  function AddDevice(string memory serial, address device)
    public
    override
    UnusedSerial(serial)
  {
    hwMgmt.AddDevice(serial, device);
    return;
  }

  function RegisterSeed(
    string memory deviceSerial,
    string memory strainName,
    uint64 plantedEpoch
  ) public override RegisteredDevice(deviceSerial) {
    seedAccting.RegisterSeed(
      deviceSerial,
      strainName,
      plantedEpoch
    );
    return;
  }
}

