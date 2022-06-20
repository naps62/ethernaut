pragma solidity ^0.8.0;

interface ILevel {
    function validateInstance(address payable _instance, address _player)
        external
        returns (bool);
}
