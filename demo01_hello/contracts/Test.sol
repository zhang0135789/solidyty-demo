pragma solidity ^0.5.10;


contract Test {

    constructor() public {
        age[0] = 17;
        age[1] = 15;

    }

    //1.函数修饰符
    // 存储用户年龄的映射
    mapping(uint => uint) public age;

    // 限定用户年龄的修饰符
    modifier olderThan(uint _age, uint _userId) {
        require(age[_userId] >= _age, "not driving");
        _;
    }
    // 必须年满16周岁才允许开车 (至少在美国是这样的).
    // 我们可以用如下参数调用`olderThan` 修饰符:
    function driveCar(uint _userId) public payable olderThan(16, _userId) returns (uint) {
        // 其余的程序逻辑
        return _userId;
    }


    //1.数据操作
    uint value;
    //两个uint相加
    function add(uint _x, uint _y) public returns (uint){
        value = _x + _y;
        return value;
    }
    //两数相除
    function divide(uint _x, uint _y) public returns (uint){
        value = _x / _y;
        return value;
    }


    //3.地址
    function getBalance(address _account) public returns (uint) {
        return _account.balance;
    }

    //4.数组
    uint[] a = new uint[](3);//注意在括号里写length
    int b;

    function extendArr() public returns(uint){
        //在后面追加元素
        a.push(1);//可以通过push动态扩大长度
        a.push(2);
        a.push(3);
        a.pop();//删除末尾元素

        return a.length;//数组长度
    }

    uint[] unitArray;
    bytes b4;
    function arrayPush() public returns (uint) {
        uint[3] memory a = [uint(1), 2, 3];
        unitArray = a;
        return unitArray.push(6);
    }
    function bytesPush() public returns (uint){
        b4 = new bytes(3);
        return b4.length;
    }

    //5.映射
    mapping(address => uint) public balances;
    uint balance;
    function updateBalance(uint _amount) public returns(uint) {
        balances[msg.sender] = _amount;
        balance = balances[msg.sender];
        return balance;
    }

    //6.合约外部调用
    User user;
    function exfunction() public returns (address){
        address addr = address(0xE5f2A565Ee0Aa9836B4c80a07C8b32aAd7978e22);
        user = User(addr);
        return addr;
    }
    function callUser() public returns (uint){
        return user.age();
    }

    //7.命名参数调用
    function add(uint _first, uint _second) public returns (uint, uint) {
        return (_first, _second);
    }

    function callAdd() public returns (uint, uint) {
        return add({_second : 2, _first : 1});
    }

    //7.命名参数调用
    function add(uint _first , uint _second) public returns(uint ,uint) {
        return (_first , _second);
    }

    function callAdd() public returns (uint ,uint) {
        return add({_second : 2 , _first : 1});
    }

    //8函数可见性
    function func(uint _a) private returns(uint b){
        return _a + 1;
    }
    function setData(uint _a) internal {
        data = _a;
    }
    uint public data;

    //9.时间处理
    function f(uint _start , uint _daysAfter) public returns(bool) {
        if(now >= _start + _daysAfter * 1 days) {
            return true;
        }
        return false;
    }

    //10.事件
    event LogSender(address);
    function eventTest() public  {
        address sender = msg.sender;
        emit LogSender(sender);
    }

    //11.结构体
    struct Student {
        uint age;
        string name;
    }
    Student[] public students;

    function setStudent( uint _age , string memory _name) public{
        Student memory stu = Student(_age , _name);
        students.push(stu);
        }

    //12.枚举
    enum State { Created, Locked, Inactive } // 枚举
    State public state;

    function setState(State _state) public {
        state = _state;
    }






    //合约参数限制 16个参数 超过16个参数,编译报错
    function fun(
        uint m2,
        uint m3,
        uint m4,
        uint m5,
        uint m6,
        uint m7,
        uint m8,
        uint m9,
        uint m10,
        uint m11,
        uint m12,
        uint m13,
        uint m14,
        uint m15,
        uint m16
    ) public returns(bool m1){
        uint a;
        uint b;
    }


}

contract User {
    function age() external returns (uint) {
        return 26;
    }
}

