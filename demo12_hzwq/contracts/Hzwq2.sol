pragma solidity >= 0.5.0 < 0.7.4;


contract Hzwq2 {
    constructor() public {

    }


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



    //json数据
    function checkJson(string memory _json) public pure returns (bool)  {
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

        return strConcat(_head , randomCode());
    }


    // 自增码
    function randomCode() public payable returns(string memory) {

        if(random >= MAX_random) {
            random = 0;
        }

        randomStr = uint2str(random++);
        return randomStr;
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

}
