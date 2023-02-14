// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.17;

library Tick {
    struct Info {
        bool initialized;
        // total liquidity at tickQq
        uint128 liquidity;
    }
    // I don't really understand the second part of this function
    function update(
        mapping(int24 => Tick.Info) storage self,
        int24 tick,
        uint128 liquidityDelta
    ) internal returns (bool flipped) {
        Tick.Info storage tickInfo = self[tick];
        uint128 liquidityBefore = tickInfo.liquidity;
        uint128 liquidityAfter = liquidityBefore + liquidityDelta;

        flipped = (liquidityAfter == 0) != (liquidityBefore == 0);

        if (liquidityBefore == 0) {
            tickInfo.initialized = true;
        }

        tickInfo.liquidity = liquidityAfter;
    }
}
