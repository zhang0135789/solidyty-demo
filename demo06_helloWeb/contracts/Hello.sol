//SPDX-License-Identifier: MIT
pragma solidity >= 0.5.1 < 0.7.0;

//import "https://github.com/Arachnid/solidity-stringutils/strings.sol";
import "./StringUtils.sol";

contract Hello {

  string str = "Hello " ;

  constructor() public {
  }

  //public: 函数访问属性(后续文章为详细阐述)
  //returns (string): 定义返回值类型为string
  function say(string memory name) public view returns (string memory) {
    // solidity语言不支持 字符串拼接
//    return str + name;
    //需要引入第三方库来解决
    return StringUtils.strConcat(str , name);
  }




}
