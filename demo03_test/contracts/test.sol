pragma solidity ^0.4.4;
contract TxHashAccessor {
    function getHash() returns(bytes32);
}
contract Tracidence {

    /***********************************************************************************************************************
                                                            存证溯源写入
     **********************************************************************************************************************/

    struct Evidence {
        bytes32 _id;        // 编号
        bytes32 _bytes32;   // hash
        uint _uint;         // 时间戳
        address _address;   // 所有权
        bytes32 _index;     // 索引
    }

    mapping(bytes32 => mapping(bytes32 => bytes32))  evidenceIndexMap;  // 场景值+索引2最新编号
    mapping(bytes32 => mapping(bytes32 => Evidence))  evidenceMap;      // 场景值+编号2实体
    mapping(bytes32 => bytes32[]) evidenceListMap;                      // 场景值2编号

    mapping(bytes32 => mapping(address=>bytes32[])) personMap;          // 存证映射, 用户的存证列表
    mapping(bytes32 => mapping(bytes32=>bytes32[])) traceMap;           // 溯源映射, 产品的溯源历史列表

    /**
     * 存储数据 - 存证无溯源
     * bytes32Array: serType, 主键, md5index, mark 角色列表,
     * uintArray： 角色数量n，时间
     */
    function postWithoutTrace(bytes32 serType,bytes32 id,bytes32 md5index,bytes32 index, uint _time) returns (uint, bytes32[]) {
        uint b = 0;
        // 交易哈希处理
        TxHashAccessor hasher = TxHashAccessor(0x00000000000000000000000000000000000000fa);
        bytes32 txhash = hasher.getHash();

        // 存储主键
        evidenceListMap[serType].push(id);
        evidenceIndexMap[serType][md5index] = id;
        indexToIdMap[serType][md5index].push(md5index);
        // 存储数据
        evidenceMap[serType][id] = _createEvidence(id, txhash, index, _time);
        // 组装返回数据
        // 初始化数组
        _initArrayReturn();
        _bytes32ArrayReturn.push(id);
        _bytes32ArrayReturn.push(index);
        return(SUCCESS, _bytes32ArrayReturn);
    }
    /***********************************************************************************************************************
                                                            数据查询
     **********************************************************************************************************************/

    /**
     * 查询某存证是否存在 - 利用编号查
     * uintArray  0:是否进行权限判断;
     * bytes32Array: 0: serType, 1: 编号，2: 权限角色
     */
    function getEvidenceWithId(uint[] uintArray, bytes32[] bytes32Array) returns (uint, uint[], int[], address[], bytes32[]) {
        // 初始化数组
        _initArrayReturn();
        // todo 查存证数组，不是溯源数组 - 存证溯源id不一样
        if (evidenceMap[bytes32Array[0]][bytes32Array[1]]._id == 0x0) {
            return(NODATA, new uint[](0), new int[](0), new address[](0), new bytes32[](0));
        }
        createReturnArray(evidenceMap[bytes32Array[0]][bytes32Array[1]]);
        return(SUCCESS, _uintArrayReturn, _intArrayReturn, _addressArrayReturn, _bytes32ArrayReturn);
    }

    /**
    * 查询存证列表是否存在 - 利用编号查
    * uintArray : 0: start, 1: end, 2：page；3：pageSize; 4: 是否进行权限判断；
    * bytes32Array: 0: serType, 1: 编号
    */
    function getEvidenceWithIds(uint[] uintArray, bytes32[] bytes32Array) returns (uint, uint, uint[], int[], address[], bytes32[]) {
        // 初始化数组
        _initArrayReturn();
        bytes32 serType = bytes32Array[0];
        for (uint b = 1; b < bytes32Array.length; b++){
            if (evidenceMap[serType][bytes32Array[b]]._id != 0x0) {
                _tmpEvidenceArray.push(evidenceMap[serType][bytes32Array[b]]);
            }
        }
        return(SUCCESS, dealEvidenceArray(_tmpEvidenceArray, uintArray), _uintArrayReturn, _intArrayReturn, _addressArrayReturn, _bytes32ArrayReturn);
    }

    /**
    * 查询某存证是否存在 - 利用索引查
    * uintArray  0:是否进行权限判断;
    * bytes32Array: 0: serType, 1: 索引，2: 权限角色
    */
    function getEvidenceWithIndex(uint[] uintArray, bytes32[] bytes32Array) returns (uint, uint[], int[], address[], bytes32[]) {
        // 初始化数组
        _initArrayReturn();
        bytes32 id = evidenceIndexMap[bytes32Array[0]][bytes32Array[1]];
        // todo 查存证数组，不是溯源数组 - 存证溯源id不一样
        if (evidenceMap[bytes32Array[0]][id]._id == 0x0) {
            return(NODATA, new uint[](0), new int[](0), new address[](0), new bytes32[](0));
        }
        createReturnArray(evidenceMap[bytes32Array[0]][id]);
        return(SUCCESS, _uintArrayReturn, _intArrayReturn, _addressArrayReturn, _bytes32ArrayReturn);
    }

    /***********************************************************************************************************************
                                                            全局常量
     **********************************************************************************************************************/

    // 返回代码常量：成功（0）
    uint constant SUCCESS = 0;
    // 返回代码常量：没权限（2）
    uint constant NOAUTH = 2002;
    // 数据不存在
    uint constant NODATA = 2003;
    // 数据已存在
    uint constant DATA_EXIST = 2004;



    // 权限级别
    uint constant PERMISSION_USER = 0;
    uint constant PERMISSION_ROLE = 1;

    // 类别
    uint constant ADD = 0;
    uint constant DELETE = 1;

    // 是否需要进行权限判断
    uint constant NOT_NEED_AUTH = 0;
    uint constant NEED_AUTH = 1;



    /***********************************************************************************************************************
                                                            内部方法
     **********************************************************************************************************************/

    bytes32[] _bytes32ArrayReturn;

    uint[] _uintArrayReturn;

    int[] _intArrayReturn;

    address[] _addressArrayReturn;

    Evidence[] _tmpEvidenceArray;

    uint[] _tmpStack;

    function _initArrayReturn() internal {
        _bytes32ArrayReturn.length = 0;
        _uintArrayReturn.length = 0;
        _intArrayReturn.length = 0;
        _addressArrayReturn.length = 0;
        _tmpEvidenceArray.length = 0;
    }

    function _deleteArrayElement(address[] storage array, address element) internal {
        uint length = array.length;
        for (uint i = 0; i < length; ++i) {
            if (array[i] == element) {
                array[i] = array[length - 1];
                array.length -= 1;
                return;
            }
        }
    }

    function _deleteArrayElement(bytes32[] storage array, bytes32 element) internal {
        uint length = array.length;
        for (uint i = 0; i < length; ++i) {
            if (array[i] == element) {
                array[i] = array[length - 1];
                array.length -= 1;
                return;
            }
        }
    }

    function _pushEvidenceArrayElement(Evidence[] storage array, Evidence[] element) internal {
        uint length = element.length;
        for (uint i = 0; i < length; ++i) {
            array.push(element[i]);
        }
    }

    function _getArrayElement(bytes32[] storage array, uint index, uint elementLength) internal returns (bytes32[]) {
        bytes32[] memory element = new bytes32[](elementLength);
        for (uint i = 0; i < elementLength; ++i) {
            element[i] = array[index * elementLength + i];
        }
        return element;
    }

    // 组装存证溯源结构体
    function _createEvidence(bytes32 id, bytes32 txhash, bytes32 index, uint u) internal returns (Evidence e) {
        Evidence memory evidenceRet;
        evidenceRet._id = id;
        evidenceRet._bytes32 = txhash;
        evidenceRet._index = index;
        evidenceRet._uint = u;
        evidenceRet._address = msg.sender;
        return evidenceRet;
    }

    // 处理存证溯源数据， 0: start, 1: end, 2：page；3：pageSize; 4: 是否进行权限判断；
    // bytes32 0: serType, 1: 权限角色
    function dealEvidenceArray(Evidence[] storage array, uint[] uintArray) internal returns (uint){
        // 处理范围
        // todo 结尾为null，开头不为null则查询至结尾 - 处理好了
        uint start = 0;
        // todo 处理end 出现负数的情况
        uint end = _tmpEvidenceArray.length - 1 >= 0 ? _tmpEvidenceArray.length - 1 : 0;
        if (uintArray[0] != 0) {
            // 二分查范围, 找到大于等于该数字的下标
            start = _binSearchEvidenceArray(_tmpEvidenceArray, uintArray[0]);
            // 处理没有在start - end 范围内的值
            if (_tmpEvidenceArray[start]._uint < uintArray[0]) { return 0; }
        }
        if (uintArray[1] != 0) {
            end = _binSearchEvidenceArray(_tmpEvidenceArray, uintArray[1]);
            // 处理没有在start - end 范围内的值
            if (_tmpEvidenceArray[end]._uint > uintArray[1]) { return 0; }
            // 处理结尾大于情况
            if (_tmpEvidenceArray[end]._uint > uintArray[1]) end--;
        }

        // 处理分页
        uint total = _tmpEvidenceArray.length;
        if (uintArray[2] != 0 && uintArray[3] != 0) {
            total = getEvidenceWithPagingInner(uintArray[2], uintArray[3], start, end);
        }
        else {
            total = getEvidenceWithoutPagingInner(start, end);
        }
        return (total);
    }

    // 查询存证数据分页方法
    function getEvidenceWithPagingInner(uint _page, uint _pageSize, uint _start, uint _end) internal returns(uint){
        // 获取page~pageSize范围的存证数据
        for (uint k = _start + (_page - 1) * _pageSize; k < _start + _page * _pageSize && k <= _end && k < _tmpEvidenceArray.length; k++) {
            createReturnArray(_tmpEvidenceArray[k]);
        }
        return(_uintArrayReturn.length);
    }

    // 查询存证数据不分页方法
    function getEvidenceWithoutPagingInner(uint _start, uint _end) internal returns(uint){
        for (uint k = _start; k < _tmpEvidenceArray.length && k <= _end; k++) {
            createReturnArray(_tmpEvidenceArray[k]);
        }
        return(_uintArrayReturn.length);
    }

    // 组装返回数组
    function createReturnArray(Evidence storage evidenceRet) internal{
        _bytes32ArrayReturn.push(evidenceRet._id);
        _bytes32ArrayReturn.push(evidenceRet._bytes32);
        _bytes32ArrayReturn.push(evidenceRet._index);
        _uintArrayReturn.push(evidenceRet._uint);
        _addressArrayReturn.push(evidenceRet._address);
    }

    /***********************************************************************************************************************
                                                            二分查找
     **********************************************************************************************************************/

    function _binSearchEvidenceArray(Evidence[] storage array, uint key) internal returns(uint){
        if (array.length == 0) {
            return 0;
        }
        uint left = 0;
        uint right = array.length - 1 >= 0 ? array.length - 1 : 0;
        if (array[right]._uint < key) {
            return right;
        }
        if (array[left]._uint > key) {
            return left;
        }
        while(left <= right) {
            uint mid = left + ((right-left)>>1);
            if(array[mid]._uint == key) { return mid; }
            else if (array[mid]._uint < key){ left = mid + 1; }
            else { right = mid - 1;}
        }
        return left;
    }
    /***********************************************************************************************************************
                                                                合约升级改动
     **********************************************************************************************************************/
    mapping(bytes32 => mapping(bytes32=>bytes32[])) indexToIdMap;           // 存证索引值对应的id列表，以解决相同md5无法存证问题

    /**
      * 判断数组中是否包含指定字符串
      */
    function _isElementExistInArray(bytes32[] storage array, bytes32 content) internal returns (uint) {
        for (uint i = 0; i < array.length; ++i) {
            if(array[i] == content){
                return 1; //存在
            }
        }
        return 0; // 不存在
    }

    /**
      * 查询利用索引查存证列表
      * uintArray  0:是否进行权限判断;
      * bytes32Array: 0: serType, 1: 索引，2: 权限角色
      */
    function getEvidenceWithIndexs(uint[] uintArray, bytes32[] bytes32Array) returns (uint,uint, uint[], int[], address[], bytes32[]) {
        // 初始化数组
        _initArrayReturn();
        // 判断该索引是否有数据
        if (evidenceMap[bytes32Array[0]][id]._id == 0x0) {
            return(NODATA,0, new uint[](0), new int[](0), new address[](0), new bytes32[](0));
        }
        bytes32 id = evidenceIndexMap[bytes32Array[0]][bytes32Array[1]];
        // 兼容之前合约
        if(_isElementExistInArray(indexToIdMap[bytes32Array[0]][bytes32Array[1]], id)==0){
            _tmpEvidenceArray.push(evidenceMap[bytes32Array[0]][id]);
        }

        // 索引对应id的映射列表
        for(uint k=0;k<indexToIdMap[bytes32Array[0]][bytes32Array[1]].length;k++){
            id = indexToIdMap[bytes32Array[0]][bytes32Array[1]][k];
            _tmpEvidenceArray.push(evidenceMap[bytes32Array[0]][id]);
        }
        return (SUCCESS, dealEvidenceArray(_tmpEvidenceArray, uintArray), _uintArrayReturn, _intArrayReturn, _addressArrayReturn, _bytes32ArrayReturn);
    }
}
