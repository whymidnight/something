// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract hardwareMgmt {
    mapping(address => string) public inventory;

    function AddDevice(address device, string memory serial) public {
        inventory[device]  = serial;
        return;
    }
}
