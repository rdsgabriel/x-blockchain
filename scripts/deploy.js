const main = async () => {
  const [owner] = await hre.ethers.getSigners();
  const accountBalance = await owner.provider.getBalance(owner.address);

  console.log("Deploy do contrato feito por:", owner.address);
  console.log("Saldo da conta:", accountBalance.toString());

  const xPost = await hre.ethers.deployContract("XPost");
  await xPost.waitForDeployment();

  console.log("Deploy do contrato no endereço:", xPost.target);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
