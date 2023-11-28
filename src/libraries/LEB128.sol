// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/// @author shung: https://github.com/Shungy/leb128-nooffset/blob/063c70211eea731736cd459a2037a0dce711cc8b/src/LEB128Lib.sol
library LEB128 {
    /// @dev Decodes an Unsigned LEB128 encoded value, starting from calldata `ptr`.
    /// See: https://en.wikipedia.org/wiki/LEB128#Decode_unsigned_integer
    /// Note: Anything overflowing 256 bits is truncated silently without a revert.
    /// Note: Superfluous zero padding can be used to control the length of the encoded data.
    function rawDecodeUint(uint256 ptr) internal pure returns (uint256 result, uint256 newPtr) {
        /// @solidity memory-safe-assembly
        assembly {
            for { let shift := 0 } 1 { shift := add(shift, 7) } {
                let nextByte := byte(0, calldataload(ptr))
                result := or(result, shl(shift, and(nextByte, 0x7f)))
                ptr := add(ptr, 1)
                if iszero(shr(7, nextByte)) { break }
            }
            newPtr := ptr
        }
    }
}
