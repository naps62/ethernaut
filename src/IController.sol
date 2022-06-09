pragma solidity ^0.8.0;

interface IController {
    function createLevelInstance(address _level) external payable;

    function submitLevelInstance(address payable _instance) external;
}
