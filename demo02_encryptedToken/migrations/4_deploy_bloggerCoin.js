var BloggerCoin = artifacts.require('./BloggerCoin.sol');

module.exports = function(deployer) {
    deployer.deploy(BloggerCoin);
}
