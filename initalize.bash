#!/bin/bash

# AWS Amplify Project Setup Script
# This script automates the setup process for an AWS Amplify project.
# It handles system updates, installation of necessary tools, and configuration of AWS and Amplify CLIs.

# Error handling: Exit immediately if a command fails, treat unset variables as an error,
# and ensure that pipeline failures are properly caught.
set -euo pipefail

# Function to log messages with timestamps
# Parameters:
#   $1: The message to log
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to log error messages
# Parameters:
#   $1: The error message to log
log_error() {
    log "ERROR: $1" >&2
}

# Function to check if a command is available
# Parameters:
#   $1: The command to check
check_command() {
    if ! command -v "$1" &> /dev/null; then
        log_error "Command '$1' could not be found. Please install it and try again."
        exit 1
    fi
}

# Function to install a package if it's not already installed
# Parameters:
#   $1: The name of the package to install
install_package() {
    if ! dpkg -s "$1" &> /dev/null; then
        log "Installing $1..."
        sudo apt install -y "$1" || { log_error "Failed to install $1"; exit 1; }
    else
        log "$1 is already installed."
    fi
}

# Function to configure AWS CLI
# This function reads AWS credentials from ~/.aws/credentials and prompts for region and profile
configure_aws_cli() {
    log "Configuring AWS CLI..."
    
    # Check if ~/.aws/credentials exists
    if [ ! -f ~/.aws/credentials ]; then
        log_error "AWS credentials file not found at ~/.aws/credentials"
        echo "Please set up your AWS credentials first. You can do this by running 'aws configure'."
        exit 1
    fi
    
    # Read AWS credentials
    AWS_ACCESS_KEY_ID=$(awk -F ' = ' '/aws_access_key_id/ {print $2}' ~/.aws/credentials)
    AWS_SECRET_ACCESS_KEY=$(awk -F ' = ' '/aws_secret_access_key/ {print $2}' ~/.aws/credentials)
    
    # Check if credentials were successfully read
    if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
        log_error "Failed to read AWS credentials from ~/.aws/credentials"
        echo "Please ensure your credentials are properly set in the file."
        exit 1
    fi
    
    # Export environment variables
    export AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY
    
    # Prompt for AWS region and profile
    read -p "Enter your AWS region: " AWS_DEFAULT_REGION
    read -p "Enter your AWS profile name: " AWS_PROFILE
    
    export AWS_DEFAULT_REGION
    export AWS_PROFILE
}

# Function to configure Amplify CLI in headless mode
configure_amplify_cli() {
    log "Configuring Amplify CLI..."
    amplify configure --headless <<EOF
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_DEFAULT_REGION}
javascript
${AWS_PROFILE}
EOF
}

# Main function that orchestrates the entire setup process
main() {
    # Prompt for the Amplify project name
    read -p "Enter the AWS Amplify project name: " project_name

    # Update and upgrade the system
    log "Updating system..."
    sudo apt update && sudo apt full-upgrade -y || { log_error "System update failed"; exit 1; }

    # Install necessary packages
    install_package unzip
    install_package curl

    # Install AWS CLI if not already installed
    if ! command -v aws &> /dev/null; then
        log "Installing AWS CLI..."
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" || { log_error "AWS CLI download failed"; exit 1; }
        unzip awscliv2.zip || { log_error "AWS CLI unzip failed"; exit 1; }
        sudo ./aws/install || { log_error "AWS CLI installation failed"; exit 1; }
        rm awscliv2.zip
        rm -rf aws
    else
        log "AWS CLI is already installed."
    fi

    # Install Node Version Manager (NVM) and Node.js if not already installed
    if [ ! -d "$HOME/.nvm" ]; then
        log "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash || { log_error "NVM installation failed"; exit 1; }
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install node || { log_error "Node.js installation failed"; exit 1; }
    else
        log "NVM is already installed."
    fi

    # Verify all required tools are installed
    log "Verifying installations..."
    check_command nvm
    check_command node
    check_command npm
    check_command aws

    # Configure AWS CLI
    configure_aws_cli

    # Install Amplify CLI if not already installed
    if ! command -v amplify &> /dev/null; then
        log "Installing Amplify CLI..."
        npm install -g @aws-amplify/cli || { log_error "Amplify CLI installation failed"; exit 1; }
    else
        log "Amplify CLI is already installed."
    fi

    # Configure Amplify CLI
    configure_amplify_cli

    # Initialize a new Amplify project
    log "Initializing Amplify project '$project_name'..."
    mkdir -p "$project_name" && cd "$project_name" || { log_error "Failed to create project directory"; exit 1; }
    amplify init

    log "AWS Amplify project '$project_name' has been initialized successfully."
}

# Run the main function
main

# Note: This script automates the setup of an AWS Amplify project, including system updates,
# installation of necessary tools (AWS CLI, NVM, Node.js, Amplify CLI), and configuration of
# AWS and Amplify CLIs. It reads AWS credentials from ~/.aws/credentials for security.
# The script is designed to be robust, with error checking and informative logging throughout.
# However, please ensure you understand each step before running this script, especially
# in a production environment. Always follow AWS best practices for credential management.