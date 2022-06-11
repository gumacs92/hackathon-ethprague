// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract crossDAO is ERC721URIStorage, Ownable {

constructor() ERC721("Angel", "AT"){
    governors.push(msg.sender);
}

struct RobRequest {
    address myAddress;
    string description;
    string imageUrl;
}

struct Volunteers { 
    address myAddress;
    // uint8 country; /Do we need countrys right now?
    string city;
    string description;
    //string contractInfo; // Kell-e kontaktinfó? mondjuk telefonszám / E-mail 
}

Volunteers [] newVolunteer;

uint256 angelTokenId;
address[] angels; //  who can vote in a proposal
string angelURI = "something.com"; // ide jön majd az ipfs uri link ami az angel NFT imagét mutatja
address[] governors; 

mapping(address => bool) hasVoted;
mapping(address => uint256) votingPower; // Kell ez most?


// Countrys for name, default 3

// uint8 Czech = 1;
// uint8 Slovakia = 2;
// uint8 Hungary = 3;

modifier isVoter () {
    bool voter = false;
    for(uint i = 0; i < angels.length; i++){
        if(msg.sender == angels[i]){
            voter = true;
        }
    }
    require(voter == true, "Governor: You do not have the privile to vote on this proposal!");
    _;
}

modifier isGovernor() {
    bool governor = false;
    for(uint i = 0; i < governors.length; i++){
        if(msg.sender == governors[i]){
           governor = true;
        }
    }
    require(governor == true, "Governing: You are not a governor so you cannot make a proposal!");
     _;
}

// Donate function amiben elmentjük a donatelőt is, hozzáadjuk az angel structhoz vagy arrayhez + mintelünk NFT-t
 function donate() public payable{
    angels.push(msg.sender);
    _mint(msg.sender, angelTokenId);
    _setTokenURI(angelTokenId, angelURI);
    angelTokenId ++;
 }

 function joinAsVolunteer(string memory _introduction, string memory _city) public { 
    Volunteers memory addVolunteer = Volunteers(msg.sender, _city, _introduction);
    newVolunteer.push(addVolunteer);
}

function getHelp() public view returns (Volunteers[] memory){
    // Ez itt kilistázná az összes volunteert aki tud valamibe segíteni, countryt még most lehet haggyjuk ki
    // Itt még van olyan ötletem, hogy esetleg ezt fordítsuk meg, valaki submitel valamit, hogy kéne neki segítség itt meg itt
    // aztán megadja a kontakt infóját és ráírnak
    return newVolunteer;
}

function getDefaultVaultBalance() public view returns (uint256){
    return address(this).balance; // gets back main vault Balance
}

function proposeFunding(address _selectedAddress) public isGovernor { // ez sima pénzküldési propose egy adott személynek
    
}



// function proposeNewFunding(address _newVault, string memory _description) public {
//         Itt ezt ugyanúgy csak governor tudja megtenni, nyit egy új vault address-t amire lehet donatelni
//         Pl volt egy földrengés és az ottani embereket akarják segíteni ezzel minden pénzel ami befolyik
//     Itt pl ezt lehessen látni mennyi pénz ment be eddig a megadott Vaultba 
// }

// governance smart contractot is inheritálhatjuk, bár ez nem teljesen szükséges
// Berakjuk az Ownable-t is, az az address lesz majd az egyik governor


// Functionok - Structok
// Kell egy Struct amibe valaki, hogyha jelentkezik, hogy meglopták, abba mik kellenek ==>
// (név, address, hogy vesztette el a pénzét(description), kép vagy képek amit esetleg ipfs-re feltölt proof miatt
// Lehet Egy Angel Struct is ami csak annyit listáz, hogy ki az aki már donatelt és ki nem ( Angeleknek van voting Powerjük )
// Hogyan határozzuk meg a voting Powert?

// Ez ahhoz a részhez fog kelleni amit tegnap este beszéltünk, hogy mindenki beregisztrál, hogy mit csinál mibe tudna segíteni
// Erre is kelleni egy Struct amiben követnénk, hogy kiről milyen infó van
// A fő cél ugye az lenne, hogy ezzel olyan globális hálót alakítunk ki amiben a lehető leggyorsabban tudunk segíteni aki bajban van
// Ezt lehetne tovább fokozni majd később fizetési formákban ( csak opció de ez is egy út lehet ) hogy valahonnan legyen funding
// hogyha már nagy lesz a DAO 

// Ez itt egy olyan function lenne, hogy valaki felsubmitol valamit, hogy elakadt a kocsija, kéne neki orvosi kivizsgálás
// de nincs rá pénze, bármi, ez bemenne egy közös helyre ahol a már segítő emberek megtudnák nézni, hogy tud e segíteni vagy sem
// Ez lehetne itt akár lens-el is később  

// function submitHelp(address _address, uint256 _country, string memory _description) public {
    // Itt ezt bemenne valami adatbázisba amit mindenki lát, itt valami kontakt method majd kelleni fog
// }

//Csak Governor írhatja ki, itt lesz egy amount, description és aztán erre lehet majd szavazni


// function addGovernor() public {

// }
}