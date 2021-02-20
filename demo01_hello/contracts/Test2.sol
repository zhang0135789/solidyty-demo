pragma solidity 0.5.10;




library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}


contract Test2 {
    constructor() public {
    }


    //1.1整型 幂运算
    function exponentiation() public returns(uint) {
        uint a = 10;

        return a**2;
    }

    //1.2 整型  位运算
    function bitwise() public returns(uint) {
        uint a = 2;
        return a >> 2;
    }

    //1.3 整型 异或运算
    function exclusive() public returns(uint, uint) {
        uint a = 1;
        uint b = 2;
        a = a ^ b;
        b = b ^ a;
        a = a ^ b;
        return (a,b);
    }

    //1.4 uint8  1111 1111
    function testInt8() public returns(uint,uint){
        uint8 a = 255;
        uint8 b = 254;
        return (a + 1 , b + 1);
    }


    //2 地址类型
    // 1ether = 1e3 finny  1finny = 1e3szabo 1szabo = 1e12wei
    // assert(1 wei == 1);
    // assert(1 gwei == 1e9);
    // assert(1 ether == 1e18);
    function sendToaddress(address payable _to) public payable returns(uint) {
        uint balance = address(this).balance;

        //向地址_to发送  Wei 以太币
        _to.transfer(balance);

        return address(this).balance;
    }

    function getBalance() public view returns(uint) {
        return msg.sender.balance;
    }

    uint public money;
    //payable
    function buy() public payable{
        assert(msg.value > 0);
        money += msg.value;
    }


    //3.1 内置 hashyunsuan运算方法
    bytes32 public name = keccak256("laozeng");

    //4 合约自毁 selfdestruct
    function kill() public  {
        //合约自毁，并退回合约中的代币
        selfdestruct(msg.sender);
    }

    //5. 合约外部调用
    User user;
    function createUser() public returns(address) {
        User u = new User();
        return address(u);
    }
    function setUser(User _addr) public {
        user = _addr;
    }
    function callUser() public returns(uint){
        return user.age();
    }

    //6.创建合约 -提前计算出合约地址
    function createDSalted(bytes32 _salt, uint arg) public returns(address,address){
        /// 这个复杂的表达式只是告诉我们，如何预先计算地址。
        /// 这里仅仅用来说明。
        /// 实际上，你仅仅需要 ``new D{salt: salt}(arg)``.
        address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(abi.encodePacked(
                    type(User).creationCode
                ))
            )))));

        // User d = new User{salt:_salt}();
        // require(address(d) == predictedAddress , "not same");
        return (predictedAddress , predictedAddress);
    }



    //7. library 的使用
    using SafeMath for uint;
    function testLibrary() public returns(uint){
        uint a = 1;
        return a.add(2);
    }


    //8.



}


contract User {
    constructor() public {
    }

    function age() external returns(uint) {
        return 27;
    }

    function info() public payable returns (uint) {
        return 42;
        // return age();
    }


}
