const ExampleContract = artifacts.require("ExampleContract");
const ExampleRandom = artifacts.require("ExampleRandom");


module.exports = function (deployer) {
  deployer.deploy(ExampleContract);
  deployer.deploy(ExampleRandom);

};
