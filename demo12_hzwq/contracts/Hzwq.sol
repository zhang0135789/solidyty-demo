//SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.7.4;


//import "./provableAPI.sol";
import "./StringUtils.sol";


//contract Hzwq is usingProvable{
contract Hzwq {

  constructor() public {
//    OAR = OraclizeAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);
//    OAR = OracleAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);
  }


  event LogNewOraclizeQuery(string description);
  event LogNewOraclizeQuery2(string description);
  event LogPriceUpdated(string price);




  //取绝对值
  function abs(int  _x) pure public returns(int) {
    if(_x < 0) {
      return -_x;
    }
    return _x;
  }

  //比较str
  function hashCompareInternal(string memory _a, string memory _b) public pure returns (bool) {
    return keccak256(bytes(_a)) == keccak256(bytes(_b));
  }



  //json数据校验
  function checkJsonData(string memory _json , uint _type) public pure returns (bool)  {
    //        string memory json='{"code":0,"message":"ok","ok":true,"test":testtttt}';
    //         string memory str="shily";
    bool check = false;
    if(_type == 1) {
      uint total=7;
      for(uint index=1;index<=total;index++){
        check=checkStr(_json,getParameter(index));
        if(!check) {
          return false;
        }
      }
    }
    if(_type == 2) {
      uint total = 22;
      for(uint index=1 ; index <= total; index++){
        // check = checkStr(_json,getParameter2(index));
        check = checkStr(_json,getParameter2(index));
        if(!check) {
          return false;
        }
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

  //获取电能表需要校验的参数
  function getParameter2(uint index) public pure returns (string memory){
    if(index==1) {
      return "cert_id";
    }
    if(index==2){
      return "cert_code";
    }
    if(index==3){
      return "volt_code";
    }
    if(index==4){
      return "rated_current";
    }
    if(index==5){
      return "detect_task_no";
    }
    if(index==6){
      return "verified_date";
    }
    if(index==7){
      return "line_certno_id";
    }
    if(index==8){
      return "divice_name";
    }
    if(index==9){
      return "divice_certificate_no";
    }
    if(index==10){
      return "divice_expired_date";
    }
    if(index==11){
      return "equip_name";
    }
    if(index==12){
      return "equip_certificate_no";
    }
    if(index==13){
      return "equip_expired_date";
    }
    if(index==14){
      return "place";
    }
    if(index==15){
      return "temperaure";
    }
    if(index==16){
      return "humidity";
    }
    if(index==17){
      return "detect_person";
    }
    if(index==18){
      return "line_certno_id";
    }
    if(index==19){
      return "audit_person";
    }
    if(index==20){
      return "conclusion";
    }
    if(index==21){
      return "cert_no";
    }
    if(index==22){
      return "cert_code";
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




  //json数据
  function checkJson(string memory _json) public pure returns (bool)  {
    return 1==1;
  }



  uint256 MAX_random = 100000000;
  uint256 random = 0;
  string  public randomStr ;


  //唯一码
  function onlyCode(string memory _head , uint _type) public payable
  returns ( string memory )
  {
    //    bytes32 hash = keccak256(bytes(json));
    string memory result;
    string memory number;

    number = randomCode();
    if(_type == 1) {
      result = strConcat("DD-",_head);
      bytes memory numberBytes = bytes(number);
      for(uint i = 0 ; i < (9-numberBytes.length) ; i++) {
        number = strConcat("0" , number);
      }

    }
    if(_type == 2) {
      result = strConcat("DSZ-",_head);
      bytes memory numberBytes = bytes(number);
      for(uint i = 0 ; i < 8 - numberBytes.length ; i++) {
        number = strConcat("0" , number);
      }
    }
    if(_type == 3) {
      result = strConcat("DSH-",_head);
      bytes memory numberBytes = bytes(number);
      for(uint i = 0 ; i < 8 - numberBytes.length ; i++) {
        number = strConcat("0" , number);
      }
    }

    return strConcat(result ,number);
  }


  // 自增码
  function randomCode() public payable returns(string memory) {

    if(random >= MAX_random) {
      random = 0;
    }
    randomStr = uint2str(random++);
    return randomStr;
  }

  /**
    对两个字符串进行拼接
*/
  function strConcat(string memory _a, string memory _b) internal pure returns (string memory){
    bytes memory _ba = bytes(_a);
    bytes memory _bb = bytes(_b);
    string memory ret = new string(_ba.length + _bb.length );
    bytes memory bret = bytes(ret);
    uint k = 0;
    uint i;
    for (i = 0; i < _ba.length; i++){
      bret[k++] = _ba[i];
    }
    for (i = 0; i < _bb.length; i++) {
      bret[k++] = _bb[i];
    }
    return string(ret);
  }

  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
    if (_i == 0) {
      return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
      len++;
      j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (_i != 0) {
      bstr[k--] = byte(uint8(48 + _i % 10));
      _i /= 10;
    }
    return string(bstr);
  }


//  string public result;
//  bytes32 public myid;
//
//  //签章
//  function signature(string memory _url) public payable {
//
//    if (provable_getPrice("URL") >= address(this).balance) {
//
//    } else {
//      provable_query("URL", _url);
//
//    }
//
//  }
//  function __callback( bytes32 _myid, string memory _result ) public {
//    if (msg.sender != provable_cbAddress()) revert();
//    result = _result;
//    myid = _myid;
//
//    // Do something with viewsCount, like tipping the author if viewsCount > X?
//  }






}
