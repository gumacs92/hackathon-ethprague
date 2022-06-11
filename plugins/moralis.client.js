import Moralis from 'moralis'
// import Web3 from 'web3'
// import Web3 from 'web3'
// import { ethers } from 'ethers'
export default async function ({ $config }) {
  console.log('hello')
  await Moralis.start({ appId: $config.moralisAppId, serverUrl: $config.moralisServerUrl })
  await Moralis.enableWeb3()
  //  await Moralis.initPlugins()
}
