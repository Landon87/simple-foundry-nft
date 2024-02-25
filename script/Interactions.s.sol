//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "../forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant Fox1 =
        "ipfs.io/ipfs/QmcReySqsUvvL4XBTE1wyiyJzzVwUpxe6QbrFTwNfEP5VQ?filename=transparent_2024-02-24T07-11-52.png";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address basicNftAddress) internal {
        vm.startBroadcast();
        BasicNft(basicNftAddress).mintNft(Fox1);
        vm.stopBroadcast();
    }
}
