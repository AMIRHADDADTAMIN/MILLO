// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title RWANFT
/// @dev This contract represents Real World Asset NFTs for Cars and Properties
contract RWANFT is ERC721URIStorage, Ownable {
    /// @notice Struct to store asset metadata
    struct Asset {
        string assetType; // car or property
        string location; // physical location
        uint256 price; // price in USDC or ETH
        uint256 mileage; // mileage for cars
        string VINorTitleID; // Vehicle Identification Number or property title ID
        uint256 esgScore; // ESG score for sustainability
    }

    /// @dev Maps token ID to asset metadata
    mapping(uint256 => Asset) public assetDetails;

    /// @dev Token ID counter
    uint256 private _nextTokenId;

    /// @notice Event emitted when a new asset is minted
    /// @param tokenId The token ID of the minted asset
    /// @param owner The owner of the newly minted asset
    event AssetMinted(uint256 indexed tokenId, address indexed owner, string assetType);

    constructor() ERC721("Real World Asset NFT", "RWANFT") {}

    /// @notice Mints a new token representing a real-world asset
    /// @param to The address of the token receiver
    /// @param uri The metadata URI for the token
    /// @param asset Data struct representing the asset details
    function mint(address to, string memory uri, Asset memory asset) public onlyOwner {
        uint256 tokenId = ++_nextTokenId;
        _mint(to, tokenId);
        _setTokenURI(tokenId, uri);
        assetDetails[tokenId] = asset;

        emit AssetMinted(tokenId, to, asset.assetType);
    }
}