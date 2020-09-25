//SPDX-License-Identifier: MIT
pragma solidity >= 0.4.24 < 0.7.0;

contract EncryptedToken {

    //代币总量
    uint256 INITIAL_SUPPLY = 666666;
    //定义资产账户
    mapping(address => uint256) balances;

    constructor() public {
        balances[msg.sender] = INITIAL_SUPPLY;
    }

    // 转账到⼀个指定的地址
    function transfer(address _to, uint256 _amount) public {
        assert(balances[msg.sender] > _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }


    // 查看指定地址的余额
    function balanceOf(address _owner) public view  returns (uint256) {
        return balances[_owner];
    }
}
