const hre = require("hardhat");

async function main() {
  const BlockHashVerifier = await hre.ethers.getContractFactory("BlockHashVerifier");
  const blockHashVerifier = await BlockHashVerifier.deploy();

  await blockHashVerifier.deployed();

  console.log("BlockHashVerifier deployed to:", blockHashVerifier.address);
}

// Recommended pattern to use async/await everywhere and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
