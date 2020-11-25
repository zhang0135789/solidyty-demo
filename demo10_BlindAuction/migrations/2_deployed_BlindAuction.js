const BlindAuction = artifacts.require("BlindAuction");

module.exports = function (deployer) {
  deployer.deploy(BlindAuction);
};
