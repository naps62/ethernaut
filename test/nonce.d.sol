pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract Nonce is Test {
    // run this test from rinkeby block 10822899
    function test_EOA_deploys_contract() public {
        address from = address(0x1057dc7277a319927D3eB43e05680B75a00eb5f4);
        uint256 nonce = 10901;
        address expected = address(0xd194e32904B8643E238B381181A9995D084F5786);
        address actual = addressFrom(from, nonce);
        require(actual == expected);
    }

    // run this test from rinkeby block 10822969
    function test_contract_deploys_contract() public {
        address from = address(0x096bb5e93a204BfD701502EB6EF266a950217218);
        address expected = address(0xB9cCB813005Af9A53AAD7F63B33AC5F5DD05937f);
        uint256 nonce = 2018;
        for (uint256 i = 0; i < 2050; ++i) {
            address actual = addressFrom(from, i);
            if (actual == expected) {
                console.log("found", i);
            }
        }
        // console.log(expected);
        // console.log(actual);
        require(1 == 2);
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
