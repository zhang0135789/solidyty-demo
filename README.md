# solidyty-demo
智能合约入门

智能合约语言solidity入门基础知识

    本项目编写环境为
    Truffle v5.1.45 (core: 5.1.45)
    Solidity - 0.4.22 (solc-js)
    Node v10.15.3
    Web3.js v1.2.


    智能合约交流qq群：786937587

## 项目简介
#### demo01_hello
    简单的hello world 入门，学习solidity开发环境的搭建，以及测试

#### demo02_encryptedToken
    学习代币合约,开发简单的代币，
    具备初始化，查询余额，转账功能
    -Coin 
    -EncryptedToken
    -BloggerCoin  创建的代币如果想要能够通过以太币钱包来进行转账和收帐，必须兼容于以太坊的 ERC20 标准， ERC20 定义了支持钱包所必需的合约界面

#### demo03_test
    基础测试
    -SimpleStorage 只能合约数据缓存
       
#### demo04_ballot
    投票合约案例
    -投票合约
    -展示如何进行委托投票，同时，计票又是 自动和完全透明的
    -Ballot 
    -调用说明:
        1.初始化合约.生成["Nick", "Rama", "Jose"]投票选项
        2.调用giveRightToVote(""0x....) 授权账户可以进行投票操作
        3.账户调用vote([投票序号] , {from:"0x..."}) 对选项进行投票
        4.调用winningProposal()方法进行统计
        5.调用winnerName()输出得票获胜这的名字
        
#### demo04_login
    登录注册案例
    
    
#### javaDemo
    使用java调用智能合约 （demo_login） 案例
    TODO 遇到一个问题 testrpc的助记词 在web3j没有按照BIP44标准生成地址，导致无法注册（没有gas）






