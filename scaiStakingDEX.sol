// Sources flattened with hardhat v2.9.1 https://hardhat.org

// File @openzeppelin/contracts/utils/Context.sol@v4.5.0

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

interface IPancakeFactory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

    function INIT_CODE_PAIR_HASH() external view returns (bytes32);
}


interface IPancakePair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(
        address to
    ) external returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}


interface IPancakeRouter01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB, uint256 liquidity);

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (uint256 amountToken, uint256 amountETH, uint256 liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(
        uint256 amountIn,
        address[] calldata path
    ) external view returns (uint256[] memory amounts);

    function getAmountsIn(
        uint256 amountOut,
        address[] calldata path
    ) external view returns (uint256[] memory amounts);
}


interface IPancakeRouter02 is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}


/**
 * @dev Staking Contract 
 *   - Stake LP Token for X number of days  
 *   - Add penelty function also 
 */
contract scaiStakingDEX is Ownable, ReentrancyGuard {

    uint256 public minimumValidatorStaking =100000000 ; //1000000 * 1e18;
    uint256 public rewardFund;
    uint256 public lastReferenceValueRF = 100000000 * 1e18; // reference to check next half
    mapping(address=>uint256) public rewardBalance;
    mapping(address=>uint256) public totalProfitWithdrawn;
    
    uint256 public totalStakers;
    uint256 public totalStakeAmount;

    struct UserStake {
        uint256 amount;
        uint256 startTimeStamp;
        uint256 lastRewardClaimTime;
        uint256 rewardsPerSecond;
        uint256 totalRewardsClaimed;
        bool stakeClosed;
    }
 
    uint256 halvingThreshold = 100000000 * 1e18; // reference to check next half
    // stakes that the owner have    
    mapping(address => UserStake) public stakeInfo;
     IERC20 public wSCAI; // The ERC20 token to be distributed
    IERC20 public SCAItoken; // The ERC20 token to be distributed
     /// @notice Address of the pancakeswap V2 router
    IPancakeRouter02 public pancakeswapV2Router;
    /// @notice Address of the pancakeswap pair
    address public pancakePair;
    uint256 public APY = 20; // Reward rate
    uint256 public lockdays = 90 ;
     // the penalty, a number between 0 and 100
    uint8 public penalty = 10;

    //events
    event Withdraw(address user,  uint256 amount, uint256 timestamp);
    event EmergencyWithdraw(address user,  uint256 amount, uint256 timestamp);
    event StakeCreated(address user, uint256 amount);
    event ClaimRewards(address user,  uint256 amount, uint256 timestamp);


    receive() external payable {}
    fallback() external payable {}
 
   
    //------------------ Constructor ------------------

    constructor(address _router , address _token)  Ownable(msg.sender){

        SCAItoken = IERC20(_token);

        pancakeswapV2Router = IPancakeRouter02(_router);
        // Creating a new pancakeswap pair for this new token
        pancakePair = IPancakeFactory(pancakeswapV2Router.factory()).createPair(
            address( SCAItoken),
            pancakeswapV2Router.WETH()
        );

        wSCAI = IERC20(pancakeswapV2Router.WETH());
    }


    //============= Setter Functions ====================

    function setPenalty(uint8 _penalty) external onlyOwner {
        require(_penalty<=100, "Penalty must be less than 100");
        penalty = _penalty;
    }

    function getRewardFund() external onlyOwner {
        rewardFund = rewardFund + IERC20(wSCAI).balanceOf(address(this));
    }

    function rescueTokens() external onlyOwner {
        uint256 contractBalInWSCAI = IERC20(wSCAI).balanceOf(address(this));
        wSCAI.transfer(msg.sender,contractBalInWSCAI);
    }

    function setLockingPeriodDays(uint8 _lockdays) external onlyOwner {
        lockdays = _lockdays;
    }

    //============= External Functions ====================

    /// @notice  auto addLiquidity to router , get lptokens and stake them

    function stake(uint256 tokenAmount) external payable nonReentrant   
    {   
        uint256 amount = msg.value;
        require(amount >0, "Invalid amount");
       
        // Approve token transfer to Uniswap Router
        IERC20(SCAItoken).approve(address(pancakeswapV2Router), tokenAmount);

        // addLiquidity with native coins and SCAI tokens
        (, , uint256 liquidityAdded) = pancakeswapV2Router.addLiquidityETH{value: amount}(
            address(SCAItoken),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(this),
            block.timestamp + 600000
        );

        UserStake storage newUserStake = stakeInfo[msg.sender];

        // check for pending rewards, when user restakes we will first transfer all user's pending rewards to user
        uint256 pendingRewards =  calculateRewards(msg.sender);
        if(pendingRewards >0)
        {
            // Transfer all pending rewards to user
            wSCAI.transfer(msg.sender,pendingRewards);
            newUserStake.totalRewardsClaimed=  newUserStake.totalRewardsClaimed + pendingRewards;
            pendingRewards=0;
        }

        //  seconds of the 3 months lock period :  90*24*60*60
        uint256 secondInDays =    60 * 60 * 24* lockdays ;
        // calculate rewards for inputted tokenAmount.
        uint256 totalRewards = tokenAmount * APY / 100;
        uint256 rewardsPerSecond = totalRewards / secondInDays;
       
        newUserStake.amount =   liquidityAdded;
        newUserStake.startTimeStamp = block.timestamp;
        newUserStake.lastRewardClaimTime = block.timestamp;
        newUserStake.rewardsPerSecond = rewardsPerSecond;
        newUserStake.stakeClosed = false;

        totalStakers += 1;
        totalStakeAmount += amount;

        emit StakeCreated(msg.sender, amount);
    }


    function emergencyWithdrawStake()  external nonReentrant {
         
        UserStake storage stakedata = stakeInfo[msg.sender];
        require(stakedata.stakeClosed == false, "This stake is closed");
        require(stakedata.amount >0, "Nothing to withdraw");
        // check if normal withdraw possibe then ask user not to user emergency withdraw

        //  seconds of the 3 months lock period :  90*24*60*60
        uint256 secondInDays =    60 * 60 * 24* lockdays ;
        uint256 stakeEndDate =  block.timestamp + secondInDays   ;
        require(block.timestamp <= stakeEndDate, "You can withdraw normally");
    
        // calculate penalty = amount * penalty / 100
        uint256 thePenalty = stakedata.amount * penalty / 100;
         
        // remaining amount= amount - penaty
        uint256 amountToWithdraw = stakedata.amount - thePenalty;

        // store the results in the stakes array of the user
        stakedata.stakeClosed = true;
        stakedata.amount=0;
        // transfer remaining
        IERC20(pancakePair).transfer(msg.sender, amountToWithdraw);

        //Burn the penalty tokens 
        IERC20(pancakePair).transfer(address(0), thePenalty); 
       
        emit EmergencyWithdraw(msg.sender, amountToWithdraw, block.timestamp);
    }

    function WithdrawStake() external nonReentrant returns (bool)
    {
        address staker = msg.sender;
        UserStake storage newUser = stakeInfo[staker];
        require(newUser.stakeClosed ==false, "This stake is closed");
        uint256 unstakeAmount = newUser.amount;
        require(unstakeAmount > 0, "You don't have any stake");

        //  seconds of the 3 months lock period :  90*24*60*60
        uint256 secondInDays =    60 * 60 * 24* lockdays ;
        uint256 stakeEndDate =  block.timestamp + secondInDays   ;
        require(block.timestamp > stakeEndDate, "Stake is still active");
        
        uint256 rewardsOfStake = calculateRewards(msg.sender);
        uint256 contractBalanceInLP = IERC20(pancakePair).balanceOf(address(this));

        // check contract balance in LP
        require( contractBalanceInLP >= newUser.amount , "Insufficient LP balance");

        // check contract balance in wSCAI
        require( IERC20(wSCAI).balanceOf(address(this)) >= rewardsOfStake , "Insufficient contract wSCAI balance");
        
        // transfer rewards
         wSCAI.transfer(msg.sender,rewardsOfStake);
        // transfer the lptokens from the liquidity
        IERC20(pancakePair).transfer(staker, unstakeAmount );

        newUser.stakeClosed = true;
        newUser.totalRewardsClaimed=  newUser.totalRewardsClaimed + rewardsOfStake;
        newUser.lastRewardClaimTime = block.timestamp;
        rewardsOfStake=0;
  
        newUser.amount = newUser.amount - (unstakeAmount);
        totalStakeAmount = totalStakeAmount - (unstakeAmount);
        
        emit Withdraw(staker,  unstakeAmount + rewardsOfStake, block.timestamp);
        return true;
    }


    function WithdrawRewards() external  nonReentrant
    {
        UserStake storage newUser = stakeInfo[msg.sender];
        require(newUser.stakeClosed ==false, "This stake is closed");
        require( rewardFund >0 , "Insufficient reward fund");

        if(rewardFund <= halvingThreshold /2) 
        {   
            halvingThreshold =  halvingThreshold /2;
            APY = APY/ 2;
        }

        uint256 rewardsAmount = calculateRewards(msg.sender);
        require(rewardsAmount > 0, "No rewards to claim");
        // check contract balance in wSCAI
        require( IERC20(wSCAI).balanceOf(address(this)) >= rewardsAmount , "Insufficient contract balance");

        // transfer rewards to user
        wSCAI.transfer(msg.sender,rewardsAmount);
        newUser.totalRewardsClaimed=  newUser.totalRewardsClaimed + rewardsAmount;
        newUser.lastRewardClaimTime = block.timestamp;
        // decrease reward fund
        rewardFund = rewardFund - rewardsAmount;
        rewardsAmount=0;

        emit  ClaimRewards( msg.sender,   rewardsAmount,   block.timestamp);
    }

    function calculateRewards(address _user)  public  view returns(uint256)
    {
        UserStake storage stakedata = stakeInfo[_user];
        uint256 pendingRewardsAmount =0;
        if(stakedata.amount > 0)
        {
            uint256 timeElapsed = block.timestamp - stakedata.lastRewardClaimTime;
            pendingRewardsAmount = stakedata.rewardsPerSecond * timeElapsed;
        }
        return pendingRewardsAmount;
    }
}

