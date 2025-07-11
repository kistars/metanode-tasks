// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    event MintNFT(address receiver, string tokenURI, uint256 tokenId);

    constructor() ERC721("SpaceshipNFT", "ssp") {}

    function mintNFT(address receiver, string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 currentId = _tokenIds.current();

        _mint(receiver, currentId);
        _setTokenURI(currentId, tokenURI);

        emit MintNFT(receiver, tokenURI, currentId);
        return currentId;
    }
}
