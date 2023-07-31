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

**Step 2: Clone the fabric-samples Repository**

- Clone the fabric-samples repository from GitHub:
   git clone https://github.com/hyperledger/fabric-samples.git
   cd fabric-samples

- Install Hyperledger Fabric Binaries and Docker Images:
  curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh | bash -s -- docker samples binary

- Navigate to the fabric-samples/test-network directory:
  cd fabric-samples/test-network

- Generate Crypto Material:
  ../bin/cryptogen generate --config=./crypto-config.yaml

- Generate the channel artifacts:
   ./network.sh generateArtifacts

- Start the Network:
  ./network.sh up

- Create and Join Channels:
  ./network.sh createChannel
  ./network.sh joinChannel

- Deploy and Instantiate Chaincode:
  ./network.sh deployCC -ccn <chaincode-name> -ccp <chaincode-path> -ccl <chaincode-language>

- To shut down the network: 
  ./network.sh down
