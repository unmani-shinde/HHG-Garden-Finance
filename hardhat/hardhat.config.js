/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require('@nomiclabs/hardhat-ethers');
require("@nomiclabs/hardhat-waffle");
require("@nomicfoundation/hardhat-ignition");
require('dotenv').config();
require("hardhat-deploy");



module.exports = {
   defaultNetwork: 'core',
   networks: {
      hardhat: {
      },
      core: {
         url: 'https://rpc.test.btcs.network',
         accounts: [process.env.DEPLOYER_PRIVATE_KEY],
         chainId: 1115,
      },
      sepolia:{
        url: 'https://rpc2.sepolia.org',
        accounts: [process.env.DEPLOYER_PRIVATE_KEY],
        chainId: 11155111,
      }
   },
   solidity: {
    version: "0.8.20",

    settings: {
      optimizer: {
        enabled: true,
        runs: 400,
      }
    }
  },
   paths: {
      sources: './contracts',
      cache: './cache',
      artifacts: './artifacts',
   },
   mocha: {
      timeout: 20000,
   },
};