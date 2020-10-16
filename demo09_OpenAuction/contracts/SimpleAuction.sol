pragma solidity >=0.4.22 <0.6.0;

contract SimpleAuction {


    // 受益人
    address  public beneficiary;
    // 拍卖结束时间 以时间戳形式存放
    uint public auctionEndTime;
    // 拍卖开始时间
    uint public auctionBeginTime;

    // 最高出价 账户地址
    address public highestBidder;
    // 最高出价
    uint public highestBid;

    // 用于取回之前的出价
    mapping(address => uint) pendingReturns;

    // 拍卖是否结束，不允许被修改
    bool ended;

    // 最高出价变动时调用事件
    event HighestBidIncreased(address bidder, uint amount);
    // 拍卖结束时调用事件
    event AuctionEnded(address winner, uint amount);

    /// 创建一个拍卖对象 , 初始化参数, 拍卖初试时间
    constructor(uint _biddingTime, address  _beneficiary ) public {
        beneficiary = _beneficiary;
        auctionBeginTime = now;
        auctionEndTime = now + _biddingTime;
    }

    /// 进行拍卖竞价
    // 使用代币进行拍卖，当拍卖失败时，会退回代币
    // 出价功能：包括交易参数
    // 当出价不是最高，资金会被自动退回
    function bid() public payable {
        // 不需要参数，因为都被自动处理了
        // 当一个函数要处理Ether时，需要包含payable的修饰符

        // 如果拍卖结束, 滚交易
        require(
            now <= auctionEndTime,
            "Auction already ended."
        );

        // 如果竞价低于最高竞价, 回滚交易
        require(
            msg.value > highestBid,
            "There already is a higher bid."
        );


        // 如果出价超过当前最高竞价 , 那么当前出价者 为最高竞价者
        if (highestBid != 0) {
            //highestBidder.send(highestBid); // send ether(in wei)to the address
            // 调用highestBidder.send(highestBid)的方式是危险的
            // 因为会执行不知道的协议
            // 因此最好让用户自己取回自己的代币
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    /// 取回拍卖的资金
    function withdraw() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // 需要提前设置为0，因为接收者可以在这个函数结束前再次调用它
            pendingReturns[msg.sender] = 0;

            if (!msg.sender.send(amount)) {
                // 不需要throw，直接重置代币数量即可
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    /// 竞拍结束 , 将最高竞拍余额给予受益人
    function auctionEnd() public {
        // 与其他协议交互的最好遵循以下顺序的三个步骤：
        // 1.检查状况
        // 2.修改状态
        // 3.合约交互
        // 如果这三个步骤混在一起，那么攻击者可能通过多次调用这个函数来进行攻击

        // 检测拍卖是否到结束时间
        require(now >= auctionEndTime, "Auction not yet ended.");

        // 检测此次拍卖的结束状态是否为true
        require(!ended, "auctionEnd has already been called.");

        // 设置拍卖结束状态为true
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // 合约交互,调用转账
        beneficiary.transfer(highestBid);
    }
}
