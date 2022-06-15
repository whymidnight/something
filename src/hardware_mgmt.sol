// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract hardwareMgmt {
  struct Device {
    string serial;
    address device;
    bool registered;
  }
  mapping(string => Device) public inventory;

  function AddDevice(string memory serial, address device)
    public
    virtual
  {
    inventory[serial] = Device(serial, device, true);
    return;
  }

  function GetDevice(string memory serial)
    public
    view
    returns (address, bool)
  {
    return (
      inventory[serial].device,
      inventory[serial].registered
    );
  }
}
