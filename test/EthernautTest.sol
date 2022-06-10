pragma solidity ^0.8.0;

import "test/TestPlus.sol";

import {IController} from "src/IController.sol";
import {ILevel} from "src/ILevel.sol";

abstract contract EthernautTest is TestPlus {
    address[2] factories = [
        address(0x0),
        address(0x9CB391dbcD447E645D6Cb55dE6ca23164130D008)
    ];

    address constant me = address(0x0077014b4C74d9b1688847386B24Ed23Fdf14Be8);
    IController constant controller =
        IController(address(0xD991431D8b033ddCb84dAD257f4821E9d5b38C33));

    address factory;
    address payable instance;
    bool testMode;

    function initialize(address _factory) internal {
        factory = _factory;
        uint256 nonce = getAddressNonce(factory);
        instance = payable(getCreateAddress(factory, nonce));
    }

    function deploy() internal {
        broadcastOrPrank();
        controller.createLevelInstance(factory);
    }

    function submit(address sender) internal {
        require(
            ILevel(factory).validateInstance(instance, sender),
            "invalid submission"
        );
        broadcastOrPrank();
        controller.submitLevelInstance(instance);
    }

    function broadcastOrPrank() internal {
        testMode ? vm.prank(me) : vm.broadcast();
    }
}
