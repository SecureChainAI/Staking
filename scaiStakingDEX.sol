// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

interface IUniswapV2Router {
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
    uint256 public constant LOCK_PERIOD = 90 days;

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
        }

        uint256 lpTokensToRemove = userStake.lpTokens - penalty;

        // Remove liquidity from Uniswap
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

        emit Unstaked(msg.sender, tokenAmount, ethAmount, lpTokensToRemove, premature);
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
