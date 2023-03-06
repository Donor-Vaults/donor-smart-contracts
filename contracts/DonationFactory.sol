pragma solidity ^0.8.15;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Campaign.sol";

contract DonationFactory is Ownable {
    address public baseToken;
    address[] public campaigns;

    address public teamWallet;
    address public burningWallet;
    address public rewardWallet;



    event onCreateCampaign(address campaginAddress);

    constructor(address _baseToken,
    address _teamWallet,
    address _burningWallet,
    address _rewardWallet
    ) {
        baseToken = _baseToken;
        rewardWallet = _rewardWallet;
        burningWallet = _burningWallet;
        teamWallet = _teamWallet;
    }


    function changeRewardWallet(address newAddress) public onlyOwner{
        rewardWallet = newAddress;
    }


    function changeTeamWallet(address newAddress) public onlyOwner{
        teamWallet = newAddress;
    }

    function changeBurningWallet(address newAddress) public onlyOwner{
        burningWallet = newAddress;
    }

    function setBaseToken(address newBaseToken) public onlyOwner {
        baseToken = newBaseToken;
    }

    function createCampaign() public {
        Campaigns campaign = new Campaigns(msg.sender);
        campaigns.push(address(campaign));
        emit onCreateCampaign(address(campaign));
    }

    function totalCampaignsLength() public view returns (uint256) {
        return campaigns.length;
    }
}
