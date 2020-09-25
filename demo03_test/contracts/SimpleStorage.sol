//SPDX-License-Identifier: MIT
pragma solidity >= 0.4.0 < 0.7.0;

contract SimpleStorage {

    constructor() public {
    }

    // 定义一个在合约中定义魂村数据
    uint storageData;

    // 设置缓存数据
    function set(uint x) public {
        storageData = x;
    }

    // 获取缓存数据
    // 如果storageData 用 public 修饰,就不需要get方法,系统会自带获取storageData的方法
    function get() public view returns (uint) {
        return storageData;
    }


}
