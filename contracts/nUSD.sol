// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract nUSD is ERC20 {
    

    event Deposit(address indexed from, uint256 ethAmount, uint256 nUsdAmount);
    event Redeem(address indexed from, uint256 nUsdAmount, uint256 ethAmount);

    constructor() ERC20("nUSD", "nUSD") {
    }

    function getETHPrice() external view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer);
    }


    function deposit() external payable {
        uint256 ethAmount = msg.value;
        uint256 nUSDAmount = ethAmount  / 2;

        require(ethAmount > 0, "Invalid amount");

        _mint(msg.sender, nUSDAmount);

        emit Deposit(msg.sender, ethAmount, nUSDAmount);
    }
        
    function redeem(uint256 nUSDAmount) external {
        require(nUSDAmount > 0, "Invalid nUSD amount");
        require(balanceOf(msg.sender) >= nUSDAmount, "Insufficient nUSD balance");

        uint256 ethAmount = nUSDAmount * 2;

        _burn(msg.sender, nUSDAmount);

        emit Redeem(msg.sender, nUSDAmount, ethAmount);
    }
}
