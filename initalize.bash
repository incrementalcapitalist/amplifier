#!/bin/bash

# Prompt the user for the Amplify project name
read -p "Enter the AWS Amplify project name: " project_name

# Initialize an error flag
errors="NO"

# Function to log and set the error flag
log_error() {
    echo "Error occurred in: $1"
    errors="YES"
}

# Update and upgrade the system
sudo apt update || log_error "apt update"
sudo apt full-upgrade -y || log_error "apt full-upgrade"

# Install necessary packages
sudo apt install unzip curl -y || log_error "install unzip and curl"

# Download and install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" || log_error "download AWS CLI"
unzip awscliv2.zip || log_error "unzip AWS CLI"
sudo ./aws/install || log_error "install AWS CLI"
rm awscliv2.zip || log_error "remove awscliv2.zip"
rm -rf aws || log_error "remove aws directory"

# Install Node Version Manager (NVM) and Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash || log_error "install NVM"
source ~/.nvm/nvm.sh
nvm install node || log_error "install Node.js"

# Verify installations
nvm -v
node -v
npm -v
aws --version

# Conditional logging based on errors
if [ "$errors" == "YES" ]; then
    echo "There were errors during the installation. Please check the log above."
else
    echo "All packages installed successfully."
    echo "nvm installed..."
    echo "Node.js installed..."
    echo "AWS CLI installed. PATH updated and reloaded..."
fi

# Configure AWS CLI
echo "Configuring AWS programmatic access"
aws configure

# Install Amplify CLI
npm install -g @aws-amplify/cli || log_error "install Amplify CLI"
amplify --version

# Configure Amplify CLI
amplify configure

# Initialize a new Amplify project with the specified project name
mkdir "$project_name"
cd "$project_name"
amplify init

echo "AWS Amplify project '$project_name' has been initialized successfully."
