# Supply-Chain---Blockchain

Step by Step guide to implemenet the hyperledger fabric:

**Step 1: Set up the Prerequisites**

- Operating system (Ubuntu Linux 14.04 / 16.04 LTS or Mac OS 10.12)
- Install the required software:
   Docker Engine (version 17.03 or higher)
          $ sudo apt install docker.io
          

   Docker Compose (version 1.8 or higher)
          $ sudo apt install docker-compose
  
   Node.js (version 8.9 or higher)
          $ sudo apt install nodejs
          $ node -v or node –version
   Go
          $ sudo apt-get update
          $ sudo apt-get install golang-go
  
  npm (version 5.x)
         $ sudo apt-get update
         $ sudo apt-get upgrade
  Git (version 2.9.x or higher)
         $ sudo apt-get update
         $ sudo apt-get install git
         $ git --version

  Python (version 2.7.x)
        $ sudo apt-get install python-software-properties

**Implementing Hyperledger Fabric involves several steps, including setting up the prerequisites, installing the necessary software, creating the network configuration, generating crypto material, and deploying and interacting with the network. Below is a step-by-step guide to help you get started:**

Step 1: Set up the Prerequisites
- Ensure you have a supported operating system (Ubuntu Linux 14.04 / 16.04 LTS or Mac OS 10.12).
- Install the required software: Docker Engine (version 17.03 or higher), Docker Compose (version 1.8 or higher), Node.js (version 8.9 or higher), npm (version 5.x), Git (version 2.9.x or higher), Python (version 2.7.x), and a code editor (e.g., VSCode).

Step 2: Clone the fabric-samples Repository
- Open a terminal and navigate to your desired location to store the Hyperledger Fabric sample code.
- Clone the fabric-samples repository from GitHub:

```bash
git clone https://github.com/hyperledger/fabric-samples.git
cd fabric-samples
```

Step 3: Install Hyperledger Fabric Binaries and Docker Images
- Run the `install-fabric.sh` script to download the Hyperledger Fabric binaries and Docker images:

```bash
curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh | bash -s -- <components>
```

Replace `<components>` with the components you want to install. For example, to install Docker images, samples, and binaries, use:

```bash
curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh | bash -s -- docker samples binary
```

Step 4: Set up Network Configuration
- Navigate to the `fabric-samples/test-network` directory:

```bash
cd fabric-samples/test-network
```

- Customize the network configuration (e.g., number of organizations, peers, channels, etc.) by modifying the `network.sh` script or other configuration files.

Step 5: Generate Crypto Material
- Generate the crypto material using the `cryptogen` tool. Make sure you have already updated the `crypto-config.yaml` file (as described in a previous answer) to include all the organizations you want to include in the network.

```bash
../bin/cryptogen generate --config=./crypto-config.yaml
```

Step 6: Set up Channel Artifacts
- Generate the channel artifacts (genesis block and channel configuration transaction) for your channels:

```bash
./network.sh generateArtifacts
```

Step 7: Start the Network
- Start the network using Docker Compose:

```bash
./network.sh up
```

Step 8: Create and Join Channels
- Create channels and let peers join the channels:

```bash
./network.sh createChannel
./network.sh joinChannel
```

Step 9: Deploy and Instantiate Chaincode
- Deploy and instantiate the chaincode on the channels:

```bash
./network.sh deployCC -ccn <chaincode-name> -ccp <chaincode-path> -ccl <chaincode-language>
```

Replace `<chaincode-name>`, `<chaincode-path>`, and `<chaincode-language>` with your chaincode details.

Step 10: Interact with the Network
- You can use the provided scripts or develop your own applications to interact with the deployed chaincode and query or invoke transactions on the network.

Step 11: Stop the Network
- When you are done working with the network, you can stop and clean up the containers:

```bash
./network.sh down
```

Example of a smart contract for a dairy supply chain management project using Hyperledger Fabric's chaincode. In this example, we'll create a smart contract to manage dairy products moving through the supply chain. The contract will allow the creation, updating, and reading of dairy products, and it will also record the history of each product's movement.

