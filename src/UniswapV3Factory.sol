// SPDX-License-Identifier:
pragma solidity ^0.8.17;

contract UniswapV3Factory is IUniswapV3PoolDeployer {
    PoolParameters public parameters;
    mapping(address => mapping(address => mapping(uint24 => address)))
        public pools;

    mapping(uint24 => uint24) public fees;

    constructor() {
        fees[500] = 10;
        fees[3000] = 60;
    }

    function createPool(
        address tokenX,
        address tokenY,
        uint24 fee
    ) public returns (address pool) {
        if (tokenX == tokenY) revert TokenMustBeDiffernt();
        if (!tickSpacings[tickSpacing]) revert UnsupportedTickSpacing();
        
        (tokenX, tokenY) = tokenX < tokenY
            ? (tokenX, tokenY)
            : (tokenY, tokenX);

        if (tokenX == address(0)) revert TokenXCannotBeZero;
        if (pools[tokenX][tokenY][tickSpacing] != address(0))
            revert PoolAlreadyExists();

    parameters = PoolParameters({
        factory: address(this),
        token0: tokenX,
        token1: tokenY,
        tickSpacing: fees[fee],
        fee: fee
    });

    pool = address(
        new UniswapV3Pool{
            salt: keccak256(abi.encodePacked(tokenX, tokenY, tickSpacing))
        } ();
    )

    delete parameters;

    pools[tokenX][tokenY][tickSpacing] = pool;
    pools[tokenY][tokenX][tickSpacing] = pool;

    emit PoolCreated(tokenX, tokenY, tickSpacing, pool);
    
    }
}