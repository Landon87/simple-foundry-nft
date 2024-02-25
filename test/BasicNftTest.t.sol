//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("USER");
    string public constant FOX1 =
        "http://ipfs.io/ipfs/QmcReySqsUvvL4XBTE1wyiyJzzVwUpxe6QbrFTwNfEP5VQ?filename=transparent_2024-02-24T07-11-52.png";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Meta Mask Wallet Fox";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testSymbolIsCorrect() public {
        assertEq(basicNft.symbol(), "Fox1");
    }

    function testMintNft() public {
        vm.prank(msg.sender);
        basicNft.mintNft("test");
        // Add assertions here to verify the minting process
        // For example, check the total supply, check the URI, etc.
    }

    function testMintNftWithRandomness() public {
        vm.prank(msg.sender);
        basicNft.mintNftWithRandomness("testRandom");
        // Add assertions here to verify the minting process with randomness
        // For example, check the total supply, check the URI, etc.
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(FOX1);
        assertEq(basicNft.balanceOf(USER), 1);
        assertEq(
            keccak256(abi.encodePacked(FOX1)),
            keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
