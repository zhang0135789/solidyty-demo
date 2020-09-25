var Coin = artifacts.require('./Coin.sol');

module.exports = function(deployer) {
    deployer.deploy(Coin);
}
