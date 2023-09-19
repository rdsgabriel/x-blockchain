require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    staging: {
      url: "https://eth-sepolia.g.alchemy.com/v2/AvopbILk-uYvfVYj8bbZEV_pbxOuZd_c",
      accounts: ["5ae64df0f14260a3ac10a5eb8871dda00b67ffe39ba2669511868e2a2e6eda5a"],
    },
  }
};
