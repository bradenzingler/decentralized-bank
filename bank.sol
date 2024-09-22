// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.8.2 <0.9.0;

contract Bank {
    Account[] public accounts;
    mapping(address => Account) addrToAccount;

    struct Account {
        uint balance;
        address walletAddress;
    }

    event AccountCreated(address indexed walletAddress);
    event MoneyDeposited(address indexed walletAddress, uint amount);
    event MoneyWithdrawn(address indexed walletAddress, uint amount);

    function createAccount() public {
        require(addrToAccount[msg.sender].walletAddress == address(0), "Account already exists."); 
        Account memory newAccount = Account(0, msg.sender);
        accounts.push(newAccount);
        addrToAccount[msg.sender] = newAccount;
        emit AccountCreated(msg.sender);
    }   

    function depositMoney(uint amount) public {
        addrToAccount[msg.sender].balance += amount;
        emit MoneyDeposited(msg.sender, amount);
    }

    function withdrawMoney(uint amount) public {
        require(addrToAccount[msg.sender].balance >= amount, "Insufficient funds.");
        addrToAccount[msg.sender].balance -= amount;
        emit MoneyWithdrawn(msg.sender, amount);
    }

    function getAccountBalance() external view returns(uint) {
        require(addrToAccount[msg.sender].walletAddress != address(0), "Account must exist.");
        return (addrToAccount[msg.sender].balance);
    }
}
