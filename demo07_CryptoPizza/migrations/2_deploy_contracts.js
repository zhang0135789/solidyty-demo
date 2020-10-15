const CryptoPizza = artifacts.require("CryptoPizza");

module.exports = function(deployer) {
  deployer.deploy(CryptoPizza);
};
