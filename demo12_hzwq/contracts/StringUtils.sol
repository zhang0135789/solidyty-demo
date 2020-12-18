
pragma solidity >= 0.5.1 < 0.7.0;

library StringUtils {



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
}
