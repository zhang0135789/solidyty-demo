var Test = artifacts.require("Test");
var Test2 = artifacts.require("Test2");

module.exports = function(deployer) {
  deployer.deploy(Test);
  deployer.deploy(Test2);
};
