// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RedCrossVault is ERC721URIStorage, Ownable {
    struct VictimRequestInput {
        string name;
        string email;
        string description;
        string expectedAmount;
    }

    struct VictimRequest {
        uint256 id;
        address myAddress;
        string name;
        string email;
        string description;
        string expectedAmount;
        bool valid;
        bool approved;
    }

    struct AngelInput { 
        string name;
        string description;
        string givenAmount;
    }


    struct Angel { 
        uint256 id;
        address myAddress;
        string name;
        string description;
        string givenAmount;
    }

    address elfiContract;
    address coreVoting;
    address vaultLockingContract;

    uint256 requestsNum = 0;
    VictimRequest[] requests;

    uint256 angelsNum = 0;
    string angelURI = "something.com"; // ide jön majd az ipfs uri link ami az angel NFT imagét mutatja
    Angel[] angels;


    constructor(address _elfiContract) ERC721("Angel", "AT"){ 
        elfiContract = _elfiContract;
    }

    // Donate function amiben elmentjük a donatelőt is, hozzáadjuk az angel structhoz vagy arrayhez + mintelünk NFT-t
    function donate(AngelInput memory angelRequest) public payable{
        angels.push(Angel({
            id: angelsNum,
            myAddress: msg.sender,
            name: angelRequest.name,
            description: angelRequest.description,
            givenAmount: angelRequest.givenAmount//msg.value
        }));
        _mint(msg.sender, angelsNum);
        _setTokenURI(angelsNum++, angelURI);
        
        // elfiContractAddress.call()
    }

    function requestHelp(VictimRequestInput memory input) public returns(uint256) {
        requests.push(VictimRequest({
            id: requestsNum++,
            myAddress: msg.sender,
            name: input.name,
            email: input.email,
            description: input.description,
            expectedAmount: input.expectedAmount,
            valid: false,
            approved: false
        }));
        return requestsNum -1;
        // coreVoting.call("proposal",[vaultLockingContract], [], [address(this)], ["todo calldatas"], "lastCall todo", "MAYBE");
    }

    function validateRequest(uint256 requestId) public {
        requests[requestId].valid = true;
    }

    function approveRequest(uint256 requestId) public {
        requests[requestId].approved = true;

        //TODO send out funds to the victim
    }

    function getVaultBalance() public view returns (uint256){
        return address(this).balance; // gets back main vault Balance
    }
}