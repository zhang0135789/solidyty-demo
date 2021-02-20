pragma solidity >= 0.5.0 < 0.7.4;


contract Hzwq2 {
    constructor() public {

    }



    //审批4-5
    function examine2(
    //4
        int  dayerr_conc_code,
    //5
        int clock_error,
        uint met_value,
        uint std_value,
        uint time_err,
    //6
        string memory clock_conc
    //7

    ) public pure returns (bool , string memory ,uint) {

        //4
        if(dayerr_conc_code > 40) {
            return (false, "日计时误差误差限不合格" , 0);
        }
        if(dayerr_conc_code < -40) {
            return (false, "日计时误差误差限不合格" , 0);
        }


        //5-a
        if(clock_error > 400) {
            return (false, "检查时钟示值误差不合格a1" , 0);
        }
        if(clock_error < -400) {
            return (false, "检查时钟示值误差不合格a2" , 0);
        }
        //5-b
        if(met_value > std_value) {
            if(met_value - std_value != time_err) {
                return (false, "检查时钟示值误差不合格b1" , 0);
            }
        }else {
            if(std_value - std_value != time_err) {
                return (false, "检查时钟示值误差不合格b2" , 0);
            }
        }


        //6-a
        //    if(!hashCompareInternal(clock_conc,"合格")) {
        //      return (false, "检查电能示值误差不合格" , 0);
        //    }
        //6-b


        //7

        return (true , "审核成功" ,1);
    }



    //审批1-2
    function examine1(
    //1
        string memory _json,
    //2
        string memory conc_code,
        string memory volt_conc_code,
        string memory intuit_conc_code,
        string memory starting_conc_code,
        string memory creeping_conc_code,
        string memory const_conc_code

    ) public pure returns (bool , string memory ,uint) {

        //1
        if(!checkStr(_json,"cert_id")) {
            return (false, "cert_id字段不存在" , 0);
        }

        //2
        if(!hashCompareInternal(conc_code , "合格")) {
            return (false, "检测结论不合格" , 0);
        }
        if(!hashCompareInternal(volt_conc_code , "合格")) {
            return (false, "交流电压试验不合格" , 0);
        }
        if(!hashCompareInternal(intuit_conc_code , "合格")) {
            return (false, "外观、标志及通电检查不合格" , 0);
        }
        if(!hashCompareInternal(starting_conc_code , "合格")) {
            return (false, "起动实验不合格" , 0);
        }
        if(!hashCompareInternal(creeping_conc_code , "合格")) {
            return (false, "潜动实验不合格" , 0);
        }
        if(!hashCompareInternal(const_conc_code , "合格")) {
            return (false, "电能表常数试验不合格" , 0);
        }
        // if(!hashCompareInternal(dayerr_conc_code , "01")) {
        //   return (false, "日计时误差不合格" , 0);
        // }
        // if(!hashCompareInternal(clock_value_conc_code , "01")) {
        //   return (false, "时钟示值误差不合格" , 0);
        // }

        //3

        return (true , "审核成功" ,1);
    }



    // 如果是固定大小字节数组转string，那么就需要先将字节数组转动态字节数组，再转字符串。
    // 但是，如果字符串不是占满32个字节。那么后面就会由0进行填充。所以我们需要将这些空字符去掉。
    function bytes32ToString(bytes32 b32name) internal pure returns(string memory){

        bytes memory bytesString = new bytes(32);

        // 定义一个变量记录字节数量
        uint charCount = 0;

        uint32 i = 0;
        // 统计共有多少个字节数
        for( i = 0; i < 32; i++){

            byte char = byte(bytes32(uint(b32name) * 2 ** (8 * i)));  // 将b32name左移i位,参考下面算法
            // 获取到的始终是第0个字节。
            // 但为什么*2

            if(char != 0){
                bytesString[charCount] = char;
                charCount++;
            }
        }

        // 初始化一动态数组，长度为charCount
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for(i = 0;i< charCount;i++){
            bytesStringTrimmed[i] = bytesString[i];
        }

        return string(bytesStringTrimmed);
    }


    function abs(int  _x) pure internal returns(int) {
        if(_x < 0) {
            return -_x;
        }
        return _x;
    }


    //匹配是否存在字符串
    function checkStr(string memory _source,string memory _pattern) internal pure returns (bool)  {
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


    //比较str
    function hashCompareInternal(string memory _a, string memory _b) internal pure returns (bool) {
        return keccak256(bytes(_a)) == keccak256(bytes(_b));
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
