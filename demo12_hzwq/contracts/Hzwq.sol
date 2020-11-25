//SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.7.4;


import "./provableAPI.sol";

contract Hzwq is usingProvable{
  constructor() public {
    OAR = OracleAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);

  }

  string public ETHUSD;

  event LogNewOraclizeQuery(string description);
  event LogNewOraclizeQuery2(string description);
  event LogPriceUpdated(string price);





  //json校验
  function checkJson() public pure returns (bool)  {

    return 1==1;
  }

  //唯一码
  function onlyCode() public pure returns (string memory) {

    return "";
  }


  //审批
  function examine() public pure returns (bool) {
    return 1==1;
  }


  //签章
  function signature() public payable {

    if (provable_getPrice("URL") >= address(this).balance) {

    } else {
      //            provable_query("URL", "json(https://api.pro.coinbase.com/products/ETH-USD/ticker).price");
      //            provable_query("URL", "json(http://192.168.15.177:10080/blockServer/cunzheng/data/query?hash=123)");
      //            provable_query("URL", "https://smlopenapi.esign.cn/v1/oauth2/access_token?appId=7438830459&secret=c1b5ae47815c51af51e0ffdda1cd0693&grantType=client_credentials");
      provable_query("URL", "https://api.pro.coinbase.com/products/ETH-USD/ticker");


    }

  }
  function __callback( bytes32 _myid, string memory _result ) public {
    if (msg.sender != provable_cbAddress()) revert();
    ETHUSD = _result;
    // Do something with viewsCount, like tipping the author if viewsCount > X?
  }





}
