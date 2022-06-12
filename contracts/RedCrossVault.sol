// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RedCrossVault is ERC721URIStorage, Ownable {
    ///////////////////////////////////////////////////////////////////////////
    /////////CONSTANTS
    ///////////////////////////////////////////////////////////////////////////
    uint256 VOTING_TIME= 60*1; //60 sec -> 1 min
    
    ///////////////////////////////////////////////////////////////////////////
    /////////STRUCTS and ENUMS
    ///////////////////////////////////////////////////////////////////////////
    struct Volunteer{
        uint256 volunteerId;
        address volunteerAddress;
        string name;
        string introduction;
    }

    struct VictimRequest {
        uint256 id;
        address payable myAddress;
        string name;
        string email;
        string description;
        uint256 expectedAmount;
        bool invalid;
        bool valid;
        bool approved;
        uint256 votingEndsAt;
        uint256 yesVotes;
        uint256 noVotes;
    }

    enum Votes {
        YES, // 0
        NO // 1
    }

    ///////////////////////////////////////////////////////////////////////////
    /////////PROPERTY VARIABLES
    ///////////////////////////////////////////////////////////////////////////
    uint256 requestsNum = 0;
    uint256 volunteersNum = 0; 
    VictimRequest[] requests;
    Volunteer[] volunteers;

    uint256 angelsNum = 0;
    address[] governors;
    address[] angels;

    mapping(address => mapping(uint256 => bool)) alreadyVoted;

    ///////////////////////////////////////////////////////////////////////////
    /////////CONSTRUCTOR
    ///////////////////////////////////////////////////////////////////////////
    constructor() ERC721("Angel", "AT"){ 
        governors.push(msg.sender);
    }

    ///////////////////////////////////////////////////////////////////////////
    /////////MODIFIERS
    ///////////////////////////////////////////////////////////////////////////

    //Checks if the request is during an active voting perios
    modifier votingIsActive(uint256 _voteId){
        require(requests[_voteId].valid == true && requests[_voteId].votingEndsAt >= block.timestamp, "This voting is not active");
        _;
    }

    //Decides if the sender is a governor
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

    //Decides if the sender is eligible to vote
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

    ///////////////////////////////////////////////////////////////////////////
    /////////FUNCTIONS
    ///////////////////////////////////////////////////////////////////////////

    //Donate function let's people donate some money to the vault.
    function donate() public payable {
        angels.push(msg.sender);

        _mint(msg.sender, angelsNum);
        _setTokenURI(angelsNum++, "angelNft.com");
    }

    //Everyone can start a request. This is the method apply for help
    function requestHelp(string memory _name, string memory _email, string memory _description, uint256 _expectedAmount) public {
        requests.push(VictimRequest({
            id: requestsNum++,
            myAddress: payable(msg.sender),
            name: _name,
            email: _email,
            description: _description,
            expectedAmount: _expectedAmount,
            invalid: false,
            valid: false,
            approved: false,
            votingEndsAt: 0,
            yesVotes: 0,
            noVotes: 0
        }));
    }

    //The user can join as a volunteer through this method
    function joinAsVolunteer(string memory _name, string memory _introduction) public {
        Volunteer memory newVolunteer = Volunteer(volunteersNum++, msg.sender, _name, _introduction);
        volunteers.push(newVolunteer);
    }

    //This method is only for the governor to approve a request
    //The gevornor have to decide whether the request is scam or not, and if it is scam, he/she can reject it
    //If it's valid then it will get inserted into the requests which can be voted on
    function validateRequest(uint256 _requestId, bool _valid, uint256 _expectedAmount) public isGovernor{
        require(requests[_requestId].valid == false, "Governor already validated this request");

        if(_valid == true) {
            requests[_requestId].votingEndsAt = block.timestamp + VOTING_TIME;
            requests[_requestId].valid = true;
            requests[_requestId].expectedAmount = _expectedAmount;
        } else 
            requests[_requestId].invalid = true;
    }
    
    //This method changes the request amount of money to be paid to the victim
    //It is usueful if a victim seems legit, but requests way too much money
    function changeRequestedAmount(uint256 _requestId, uint256 _newAmount) public isGovernor{
        requests[_requestId].expectedAmount = _newAmount;
    }

    //This method transfers the requested amount to the victim only if the request has been voted YES by the majority of the angels
    function approveRequest(uint256 _requestId) public isGovernor{
        require(requests[_requestId].yesVotes > requests[_requestId].noVotes, "A request is only approved if it has won a voting");
        requests[_requestId].approved = true;
        address payable victimAddress = requests[_requestId].myAddress;
        victimAddress.transfer(requests[_requestId].expectedAmount * (10 ** 18));
    }

    //This method gets back the current vault balance
    function getVaultBalance() public view returns (uint256){
        return address(this).balance; 
    }

    //This function let's the users vote. The user can vote only once per request and only during its voting time.
    //Also the user have to be an angel to vote
    function vote(uint256 _requestId, Votes _voteNumber) public isVoter votingIsActive(_requestId) {
        require(alreadyVoted[msg.sender][_requestId] == false, "You already made your vote for this request");

        if(_voteNumber == Votes.YES){
            requests[_requestId].yesVotes++;
        }
        else{
            requests[_requestId].noVotes++;
        }
    }

    //Gets all the requests
    function getRequests() public view returns(VictimRequest[] memory){
        return requests;
    }

    //Gets all the volunteers
    function getVolunteers() public view returns(Volunteer[] memory){
        return volunteers;
    }
}