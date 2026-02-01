// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe{
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;
    //"payable" keyword allows a function to accept $
    // Contract and Wallet Addresses can both hold $

    address[] public funders;

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    
    address public immutable i_owner;
     //a constructor is a special function that runs when the contract is initially deployed
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable{
        //"msg" is a global variable that holds the transaction details
        //"msg.value" is the amount of $ sent to the contract
        //require is to use to force a minimum amount to be sent
        // if less than the required amount is sent then the function reverts to it's original state
        // "revert message" lets the user know that the requiements weren't met
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!"); //1e18 == 1ETH == 1 * 10 ** 18
        
        funders.push(msg.sender);

        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() onlyOwner public {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;    
        }
        //reset array
        funders = new address[](0);

        //Three ways to foward ETH: transfer, send, call(recommended)

        //transfer
        //payable(msg.sender).transfer(address(this).balance);
        
        //send
        //bool sendSuccess = (msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send Failed!");
        
        //call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed!");
    }

    // modifier adds additional logic to functions
    //_; executes the function that the modifier is attached to
    modifier onlyOwner() {
        //require(msg.sender == i_owner, "Only Owner can call this function!");
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }
}   