pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IMagicNum {
    function setSolver(address _solver) external;
}

contract Ethernaut18 is EthernautTest {
    constructor() EthernautTest(18) {}

    function solve() internal override(EthernautTest) {
        bytes memory init = hex"600a600c600039600a6000f3";
        bytes memory runtime = hex"602a60805260206080f3";
        bytes memory bytecode = abi.encodePacked(init, runtime);

        address solver;
        bool success;
        assembly {
            solver := create(0, add(bytecode, 0x20), mload(bytecode))
            success := gt(extcodesize(solver), 0)
        }

        require(success);

        IMagicNum(instance).setSolver(solver);
    }
}
