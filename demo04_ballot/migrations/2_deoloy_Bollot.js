const Ballot = artifacts.require("Ballot");

module.exports = function (deployer) {
  deployer.deploy(
      Ballot ,
      ["Nick", "Rama", "Jose"].map(x => web3.utils.asciiToHex(x))
      );
};





