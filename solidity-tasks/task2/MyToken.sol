// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ownable.sol";

// 发布ERC20 token
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

contract MyToken is IERC20, Ownable {
    uint256 private _totalSupply; // 代币总供应量
    mapping(address => uint256) private _balances; // 账户余额
    // owner允许spender转账代币amount
    mapping(address owner => mapping(address spender => uint256 amount)) private _allowance;

    constructor() Ownable() {
        _mint(msg.sender, 10000);
    }

    function _mint(address account, uint256 amount) internal virtual onlyOwner {
        _totalSupply += amount;
        _balances[account] += amount;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowance[owner][spender];
    }

    // 授权
    function approve(address spender, uint256 value) external returns (bool) {
        _allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external onlyOwner returns (bool) {
        _balances[from] -= value;
        _balances[to] += value;
        return true;
    }
}
