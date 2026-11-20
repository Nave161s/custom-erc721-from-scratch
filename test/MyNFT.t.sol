// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract MyNFTTest is Test {
    MyNFT nft;
    address alice = address(0xA11CE);
    address bob = address(0xB0B);

    function setUp() public {
        nft = new MyNFT("Naweed NFT", "NWD");
    }

    function test_Mint() public {
        nft.mint("ipfs://QmFakeLink1");
        
        assertEq(nft.ownerOf(1), address(this));
        assertEq(nft.balanceOf(address(this)), 1);
        assertEq(nft.tokenURI(1), "ipfs://QmFakeLink1");
        assertEq(nft.nextTokenId(), 2);
    }

    function test_Transfer() public {
        nft.mint("ipfs://QmFakeLink1");
        nft.transferFrom(address(this), alice, 1);
        
        assertEq(nft.ownerOf(1), alice);
        assertEq(nft.balanceOf(alice), 1);
        assertEq(nft.balanceOf(address(this)), 0);
    }

    function test_RevertWhen_NonOwnerMints() public {
        vm.prank(bob);
        vm.expectRevert("Not the owner");
        nft.mint("ipfs://QmHackerLink");
    }

    // A dummy contract that does NOT implement onERC721Received

        function test_RevertWhen_SafeTransferToBadContract() public {
        nft.mint("ipfs://test");
        BadReceiver badReceiver = new BadReceiver();

        vm.expectRevert();
        nft.safeTransferFrom(address(this), address(badReceiver), 1);
    }
}

contract BadReceiver {

}