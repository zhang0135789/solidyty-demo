const Score = artifacts.require("Score");

module.exports = function (deployer) {
  deployer.deploy(Score);
};
