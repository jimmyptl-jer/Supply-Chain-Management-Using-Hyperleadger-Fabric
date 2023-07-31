#!/bin/bash

# Update package lists
sudo apt-get update

# Install Docker Engine
sudo apt-get install -y docker.io

# Install Docker-Compose
sudo apt-get install -y docker-compose

# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install git
sudo apt-get install -y git

# Install Python
sudo apt-get install -y python2.7

# Install npm v5.x
sudo npm install -g npm@5

# Install VSCode (optional, uncomment the following line if you want to install it)
# sudo snap install code

# Add the current user to the docker group to run docker commands without sudo
sudo usermod -aG docker $USER

echo "Installation complete."
