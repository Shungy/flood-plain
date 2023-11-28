// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IZone {
    struct FeeInfo {
        address recipient;
        uint96 bps;
    }

    /**
     * @notice Event emitted when fee BPS or fee recipient is changed.
     */
    event FeeUpdated(FeeInfo indexed newFee);

    /**
     * @notice Event emitted when a Fulfiller is added or removed from the Zone.
     */
    event FulfillerUpdated(address indexed fulfiller, bool indexed valid);

    /**
     * @notice Restricted function to set the fee BPS that should be taken from consideration.
     *
     * @param fee The feeBps and the fee recipient. The fulfiller should send
     * `considerationAmount * fee.bps / 10000` to the `fee.recipient` on each fulfillment.
     */
    function setFee(FeeInfo calldata fee) external;

    /**
     * @notice Restricted function to add or remove a fulfiller from the zone.
     *
     * @param enabled True if fulfiller is added to the zone, false if fulfiller is removed.
     */
    function setFulfiller(address fulfiller, bool enabled) external;

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
    function fee() external view returns (address, uint96);
}
