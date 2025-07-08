// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntToRome {
    function IntToRomeFunc(string memory s) public pure returns (uint256) {
        bytes memory str = bytes(s);
        uint256 total = 0;
        uint256 prev = 0;

        for (uint256 i = str.length - 1; i > 0; i--) {
            uint256 val = charToValue(str[i]);
            if (val < prev) {
                total -= val;
            } else {
                total += val;
                prev = val;
            }
        }

        return total;
    }

    function charToValue(bytes1 ch) internal pure returns (uint256) {
        if (ch == "I") return 1;
        if (ch == "V") return 5;
        if (ch == "X") return 10;
        if (ch == "L") return 50;
        if (ch == "C") return 100;
        if (ch == "D") return 500;
        if (ch == "M") return 1000;

        revert("Invalid Roman symbol");
    }
}
