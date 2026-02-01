// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SafeMathTester {
    //uint8 max number is 255
    uint8 public bigNumb = 255;

    function add() public {
        bigNumb += 1;
    }

}

