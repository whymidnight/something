// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "seedtosale/cultivation.sol";
import "seedtosale/hardware_mgmt.sol";

contract Contract is
  hardwareMgmt,
  seedAccounting,
  cultivationAccounting
{
  hardwareMgmt hwMgmt = new hardwareMgmt();
  seedAccounting seedAccting = new seedAccounting();
  cultivationAccounting cultivationAccting =
    new cultivationAccounting();

  modifier HasSeed(string memory serial) {
    (, bool hasSeed) = seedAccting.GetSeed(serial);
    require(hasSeed, "no seed");
    _;
  }

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
    string memory strainName
  ) public override RegisteredDevice(deviceSerial) {
    seedAccting.RegisterSeed(deviceSerial, strainName);
    return;
  }

  function StartGrowth(
    string memory deviceSerial,
    uint64 plantedEpoch
  )
    public
    override
    RegisteredDevice(deviceSerial)
    HasSeed(deviceSerial)
  {
    cultivationAccting.StartGrowth(
      deviceSerial,
      plantedEpoch
    );
    return;
  }
}
