//SPDX-License-Identifier: MIT
pragma solidity 0.5.10;
/**
 第一行指名目前使用的 solidity 版本，不同版本的 solidity 可能会编译出不同的 bytecode 。
 ^代表兼容 solidity 0.4.4 ~ 0.4.9 的版本
*/


contract HelloWorld {
    /**
      contract 关键字类似于其他语言中较常见的 class
      也可以把这句理解为 class HelloWorld extends Contract
      声明 contract 后即内置了开发智能合约所需的功能。
    */


    /**
        注意如果该函数没有constant 或者pure ，需要.call（）
    */
    // 能直接调用
    function sayHello() public pure returns (string memory) {
        // 合约返回经典　Hello World
        return ("Hello World");
    }

    // 需要依靠.call调用
    function test() public pure returns (string memory) {
        return ("Hello World");
    }

    function echo(string memory s) public pure returns (string memory) {
        return s;
    }


    uint balance;
    function update(uint amount) public returns (address, uint){
        balance += amount;
        return (msg.sender, balance);
    }

}
