const RedCrossVault = artifacts.require("RedCrossVault");

module.exports = function (deployer) {
  deployer.deploy(RedCrossVault);
};
