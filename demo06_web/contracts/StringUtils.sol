
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
}
