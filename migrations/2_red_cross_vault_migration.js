const RedCrossVault = artifacts.require("RedCrossVault");

module.exports = function (deployer) {
  deployer.deploy(RedCrossVault, "0x610178dA211FEF7D417bC0e6FeD39F05609AD788");
};
