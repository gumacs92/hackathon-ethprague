// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RedCrossVault is ERC721URIStorage, Ownable {

    uint256 votingTime= 60*1; //900 sec -> 15 min

    struct VictimRequestInput {
        string name;
        string email;
        string description;
        uint256 expectedAmount;
    }

    struct VictimRequest {
        uint256 id;
        address payable myAddress;
        string name;
        string email;
        string description;
        uint256 expectedAmount;
        bool valid;
        bool isOnVote;
        bool approved;
    }

    struct VotingIds {
        uint256 voteId;
        uint256 startTime;
        uint256 yesVotes;
        uint256 noVotes;
    }

    enum Votes {
        YES, // 0
        NO // 2
    }

    uint256 requestsNum = 0;
    VictimRequest[] requests;
    VotingIds[] newVote;

    uint256 angelsNum = 0;
    string angelURI = "something.com"; // ide jön majd az ipfs uri link ami az angel NFT imagét mutatja
    address[] governors;
    address[] angels;

    mapping(address => bool) alreadyVoted;


    constructor() ERC721("Angel", "AT"){ 
        governors.push(msg.sender);
    }

    modifier votingIsActive(uint256 _voteId){
        require(newVote[_voteId].startTime > block.timestamp, "Vote period for this request has been ended");
        // if(newVote[_voteId].startTime < block.timestamp){
        //     requests[_voteId].isOnVote = false;
        // }
        _;
    }

    modifier isGovernor() {
        bool governor = false;
        for(uint i = 0; i < governors.length; i++){
                if(governors[i] == msg.sender){
                    governor = true;
                }
            }
        require(governor == true, "NonGovernor address");
        _;
    }

    modifier isVoter() {
        bool voter = false;
        for(uint i = 0; i < angels.length; i++ ){
            if(angels[i] == msg.sender){
                voter = true;
            }
        }
        require(voter == true, "Ineligible to vote");
        _;
    }

    // Donate function amiben elmentjük a donatelőt is, hozzáadjuk az angel structhoz vagy arrayhez + mintelünk NFT-t
    function donate() public payable {
        angels.push(msg.sender);

        _mint(msg.sender, angelsNum);
        _setTokenURI(angelsNum++, angelURI);
    }

    function requestHelp(string memory _name, string memory _email, string memory _description, uint256 _expectedAmount) public {
        requests.push(VictimRequest({
            id: requestsNum++,
            myAddress: payable(msg.sender),
            name: _name,
            email: _email,
            description: _description,
            expectedAmount: _expectedAmount,
            valid: false,
            isOnVote: false,
            approved: false
        }));
    }

    function validateRequest(uint256 _requestId) public isGovernor{
        require(requests[_requestId].valid == false, "Governor already validated this request");

        uint256 votingEnds = block.timestamp + votingTime;
        VotingIds memory addVote = VotingIds(_requestId, votingEnds,0,0);
        newVote.push(addVote);

        requests[_requestId].valid = true;
        requests[_requestId].isOnVote = true;
    }

    // function checkRequestId(uint256 _requestId) public view returns (bool){
        // check whether a request Id has been submitted or not 
    // }

    function changeRequestedAmount(uint256 _requestId, uint256 _newAmount) public isGovernor{
        requests[_requestId].expectedAmount = _newAmount;
    }

    function approveRequest(uint256 requestId) public isGovernor{
        requests[requestId].approved = true;
        address payable victimAddress = requests[requestId].myAddress;
        victimAddress.transfer(requests[requestId].expectedAmount);
    }

    function getVaultBalance() public view returns (uint256){
        return address(this).balance; // gets back main vault Balance
    }

    function vote(uint256 _requestId, Votes _voteNumber) public isVoter votingIsActive(_requestId) {
        require(alreadyVoted[msg.sender] == false, "You already made your vote for this request");

        if(_voteNumber == Votes.YES){
            newVote[_requestId].yesVotes++;
        }
        else{
            newVote[_requestId].noVotes++;
        }
    }

    function checkRequest(uint256 _requestId) public view returns(bool){
        return requests[_requestId].isOnVote;
    }
}