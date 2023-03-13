// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DonorVesting {
    IERC20 public donorToken;
    bool public initialized;


    uint256 constant public ONE_DAY = 1 days;

    address public rewardAddress;
    address public teamAddress;
    address public seedInvestorAddress;
    address public ecosystemAddress;
    address public saleAddress;
    address public marketingAddress;
    address public reserveAddress;




    uint256 public teamTokens;
    uint256 public teamClaimTime;
    uint256 public remainingTeamInstallments;
    uint256 public totalTeamInstallments;



    uint256 public seedInvestorToken;
    uint256 public seedInvestorClaimTime;
    uint256 public remainingSeedInvestorInstallments;
    uint256 public totalSeedInvestorInstallments;


    uint256 public ecoSystemToken;
    uint256 public ecoSystemClaimTime;
    uint256 public remainingEcoSystemInstallments;
    uint256 public totalEcoSystemInstallments;




    uint256 public marketingToken;
    uint256 public marketingClaimTime;
    uint256 public remainingMarketingInstallments;
    uint256 public totalMarketingInstallments;










    function initialize(
        IERC20 _donorToken,
        address _rewardAddress,
        address _teamAddress,
        address _seedInvestorAddress,
        address _ecosystemAddress,
        address _saleAddress,
        address _marketingAddress,
        address _reserveAddress
    ) public {
        require(!initialized, "already initialized");
        donorToken = _donorToken;
        rewardAddress = _rewardAddress;
        teamAddress = _teamAddress;
        seedInvestorAddress = _seedInvestorAddress;
        ecosystemAddress = _ecosystemAddress;
        saleAddress = _saleAddress;
        marketingAddress = _marketingAddress;
        reserveAddress = _reserveAddress;
        initializeTokenDistribution();
        initialized = true;
    }


     function initializeTokenDistribution() internal{
         
        uint256 totalAmount = donorToken.balanceOf(address(this));
        donorToken.transfer(rewardAddress, totalAmount*600/1000);
        donorToken.transfer(saleAddress, totalAmount*60/1000);
        donorToken.transfer(reserveAddress, totalAmount*100/1000);

        teamTokens =totalAmount*100/1000;
        teamClaimTime = block.timestamp + (ONE_DAY*356);
        remainingTeamInstallments  = 12;
        totalTeamInstallments = 12;


        seedInvestorToken =totalAmount*50/1000;
        seedInvestorClaimTime = block.timestamp + (ONE_DAY*356);
        remainingSeedInvestorInstallments  = 12;
        totalSeedInvestorInstallments = 12;




        ecoSystemToken = totalAmount*50/1000;
        ecoSystemClaimTime = block.timestamp + (ONE_DAY*90);
        totalEcoSystemInstallments = 36;
        remainingEcoSystemInstallments  = 36;



        marketingToken =  totalAmount*40/1000;
        marketingClaimTime =  block.timestamp + (ONE_DAY*30);
        totalMarketingInstallments = 12;
        remainingMarketingInstallments = 12;

    

     }



    function claimTeamTokens() public {
        require(teamClaimTime < block.timestamp,"Time has not reached");
        require(remainingTeamInstallments >0,"Team has claimed all tokens");
        teamClaimTime =  block.timestamp + (ONE_DAY*30);
        remainingTeamInstallments = remainingTeamInstallments-1;
        donorToken.transfer(teamAddress, teamTokens/totalTeamInstallments);

    }


    function claimInvestorTokens() public {
        require(seedInvestorClaimTime < block.timestamp,"Time has not reached");
        require(remainingSeedInvestorInstallments >0,"Investor has claimed all tokens");
        seedInvestorClaimTime =  block.timestamp + (ONE_DAY*30);
        remainingSeedInvestorInstallments = remainingSeedInvestorInstallments-1;
        donorToken.transfer(seedInvestorAddress, seedInvestorToken/totalSeedInvestorInstallments);

    }




    function claimMarketingTokens() public {
        require(marketingClaimTime < block.timestamp,"Time has not reached");
        require(remainingMarketingInstallments >0,"Marketing has claimed all tokens");
        marketingClaimTime =  block.timestamp + (ONE_DAY*30);
        remainingMarketingInstallments = remainingMarketingInstallments-1;
        donorToken.transfer(marketingAddress, marketingToken/totalMarketingInstallments);

    }


    function claimEcosystemTokens() public {
        require(ecoSystemClaimTime < block.timestamp,"Time has not reached");
        require(remainingEcoSystemInstallments >0,"Ecosystem has claimed all tokens");
        ecoSystemClaimTime =  block.timestamp + (ONE_DAY*30);
        remainingEcoSystemInstallments = remainingEcoSystemInstallments-1;
        donorToken.transfer(ecosystemAddress, ecoSystemToken/totalEcoSystemInstallments);

    }

}


