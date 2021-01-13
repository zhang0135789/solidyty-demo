//SPDX-License-Identifier: MIT
pragma solidity ^0.5.10;

contract Utils {
  function stringTobytes32(string memory _source) internal pure returns(bytes32 result) {
    assembly {
      result := mload(add(_source , 32))
    }
  }

  function bytes32ToString(bytes32 x) internal pure returns(string memory){
    bytes memory bytesString = new bytes(32);
    uint charCount = 0;
    for (uint j = 0 ; j < 32 ; j++) {
      byte char = byte(bytes32(uint(x) * 2 ** (8 * j) ));
      if(char != 0) {
        bytesString[charCount] = char;
        charCount++;
      }
    }
    bytes memory bytesStringTrimmed = new bytes(charCount);
    for(uint j = 0 ; j < charCount ; j++) {
      bytesStringTrimmed[j] = bytesString[j];
    }
    return string(bytesStringTrimmed);
  }
}

contract Score is Utils{
  constructor() public {
    owner = msg.sender;
  }

  //合约拥有者 ,银行
  address public owner;

  //银行已经发行的积分数
  uint issuedScoreAmount;

  //已经清算的积分总数
  uint settledScoreAmount;

  struct Customer {
    //用户address
    address customerAddr;
    //密码
    bytes32 password;
    //积分余额
    uint scoreAmount;
    //购买的商品数组
    bytes32[] buyGoods;
  }

  struct Good {
    //商品ID
    bytes32 goodId;
    //商品价格
    uint price;
    //商品属于哪个商户
    address belong;
  }

  struct Merchant {
    //上人address
    address merchantAddr;
    //密码
    bytes32 password;
    //积分余额
    uint scoreAmount;
    //发布的商品数组
    bytes32[] sellGoods;
  }

  //根据客户的address查询客户
  mapping(address => Customer) customer;
  //已注册的客户数组
  address[] customers;

  //根据商品id查找商品
  mapping(bytes32 => Good) good;
  //已经上线的商品数组
  bytes32[] goods;

  //根据地址查询商家
  mapping(address => Merchant) merchant;
  //商家
  address[] merchants;


  //1.合约拥有者
  function getOwner() view public  returns (address) {
    return owner;
  }

  event NewCustomer(address sender , bool isSuccess , string message);
  //2.1用户注册
  function newCustomer(address _customerAddr , string memory _password) public {
    //判断是否已经注册
    if(!isCustomerAlreadyRegister(_customerAddr)) {
      //未注册
      customer[_customerAddr].customerAddr = _customerAddr;
      customer[_customerAddr].password = stringTobytes32(_password);
      customers.push(_customerAddr);
      emit NewCustomer(msg.sender , true , "regist successfully");
      return;
    }
    else {
      emit NewCustomer(msg.sender , false , "regist failed , already regist");
      return;
    }
  }

  event NewMerchant(address sender , bool isSuccess , string message);
  //2.2商户注册
  function newMerchant(address _merchantAddr , string memory _password) public {
    if(!isMerchantAlreadyRegister(_merchantAddr)) {
      merchant[_merchantAddr].merchantAddr = _merchantAddr;
      merchant[_merchantAddr].password = stringTobytes32(_password);
      merchants.push(_merchantAddr);
      emit NewMerchant(msg.sender , true , "regist successfully");
    }
    else {
      emit NewMerchant(msg.sender , false , "regist failed , already regist");
      return;
    }
  }



  //3.1判断一个用户是否已经注册
  function isCustomerAlreadyRegister(address _customerAddr) internal view returns(bool) {
    for(uint i = 0 ; i < customers.length ; i++) {
      if(customers[i] == _customerAddr) {
        return true;
      }
    }
    return false;
  }

  //3.2判断一个商户是否已经注册
  function isMerchantAlreadyRegister(address _merchantAddr) public view returns(bool) {
    for(uint i = 0 ; i < merchants.length ; i++) {
      if(merchants[i] == _merchantAddr) {
        return true;
      }
    }
    return false;
  }

  //3.3判断一个商品是否已经注册
  function isGoodAlreadyAdd(bytes32 _goodId) public view returns(bool) {
    for(uint i = 0 ; i < goods.length ; i++) {
      if(goods[i] == _goodId) {
        return true;
      }
    }
    return false;
  }




  //4.1客户登录
  function getCustomerPassword(address _customerAddr) public view returns (bool , bytes32) {
    //判断是否注册
    if(isCustomerAlreadyRegister(_customerAddr)) {
      return (true , customer[_customerAddr].password);
    }else {
      return (false , "");
    }
  }
  //4.2商户登录
  function getMerchantPassword(address _merchantAddr) public view returns (bool , bytes32) {
    //判断是否注册
    if(isMerchantAlreadyRegister(_merchantAddr)) {
      return (true , merchant[_merchantAddr].password);
    }else {
      return (false , "");
    }
  }

  modifier OnlyOwner() {
    require(msg.sender == owner , "no permission");
    _;
    //   if (msg.sender == owner) _;
  }
  //4.3根据客户address查找余额
  function getScoreWithCustomerAddr(address customerAddr) view public returns (uint) {
    return customer[customerAddr].scoreAmount;
  }

  //4.4根据商户address查找余额
  function getScoreWithMerchantAddr(address merchantAddr) view public returns (uint) {
    return merchant[merchantAddr].scoreAmount;
  }


  event SendScoreToCustomer(address sender , string message);

  //5.银行发送积分给客户,只能被合约拥有者调用,且只能发送给客户
  function sendScoreToCustomer(address _receiver , uint _amount) OnlyOwner public {
    if(isCustomerAlreadyRegister(_receiver)) {
      issuedScoreAmount += _amount;
      customer[_receiver].scoreAmount += _amount;
      emit SendScoreToCustomer(msg.sender , "issued successfully");
      return;
    }
    //未注册
    else {
      emit SendScoreToCustomer(msg.sender , "issued failed , unregistered");
      return;
    }
  }

  //5.2银行查找已经发行的积分总数
  function getIssuedScoreAmount() view public returns (uint) {
    return issuedScoreAmount;
  }
  //5.3银行查找已经清算的积分总数
  function getSettledScoreAmount() view public returns (uint) {
    return settledScoreAmount;
  }

  //6.两个账户转让积分,任意两个账户间都可以转让,客户商户都调用该方法
  event TransferScoreToAnother(address sender , string message);

  function transferScoreToAnother(
    uint _senderType ,
    address _sender ,
    address _receiver ,
    uint _amount
  ) public {
    if(!isCustomerAlreadyRegister(_receiver) && !isMerchantAlreadyRegister(_receiver)) {
      emit TransferScoreToAnother(_receiver , "transfer failed , unregistered , please try again");
      return;
    }
    //客户转移
    if(_senderType == 0) {
      if(customer[_sender].scoreAmount >= _amount) {
        customer[_sender].scoreAmount -= _amount;

        if(isCustomerAlreadyRegister(_receiver)) {
          customer[_receiver].scoreAmount += _amount;
        } else {
          merchant[_receiver].scoreAmount += _amount;
        }
        emit TransferScoreToAnother(msg.sender , "transfer successfully");
        return;
      }else {
        emit TransferScoreToAnother(msg.sender , "transfer failed , not enough amount");
        return;
      }
    }
    //商户转移
    else {
      if(merchant[_sender].scoreAmount >= _amount){
        merchant[_sender].scoreAmount -= _amount;
        if(isCustomerAlreadyRegister(_receiver)) {
          customer[_receiver].scoreAmount += _amount;
        }
        else {
          merchant[_receiver].scoreAmount += _amount;
        }
        emit TransferScoreToAnother(msg.sender , "transfer successfully");
        return;
      }
      else {
        emit TransferScoreToAnother(msg.sender , "transfer failed , not enough amount");
        return;
      }
    }
  }

  event AddGood(address sender , bool isSuccess , string message);
  //7.发布商品
  function addGood(address _merchantAddr , string memory _goodId , uint _price) public {
    bytes32 tempId = stringTobytes32(_goodId);
    if(!isGoodAlreadyAdd(tempId)) {
      good[tempId].goodId = tempId;
      good[tempId].price = _price;
      good[tempId].belong = _merchantAddr;

      goods.push(tempId);
      merchant[_merchantAddr].sellGoods.push(tempId);
      emit AddGood(msg.sender , false , "create a new good");
      return;
    }
    else {
      emit AddGood(msg.sender , false , "create a good failed , good already add");
      return;
    }
  }
  //7.2查看商品
  //商户查找自己的商品数组
  function getGoodsByMerchant(address _merchantAddr) view public returns (bytes32[] memory) {
    return merchant[_merchantAddr].sellGoods;
  }


  //8.用户用积分购买一件商品
  event BuyGood(address sender , bool isSuccess , string message);

  function buyGood(address _customerAddr , string memory _goodId) public {
    //首先判断输入的商品id是否存在
    bytes32 tempId = stringTobytes32(_goodId);
    if(isGoodAlreadyAdd(tempId)) {
      //该商品已经添加,可以购买
      if(customer[_customerAddr].scoreAmount < good[tempId].price) {
        emit BuyGood(msg.sender , false , "transaction failed , not enough amount");
        return;
      }
      else {
        customer[_customerAddr].scoreAmount -= good[tempId].price;
        merchant[good[tempId].belong].scoreAmount += good[tempId].price;
        customer[_customerAddr].buyGoods.push(tempId);
        emit BuyGood(msg.sender , true , "transaction successfully");
        return;
      }
    }
    else {
      emit BuyGood(msg.sender , true , "transaction failed , there is no good");
      return;
    }
  }

  //8.2客户查找自己的商品数组
  function getGoodsByCustomer(address _customerAddr) view public returns (bytes32[] memory) {
    return customer[_customerAddr].buyGoods;
  }

  //商户和银行清算积分
  event SettleScoreWithBank(address sender, string message);
  function settleScoreWithBank(address _merchantAddr, uint _amount) public {
    if (merchant[_merchantAddr].scoreAmount >= _amount) {
      merchant[_merchantAddr].scoreAmount -= _amount;
      settledScoreAmount += _amount;
      emit SettleScoreWithBank(msg.sender, "settle score successfully");
      return;
    }
    else {
      emit SettleScoreWithBank(msg.sender, "settle score failed , not enough amount");
      return;
    }
  }


}


