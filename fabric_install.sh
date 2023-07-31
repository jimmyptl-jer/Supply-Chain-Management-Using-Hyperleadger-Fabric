#!/bin/bash

# Ask the user to enter their GitHub user ID
read -p "Enter your GitHub user ID: " GITHUB_USERID

# Create the required directory structure
mkdir -p $HOME/go/src/github.com/$GITHUB_USERID
cd $HOME/go/src/github.com/$GITHUB_USERID

# Download the installation script
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh

# Run the installation script with desired options
./install-fabric.sh docker samples binary

# Alternatively, you can use the following command to specify the Fabric version
# ./install-fabric.sh --fabric-version 2.5.0 binary

