// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

// Interface for interacting with the response contract
interface IResponseContract {
    function isActive() external view returns (bool);
}

contract FlashLoanTrap is ITrap {
    address public constant RESPONSE_CONTRACT = 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608;

    // Max suspicious flash loan amount: 1,000,000 DRO (18 decimals)
    uint256 public constant MAX_LOAN_AMOUNT = 1_000_000 ether;

    struct CollectOutput {
        uint256 loanAmountDRO; // In DRO with 18 decimals
    }

    function collect() external view returns (bytes memory) {
        // Simulated flash loan amount: 2,000,000 DRO
        uint256 simulatedLoanAmount = 2_000_000 ether;

        // Use response contract toggle
        bool active = IResponseContract(RESPONSE_CONTRACT).isActive();

        return abi.encode(CollectOutput({loanAmountDRO: simulatedLoanAmount}), active);
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        (CollectOutput memory current, bool active) = abi.decode(data[0], (CollectOutput, bool));

        if (current.loanAmountDRO > MAX_LOAN_AMOUNT && active) {
            return (true, bytes("Flash loan in DRO detected"));
        }

        return (false, bytes(""));
    }
}
