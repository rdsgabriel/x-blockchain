const main = async () => {
  const [owner] = await hre.ethers.getSigners();
  const xPost = await hre.ethers.deployContract("XPost", {
    value: hre.ethers.parseEther("0.1"),
  });
  await xPost.waitForDeployment();

  console.log("Deploy do contrato no endereço:", xPost.target);
  console.log("Deploy do contrato feito por:", owner.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    xPost.target
  );
  console.log(
    "Saldo do contrato:",
    hre.ethers.formatEther(contractBalance)
  );

  const postTxn = await xPost.createPost("Enviando o post #1");
  await postTxn.wait();

  contractBalance = await hre.ethers.provider.getBalance(xPost.target);
  console.log(
    "Saldo do contrato após um post ser criado:",
    hre.ethers.formatEther(contractBalance)
  );

  await xPost.getTotalPosts();
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
