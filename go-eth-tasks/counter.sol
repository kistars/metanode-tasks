// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    int256 private count;

    // 获取当前计数值
    function getCount() public view returns (int256) {
        return count;
    }

    // 增加计数
    function increment() public {
        count += 1;
    }

    // 减少计数
    function decrement() public {
        count -= 1;
    }

    // 设置初始值（可选）
    function setCount(int256 _value) public {
        count = _value;
    }
}
