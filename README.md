# Custom ERC721 (NFT) Implementation

An implementation of the ERC721 token standard written from scratch in Solidity, without using OpenZeppelin.

## Overview
This project was built to understand the low-level mechanics of NFTs: token IDs, ownership mappings, and metadata URIs.

## Features
- `mint` function with `onlyOwner` access control.
- Standard `ownerOf`, `balanceOf`, and `transferFrom` functions.
- Metadata tracking via `tokenURI`.
- Fully tested using Foundry.

## Tests
The test suite covers:
- Minting new tokens and tracking IDs.
- Transferring tokens between addresses.
- Access control (preventing unauthorized minting).

Run tests:
```bash
forge test# custom-erc721-from-scratch
