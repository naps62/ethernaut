pragma solidity ^0.8.0;

import "test/TestPlus.sol";

import {IController} from "src/IController.sol";
import {ILevel} from "src/ILevel.sol";

abstract contract EthernautTest is TestPlus {
    address[4] factories = [
        address(0x4E73b858fD5D7A5fc1c3455061dE52a53F35d966), // 00. Hello Ethernaut
        address(0x9CB391dbcD447E645D6Cb55dE6ca23164130D008), // 01. Fallback
        address(0x5732B2F88cbd19B6f01E3a96e9f0D90B917281E5), // 02. Fallout
        address(0x4dF32584890A0026e56f7535d0f2C6486753624f) // 03. Coin Flip
    ];

    IController constant controller =
        IController(address(0xD991431D8b033ddCb84dAD257f4821E9d5b38C33));

    address payable instance;
    address immutable factory;

    constructor(uint256 idx) {
        factory = factories[idx];
        uint256 nonce = getAddressNonce(factory);
        instance = payable(getCreateAddress(factory, nonce));
    }

    function solve() internal virtual;

    function test() public {
        controller.createLevelInstance(factory);
        solve();
        controller.submitLevelInstance(instance);
    }
}
