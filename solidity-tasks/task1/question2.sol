// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseString {
    function reverseString(
        string calldata str
    ) public pure returns (string memory) {
        bytes memory bs = bytes(str);
        uint len = bs.length;

        for (uint i = 0; i < len / 2; i++) {
            bytes1 temp = bs[i];
            bs[i] = bs[len - 1 - i];
            bs[len - 1 - i] = temp;
        }

        return string(bs);
    }
}
