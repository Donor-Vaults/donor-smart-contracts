pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



contract BUSD is ERC20("BUSD","BUSD") {
  
   

    constructor() {
        _mint(msg.sender,100000000000*1e18);
    }

    function mint( uint256 amount) public {
        _mint(msg.sender,amount);
    }

   
}