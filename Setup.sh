#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to display error messages and exit
error() {
    echo "Error: $1"
    exit 1
}

# Update package lists
if ! sudo apt update; then
    error "Failed to update package lists."
fi

# Install necessary packages
REQUIRED_PACKAGES=("python3" "python3-venv" "python3-pip")
for package in "${REQUIRED_PACKAGES[@]}"; do
    if ! dpkg -l | grep -q "$package"; then
        if ! sudo apt install -y "$package"; then
            error "Failed to install package: $package"
        fi
    fi
done

# Create a virtual environment
VENV_DIR="venv"
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR" || error "Failed to create virtual environment"
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate" || error "Failed to activate virtual environment"

# Upgrade pip
if ! pip install --upgrade pip; then
    error "Failed to upgrade pip"
fi

echo "VVE setup completed successfully!"