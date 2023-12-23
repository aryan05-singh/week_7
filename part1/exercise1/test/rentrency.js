const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EtherStore", function () {
  let etherStore;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();

    const EtherStore = await ethers.getContractFactory("EtherStore");
    etherStore = await EtherStore.deploy();
    await etherStore.deployed();
  });

  it("Should deposit and withdraw ether", async function () {
  
    const depositAmount = ethers.utils.parseEther("1");
    await etherStore.deposit({ value: depositAmount });

    
    const contractBalanceBefore = await etherStore.getBalance();
    expect(contractBalanceBefore).to.equal(depositAmount);

    await etherStore.withdraw();

   
    const contractBalanceAfter = await etherStore.getBalance();
    expect(contractBalanceAfter).to.equal(0);

 
    const userBalanceAfter = await ethers.provider.getBalance(owner.address);
    expect(userBalanceAfter.gt(depositAmount)).to.be.true;
  });

  it("Should not allow withdrawal when locked", async function () {
  
    const depositAmount = ethers.utils.parseEther("1");
    await etherStore.deposit({ value: depositAmount });

 
    await etherStore.withdraw();

    
    await expect(etherStore.withdraw()).to.be.revertedWith("Locked");
  });
});
