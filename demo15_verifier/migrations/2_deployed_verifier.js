const VerifierTesting = artifacts.require("VerifierTesting");

module.exports = function (deployer) {
  deployer.deploy(VerifierTesting);
};
