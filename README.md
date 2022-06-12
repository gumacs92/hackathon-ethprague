# Red-Cross-Crypto / Decentralized Charity
Developed at [ETHPrague 2022]  

## About
The Project does a few things already, but phase2 still needs to be developed. The most basic implementation is that anyone can submit a request who is in trouble ( for example if somebody's house has been destroyed by an earthquake or simply has been hacked, then he or she can request a little money for assistance. Of course in this case they will need to add some proof, DAO would not just give out money for everyone who requests it ). After the request the governor can validate the request and decide whether it is worthy to put on a voting period. If the governor deems it appropriate, then the voting period begins. If the voting period ends with more yesVotes than noVotes then the governor can send the requested amount to the target in need (Governor can aldo change the amount if he thinks it's too high)

Right now only those people can vote who have made some donation in the DAO. Of course later on we plan to change this, so a dedicated team of charitable people can steer the decision of this DAO.

## Contracts

[📚 RedCrossVault]

### Built with:

-Nuxt.js
-TailwindCSS
-Moralis
-Solidity


### Dev Environemnt

We have been working with Ganache local blockchain, so we suggest using that too. If installed, then start a Ganache blockchain on http://127.0.0.1:7545)

1. Make `.env`

```shell
touch .env
```

add environment variable

```text
MORALIS_APP_ID=<your-moralis-app-id-here>
MORALIS_SERVER_URL=<your-moralis-server-url-here>
```

3. Install dependencies

```bash
npm install
```

4. Deploy contract on the running local blockchain

```bash
npm run deploy
```

4. Start developmment

```bash
npm run dev
```

5. 📱 Open http://localhost:3000 to see the app