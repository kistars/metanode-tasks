// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    event MintNFT(address receiver, string tokenURI, uint256 tokenId);

    mapping(uint256 tokenId => string tokenURI) public _tokenURIs;

    constructor() ERC721("SpaceshipNFT", "ssp") {}

    function mintNFT(address receiver, string memory uri) public returns (uint256) {
        _tokenIds.increment();
        uint256 currentId = _tokenIds.current();

        _mint(receiver, currentId);
        _tokenURIs[currentId] = uri;

        emit MintNFT(receiver, uri, currentId);
        return currentId;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory uri = _tokenURIs[tokenId];
        require(bytes(uri).length != 0, "uri cannot be null");
        return uri;
    }
}
