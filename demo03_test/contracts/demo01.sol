pragma solidity ^0.4.22;


// 合约结构
contract demo01 {


    constructor() public {
        seller = msg.sender;
    }

    // 1.状态变量
    uint public storedData ;


    // 2.函数
    function set(uint x) public {
        storedData = x;
    }



    // 3.函数修饰器
    address public seller;

    modifier onlySeller() { // 修饰器
        require(
            msg.sender == seller,
            "Only seller can call this."
        );
        _;
    }
    function abort() public view onlySeller { // Modifier usage
        // ...
    }

    function setSeller(address addr) public {
        seller = addr;
    }


    // 4.事件
    event HighestBidIncreased(address bidder, uint amount); // 事件
    function bid() public payable {
        // ...
        emit HighestBidIncreased(msg.sender, msg.value); // 触发事件
    }



    // 5.接口类型
    struct Voter { // 结构
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }


    // 6.枚举
    enum State { Created, Locked, Inactive } // 枚举


}
