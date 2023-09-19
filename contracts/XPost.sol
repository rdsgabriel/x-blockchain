// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "hardhat/console.sol";

contract XPost {
    uint256 totalPosts;

    constructor() {
        console.log("Eu serei o contrato inteligente para fazer um post no Twitter descentralizado.");
    }

    function createPost() public {
        totalPosts += 1;
        console.log("%s criou o post!", msg.sender);
    }

    function getTotalPosts() public view returns (uint256) {
        console.log("Eu tenho %d posts!", totalPosts);
        return totalPosts;
    }
}
