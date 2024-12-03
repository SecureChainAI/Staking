
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


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



contract SCAIStaking is ReentrancyGuard {
    struct Stake {
        uint256 scaiAmount;
        uint256 ethAmount;
        uint256 lpTokens;
        uint256 startTime;
        uint256 lastRewardTime;
        uint256 unlockTime;
    }

    IERC20 public scaiToken;
    IUniswapV2Router public uniswapRouter;
    address public rewardPool;
    uint256 public totalRewardPool;
    uint256 public remainingRewards;
    uint256 public apy = 20; // Initial APY: 20%
    uint256 public constant APY_DIVISOR = 100; // For calculating APY
    uint256 public constant PENALTY_PERCENT = 10; // Penalty for premature unstaking
    uint256 public constant LOCK_PERIOD = 10 minutes;
    address public uniswapPair;

    mapping(address => Stake) public stakes;

    event Staked(address indexed user, uint256 scaiAmount, uint256 ethAmount, uint256 lpTokens);
    event Unstaked(address indexed user, uint256 scaiAmount, uint256 ethAmount, uint256 lpTokens, bool premature);
    event RewardsDistributed(address indexed user, uint256 amount);
    event Halving(uint256 newAPY);
    event RewardsWithdrawn(address indexed user, uint256 amount);

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
       
        
        uniswapPair = IUniswapFactory(uniswapRouter.factory()).getPair(
            address( scaiToken),
            uniswapRouter.WETH()
        );

        if(uniswapPair == address(0))
        {
             // Creating a new pancakeswap pair for this new token
             uniswapPair = IUniswapFactory(uniswapRouter.factory()).createPair(
                 address( scaiToken),
                 uniswapRouter.WETH()
        );
        }

        scaiToken.approve(address(uniswapRouter), totalRewardPool* (10**20));
         // Approve Uniswap router for LP tokens
        IERC20(uniswapPair).approve(address(uniswapRouter), totalRewardPool* (10**20));
    }

    modifier hasStake(address user) {
        require(stakes[user].lpTokens > 0, "No active stake");
        _;
    }

    function stake(uint256 scaiAmount) external payable nonReentrant {
        require(scaiAmount > 0, "SCAI amount must be greater than zero");
        require(msg.value > 0, "ETH amount must be greater than zero");

        scaiToken.transferFrom(msg.sender, address(this), scaiAmount);
        scaiToken.approve(address(uniswapRouter), scaiAmount);

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

    function withdrawRewards() external nonReentrant hasStake(msg.sender) {
        _distributeRewards(msg.sender);
    }

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



    function viewUnlockTime(address user) external view returns (uint256) {
        return stakes[user].unlockTime;
    }

  
    function viewCurrentRewards(address user) external view returns (uint256) {
        Stake memory userStake = stakes[user];
        uint256 stakedDuration = block.timestamp - userStake.lastRewardTime;
        uint256 reward = (userStake.scaiAmount * apy * stakedDuration) /
            (APY_DIVISOR * 365 days);
        return reward;
    }
}
