// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.2 <  0.9.0;

contract AddressWallets {
    uint public fortune; // Make fortune public to easily check the contract balance
    
    address payable[] investorWallets; 
    
    mapping(address => uint) public investors; // Make investors mapping public to check individual investor's investment amount
    
    
    function payInvestors(address payable wallet, uint amount) public {
        require(amount <= fortune, "Not enough funds in the contract"); // Check if the contract has enough funds to invest
        fortune -= amount; // Subtract the invested amount from the contract fortune
        investorWallets.push(wallet);
        investors[wallet] = amount;
    }
    
    function payout() private {
        for(uint i =0; i<investorWallets.length; i++) {
            require(address(this).balance >= investors[investorWallets[i]], "Not enough balance to pay out"); // Check if the contract has enough balance to pay out
            investorWallets[i].transfer(investors[investorWallets[i]]);
            investors[investorWallets[i]] = 0; // Set the investor's investment to 0 after paying out
        }
    } 
    
    constructor() payable  {
        fortune= msg.value;
    }
    
    function makePayment() public {
        payout();
    }


    function checkInvestors() public view returns (uint) {
        return investorWallets.length;
    }    
}
