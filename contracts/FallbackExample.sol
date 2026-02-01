// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FallbackExample {
    uint256 public result;

    // recieve is a special function that executes when a contract gets any transaction wihout data
    receive() external payable { 
        result = 1;
    } 
    // fallback is a special function that executes when a contract gets any transaction with data
    fallback() external payable {
        result = 2;
     }

}
