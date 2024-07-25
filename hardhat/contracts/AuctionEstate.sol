// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AuctionEstate is ERC1155, IERC1155Receiver{

    uint256 private estateId;
    uint256 private estateEvaluation;
    uint256 private highestBid;
    address payable private auctionWinner;
    uint256 private timestamp;
    address payable private estateOwner;

    address payable[] private bidders;
    mapping(address => uint256) private BidsPlaced;

    IERC20 public token;

    constructor(uint256 _id, uint256 _evaluation, uint256 _timestamp, address payable owner)
        ERC1155("")
    {
        estateId = _id;
        estateEvaluation = _evaluation;
        timestamp = _timestamp;
        highestBid = 0;
        estateOwner = owner;
        token = IERC20(0xaD9d14CA82d9BF97fFf745fFC7d48172A1c0969E);
    }

    function getAuctionDetails() external view returns (uint256, uint256, uint256, address payable, address payable, uint256) {
        return (estateId, estateEvaluation, highestBid, estateOwner, auctionWinner, timestamp);
    }

    function getAllBidders() external view returns (address payable[] memory) {
        return bidders;
    }

    function getBidDetails(address payable bidder) external view returns (uint256) {
        return BidsPlaced[bidder];
    }

    function placeBid(uint256 bid) external {
        require(bid > estateEvaluation, "Bid placed must be higher than the evaluation of the estate");

        BidsPlaced[msg.sender] = bid;
        bidders.push(payable(msg.sender));

        if (highestBid < bid) {
            highestBid = bid;
            auctionWinner = payable(msg.sender);
        }

        require(token.transferFrom(msg.sender, address(this), bid), "Token transfer failed");
    }

    function declareWinner() public view returns (address payable) {
        return auctionWinner;
    }

    function withdrawMyFunds() external {
        require(auctionWinner != msg.sender, "Winner cannot withdraw funds");
        uint256 bidPlaced = BidsPlaced[msg.sender];
        require(bidPlaced != 0, "You have not placed any bid in this auction");

        payable(msg.sender).transfer(bidPlaced);
        BidsPlaced[msg.sender] = 0;
    }

    function claimPrize() external {
        require(msg.sender == auctionWinner, "Only the auction winner can claim the prize");

        estateOwner.transfer(highestBid);
        _safeTransferFrom(address(this), auctionWinner, estateId, 1, ""); // Assuming quantity is 1
        BidsPlaced[auctionWinner] = 0;
    }

    function onERC1155Received(address, address, uint256, uint256, bytes memory) external virtual override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(address, address, uint256[] memory, uint256[] memory, bytes memory) external virtual override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

}
