pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IInstance {
    function authenticate(string memory password) external;

    function getCleared() external view returns (bool);
}

contract Ethernaut00 is EthernautTest {
    function setUp() public {
        initialize(address(0x4E73b858fD5D7A5fc1c3455061dE52a53F35d966));
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
        IInstance(instance).authenticate("ethernaut0");
    }
}
