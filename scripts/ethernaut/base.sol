pragma solidity ^0.8.0;

import "forge-std/Test.sol";

interface IController {
    function createLevelInstance(address _level) external payable;

    function submitLevelInstance(address payable _instance) external;
}

interface ILevel {
    function validateInstance(address payable _instance, address _player)
        external
        view
        returns (bool);
}

abstract contract Ethernaut is Test {
    address constant me = address(0x0077014b4C74d9b1688847386B24Ed23Fdf14Be8);
    IController constant controller =
        IController(address(0xD991431D8b033ddCb84dAD257f4821E9d5b38C33));

    function createNewInstance(address level)
        internal
        returns (address instance)
    {
        uint256 nonce = getNonce(level);
        instance = addressFrom(level, nonce);
        console.log("Creating instance at", instance);

        controller.createLevelInstance(level);
    }

    function submit(address level, address instance) internal {
        require(
            ILevel(level).validateInstance(payable(instance), me),
            "invalid submission"
        );
        controller.submitLevelInstance(payable(instance));
    }

    function getNonce(address addr) private returns (uint256) {
        string[] memory inputs = new string[](2);
        inputs[0] = "./ffi/cast-nonce";
        inputs[1] = addr2string(addr);

        bytes memory res = vm.ffi(inputs);
        return abi.decode(res, (uint256));
    }

    function addr2string(address account) private pure returns (string memory) {
        return addr2string(abi.encodePacked(account));
    }

    function addr2string(bytes memory data)
        private
        pure
        returns (string memory)
    {
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(2 + data.length * 2);
        str[0] = "0";
        str[1] = "x";
        for (uint256 i = 0; i < data.length; i++) {
            str[2 + i * 2] = alphabet[uint256(uint8(data[i] >> 4))];
            str[3 + i * 2] = alphabet[uint256(uint8(data[i] & 0x0f))];
        }
        return string(str);
    }

    function addressFrom(address _origin, uint256 _nonce)
        public
        pure
        returns (address)
    {
        bytes memory data;
        if (_nonce == 0x00)
            data = abi.encodePacked(
                bytes1(0xd6),
                bytes1(0x94),
                _origin,
                bytes1(0x80)
            );
        else if (_nonce <= 0x7f)
            data = abi.encodePacked(
                bytes1(0xd6),
                bytes1(0x94),
                _origin,
                uint8(_nonce)
            );
        else if (_nonce <= 0xff)
            data = abi.encodePacked(
                bytes1(0xd7),
                bytes1(0x94),
                _origin,
                bytes1(0x81),
                uint8(_nonce)
            );
        else if (_nonce <= 0xffff)
            data = abi.encodePacked(
                bytes1(0xd8),
                bytes1(0x94),
                _origin,
                bytes1(0x82),
                uint16(_nonce)
            );
        else if (_nonce <= 0xffffff)
            data = abi.encodePacked(
                bytes1(0xd9),
                bytes1(0x94),
                _origin,
                bytes1(0x83),
                uint24(_nonce)
            );
        else
            data = abi.encodePacked(
                bytes1(0xda),
                bytes1(0x94),
                _origin,
                bytes1(0x84),
                uint32(_nonce)
            );
        return address(uint160(uint256(keccak256(data))));
    }
}
