const main = async () => {
  const [owner] = await hre.ethers.getSigners();
  const xPost = await hre.ethers.deployContract("XPost");
  await xPost.waitForDeployment();

  console.log("Deploy do contrato no endereço:", xPost.target);
  console.log("Deploy do contrato feito por:", owner.address);

  await xPost.getTotalPosts();

  const waveTxn = await xPost.createPost();
  await waveTxn.wait();

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
