const SimpleAuction = artifacts.require("SimpleAuction");

module.exports = function (deployer) {


  deployer.deploy(SimpleAuction , 1000  , "0xdc1e01560B80790B9be0E798Cf915FF797E13d70" );
};
