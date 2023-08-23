// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract Relay {

  IUniswapV2Router02 public uniswapRouter;
  
  constructor(address _uniswapRouter) {
    uniswapRouter = IUniswapV2Router02(_uniswapRouter); 
  }

  function trade(address trader, address tokenIn, address tokenOut, uint amountIn) external {

    // Transfer tokens from user
    IERC20(tokenIn).transferFrom(trader, address(this), amountIn);

    // Approve router to spend tokens
    IERC20(tokenIn).approve(address(uniswapRouter), amountIn); 

    // Execute trade on Uniswap
    address[] memory path;
    path[0] = tokenIn;
    path[1] = tokenOut;
    uniswapRouter.swapExactTokensForTokens(
      amountIn, 
      0, // Accept any amount out 
      path, 
      trader, // Send output tokens to user
      block.timestamp
    );

  }

}
