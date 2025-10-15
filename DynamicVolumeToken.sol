// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicVolumeToken {
    // Basic token data
    string public name = "DynamicVolumeToken";
    string public symbol = "DVT";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1_000_000 * (10 ** 18);

    // Mappings for balances
    mapping(address => uint256) public balanceOf;

    // Volume-based variables
    uint256 public dailyVolume;
    uint256 public lastTradeTime;

    // Base price (in wei per token)
    uint256 public basePrice = 1e15; // 0.001 ETH
    uint256 public price; // current price

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Purchase(address indexed buyer, uint256 amount, uint256 price);

    // Initialize state (no constructor)
    function initialize() external {
        require(balanceOf[msg.sender] == 0, "Already initialized");
        balanceOf[msg.sender] = totalSupply;
        price = basePrice;
    }

    // Transfer tokens between addresses
    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);

        // Track volume and update price dynamically
        _updateVolume(amount);
        return true;
    }

    // Allow users to buy tokens directly with ETH
    function buyTokens() external payable {
        require(msg.value > 0, "Send ETH to buy tokens");
        uint256 tokensToBuy = (msg.value * (10 ** 18)) / price;
        require(balanceOf[address(this)] >= tokensToBuy, "Not enough tokens available");

        balanceOf[address(this)] -= tokensToBuy;
        balanceOf[msg.sender] += tokensToBuy;

        emit Purchase(msg.sender, tokensToBuy, price);

        // Update volume & price dynamically
        _updateVolume(tokensToBuy);
    }

    // Core function: updates volume and recalculates price
    function _updateVolume(uint256 amount) internal {
        if (block.timestamp > lastTradeTime + 1 days) {
            dailyVolume = 0; // reset daily volume every 24h
        }

        dailyVolume += amount;
        lastTradeTime = block.timestamp;

        // Dynamic price formula: price increases with daily volume
        // Example: price = basePrice * (1 + dailyVolume / 1,000,000)
        price = basePrice + (basePrice * dailyVolume / (1_000_000 * (10 ** 18)));
    }

    // Helper to get the current price per token
    function getCurrentPrice() external view returns (uint256) {
        return price;
    }
}
