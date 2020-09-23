//SPDX-License-Identifier: MIT
pragma solidity ^0.4.22;
/// 第一行指名目前使用的 solidity 版本，不同版本的 solidity 可能会编译出不同的 bytecode 。
/// ^代表兼容 solidity 0.4.4 ~ 0.4.9 的版本

contract HelloWorld {
    /// contract 关键字类似于其他语言中较常见的 class
    /// 也可以把这句理解为 class HelloWorld extends Contract
    /// 声明 contract 后即内置了开发智能合约所需的功能。

    function sayHello() public pure returns (string) {
        /// 合约返回经典　Hello World
        return ("Hello World");
    }
}
