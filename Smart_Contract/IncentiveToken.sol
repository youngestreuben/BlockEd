// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IncentiveToken is ERC20, Ownable {
    constructor() ERC20("BlockEdToken", "BED") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function reward(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }
}
