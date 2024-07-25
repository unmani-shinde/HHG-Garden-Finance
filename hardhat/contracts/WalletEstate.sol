// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract WalletEstate is ERC1155,IERC1155Receiver {

    uint256 private constant WALLET_TOKEN = 0;
    uint256 private estateId;
    uint256 private estateEvaluation;
    address payable private estateOwner;

    mapping (address=>uint256) estateShareHolders;

    address payable [] private investors;

    constructor(uint256 _id,uint256 _evaluation)
        ERC1155("")
    {   estateId = _id;
        estateEvaluation = _evaluation;
        estateOwner = payable(address(msg.sender));
        
    }

     function getInvestmentDetails() external view returns(uint256,uint256,address payable){
        return(estateId,estateEvaluation,estateOwner);
    }

    function getAllInvestors() external view returns(address payable [] memory){
        return investors;
    }

    function getInvestmentDetails(address payable investor) external view returns(uint256){
        return (estateShareHolders[investor]);
    }

    function purchaseShares(uint256 quantity) external payable  {
        require(quantity<=100,"Maximum number of shares that can be purchased is 100");
        require(quantity>0, "Number of shares purchased cannot be zero or less");
        require(quantity<balanceOf(address(this), WALLET_TOKEN),"There aren't sufficient shares to be purchased");

        //uint256 share_evaluation = ((estateEvaluation*10**18)/100)*quantity;
        //require(share_evaluation==msg.value,"Incorrect funds sent!");
        payable(address(this)).transfer(msg.value);

       safeTransferFrom(address(this), address(msg.sender), WALLET_TOKEN, quantity, "");
       estateShareHolders[address(msg.sender)] = quantity;
       investors.push(payable(address(msg.sender)));
    }

    function transferShares(address receiver,uint256 quantity) external {
        require(quantity <= estateShareHolders[address(msg.sender)], "Insufficient shares to be transferred to recepient");
        safeTransferFrom(address(msg.sender), receiver, WALLET_TOKEN, quantity, "");
        estateShareHolders[address(msg.sender)] -= quantity;
        estateShareHolders[receiver] += quantity;
    }

    function sellShares(uint256 quantity) external payable {
        require(quantity <= estateShareHolders[address(msg.sender)], "Insufficient shares to be sold");
        safeTransferFrom(address(msg.sender), address(this), WALLET_TOKEN, quantity, "");

        uint256 share_evaluation = ((estateEvaluation*10**18)/100)*quantity;
        payable(address(msg.sender)).transfer(share_evaluation);
        estateShareHolders[address(msg.sender)] -=quantity; 
    }

    function onERC1155Received(address, address, uint256, uint256, bytes memory) external virtual returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(address, address, uint256[] memory, uint256[] memory, bytes memory) external virtual returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

}