// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {IZone} from "./interfaces/IZone.sol";
import {Ownable, Ownable2Step} from "@openzeppelin/access/Ownable2Step.sol";

contract Zone is IZone, Ownable2Step {
    mapping(address fulfiller => bool enabled) public validate;
    FeeInfo public fee;

    constructor(address admin) Ownable(admin) {}

    function setFee(FeeInfo calldata newFee) external onlyOwner {
        require(newFee.bps <= 500); // %5 max zone fee.
        fee.bps = newFee.bps;
        fee.recipient = newFee.recipient;
        emit FeeUpdated(newFee);
    }

    function setFulfiller(address fulfiller, bool valid) external onlyOwner {
        validate[fulfiller] = valid;
        emit FulfillerUpdated(fulfiller, valid);
    }
}
