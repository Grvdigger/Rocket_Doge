// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FeeToken is ERC20 {
    address public feeReceiver;
    uint256 public transferFee; // Fee as a percentage (1 = 1%)

    constructor(
        string memory name,
        string memory symbol,
        address _feeReceiver,
        uint256 _transferFee
    ) payable ERC20(name, symbol) {
        feeReceiver = _feeReceiver;
        transferFee = _transferFee;
        _mint(msg.sender, 100000000 * 1e18); // Total supply set in decimal Ie 1 = 1
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        uint256 feeAmount = (amount * transferFee) / 100; // Calculating fee amount (percentage)
        uint256 transferAmount = amount - feeAmount;

        _transfer(_msgSender(), feeReceiver, feeAmount); // Transfer fee to feeReceiver
        _transfer(_msgSender(), recipient, transferAmount); // Transfer remaining amount

        return true;
    }
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
}