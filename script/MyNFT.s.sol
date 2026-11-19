// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract DeployMyNFT is Script {
    function run() external {
        vm.startBroadcast();
        new MyNFT("Naweed NFT", "NWD");
        vm.stopBroadcast();
    }
}