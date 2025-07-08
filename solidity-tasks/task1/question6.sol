// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    uint256[] arr = [1, 2, 3, 4, 5, 6];

    function binarySearchFunc(uint256 target) public view returns (uint) {
        uint left = 0;
        uint right = 0;

        while (left < right) {
            uint mid = left + (right - left) / 2;
            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return -1;
    }
}
