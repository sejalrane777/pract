
const { ethers } = require("hardhat");
async function main() {
  const Coin = await ethers.getContractFactory("nUSD");
  const coin = await Coin.deploy();
  console.log("Contract deployed to address:", coin.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

  //0xefD6183f7F265A382fd4D75042c9a05cBFe66c58