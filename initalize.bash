#!/bin/bash

set -euo pipefail

# Function to log messages
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to log errors
log_error() {
    log "ERROR: $1" >&2
}

# Function to check command availability
check_command() {
    if ! command -v "$1" &> /dev/null; then
        log_error "Command '$1' could not be found. Please install it and try again."
        exit 1
    fi
}

# Function to install a package
install_package() {
    if ! dpkg -s "$1" &> /dev/null; then
        log "Installing $1..."
        sudo apt install -y "$1" || { log_error "Failed to install $1"; exit 1; }
    else
        log "$1 is already installed."
    fi
}

# Main script execution
main() {
    # Prompt the user for the Amplify project name
    read -p "Enter the AWS Amplify project name: " project_name

    # Update and upgrade the system
    log "Updating system..."
    sudo apt update && sudo apt full-upgrade -y || { log_error "System update failed"; exit 1; }

    # Install necessary packages
    install_package unzip
    install_package curl

    # Download and install AWS CLI
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

    # Install Node Version Manager (NVM) and Node.js
    if [ ! -d "$HOME/.nvm" ]; then
        log "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash || { log_error "NVM installation failed"; exit 1; }
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install node || { log_error "Node.js installation failed"; exit 1; }
    else
        log "NVM is already installed."
    fi

    # Verify installations
    log "Verifying installations..."
    check_command nvm
    check_command node
    check_command npm
    check_command aws

    # Configure AWS CLI
    log "Configuring AWS CLI..."
    aws configure

    # Install Amplify CLI
    if ! command -v amplify &> /dev/null; then
        log "Installing Amplify CLI..."
        npm install -g @aws-amplify/cli || { log_error "Amplify CLI installation failed"; exit 1; }
    else
        log "Amplify CLI is already installed."
    fi

    # Configure Amplify CLI
    log "Configuring Amplify CLI..."
    amplify configure

    # Initialize a new Amplify project
    log "Initializing Amplify project '$project_name'..."
    mkdir -p "$project_name" && cd "$project_name" || { log_error "Failed to create project directory"; exit 1; }
    amplify init

    log "AWS Amplify project '$project_name' has been initialized successfully."
}

# Run the main function
main
