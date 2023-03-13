// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DonorToken is ERC20 {
    uint256 constant public MAX_SUPPLY= 100 *1e6*1e18; // 100 million

    constructor(address vestingContract) ERC20("DDD", "DONOR") {
        _mint(vestingContract,MAX_SUPPLY);
    }

}