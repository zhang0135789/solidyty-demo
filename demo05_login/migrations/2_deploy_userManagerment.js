const UserManagerment = artifacts.require("UserManagerment");

module.exports = function (deployer) {
  deployer.deploy(UserManagerment);
};
