# Flash Loan Attack Detection Trap

You can check out Drosera docs on how to create your first trap, deploy it to the Drosera network, and update it on the fly.

[![view - Documentation](https://img.shields.io/badge/view-Documentation-blue?style=for-the-badge)](https://dev.drosera.io "Project documentation")

## Configure dev environment

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup

# install Bun (optional)
curl -fsSL https://bun.sh/install | bash

# install node modules
bun install

# install drosera-cli
curl -L https://app.drosera.io/install | bash
droseraup
```

## Flash Loan Trap

The **FlashLoanTrap** is a smart contract designed to monitor and detect suspicious flash loan activities on the Ethereum blockchain. Here's a breakdown of what it does:

### Key Features:

1. **Monitors Loan Amounts**:

   * The trap monitors the loan amount for transactions on the Ethereum network. If the loan amount exceeds a predefined threshold (`MAX_LOAN_AMOUNT`), it flags the activity as potentially suspicious (e.g., a flash loan attack).

2. **Checks Response Contract**:

   * The trap also interacts with a **response contract** at address `0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608` to confirm whether the contract is active by calling the `isActive()` function.
   * This ensures that the trap only triggers a response when the response contract is active, adding an additional layer of security.

3. **Triggering Alerts**:

   * If the loan amount exceeds the threshold and the response contract is active, the trap triggers a response.
   * The response can include actions like notifying stakeholders or pausing the contract to prevent further transactions, thus mitigating the potential threat from the flash loan.

4. **Threshold Customization**:

   * The trap allows for adjusting the threshold of what constitutes a "suspicious" loan amount (`MAX_LOAN_AMOUNT`), making it adaptable to different security requirements.

### Workflow:

* The trap continuously monitors transactions and loan amounts.
* When a loan amount exceeds the threshold and the response contract is active, the trap triggers an alert or response.
* The response ensures that the contract takes action to mitigate any potential risks from flash loans.

### Purpose:

The **FlashLoanTrap** aims to prevent exploits and attacks typically seen in decentralized finance (DeFi) protocols that utilize flash loans. By detecting large and suspicious loans, the trap helps safeguard the network against flash loan-based attacks or price manipulation schemes.

In essence, it’s a security tool for detecting and mitigating flash loan-related vulnerabilities in real-time.


The drosera.toml file is configured to deploy a simple "Hello, World!" trap. Ensure the drosera.toml file is set to the following configuration:

```toml
response_contract = "0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608"
response_function = "alertFlashLoan(string)"
```

To deploy the trap, run the following commands:

```bash
# Compile the Trap
forge build

# Deploy the Trap
DROSERA_PRIVATE_KEY=0x.. drosera apply
```

Congratulations! You have successfully deployed the Flash Loan trap!
