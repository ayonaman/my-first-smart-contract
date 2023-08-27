// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    // Ether payments
    // Modifires
    // Visibility
    // Events
    // Enums
    enum Statuses{
        Vacant, 
        Occupied
    }
    Statuses public currentStatus;

    event occupy (address _occupant, uint _value);

    address payable public owner;
    
    constructor() {
        owner = payable (msg.sender);
        currentStatus = Statuses.Vacant;
    }     
    
    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant,"Currently occupied");
        _;
    }
    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough ether provided.");
        _;
    }
    
    function book() payable public onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        
        (bool sent, bytes memory data) = owner.call{value: msg.value}(" "); //check the transfer is sent or not(start me bool aur data ka ask hai jo).
        require(true);

        emit occupy(msg.sender, msg.value);
    }
    
}