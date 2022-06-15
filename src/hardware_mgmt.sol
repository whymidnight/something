// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract hardwareMgmt {
  event logDeviceSerial(string serial);
  event logDeviceAddress(address device);
  struct Device {
    string serial;
    address device;
    bool registered;
  }
  mapping(string => Device) public inventory;

  modifier unusedSerial(string memory serial) {
    require(!inventory[serial].registered);
    _;
  }

  function RegisteredDevice(string memory serial)
    public
    returns (bool)
  {
    emit logDeviceSerial(serial);
    emit logDeviceAddress(inventory[serial].device);
    return inventory[serial].registered;
  }

  function AddDevice(string memory serial, address device)
    public
    unusedSerial(serial)
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