```javascript
const { Contract } = require('fabric-contract-api');

class DairySupplyChainContract extends Contract {
  async initLedger(ctx) {
    // Initialize the ledger with sample dairy products (optional)
    const dairyProducts = [
      {
        id: 'product1',
        name: 'Milk',
        manufacturer: 'Dairy Farm Ltd',
        productionDate: '2023-06-01',
        expiryDate: '2023-06-15',
        currentLocation: 'Warehouse A',
        owner: 'Tom',
        history: [],
      },
      {
        id: 'product2',
        name: 'Cheese',
        manufacturer: 'CheeseCo Inc',
        productionDate: '2023-05-20',
        expiryDate: '2023-12-31',
        currentLocation: 'Warehouse B',
        owner: 'Jerry',
        history: [],
      },
      // Add more sample dairy products if needed
    ];

    for (const product of dairyProducts) {
      await ctx.stub.putState(product.id, Buffer.from(JSON.stringify(product)));
      console.log('Dairy product added to ledger:', product);
    }
  }

  async createDairyProduct(ctx, id, name, manufacturer, productionDate, expiryDate, location, owner) {
    // Create a new dairy product on the ledger
    const newProduct = {
      id,
      name,
      manufacturer,
      productionDate,
      expiryDate,
      currentLocation: location,
      owner,
      history: [],
    };

    await ctx.stub.putState(id, Buffer.from(JSON.stringify(newProduct)));
    console.log('New dairy product created:', newProduct);

    return JSON.stringify(newProduct);
  }

  async updateProductLocation(ctx, id, newLocation) {
    // Update the location of a dairy product on the ledger
    const productBytes = await ctx.stub.getState(id);

    if (!productBytes || productBytes.length === 0) {
      throw new Error(`Dairy product ${id} not found`);
    }

    const product = JSON.parse(productBytes.toString());
    product.currentLocation = newLocation;
    product.history.push({ location: newLocation, timestamp: new Date().toISOString() });

    await ctx.stub.putState(id, Buffer.from(JSON.stringify(product)));
    console.log('Dairy product location updated:', product);

    return JSON.stringify(product);
  }

  async readDairyProduct(ctx, id) {
    // Read a dairy product from the ledger
    const productBytes = await ctx.stub.getState(id);

    if (!productBytes || productBytes.length === 0) {
      throw new Error(`Dairy product ${id} not found`);
    }

    return productBytes.toString();
  }

  async getDairyProductHistory(ctx, id) {
    // Get the history of a dairy product from the ledger
    const productBytes = await ctx.stub.getState(id);

    if (!productBytes || productBytes.length === 0) {
      throw new Error(`Dairy product ${id} not found`);
    }

    const product = JSON.parse(productBytes.toString());
    return JSON.stringify(product.history);
  }
}

module.exports = DairySupplyChainContract;
```

In this smart contract, we added fields such as `name`, `manufacturer`, `productionDate`, `expiryDate`, and `owner` specific to dairy products. 

Once you deploy this smart contract and interact with it using the Node.js application, it will allow you to manage dairy products and record their movement history in the supply chain.

**After deploying your network and smart contracts, the next steps typically involve interacting with the network through client applications. These applications can be developed using various programming languages such as Node.js, Java, Go, etc. For this example, we'll provide a simple guide using Node.js as the programming language.**

Step 1: Set up the development environment

1. Make sure you have Node.js and npm (Node Package Manager) installed on your system. You can install them using the following commands:

```bash
sudo apt-get update
sudo apt-get install nodejs
sudo apt-get install npm
```

2. Verify the installations:

```bash
node -v
npm -v
```

Step 2: Create a new directory for your client application:

```bash
mkdir fabric-client-app
cd fabric-client-app
```

Step 3: Initialize the Node.js project:

```bash
npm init -y
```

Step 4: Install the required dependencies:

For interacting with the Hyperledger Fabric network, you'll need the Fabric SDK for Node.js. Additionally, you may need other dependencies based on the requirements of your client application.

```bash
npm install fabric-network
npm install fabric-ca-client
npm install dotenv
# Add other dependencies if needed
```

Step 5: Create a `.env` file in the root of your project to store environment variables:

```bash
touch .env
```

Edit the `.env` file and add the necessary environment variables for your network configuration, such as connection profile path, wallet path, user credentials, etc.

Example `.env` content:

```plaintext
NETWORK_CONNECTION_PROFILE=./path/to/connection-profile.json
WALLET_PATH=./path/to/wallet
USER_NAME=user1
USER_SECRET=user1pw
CHANNEL_NAME=mychannel
CONTRACT_NAME=mycontract
```

Step 6: Create your client application code:

In this step, you will write the Node.js code to interact with the deployed smart contract on the Hyperledger Fabric network. The exact code will depend on the functionality you want to implement, such as submitting transactions, querying data, etc.

Here's a simple example of a Node.js application to submit a transaction to the smart contract:

```javascript
const { Gateway, Wallets } = require('fabric-network');
const path = require('path');
const fs = require('fs');

async function main() {
  try {
    const ccpPath = path.resolve(__dirname, process.env.NETWORK_CONNECTION_PROFILE);
    const walletPath = path.resolve(__dirname, process.env.WALLET_PATH);

    const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf8'));
    const wallet = await Wallets.newFileSystemWallet(walletPath);

    const gateway = new Gateway();
    await gateway.connect(ccp, {
      wallet,
      identity: process.env.USER_NAME,
      discovery: { enabled: true, asLocalhost: true }
    });

    const network = await gateway.getNetwork(process.env.CHANNEL_NAME);
    const contract = network.getContract(process.env.CONTRACT_NAME);

    // Submit a transaction to the smart contract
    await contract.submitTransaction('TransactionFunction', 'arg1', 'arg2');

    console.log('Transaction submitted successfully.');

    await gateway.disconnect();
  } catch (error) {
    console.error(`Error submitting transaction: ${error}`);
    process.exit(1);
  }
}

main();
```

Replace `'TransactionFunction'`, `'arg1'`, and `'arg2'` with the actual function name and arguments of your smart contract that you want to invoke.

Step 7: Run the client application:

```bash
node app.js
```

This will execute your client application, and it will interact with the deployed smart contract on the Hyperledger Fabric network.

Please note that this is just a simple example, and in a real-world scenario, you may need to implement more complex client applications based on your specific use case and requirements.

Keep in mind that the specific details and code may vary depending on your network configuration and smart contract implementation. Make sure to adapt the code to match your specific use case and configurations.

Always ensure that you have appropriate security measures in place and handle sensitive information, such as user credentials, carefully in your client application.
