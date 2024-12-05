
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'hardhat/console.sol';
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

interface IUniswapFactory {
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

interface IUniswapPair {
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

interface IUniswapRouter01 {
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

interface IUniswapV2Router is IUniswapRouter01 {
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
}


/**
 * @title SCAIStaking
 * @dev A staking contract allowing users to stake SCAI tokens with ETH for LP tokens, earn rewards, and unstake.
 */
contract SCAIStaking is ReentrancyGuard {
    struct Stake {
        uint256 scaiAmount;       // Amount of SCAI tokens staked
        uint256 ethAmount;        // Amount of ETH paired with SCAI
        uint256 lpTokens;         // LP tokens received for the stake
        uint256 startTime;        // Time when staking started
        uint256 lastRewardTime;   // Last time rewards were distributed
        uint256 unlockTime;       // Time after which staking can be unlocked
    }

    // State variables
    IERC20 public scaiToken;                      // SCAI token contract
    IUniswapV2Router public uniswapRouter;        // Uniswap router contract
    address public rewardPool;                    // Address of the reward pool
    uint256 public totalRewardPool;               // Total rewards available
    uint256 public remainingRewards;              // Rewards remaining in the pool
    uint256 public apy = 20;                      // Annual Percentage Yield (APY)
    uint256 public constant APY_DIVISOR = 100;    // Divisor for APY calculations
    uint256 public constant PENALTY_PERCENT = 10; // Penalty for early unstaking
    uint256 public constant LOCK_PERIOD = 10 minutes; // Lock period for unstaking
    address public uniswapPair;                   // Address of the Uniswap LP pair

    mapping(address => Stake) public stakes;      // Mapping of user stakes

    // Events
    event Staked(address indexed user, uint256 scaiAmount, uint256 ethAmount, uint256 lpTokens);
    event Unstaked(address indexed user, uint256 scaiAmount, uint256 ethAmount, uint256 lpTokens, bool premature);
    event RewardsDistributed(address indexed user, uint256 amount);
    event Halving(uint256 newAPY);
    event RewardsWithdrawn(address indexed user, uint256 amount);

    /**
     * @dev Constructor initializes the staking contract with token, Uniswap router, and reward pool details.
     * @param _scaiToken Address of the SCAI token contract.
     * @param _uniswapRouter Address of the Uniswap router.
     * @param _rewardPool Address of the reward pool.
     * @param _initialRewardPool Initial amount of rewards in the reward pool.
     */
    constructor(
        address _scaiToken,
        address _uniswapRouter,
        address _rewardPool,
        uint256 _initialRewardPool
    ) {
        scaiToken = IERC20(_scaiToken);
        uniswapRouter = IUniswapV2Router(_uniswapRouter);
        rewardPool = _rewardPool;
        totalRewardPool = _initialRewardPool;
        remainingRewards = _initialRewardPool;

        // Get or create Uniswap pair
        uniswapPair = IUniswapFactory(uniswapRouter.factory()).getPair(
            address(scaiToken),
            uniswapRouter.WETH()
        );
        if (uniswapPair == address(0)) {
            uniswapPair = IUniswapFactory(uniswapRouter.factory()).createPair(
                address(scaiToken),
                uniswapRouter.WETH()
            );
        }

        // Approve tokens for Uniswap and LP
        scaiToken.approve(address(uniswapRouter), totalRewardPool * (10**20));
        IERC20(uniswapPair).approve(address(uniswapRouter), totalRewardPool * (10**20));
    }

    /**
     * @dev Modifier to check if the user has an active stake.
     * @param user Address of the user.
     */
    modifier hasStake(address user) {
        require(stakes[user].lpTokens > 0, "No active stake");
        _;
    }

    /**
     * @dev Stakes the specified amount of SCAI tokens paired with ETH to provide liquidity in the Uniswap pool.
     *      LP tokens are issued to represent the user's share in the liquidity pool.
     *      Also calculates and distributes pending rewards before adding a new stake.
     * @param scaiAmount The amount of SCAI tokens to stake.
     * 
     * Requirements:
     * - `scaiAmount` must be greater than 0.
     * - `msg.value` (ETH sent with the transaction) must cover the required ETH for the SCAI amount.
     * - The contract must have sufficient allowance to transfer `scaiAmount` from the user.
     *
     * Emits:
     * - `Staked` event indicating the staking details.
     */
    function stake(uint256 scaiAmount) external payable nonReentrant {
        require(scaiAmount > 0, "SCAI amount must be greater than zero");
        require(msg.value >= (price(scaiAmount)), "ETH amount must be greater than price");

        scaiToken.transferFrom(msg.sender, address(this), scaiAmount);
       
        // Add liquidity to Uniswap
        (uint256 tokenAmount, uint256 ethAmount, uint256 liquidity) = uniswapRouter.addLiquidityETH{
            value: msg.value
        }(
            address(scaiToken),
            scaiAmount,
            0,
            0,
            address(this),
            block.timestamp + 1 hours
        );

        // Save stake details
        Stake storage userStake = stakes[msg.sender];
        if (userStake.lpTokens > 0) {
            // Distribute previous rewards before restaking
            _distributeRewards(msg.sender);
        }
        userStake.scaiAmount += tokenAmount;
        userStake.ethAmount += ethAmount;
        userStake.lpTokens += liquidity;
        userStake.startTime = block.timestamp;
        userStake.lastRewardTime = block.timestamp;
        userStake.unlockTime = block.timestamp + LOCK_PERIOD;

        emit Staked(msg.sender, tokenAmount, ethAmount, liquidity);
    }
     /**
     * @dev Withdraws accumulated rewards for the caller based on their staked amount and duration.
     *      Rewards are transferred from the reward pool.
     * 
     * Requirements:
     * - The caller must have an active stake.
     * - Sufficient rewards must be available in the reward pool.
     *
     * Emits:
     * - `RewardsWithdrawn` event indicating the amount withdrawn.
     */
    function withdrawRewards() external nonReentrant hasStake(msg.sender) {
        _distributeRewards(msg.sender);
    }
     /**
     * @dev Internal function to calculate and distribute rewards for a user's stake.
     *      Rewards are based on the staked SCAI amount, APY, and staking duration.
     * @param user The address of the user for whom rewards are distributed.
     *
     * Emits:
     * - `RewardsWithdrawn` event when rewards are distributed.
     * - `Halving` event when the APY is halved due to reward depletion.
     */
    function _distributeRewards(address user) internal {
        Stake storage userStake = stakes[user];
        uint256 stakedDuration = block.timestamp - userStake.lastRewardTime;
        uint256 reward = (userStake.scaiAmount * apy * stakedDuration) /
            (APY_DIVISOR * 365 days);

        require(reward > 0, "No rewards available to withdraw");
        require(reward <= remainingRewards, "Insufficient rewards in pool");

        remainingRewards -= reward;
        userStake.lastRewardTime = block.timestamp;

        scaiToken.transferFrom(rewardPool, user, reward);

        // Halving mechanism
        if (remainingRewards <= totalRewardPool / 2 && apy > 1) {
            apy /= 2;
            emit Halving(apy);
        }

        emit RewardsWithdrawn(user, reward);
    }
     /**
     * @dev Allows a user to unstake their LP tokens, returning their initial SCAI and ETH.
     *      If unstaking prematurely, a penalty is applied, and the lock period is enforced.
     * @param premature Whether the user is unstaking before the lock period ends.
     *
     * Requirements:
     * - The caller must have an active stake.
     * - If `premature` is true, the penalty is deducted from the LP tokens.
     * - The contract must hold sufficient LP tokens for liquidity removal.
     *
     * Emits:
     * - `Unstaked` event indicating the unstaking details.
     */
   function unstake(bool premature) external nonReentrant hasStake(msg.sender) {
        Stake storage userStake = stakes[msg.sender];
        require(
            premature || block.timestamp >= userStake.unlockTime,
            "Cannot unstake before unlock time"
        );

        uint256 penalty = 0;
        if (premature) {
            penalty = (userStake.lpTokens * PENALTY_PERCENT) / 100;
            require(userStake.lpTokens > penalty, "Insufficient LP tokens for penalty");
        }

        uint256 lpTokensToRemove = userStake.lpTokens - penalty;

        // Approve Uniswap router for LP tokens
        IERC20(uniswapPair).approve(address(uniswapRouter), lpTokensToRemove);

        // Check LP token balance
        uint256 lpBalance = IERC20(uniswapPair).balanceOf(address(this));
        require(lpBalance >= lpTokensToRemove, "Insufficient LP tokens in contract");


        //Remove liquidity from Uniswap
        (uint256 tokenAmount, uint256 ethAmount) = uniswapRouter.removeLiquidityETH(
            address(scaiToken),
            lpTokensToRemove,
            0,
            0,
            msg.sender,
            block.timestamp + 1 hours
        );

        // Distribute pending rewards
        _distributeRewards(msg.sender);

        // Reset stake details
        delete stakes[msg.sender];

        emit Unstaked(msg.sender, tokenAmount, ethAmount , lpTokensToRemove, premature);
    }


     function test() public  returns(uint256){
        // Approve Uniswap router for LP tokens
        IERC20(uniswapPair).approve(address(uniswapRouter),  stakes[msg.sender].lpTokens);
          // Check LP token balance
        uint256 lpBalance = IERC20(uniswapPair).balanceOf(address(this));
       // require(lpBalance >= stakes[msg.sender].lpTokens, "Insufficient LP tokens in contract");
        return lpBalance;
    }
    /**
     * @dev Computes the required ETH amount for the specified SCAI amount based on the Uniswap pool reserves.
     * @param amount The amount of SCAI tokens to price.
     * @return The equivalent ETH amount for the given SCAI amount.
     */
    function price(uint256 amount) public view returns(uint256){
        (uint112 reserve0, uint112 reserve1, ) = IUniswapPair(uniswapPair).getReserves();
         uint256 minvalue=(amount*reserve0) / reserve1;
         return minvalue;
    }
   /**
     * @dev Retrieves the unlock time for a user's stake.
     * @param user The address of the user.
     * @return The timestamp when the user's stake becomes unlocked.
     */
    function viewUnlockTime(address user) external view returns (uint256) {
        return stakes[user].unlockTime;
    }

    /**
     * @dev Computes the current rewards for a user based on their staked amount and duration.
     * @param user The address of the user.
     * @return The amount of rewards currently available for the user.
     */
    function viewCurrentRewards(address user) external view returns (uint256) {
        Stake memory userStake = stakes[user];
        uint256 stakedDuration = block.timestamp - userStake.lastRewardTime;
        uint256 reward = (userStake.scaiAmount * apy * stakedDuration) /
            (APY_DIVISOR * 365 days);
        return reward;
    }
}
