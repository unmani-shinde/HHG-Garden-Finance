// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Create2.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "./AuctionEstate.sol";
import "./WalletEstate.sol";

contract EstateFactory is ERC1155,IERC1155Receiver{

    uint256 private _nextTokenId=1;

    constructor()
        ERC1155("")        
    {}

    struct Estate{
        uint256 estateID;
        address payable estateOwner;
        uint256 estateEvaluation;
        string estateMetadata;
        bool isListedForAuction;
        bool isListedForInvestment;
    }

    mapping (uint256 => Estate) private Estates;
    mapping (uint256 => address) private EstateInvestmentListings; //estate id -> estate wallet contract address
    mapping (uint256 => address) private EstateAuctionListings; //estate id -> estate auction contract address

    function tokenizeEstate(string memory _metadata,uint256 _evaluation) external  {
        require(_evaluation>0, "Evaluation of the Estate must be more than zero!");
        address payable addr = payable(address(msg.sender));
        //Mint Estate Token to Owner
                 
         uint256 tokenId = _nextTokenId;
        _nextTokenId++;
        mint(addr,tokenId,1,"");
        setURI(_metadata);

        //Create Estate Listing
        Estates[tokenId] = Estate({
            estateID:tokenId,
            estateOwner: payable(address(msg.sender)),
            estateMetadata:_metadata,
            estateEvaluation: _evaluation,
            isListedForAuction:false,
            isListedForInvestment:false
        });
        
    }

    function listEstateForAuction(uint256 estateId) external {
        bytes32 _salt = keccak256(abi.encodePacked(block.timestamp, msg.sender));
        address latestAuctionAddress = Create2.deploy(0,_salt, abi.encodePacked(type(AuctionEstate).creationCode, abi.encode(estateId,Estates[estateId].estateEvaluation,block.timestamp,Estates[estateId].estateOwner))
        );
        safeTransferFrom(msg.sender,latestAuctionAddress, estateId, 1, "");
        EstateAuctionListings[estateId] = latestAuctionAddress;
        Estates[estateId].isListedForAuction = true;
    }

     function listEstateForInvestment(uint256 estateId) external  {
      
        IERC1155Receiver newContract = new WalletEstate(estateId,Estates[estateId].estateEvaluation);
        safeTransferFrom(msg.sender,address(newContract), estateId, 1, "");
        _mint(address(msg.sender), 0, 100, "");
         safeTransferFrom(msg.sender,address(newContract), 0, 100, "");

        EstateInvestmentListings[estateId] = address(newContract);
        Estates[estateId].isListedForInvestment = true;
        
    }

    function getEstateListing(uint256 estateId) external view returns (Estate memory) {
        return Estates[estateId];
    }

    function getEstateInvestmentListing(uint256 estateId) external view returns (address) {
        return EstateInvestmentListings[estateId];
    }

    function updateOwner(uint256 estateID,address payable newOwner) external {
        Estates[estateID].estateOwner = newOwner;
        Estates[estateID].isListedForAuction = false;
        Estates[estateID].isListedForInvestment = false;
    }

    function getEstateAuctionListing(uint256 estateId) external view returns (address) {
        return EstateAuctionListings[estateId];
    }

    function getNumEstates() external view returns (uint256) {
        return _nextTokenId;
    }

    function setURI(string memory newuri) private {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount,bytes memory data) private
    {
        _mint(account, id, amount,data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        private
        
    {
        _mintBatch(to, ids, amounts, data);
    }

     function onERC1155Received(address, address, uint256, uint256, bytes memory) public virtual override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(address, address, uint256[] memory, uint256[] memory, bytes memory) public virtual override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, IERC165) returns (bool) {
        return interfaceId == type(IERC1155Receiver).interfaceId || super.supportsInterface(interfaceId);
    }





}