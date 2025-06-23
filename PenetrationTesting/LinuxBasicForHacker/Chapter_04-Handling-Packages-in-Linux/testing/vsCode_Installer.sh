#!/bin/bash

# VSCode Installation Script for Kali Linux/Debian-based systems

# Function to print colored output
print_message() {
    COLOR=$1
    TEXT=$2
    NC='\033[0m' # No Color
    case $COLOR in
        "red")     COLOR_CODE='\033[0;31m' ;;
        "green")   COLOR_CODE='\033[0;32m' ;;
        "yellow")  COLOR_CODE='\033[1;33m' ;;
        "blue")    COLOR_CODE='\033[0;34m' ;;
        *)         COLOR_CODE='\033[0m' ;;
    esac
    echo -e "${COLOR_CODE}${TEXT}${NC}"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_message "red" "Please run this script as root or using sudo"
    exit 1
fi

# Step 1: Update system
print_message "blue" "Step 1: Updating system packages..."
apt update -y
if [ $? -ne 0 ]; then
    print_message "red" "Failed to update packages"
    exit 1
fi

# Step 2: Install dependencies
print_message "blue" "Step 2: Installing required dependencies..."
apt install -y software-properties-common apt-transport-https wget gpg
if [ $? -ne 0 ]; then
    print_message "red" "Failed to install dependencies"
    exit 1
fi

# Step 3: Add Microsoft repository and GPG key
print_message "blue" "Step 3: Adding Microsoft repository and GPG key..."

# Download and install Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
if [ $? -ne 0 ]; then
    print_message "red" "Failed to download Microsoft GPG key"
    exit 1
fi

install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
if [ $? -ne 0 ]; then
    print_message "red" "Failed to install GPG key"
    exit 1
fi

# Add VSCode repository
sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
if [ $? -ne 0 ]; then
    print_message "red" "Failed to add VSCode repository"
    exit 1
fi

# Clean up temporary file
rm -f packages.microsoft.gpg

# Step 4: Install VSCode
print_message "blue" "Step 4: Installing Visual Studio Code..."
apt update -y
if [ $? -ne 0 ]; then
    print_message "red" "Failed to update package lists after adding repository"
    exit 1
fi

apt install -y code
if [ $? -ne 0 ]; then
    print_message "red" "Failed to install Visual Studio Code"
    exit 1
fi

# Completion message
print_message "green" "\nVisual Studio Code has been successfully installed!"
print_message "yellow" "You can now launch it from your application menu or by running 'code' in the terminal."
