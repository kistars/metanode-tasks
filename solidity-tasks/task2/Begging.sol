// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract Begging is Ownable {
    event Donate(address indexed donator, uint256 amount);

    // amount of donators
    mapping(address donator => uint256 amount) balanceOf;

    uint256 public startTime;
    uint256 public endTime;

    constructor(uint256 startTime_, uint256 endTime_) {
        startTime = startTime_;
        endTime = endTime_;
    }

    modifier TimeLimit() {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "not valid time to donate");
        _;
    }

    // 排行榜
    address[] public donateRanking;
    uint256 constant topN = 3;

    function updateRanking(address donator) internal {
        bool exists = false;
        for (uint256 i = 0; i < donateRanking.length; i++) {
            if (donateRanking[i] == donator) {
                exists = true;
                break;
            }
        }

        if (!exists) {
            donateRanking.push(donator);
        }

        // sort
        for (uint256 i = 0; i < donateRanking.length; i++) {
            for (uint256 j = i + 1; j < donateRanking.length; j++) {
                if (balanceOf[donateRanking[j]] > balanceOf[donateRanking[i]]) {
                    (donateRanking[i], donateRanking[j]) = (donateRanking[j], donateRanking[i]);
                }
            }
        }

        if (donateRanking.length > topN) {
            donateRanking.pop();
        }
    }

    function getTopN() public view returns (address[] memory) {
        return donateRanking;
    }

    // payable: 允许接受eth
    function donate() public payable TimeLimit {
        require(0 != msg.value, "Donate: value cannot be zero");

        balanceOf[msg.sender] += msg.value;
        updateRanking(msg.sender);
        emit Donate(msg.sender, msg.value);
    }

    function getDonation(address donator) public view returns (uint256) {
        require(address(0) != donator, "Donate: address cannot be zero");
        return balanceOf[donator];
    }

    // 合约所有者提取所有捐款
    function withdraw() public payable onlyOwner {
        uint256 contractBalance = address(this).balance; // 合约中的余额
        require(contractBalance > 0, "balance must greater than 0");

        (bool success,) = payable(owner()).call{value: contractBalance}("");
        require(success, "withdraw failed");
    }

    // 允许合约接受eth
    receive() external payable {
        donate();
    }

    fallback() external payable {
        donate();
    }
}
