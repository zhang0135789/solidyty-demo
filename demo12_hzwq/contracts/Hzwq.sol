//SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.7.4;


import "./provableAPI.sol";
import "./StringUtils.sol";


contract Hzwq is usingProvable{
  constructor() public {
    OAR = OracleAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);

  }


  event LogNewOraclizeQuery(string description);
  event LogNewOraclizeQuery2(string description);
  event LogPriceUpdated(string price);



  //json校验
  function checkJson() public pure returns (bool)  {

    return 1==1;
  }

  uint256 MAX_random = 100;
  string  public randomStr ;

  mapping(uint256 => uint256) public randomMap;

  //唯一码
  function onlyCode(string memory json) public
  returns (
    bytes32 ,
    string memory)
  {
    bytes32 hash = keccak256(bytes(json));


//    if(random > MAX_random) {
//      random = 0;
//    }


//    string memory result = hash + randomStr;
    //    string memory randomStr = uint2str(random++);
    //    string memory result = StringUtils.strConcat(hash , randomStr);
    //    return result;
    return (hash , randomCode());
  }

  uint random = 0;

  // 自增码
  function randomCode() public payable returns(string memory) {

    if(randomMap[0] == 0) {
      randomMap[0] = 1;
    }else {
      randomMap[0] = randomMap[0] + 1;
    }


    randomStr = uint2str(randomMap[0]);
    return randomStr;
  }

  function getRandomMap(uint _index) public view returns(uint){
    return randomMap[_index];
  }

  //    string memory hash = StringUtils.bytes32ToString(keccak256(abi.encode(json)));




  //审批
  function examine() public pure returns (bool) {
    return 1==1;
  }


  string public result;
  bytes32 public myid;

  //签章
  function signature(string memory _url) public payable {

    if (provable_getPrice("URL") >= address(this).balance) {

    } else {
      //            provable_query("URL", "json(https://api.pro.coinbase.com/products/ETH-USD/ticker).price");
      //            provable_query("URL", "json(http://192.168.15.177:10080/blockServer/cunzheng/data/query?hash=123)");
      //            provable_query("URL", "https://smlopenapi.esign.cn/v1/oauth2/access_token?appId=7438830459&secret=c1b5ae47815c51af51e0ffdda1cd0693&grantType=client_credentials");
      provable_query("URL", _url);

    }

  }
  function __callback( bytes32 _myid, string memory _result ) public {
    if (msg.sender != provable_cbAddress()) revert();
    result = _result;
    myid = _myid;

    // Do something with viewsCount, like tipping the author if viewsCount > X?
  }






}
