// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract FundMe{
    //"payable" keyword allows a function to accept $
    // Contract and Wallet Addresses can both hold $
    function fund() public payable{
        //"msg" is a global variable that holds the transaction details
        //"msg.value" is the amount of $ sent to the contract
        //require is to use to force a minimum amount to be sent
        // if less than the required amount is sent then the function reverts to it's original state
        // "revert message" lets the user know that the requiements weren't met
        require(msg.value > 1e18, "You need to spend more ETH!"); //1e18 == 1ETH == 1 * 10 ** 18
    }

    function withdraw() public {}
}