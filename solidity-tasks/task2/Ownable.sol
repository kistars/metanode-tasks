// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address private _owner;

    // 只会在部署时被调用一次
    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Ownable: caller is not the owner");
        _;
    }

    // get function
    function owner() public view returns (address) {
        return _owner;
    }

    // set function
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new address cannot be zero");
        _owner = newOwner;
    }

    // reset
    function renounceOwnership() public onlyOwner {
        _owner = address(0);
    }
}
