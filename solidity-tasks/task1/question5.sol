// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeArrays {
    function mergeTwoArrays(
        uint[] memory arr1,
        uint[] memory arr2
    ) public pure returns (uint[] memory) {
        uint len1 = arr1.length;
        uint len2 = arr2.length;
        uint[] memory merged = new uint[](len1 + len2);

        uint i = 0;
        uint j = 0;
        uint k = 0;

        while (i < len1 && j < len2) {
            if (arr1[i] < arr2[j]) {
                merged[k++] = arr1[i++];
            } else {
                merged[k++] = arr2[j++];
            }
        }

        while (i < len1) {
            merged[k++] = arr1[i++];
        }

        while (j < len2) {
            merged[k++] = arr2[j++];
        }

        return merged;
    }
}
