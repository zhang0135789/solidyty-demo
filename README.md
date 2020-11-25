# solidyty-demo
智能合约入门
欢迎交流qq群 ： 786937587

智能合约语言solidity入门基础知识

    本项目编写环境为
    Truffle v5.1.45 (core: 5.1.45) 
    Solidity - 0.4.22 (solc-js) (在测试环境汇总 solidity 版本可以根据truffle-config.js 的版本配置而下载相匹配的版本)
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
        
#### demo05_login
    登录注册案例
    
    
#### javaDemo
    使用java调用智能合约 （demo_login） 案例
    遇到一个问题 testrpc的助记词 在web3j没有按照BIP44标准生成地址，导致无法注册（没有gas）
    TODO 地址问题解决了，但是还是报'VM Exception while processing transaction: out of gas'的错误 
        

#### demo06_web
    Dapp HelloWorld
    web与智能合约简单的交互方式
    
#### demo07_


#### demo08_CrowdFunding
    众筹合约
    众筹合约调取tranfer内置函数出现错误，无法进行转账交易。(解决方法 : testrpc 环境换成ganache环境 可以正常调用)
    1)调用createCrowdFunding() 发起众筹, 传入众筹地址和众筹金额
    2)调用contribute() 捐赠token 需要传入众筹id,以及交易信息(发起人和捐赠金额){from:acc1 , value:web3.utils.toWei("3")}
    3)调用isCompelte() 检查众筹是否完成, 若完成,将众筹资金给予众筹对象
    
#### demo09_OpenAuction
    公开拍卖
    整体流程如下
    ·我们首先要记录拍卖的基本数据：谁是受益人，什么时候结束
    ·我们开启拍卖，一个出价更高的人会替代之前出价最高的人
    ·当出现替代时，还要退还之前出价高的人的代币
    ·出于安全的考虑，退还过程将由之前用户主动发起
    合约部署之后,
    1)调用bid()参与竞价 : contract.bid({from:acc1 , value:web3.utils.toWei("3")})
    2)调用withdraw()取回竞拍资金
    3)调用auctionEnd()竞拍结束,将最高拍卖金额给予受益人

#### demo10_BlindAuction
    盲拍
    

#### demo11_oracle
    oracle预言机
    区块链内世界状态通过oracle调用外部API接口,并反馈给区块链网络



















