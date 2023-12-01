// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {IZone, IFloodPlain} from "./interfaces/IZone.sol";
import {Ownable, Ownable2Step} from "@openzeppelin/access/Ownable2Step.sol";

contract Zone is IZone, Ownable2Step {
    mapping(address fulfiller => bool enabled) public validate;
    FeeInfo private _fee;

    event FeeUpdated(FeeInfo indexed newFee);
    event FulfillerUpdated(address indexed fulfiller, bool indexed valid);

    constructor(address admin) Ownable(admin) {}

    function fee(IFloodPlain.Order calldata, address) external view returns (FeeInfo memory) {
        return _fee;
    }

    function setFee(FeeInfo calldata newFee) external onlyOwner {
        require(newFee.bps <= 500); // %5 max zone fee.
        _fee.bps = newFee.bps;
        _fee.recipient = newFee.recipient;
        emit FeeUpdated(newFee);
    }

    function setFulfiller(address fulfiller, bool valid) external onlyOwner {
        validate[fulfiller] = valid;
        emit FulfillerUpdated(fulfiller, valid);
    }
}
