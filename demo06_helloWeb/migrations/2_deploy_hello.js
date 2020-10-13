//artifacts对象为truffle框架提供
//artifacts.require()方法与Node中的require()方法类似
//编译合约代码。自动调用solc编译器来编译合约代码并返回编译结果对象
const stringsContract = artifacts.require("./StringUtils.sol");
const HelloContract = artifacts.require("./Hello.sol");


//部署器对象deployer为truffle框架提供
module.exports = function(deployer) {
  //部署string.sol合约
  deployer.deploy(stringsContract);
  //将已部署的strings合约类库连接到Hello合约
  deployer.link(stringsContract, HelloContract);
  //部署Hello.sol合约
  deployer.deploy(HelloContract);
};
