
const Hzwq = artifacts.require("Hzwq");

const Hzwq2 = artifacts.require("Hzwq2");

const Hzwq3 = artifacts.require("Hzwq3");

const Hzwq4 = artifacts.require("Hzwq4");



module.exports = function (deployer) {
  deployer.deploy(Hzwq);
  deployer.deploy(Hzwq2);
  deployer.deploy(Hzwq3);
  deployer.deploy(Hzwq4);



};
