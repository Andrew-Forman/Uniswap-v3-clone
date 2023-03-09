pragma solidity ^0.8.17;

import "../src/UniswapV3Pool.sol";
import "../src/interfaces/IERC20.sol";

contract UniswapV3Manager {
    function mint(
        address poolAddress_,
        int24 lowerTick,
        int24 upperTick,
        uint128 liquidity,
        bytes calldata data
    ) public {
        UniswapV3Pool(poolAddres_).mint(
            msg.sender,
            lowerTick,
            upperTick,
            liquidity,
            data
        );
    }

    struct SwapSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 tickSpacing;
        uint256 amountIn;
        uint160 sqrtPriceLimitX96;
    }

    struct SwapParams {
        bytes path;
        address recipient;
        uint256 amountIn;
        uint256 minAmountOut;
    }

    struct SwapCallbackData {
        bytes path;
        address payer;
    }

    function _swap(
        uint amountIn,
        address recipient,
        uint160 sqrtPriceLimitX96,
        SwapCallbackData memory data
    ) internal returns (uint256 amountOut) {

    }

    function swap(
        address poolAddress_,
        bool zeroForOne,
        uint256 amountSpecified,
        uint160 sqrtPriceLimitX96,
        bytes calldata data
        ) public returns (int256, int256) {
        UniswapV3Pool(poolAddress_).swap(msg.sender, data);
    }

    function uniswapV3MintCallback() {}
    function uniswapV3SwapCallback() {}
}