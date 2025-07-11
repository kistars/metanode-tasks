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
    mapping(address => mapping(address => uint256)) private _allowance;

    // 增加name，symbol，decimal
    string private _name;
    string private _symbol;
    uint256 private _decimal;

    constructor(string memory name, string memory symbol, uint256 decimal) Ownable() {
        _name = name;
        _symbol = symbol;
        _decimal = decimal;
        _mint(msg.sender, 10000);
    }

    // get name
    function name() public view returns (string memory) {
        return _name;
    }

    // get symbol
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    // get decimal
    function decimal() public view returns (uint256) {
        return _decimal;
    }

    function _mint(address account, uint256 amount) internal virtual {
        _totalSupply += amount;
        _balances[account] += amount;
    }

    // 增发代币
    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(_balances[msg.sender] >= value, "ERC20: transfer amount exceeds balance");
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

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        uint256 currentAllowance = _allowance[from][msg.sender];
        require(currentAllowance >= value, "ERC20: transfer amount exceeds allowance");
        require(_balances[from] >= value, "ERC20: transfer amount exceeds balance");

        _balances[from] -= value;
        _balances[to] += value;
        _allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }
}
