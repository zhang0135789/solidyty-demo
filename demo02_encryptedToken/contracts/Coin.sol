//SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.7.0;

contract Coin {

    // 关键字 "public" 让这些变量可以从外部读取
    // 铸币人
    address public minter;
    // 资产
    mapping(address => uint) public balances;

    // 轻量级轻客户端可以通过事件有效地针对变化来做出反应。
    event Sent(address from, address to, uint amount);

    constructor() public {
        minter = msg.sender;
    }


    /*
        铸币
    */
    function mint(address receiver, uint amount) public {
        if (minter != receiver) {
            return;
        }
//        assert(minter != receiver);
        balances[receiver] += amount;
    }

    /*
        进行交易
    */
    function send(address receiver, uint amount) public {
//        if(balances[receiver] < amount) {
//            return;
//        }
        assert(balances[receiver] < amount);
        balances[msg.sender] -= amount;
        balances[receiver]   += amount;

        emit Sent(msg.sender , receiver , amount);
    }

}
