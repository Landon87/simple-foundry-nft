//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 public s_tokenCounter;
    mapping(uint256 => string) public s_tokenIdURIs;

    constructor() ERC721("Meta Mask Wallet Fox", "Fox1") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public {
        s_tokenIdURIs[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdURIs[tokenId];
    }

    //////
    function getRandomNumber(uint256 seed) internal view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.timestamp, block.basefee, seed)
                )
            );
    }

    function mintNftWithRandomness(string memory tokenUri) public {
        uint256 newTokenId = getRandomNumber(s_tokenCounter);
        s_tokenIdURIs[newTokenId] = tokenUri;
        _safeMint(msg.sender, newTokenId);
        s_tokenCounter++;
    }
}
