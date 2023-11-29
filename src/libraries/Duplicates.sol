// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IFloodPlain} from "../interfaces/IFloodPlain.sol";

library Duplicates {
    function hasDuplicates(IFloodPlain.Item[] calldata items) internal pure returns (bool) {
        uint256 length = items.length;
        if (length > 1) {
            for (uint256 i = 0; i < length - 1; ++i) {
                for (uint256 j = i; j < length; ++j) {
                    if (items[i].token == items[j].token) return true;
                }
            }
        }
        return false;
    }
}
