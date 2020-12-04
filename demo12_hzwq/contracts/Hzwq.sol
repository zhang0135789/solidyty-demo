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



  //json数据校验
  function checkJsonData(string memory _json) public pure returns (bool)  {
    //        string memory json='{"code":0,"message":"ok","ok":true,"test":testtttt}';
    //         string memory str="shily";
    uint total=3;
    bool check;
    for(uint index=1;index<=total;index++){
      check=checkStr(_json,getParameter(index));
      if(!check) {
        return false;
      }
    }
    return check;
  }


  //获取需要校验的参数
  function getParameter(uint index) public pure returns (string memory){
    if(index==1) {
      return "meter_id";
    }
    if(index==2){
      return "bar_code";
    }
    if(index==3){
      return "type_code";
    }
    if(index==4){
      return "org_no";
    }
    if(index==5){
      return "org_name";
    }
    if(index==6){
      return "manufacturer_name";
    }
    if(index==7){
      return "manufacturer";
    }

    return "";
  }



  //匹配是否存在字符串
  function checkStr(string memory _source,string memory _pattern)public pure returns (bool)  {
    bytes memory source = bytes(_source);
    bytes memory pattern = bytes(_pattern);

    uint pat_len = pattern.length;

    uint result_index = 0;
    uint pointer = 0;

    for(uint i = 0; i < source.length; i++){
      if(source[i] == pattern[pointer]) {
        pointer++;
        result_index++;
      } else {
        result_index = 0;
        pointer = 0;
      }

      if(result_index == pat_len) {
        return true;
      }
    }
    return false;
  }




  //json校验
  function checkJson() public pure returns (bool)  {

    return 1==1;
  }

  uint256 MAX_random = 100;
  uint256 random = 0;
  string  public randomStr ;

  mapping(uint256 => uint256) public randomMap;

  //唯一码
  function onlyCode(string memory _head) public payable
  returns ( string memory )
  {
//    bytes32 hash = keccak256(bytes(json));

    return StringUtils.strConcat(_head , randomCode());
  }


  // 自增码
  function randomCode() public payable returns(string memory) {

    if(random >= MAX_random) {
      random = 0;
    }

    randomStr = uint2str(random++);
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
