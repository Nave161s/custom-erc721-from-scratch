# Custom ERC721 (NFT) Implementation

An implementation of the ERC721 token standard written from scratch in Solidity, without using OpenZeppelin. 

## Overview
This project was built to understand the low-level mechanics of NFTs: token IDs, ownership mappings, approvals, and secure metadata URIs. 

## Features
- `mint` function with `onlyOwner` access control.
- Standard `ownerOf`, `balanceOf`, and `transferFrom` functions.
- **Approvals:** Full implementation of `approve`, `getApproved`, `setApprovalForAll`, and `isApprovedForAll`.
- **Safe Transfers:** Implementation of `safeTransferFrom` using `IERC721Receiver` to prevent NFTs from being stuck in contracts that cannot handle them.
- **Security:** Protection against transferring to the zero address and proper state-clearing of approvals after transfers.

## Tests
Includes a comprehensive Foundry test suite. The test suite covers:
- Minting new tokens and tracking IDs.
- Transferring tokens between addresses.
- Access control (reverting unauthorized minting).
- Safe transfer logic (reverting when sent to a bad receiver contract).

Run tests:
```bash
forge test



```


## This contract was analyzed using slither-analyzer to identify potential vulnerabilities prior to final deployment.

