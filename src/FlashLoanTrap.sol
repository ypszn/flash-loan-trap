// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

// Interface for interacting with the response contract
interface IResponseContract {
    function isActive() external view returns (bool);
}

contract FlashLoanTrap is ITrap {
    // Updated response contract address
    address public constant RESPONSE_CONTRACT = 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608;

    // Define the threshold for suspicious flash loan size
    uint256 public constant MAX_LOAN_AMOUNT = 1000000 * 10**18; // Example: 1,000,000 units of the token (adjust as needed)

    // Data structure to store the loan amount
    struct CollectOutput {
        uint256 loanAmount;
    }

    // Function to collect data about the current loan size
    function collect() external view returns (bytes memory) {
        // Simulating data collection for the loan amount (replace with actual logic)
        uint256 loanAmount = 2000000 * 10**18; // Example loan amount (replace with actual logic)

        // Query the response contract to check if it is active
        bool active = IResponseContract(RESPONSE_CONTRACT).isActive();

        // Return the loan amount and whether the response contract is active
        return abi.encode(CollectOutput({loanAmount: loanAmount}), active);
    }

    // Function to validate if the loan amount exceeds the defined threshold
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        (CollectOutput memory current, bool active) = abi.decode(data[0], (CollectOutput, bool));

        // Check if the loan amount exceeds the threshold and the contract is active
        if (current.loanAmount > MAX_LOAN_AMOUNT && active) {
            return (true, bytes("Flash loan detected"));
        }

        // No action needed if the loan amount is below the threshold or contract is not active
        return (false, bytes(""));
    }
}
