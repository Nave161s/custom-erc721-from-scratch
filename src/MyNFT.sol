// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


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

    // Modifiers //
    
    // Events //
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
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

        require(ownerOf[_tokenId] == _from, "Not the owner of the token");
        require(msg.sender == _from, "Not the owner of the token");
        ownerOf[_tokenId] = _to;
        balanceOf[_from]--;
        balanceOf[_to]++;
        emit Transfer(address(0), msg.sender, nextTokenId);    

    }
}


