pragma solidity ^0.8.15;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface IFactory {
    function owner() external view returns (address);
    function baseToken() external view returns (address);
    function teamWallet() external view returns (address);
    function burningWallet() external view returns (address);
    function rewardWallet() external view returns (address);



}

contract Campaigns {

    using SafeERC20 for IERC20;

   
    IFactory public immutable factory;
    IERC20 public immutable baseToken;

    uint256 public totalFee = 30;// 3%

    uint256 public teamFee = 15;
    uint256 public burnFee = 75;
    uint256 public rewardFee = 25;

// total amount = 100
    // fee is = 100*3/100 = 3
    // teamFee is =3/2 = 1.5 // 50%
    //burnFee is = 1.5*75/100 = 1.125
    // rewardFee is = 1.5*25/100 =  0.375

    
    uint256 public totalRaised;
    uint256 public totalPaid;

    address public immutable creator;
    bool public  isConfiscated;

    mapping(address => uint256) public participants;

    event onParticipate(uint256 donationAmount);
    event onDisperse(uint256 amount);
    event onConfiscate();

    modifier onlyOperator() {
        require(
            factory.owner() == msg.sender,
            "Ownable: caller is not the operator"
        );
        _;
    }

    constructor(address _creator) {
        factory = IFactory(msg.sender);
        baseToken = IERC20(factory.baseToken());
        creator = _creator;
    }
   

    function participate(uint256 amount) public  {
        require(!isConfiscated,"Fundraiser is disabled");
        baseToken.safeTransferFrom(msg.sender,address(this), amount);
        participants[msg.sender] +=amount;
        totalRaised +=amount;
        emit onParticipate(amount);
    }


    function disperseFund(uint256 amount) public  onlyOperator{
        totalPaid +=amount;

        uint256 totalFeeAmount = amount*totalFee/1000;
        baseToken.safeTransfer(creator, amount-totalFeeAmount);
        uint256 teamFeeAmount = totalFeeAmount/2;
        uint256 burnFeeAmount = (totalFeeAmount/2)*75/100;
        uint256 rewardFeeAmount = (totalFeeAmount/2)*25/100;
        
        baseToken.safeTransfer(factory.burningWallet(), burnFeeAmount);
        baseToken.safeTransfer(factory.rewardWallet(), rewardFeeAmount);
        baseToken.safeTransfer(factory.teamWallet(), teamFeeAmount);
        emit onDisperse(amount);
    }

    function confiscateFunds() public  onlyOperator{
        baseToken.safeTransfer(creator, baseToken.balanceOf(address(this)));
        isConfiscated = true;
        emit onConfiscate();
    }
}
