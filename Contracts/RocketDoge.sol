// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract RocketDoge is ERC20, ERC20Burnable {
    address public owner;
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor(
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) {
        owner = msg.sender;
        _mint(msg.sender, 1000000000 * 1e18); // Total supply set in decimal, 1 = 1
    }
    
    function burnForOwner(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }
}
