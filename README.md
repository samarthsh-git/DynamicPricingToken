# 🪙 DynamicVolumeToken (DVT)

A minimal ERC20-like token built in **Solidity** that implements **dynamic pricing based on trading volume** — without using imports, constructors, or input parameters.  
The token price automatically adjusts according to daily trade volume, simulating a self-regulating supply-demand mechanism.

---

## 🚀 Features

- **Dynamic Pricing Algorithm:**  
  Token price increases automatically with higher daily trading volume.
  
- **Volume Tracking:**  
  Keeps track of 24-hour trade volume and resets daily.

- **No Imports / No Constructors:**  
  Lightweight, dependency-free design that runs entirely within one Solidity file.

- **Manual Initialization:**  
  Uses an `initialize()` function instead of a constructor (useful for proxy deployment or Remix testing).

- **Direct Purchase Support:**  
  Users can buy tokens directly from the contract using ETH.

---

## ⚙️ How It Works

### Dynamic Price Formula
```solidity
price = basePrice + (basePrice * dailyVolume / (1_000_000 * (10 ** 18)));
```

- **`basePrice`** — The minimum token price (0.001 ETH by default).  
- **`dailyVolume`** — Total amount of tokens traded in the last 24 hours.  
- **`price`** — Adjusts automatically after every transfer or purchase.

The volume resets every 24 hours, ensuring daily recalibration.

---

## 🧩 Smart Contract Overview

| Function | Description |
|-----------|--------------|
| `initialize()` | Sets total supply and initial price for the deployer. |
| `transfer(address to, uint256 amount)` | Transfers tokens and updates price dynamically. |
| `buyTokens()` | Allows users to buy tokens with ETH at the current price. |
| `getCurrentPrice()` | Returns the current price of one token in wei. |

---

## 💻 Deployment Steps (Remix IDE)

1. **Open Remix IDE:**  
   [https://remix.ethereum.org](https://remix.ethereum.org)

2. **Paste Contract:**  
   Copy the Solidity code into a new file named `DynamicVolumeToken.sol`.

3. **Compile:**  
   - Select the **Solidity Compiler** tab (on the left).  
   - Choose version **0.8.30** or higher.  
   - Click **Compile DynamicVolumeToken.sol**.

4. **Deploy:**  
   - Go to **Deploy & Run Transactions** (Ethereum logo tab).  
   - Select `DynamicVolumeToken` from the dropdown.  
   - Click **Deploy**.  
   - Run `initialize()` once after deployment to mint tokens.

---

## 🧮 Example Interaction

1. Deploy contract.  
2. Run `initialize()` — the deployer receives all tokens.  
3. Call `buyTokens()` by sending some ETH (e.g., 0.01 ETH).  
4. Check `getCurrentPrice()` — you’ll see the price adjusted based on recent trading volume.  
5. Transfer tokens between accounts to simulate more volume.

---

## 🧠 Future Improvements

- Implement **price decay** when volume decreases.  
- Add **liquidity pool integration** for decentralized exchange support.  
- Include **governance controls** to manage base price or thresholds.

---

## 📄 License

This project is licensed under the **MIT License** — free to use, modify, and distribute.

---

**Author:** [Samarth Sharma]  
**Version:** 1.0  
**Language:** Solidity 0.8.x  
**Network Compatibility:** Ethereum, Polygon, BSC
```

---


