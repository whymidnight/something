// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./hardware_mgmt.sol";

contract seedAccounting is hardwareMgmt {
  struct Strain {
    string name;
  }
  struct Seed {
    Strain strain;
    uint64 plantedEpoch;
  }

  // seedInventory(device) => Seed
  mapping(string => Seed) public seedInventory;

  function RegisterSeed(
    string memory serial,
    string memory strainName,
    uint64 plantedEpoch
  ) public {
    seedInventory[serial] = Seed(
      Strain(strainName),
      plantedEpoch
    );
    return;
  }

  function GetSeed(string memory deviceSerial)
    public
    view
    returns (
      // @returns (Strain.name, Seed.plantedEpoch)
      string memory,
      uint64
    )
  {
    Seed memory seed = seedInventory[deviceSerial];

    return (seed.strain.name, seed.plantedEpoch);
  }
}
