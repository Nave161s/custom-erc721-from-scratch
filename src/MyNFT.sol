// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract MyNFT {
  
        // STATE Variables // 
    string public name;
    string public symbol;
    uint256 public nextTokenId;
    address public owner;

    // Mappings //
    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public balanceOf;
    mapping(uint256 => string) public tokenURI;
    mapping(uint256 => address) public getApproved;
    mapping(address => mapping(address => bool)) public isApprovedForAll;


    // Modifiers //
    
    // Events //
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    //// 
    // Constructor //

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
        nextTokenId = 1;
    }
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert("Not the owner");
        }
        _;
    }

    function mint(string memory _uri) public onlyOwner {
        ownerOf[nextTokenId] = msg.sender;
        balanceOf[msg.sender]++;
        tokenURI[nextTokenId] = _uri;

        emit Transfer(address(0), msg.sender, nextTokenId);
        nextTokenId++;
    }
    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        
        require(_to != address(0));

        require(ownerOf[_tokenId] == _from, "Not the owner of the token");
        require(msg.sender == _from || msg.sender == getApproved[_tokenId] || isApprovedForAll[_from][msg.sender]);
        delete getApproved[_tokenId];

        ownerOf[_tokenId] = _to;
        balanceOf[_from]--;
        balanceOf[_to]++;
        emit Transfer(_from, _to, _tokenId);    

    }

    function approve(address _to, uint256 _tokenId) public {
        require(msg.sender == ownerOf[_tokenId] || isApprovedForAll[ownerOf[_tokenId]][msg.sender], "Not authorized");
        getApproved[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);

    }

    function setApprovalForAll(address _operator, bool _approved) public {
        require(msg.sender != _operator);
        isApprovedForAll[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public {
        // 1. Execute the normal transfer logic
        transferFrom(_from, _to, _tokenId);

        // 2. Check if the receiver is a smart contract (code.length > 0)
        if (_to.code.length > 0) {
            // 3. Ask the contract: "Do you know how to handle NFTs?"
            // The magic selector is 'IERC721Receiver.onERC721Received.selector'
            require(
                IERC721Receiver(_to).onERC721Received(msg.sender, _from, _tokenId, "") == IERC721Receiver.onERC721Received.selector,
                "Transfer to non-ERC721Receiver"
            );
        }
    }
}


