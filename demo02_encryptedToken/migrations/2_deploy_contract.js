var EncryptedToken = artifacts.require('./EncryptedToken.sol');
module.exports = function (deployer) {
    deployer.deploy(EncryptedToken);
}
