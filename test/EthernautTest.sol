pragma solidity ^0.8.0;

import "test/TestPlus.sol";

import {IController} from "src/IController.sol";
import {ILevel} from "src/ILevel.sol";

abstract contract EthernautTest is TestPlus {
    address[27] factories = [
        address(0x4E73b858fD5D7A5fc1c3455061dE52a53F35d966), // 00. Hello Ethernaut
        address(0x9CB391dbcD447E645D6Cb55dE6ca23164130D008), // 01. Fallback
        address(0x5732B2F88cbd19B6f01E3a96e9f0D90B917281E5), // 02. Fallout
        address(0x4dF32584890A0026e56f7535d0f2C6486753624f), // 03. Coin Flip
        address(0x0b6F6CE4BCfB70525A31454292017F640C10c768), // 04. Telephone
        address(0x63bE8347A617476CA461649897238A31835a32CE), // 05. Token
        address(0x9451961b7Aea1Df57bc20CC68D72f662241b5493), // 06. Delegation
        address(0x22699e6AdD7159C3C385bf4d7e1C647ddB3a99ea), // 07. Forcej
        address(0xf94b476063B6379A3c8b6C836efB8B3e10eDe188), // 08. Vault
        address(0x43BA674B4fbb8B157b7441C2187bCdD2cdF84FD5), // 09. King
        address(0xe6BA07257a9321e755184FB2F995e0600E78c16D), // 10. Re-entrancy
        address(0xaB4F3F2644060b2D960b0d88F0a42d1D27484687), // 11. Elevator
        address(0x11343d543778213221516D004ED82C45C3c8788B), // 12. Privacy
        address(0x9b261b23cE149422DE75907C6ac0C30cEc4e652A), // 13. Gatekeeper One
        address(0xdCeA38B2ce1768E1F409B6C65344E81F16bEc38d), // 14. Gatekeeper Two
        address(0x096bb5e93a204BfD701502EB6EF266a950217218), // 15. Naught Coin
        address(0x97E982a15FbB1C28F6B8ee971BEc15C78b3d263F), // 16. Preservation
        address(0x0EB8e4771ABA41B70d0cb6770e04086E5aee5aB2), // 17. Recovery
        address(0x200d3d9Ac7bFd556057224e7aEB4161fED5608D0), // 18. MagicNumber
        address(0xda5b3Fb76C78b6EdEE6BE8F11a1c31EcfB02b272), // 19. Alien Codex
        address(0xf1D573178225513eDAA795bE9206f7E311EeDEc3), // 20. Denial
        address(0x3aCd4766f1769940cA010a907b3C8dEbCe0bd4aB), // 21. Shop
        address(0xC084FC117324D7C628dBC41F17CAcAaF4765f49e), // 22. Dex
        address(0x5026Ff8C97303951c255D3a7FDCd5a1d0EF4a81a), // 23. Dex Two
        address(0xe13a4a46C346154C41360AAe7f070943F67743c9), // 24. Puzzle Wallet
        address(0x58Ab506795EC0D3bFAE4448122afa4cDE51cfdd2), // 25. Motorbike
        address(0x128BA32Ec698610f2fF8f010A7b74f9985a6D17c) // 26. DoubleEntryPoint
    ];

    IController constant controller =
        IController(address(0xD991431D8b033ddCb84dAD257f4821E9d5b38C33));

    mapping(uint256 => uint256) payables;

    uint256 idx;
    address payable instance;
    address immutable factory;

    constructor(uint256 _idx) {
        idx = _idx;
        factory = factories[_idx];
        uint256 nonce = _getAddressNonce(factory);
        instance = payable(_getCreateAddress(factory, nonce));

        payables[9] = 0.01 ether;
        payables[10] = 0.01 ether;
        payables[17] = 0.001 ether;
        payables[20] = 0.001 ether;
    }

    function solve() internal virtual;

    function test() public {
        controller.createLevelInstance{value: payables[idx]}(factory);

        solve();

        require(
            ILevel(factory).validateInstance{gas: 100000000}(
                instance,
                address(this)
            ),
            "not solved"
        );

        controller.submitLevelInstance{gas: 100000000}(instance);
    }
}
