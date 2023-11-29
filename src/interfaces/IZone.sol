// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IFloodPlain} from "./IFloodPlain.sol";

interface IZone {
    struct FeeInfo {
        address recipient;
        uint64 bps;
    }

    /**
     * @notice Check if a fulfiller belongs to the zone.
     *
     * @dev Fulfiller must still ensure that
     *      - msg.sender is a the BOOK.
     *      - order.zone is the ZONE.
     *      - Book caller is authorized.
     *
     * @param fulfiller The address that will fulfill the order by supplying consideration items.
     *
     * @return True if fulfiller is enabled, false if fulfiller is not enabled.
     */
    function validate(address fulfiller) external view returns (bool);

    /**
     * @notice Get the fee information.
     *
     * @dev It is up to Fulfiller to respect the fees set in a zone.
     *
     * @return The address of the fee recipient who should receive the fees.
     * @return The fee cut in BPS that should be taken from the output tokens.
     */
    function fee() external view returns (address, uint64);
}
