// SPDX-License-Identifier: MIT
 
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal  view returns(uint256) {
        //0x694AA1769357215DE4FAC081bf1f309aDC325306 Address to Chainlink ETH/USD Price Feed
        //0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF Address to ZKSyncSepolia ETH/USD Price Feed
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        ( , int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;

    }
}