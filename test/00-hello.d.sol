pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IInstance {
    function authenticate(string memory password) external;

    function getCleared() external view returns (bool);
}

contract Ethernaut00 is EthernautTest {
    constructor() EthernautTest(0) {}

    function solve() internal override(EthernautTest) {
        IInstance(instance).authenticate("ethernaut0");
    }
}
