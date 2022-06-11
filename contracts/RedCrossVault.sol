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

    address elfiContractAddress;

    uint256 requestsNum = 0;
    VictimRequest[] requests;

    uint256 angelsNum = 0;
    string angelURI = "something.com"; // ide jön majd az ipfs uri link ami az angel NFT imagét mutatja
    Angel[] angels;


    constructor(address elfiContract) ERC721("Angel", "AT"){ 
        elfiContractAddress = elfiContract;
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

    function requestHelp(VictimRequestInput memory input) public {
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