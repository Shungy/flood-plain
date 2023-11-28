// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IFloodPlain} from "../interfaces/IFloodPlain.sol";

bytes28 constant SELECTOR_EXTENSION = bytes28(keccak256("IFulfiller.sourceConsiderations"));

library Hooks {
    function execute(IFloodPlain.Hook calldata hook) internal {
        address target = hook.target;
        bytes calldata data = hook.data;

        require(abi.decode(data, (bytes32)) << 32 != SELECTOR_EXTENSION);

        assembly ("memory-safe") {
            let fmp := mload(0x40)
            calldatacopy(fmp, data.offset, data.length)
            if iszero(call(gas(), target, 0, fmp, data.length, 0, 0)) {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
        }
    }

    function execute(IFloodPlain.Hook[] calldata hooks) internal {
        for (uint256 i; i < hooks.length; ++i) execute(hooks[i]);
    }
}
