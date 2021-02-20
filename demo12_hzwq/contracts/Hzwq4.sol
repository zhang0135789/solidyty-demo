pragma solidity >= 0.5.0 < 0.7.4;


contract Hzwq4 {

    constructor() public {
        //7-
        c1[0][0] = 80; c1[0][1] = 120;
        c1[1][0] = 44; c1[1][1] = 84;
        c1[2][0] = 41; c1[2][1] = 81;

    }


    //3
    //3-d
    function examine6(
        string memory _volt_code,
        string memory _rated_current,
        string memory _ap_pre_level_code,

        bytes32[] memory _both_way_power_flag, //有功无功判断
        uint[] memory _ave_err1,
        uint[] memory _ave_err2,
        uint[] memory _int_convert_err

    )public view returns (bool , string memory ) {

        //一、规格：3×57.7/100V，3×1.5（6）A，0.5S级（共126个误差点）
        //a1 b1
        if(hashCompareInternal(_volt_code , "3×57.7/100V") && hashCompareInternal(_rated_current , "3×1.5(6)A") && hashCompareInternal(_ap_pre_level_code,"有功0.5S")) {

            //3-d
            for(uint i = 0 ; i < _both_way_power_flag.length ; i++) {
                //3-b 0.05 * 10000  = 500
                uint val ;
                //有功
                if(_both_way_power_flag[i] == bytes32("正向有功") || _both_way_power_flag[i] == bytes32("反向有功")) {
                    if(_ave_err1[i] < 250) {
                        val = 0;
                    }else {
                        val = ((_ave_err1[i]-250) / 500 + 1) * 500;
                    }

                    if(_int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                        return (false , strConcat("有功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                    }
                }

                //无功 0.2 * 10000 = 2000
                if(_both_way_power_flag[i] == bytes32("正向无功") || _both_way_power_flag[i] == bytes32("反向无功")) {
                    if(_ave_err1[i] < 1000) {
                        val = 0;
                    }else {
                        val = ((_ave_err1[i]-1000) / 2000 + 1) * 2000;
                    }

                    if(  _int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                        return (false , strConcat("无功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                    }
                }
            }

        }
        //二、规格：3×100V，3×1.5（6）A，0.5S级（共98个误差点）
        //a2 b2
        else if(hashCompareInternal(_volt_code , "3×100V") && hashCompareInternal(_rated_current , "3×1.5(6)A") && hashCompareInternal(_ap_pre_level_code,"有功0.5S")) {
            for(uint i = 0 ; i < _both_way_power_flag.length ; i++){

                //3-d
                uint val ;
                //3-b 0.05 * 10000  = 500
                //有功
                if(_both_way_power_flag[i] == bytes32("正向有功") || _both_way_power_flag[i] == bytes32("反向有功")) {
                    if(_ave_err1[i] < 250) {
                        val = 0;
                    }else {
                        val = ((_ave_err1[i]-250) / 500 + 1) * 500;
                    }                    if(  _int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                        return (false , strConcat("有功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                    }
                }

                //无功 0.2 * 10000 = 2000
                if(_both_way_power_flag[i] == bytes32("正向无功") || _both_way_power_flag[i] == bytes32("反向无功")) {
                    if(_ave_err1[i] < 1000) {
                        val = 0;
                    }else {
                        val = ((_ave_err1[i]-1000) / 2000 + 1) * 2000;
                    }
                    if(  _int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                            return (false , strConcat("无功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                    }
                }

            }

        }
        //三、规格：3×220/380V，3×1.5（6）A，1级（共126个误差点）
        //a3 b3
        else if(hashCompareInternal(_volt_code , "3×220V/380V") && hashCompareInternal(_rated_current , "3×1.5(6)A") && hashCompareInternal(_ap_pre_level_code,"有功1级")) {
            for(uint i = 0 ; i < _both_way_power_flag.length ; i++) {

                //3-d
                uint val ;
                //3-b 0.1 * 10000  = 1000
                //有功
                if(_both_way_power_flag[i] == bytes32("正向有功") || _both_way_power_flag[i] == bytes32("反向有功")) {
                    if(_ave_err1[i] < 500) {
                        val = 0;
                    }else {
                        val = ((_ave_err1[i]-500) / 1000 + 1) * 1000;
                    }

                    if(  _int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                        return (false , strConcat("有功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                    }
                }

                //无功 0.2 * 10000 = 2000
                if(_both_way_power_flag[i] == bytes32("正向无功") || _both_way_power_flag[i] == bytes32("反向无功")) {
                    if(_ave_err1[i] < 1000) {
                        val = 0;
                    }else {
                        val = ((_ave_err1[i]-1000) / 2000 + 1) * 2000;
                    }
                    if(  _int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                        return (false , strConcat("无功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                    }
                }


            }


        }
        //四 、规格：3×220/380V，3×5（60）A，1级（共136个误差点）
        //a4 b4
        else if(hashCompareInternal(_volt_code , "3×220V/380V") && hashCompareInternal(_rated_current , "3×5(60)A") && hashCompareInternal(_ap_pre_level_code,"有功1级")) {
            for(uint i = 0 ; i < _both_way_power_flag.length ; i++) {
                //3-d
                uint val ;
                //3-d 0.1 * 10000  = 1000
                //有功
                if(_both_way_power_flag[i] == bytes32("正向有功") || _both_way_power_flag[i] == bytes32("反向有功")) {
                    if(_ave_err1[i] < 500) {
                        val = 0;
                    }else {
                        val = ((_ave_err1[i]-500) / 1000 + 1) * 1000;
                    }

                    if(  _int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                    return (false , strConcat("有功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                }                    if(  _int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                        return (false , strConcat("有功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                    }
                }

                //无功 0.2 * 10000 = 2000
                if(_both_way_power_flag[i] == bytes32("正向无功") || _both_way_power_flag[i] == bytes32("反向无功")) {
                    if(_ave_err1[i] < 1000) {
                        val = 0;
                    }else {
                        val = ((_ave_err1[i]-1000) / 2000 + 1) * 2000;
                    }
                    if(  _int_convert_err[i] != ((_ave_err1[i] - _ave_err2[i]) / val) ) {
                        return (false , strConcat("无功不平衡与平衡误差之差的验证不合格: ", uint2str(i)));
                    }
                }


            }

        }
        // //五 、规格：单相表 220V， 5（60）A，2级（共10个误差点）
        // //a5
        // else if(hashCompareInternal(_volt_code , "220V") && hashCompareInternal(_rated_current , "5(60)A") && hashCompareInternal(_ap_pre_level_code,"2级")) {
        //     for(uint i = 0 ; i < _both_way_power_flag.length ; i++) {
        //         //3-b 0.2 * 10000  = 2000
        //         //有功
        //         if(_both_way_power_flag[i] == bytes32("正向有功") || _both_way_power_flag[i] ==  bytes32("反向有功")) {
        //         }
        //         //3-d
        //     }
        // }


        return (true , "审核成功");
    }


    //7
    int[2][3] c1;
    //6-7
    function examine4(
    //6
        string memory clock_conc,
        int[] memory start_values,
        int[] memory end_values,
        int[] memory ele_increments,
        int[] memory value_conc_codes,

    //7
        string memory ap_pre_level_code,
        bytes32[] memory load_current,
        int[] memory demand_value_err


    )public view returns (bool , string memory ,uint256) {
        //6-a
        if(!hashCompareInternal(clock_conc,"合格")) {
            return (false, "检查电能示值误差不合格" , 0);
        }
        //6-b
        for(uint i = 0 ; i < value_conc_codes.length ; i++) {
            // int value_conc_code = value_conc_codes[i];
            // int ele_incrementJ = ele_increments[(i*5) + 0];
            // int ele_incrementF = ele_increments[(i*5) + 1];
            // int ele_incrementP = ele_increments[(i*5) + 2];
            // int ele_incrementG = ele_increments[(i*5) + 3];

            int sum = ele_increments[(i*5) + 0] + ele_increments[(i*5) + 1] + ele_increments[(i*5) + 2] + ele_increments[(i*5) + 3];
            int ele_incrementZ = ele_increments[(i*5) + 4];

            //6-b-1
            for(uint j = 0 ; j < 5 ; j++) {
                if(ele_increments[(i * 5) + j] != abs(start_values[(i * 5) + j]-end_values[(i * 5) + j])) {
                    return (false , strConcat("电能示值的组合误差不合格1", uint2str((i * 5) + j)) , 0);
                }
            }

            //6-b-2
            if(value_conc_codes[i] != (ele_incrementZ - sum)) {
                return (false , strConcat("电能示值的组合误差不合格2",uint2str(i)) , 0);
            }
        }

        //7
        uint index1;
        uint index2;
        for(uint i = 0 ; i < demand_value_err.length ; i++) {
            if(load_current[i] == bytes32("0.1In")) {
                index1 = 0;
                if(hashCompareInternal(ap_pre_level_code , "0.5S级")) {
                    index2 = 0;
                }else if(hashCompareInternal(ap_pre_level_code , "1级")) {
                    index2 = 1;
                }

            }
            if(load_current[i] == bytes32("In")) {
                index1 = 1;
                if(hashCompareInternal(ap_pre_level_code , "0.5S级")) {
                    index2 = 0;
                }else if(hashCompareInternal(ap_pre_level_code , "1级")) {
                    index2 = 1;
                }

            }
            if(load_current[i] == bytes32("Imax")) {
                index1 = 2;
                if(hashCompareInternal(ap_pre_level_code , "0.5S级")) {
                    index2 = 0;
                }else if(hashCompareInternal(ap_pre_level_code , "1级")) {
                    index2 = 1;
                }
            }

            if(demand_value_err[i] > c1[index1][index2] || demand_value_err[i] < -c1[index1][index2]) {
                return (false , "检查需量示值误差不合格" , 0 );
            }
        }


        return (true , "审核成功" ,1 );
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
