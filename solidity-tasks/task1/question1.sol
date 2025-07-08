// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VoteContract {
    mapping(string name => uint32 amount) public votesMapping;
    string[] candidates;

    // 投票给某人
    function voteSomeone(string calldata name) public {
        votesMapping[name] += 1;
        candidates.push(name);
    }

    // 获取投票
    function getVotes(string calldata name) public view returns (uint32) {
        return votesMapping[name];
    }

    // 重置所有人的投票
    function resetAllVotes() public {
        for (uint32 i = 0; i < candidates.length; i++) {
            delete votesMapping[candidates[i]];
        }
    }
}
