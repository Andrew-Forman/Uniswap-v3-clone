// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.17;

contract UniswapV3Quoter {
    using Path for bytes;

    struct QuoteSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        uint256 amountIn;
        uint160 sqrtPriceLimitX96;
    }
    address public immutable factory;
    
    struct QuoteParams {
        address pool;
        uint256 amountIn;
        bool zeroForOne;
    }

    function quote(QuoteParams memory params)
        public
        returns (
            uint256 amountOut,
            uint160 sqrtPriceX96After,
            int24 tickAfter
        
}