pragma solidity >0.4.22 <0.6.0;

contract BlindAuction {

  // 盲拍结构体
  struct Bid {
    bytes32 blindedBid; //加密出价
    uint deposit;  // 保证金
  }

  // 受益人账户 加上payable 修饰是因为 受益人账户需要进行代币的相关操作
  address payable public beneficiary;

  // 盲拍结束时间
  uint public biddingEnd;
  // 展示结束时间
  uint public revealEnd;
  // 盲拍是否结束
  bool public ended;

  // 账户与竞价信息和抵押保证金相关联
  mapping(address => Bid[]) public bids;

  // 最高出价者
  address public highestBidder;
  // 最该出价
  uint public highestBid;

  // 用于取回之前的出价
  mapping(address => uint) pendingReturns;

  event AuctionEnded(address winner, uint highestBid);

  modifier onlyBefore(uint _time) { require(now < _time); _; }
  modifier onlyAfter(uint _time) { require(now > _time); _; }

  // 初始化盲拍 初始化参数 盲拍持续时间 , 展示持续时间 , 盲拍受益人
  constructor( uint _biddingTime, uint _revealTime, address payable _beneficiary ) public {
    beneficiary = _beneficiary;
    biddingEnd = now + _biddingTime;
    revealEnd = biddingEnd + _revealTime;
  }

  // 竞价
  // payable 修饰词表明涉及资产操作
  function bid(bytes32 _blindedBid) public payable
  onlyBefore(biddingEnd) {
    bids[msg.sender].push(
      Bid({  blindedBid: _blindedBid,  deposit: msg.value })
    );
  }

  // 明牌
  function reveal( uint[] memory _values, bool[] memory _fake, bytes32[] memory _secret ) public
  onlyAfter(biddingEnd)
  onlyBefore(revealEnd) {
    uint length = bids[msg.sender].length;
    require(_values.length == length);
    require(_fake.length == length);
    require(_secret.length == length);

    uint refund;
    for (uint i = 0; i < length; i++) {
      Bid storage bidToCheck = bids[msg.sender][i];
      (uint value, bool fake, bytes32 secret) =
      (_values[i], _fake[i], _secret[i]);
      if (bidToCheck.blindedBid != keccak256(abi.encodePacked(value, fake, secret))) {
        continue;
      }
      refund += bidToCheck.deposit;
      if (!fake && bidToCheck.deposit >= value) {
        if (placeBid(msg.sender, value))
          refund -= value;
      }

      bidToCheck.blindedBid = bytes32(0);
    }
    msg.sender.transfer(refund);
  }

  // 出价函数
  // internal关键字修饰的函数只能在合约内部调用,类似与java的private
  function placeBid(address bidder, uint value) internal returns (bool success) {
    if (value <= highestBid) {
      return false;
    }
    if (highestBidder != address(0)) {
      pendingReturns[highestBidder] += highestBid;
    }
    highestBid = value;
    highestBidder = bidder;
    return true;
  }

  // 退款函数
  function withdraw() public {
    uint amount = pendingReturns[msg.sender];
    if (amount > 0) {
      pendingReturns[msg.sender] = 0;
      msg.sender.transfer(amount);
    }
  }

  // 结束函数
  function auctionEnd() public onlyAfter(revealEnd) {
    require(!ended);
    emit AuctionEnded(highestBidder, highestBid);
    ended = true;
    beneficiary.transfer(highestBid);
  }
}
