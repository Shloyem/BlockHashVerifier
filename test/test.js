const { expect } = require("chai");
const data = require('./data');

describe("BlockHash", function () {
    it("Should verify block header hash matches the real block hash", async function () {
      // arrange
      const BlockHashVerifier = await ethers.getContractFactory("BlockHashVerifier");
      const blockHashVerifier = await BlockHashVerifier.deploy();
      await blockHashVerifier.deployed();

      // act
      const block = data.blockmock.header;
      const hash = await blockHashVerifier.getBlockHash(block);
      console.log(`After calculating hash: ${hash}`);

      // assert
      expect(hash).to.equal(block.hash);
    });
  });
