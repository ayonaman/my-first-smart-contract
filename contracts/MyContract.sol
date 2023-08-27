// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable{
    address owner;

    modifier onlyOwner(){
        require(msg.sender == owner, "must be owner");
        _;
    } 

    constructor() {
        owner = msg.sender;
    }

}

contract SecretVault {
    string secret;

    constructor(string memory _secret)  {
        secret = _secret;
    } 

    function getSecret()public view returns(string memory) {
        return secret;
    }  


}

contract MyContract is Ownable {

    address secretVault;

    constructor(string memory _secret)  {
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
        super; //jitna bhi constructor hoga child contract me usko inherit kar sakte hai super se.
    }
 
    function getSecret()public view onlyOwner returns(string memory) {
        return SecretVault(secretVault).getSecret();
    }
}