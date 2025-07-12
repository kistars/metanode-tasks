// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Counters {
    struct Counter {
        uint256 _value;
    }

    function current(Counter storage c) internal view returns (uint256) {
        return c._value;
    }

    function increment(Counter storage c) internal {
        unchecked {
            c._value += 1;
        }
    }

    function decrement(Counter storage c) internal {
        uint256 v = c._value;
        require(v > 0, "Counter: decrement overflow");
        unchecked {
            c._value -= 1;
        }
    }

    function reset(Counter storage c) internal {
        c._value = 0;
    }
}
