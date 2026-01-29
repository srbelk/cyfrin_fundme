// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    uint256 public minimunUsd = 5;
    //"payable" keyword allows a function to accept $
    // Contract and Wallet Addresses can both hold $
    function fund() public payable{
        //"msg" is a global variable that holds the transaction details
        //"msg.value" is the amount of $ sent to the contract
        //require is to use to force a minimum amount to be sent
        // if less than the required amount is sent then the function reverts to it's original state
        // "revert message" lets the user know that the requiements weren't met
        require(msg.value >= minimunUsd, "You need to spend more ETH!"); //1e18 == 1ETH == 1 * 10 ** 18
    }

    function withdraw() public {}

    function getPrice() public view returns(uint256) {
        //0x694AA1769357215DE4FAC081bf1f309aDC325306 Address to Chainlink ETH/USD Price Feed
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        ( , int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate() public {

    }
}