const DonationFactory = artifacts.require("DonationFactory");
const BUSD = artifacts.require("BUSD");
module.exports = async function (deployer) {

  const rewardWallet = "0xd34e2294289bc709D8d62Ae23235346279741066";
  const teamWallet = "0xd34e2294289bc709D8d62Ae23235346279741066";
  const burnWallet = "0xd34e2294289bc709D8d62Ae23235346279741066";

  // await deployer.deploy(BUSD);
  await deployer.deploy(DonationFactory,
    "0xe9e7cea3dedca5984780bafc599bd69add087d56",
    teamWallet,
    burnWallet,
    rewardWallet,
    );
};
