#!/bin/bash

# Define essential functions for ultra-elite deployment logic

# Function to update and ensure package integrity
update_and_install_packages() {
    echo "Updating repositories and upgrading packages..."
    apt update && apt upgrade -y
    echo "Installing necessary packages..."
    apt install -y python-pip libssl-dev libffi-dev curl git
    if [ $? -ne 0 ]; then
        echo "Error: Some packages could not be installed, attempting to resolve..."
        apt install -y libssl1.0-dev libffi6
    fi
}

# Function to ensure that necessary scripts are executable
set_permissions() {
    echo "Setting execute permissions for necessary scripts..."
    chmod -R +x ./scripts/*.sh
    if [ $? -ne 0 ]; then
        echo "Error: Unable to set execute permissions, please check directory permissions."
        exit 1
    fi
}

# Function to verify and install missing dependencies manually if necessary
install_missing_dependencies() {
    echo "Checking for missing dependencies..."

    # Manually install dependencies if they are missing
    dpkg-query -W -f='${Status}' libssl-dev 2>/dev/null | grep -q "install ok installed"
    if [ $? -ne 0 ]; then
        echo "libssl-dev not installed, installing now..."
        apt install libssl-dev
    fi

    dpkg-query -W -f='${Status}' libffi-dev 2>/dev/null | grep -q "install ok installed"
    if [ $? -ne 0 ]; then
        echo "libffi-dev not installed, installing now..."
        apt install libffi-dev
    fi
}

# Function to check and fix file permissions across the blockchain project
fix_permissions() {
    echo "Verifying and fixing file permissions for blockchain directories..."
    chown -R $(whoami):$(whoami) ./
    chmod -R u+rwX ./scripts
}

# Function to pull latest changes from CYVX blockchain repository
pull_latest_changes() {
    echo "Pulling latest changes from CYVX Blockchain repository..."
    git pull
    if [ $? -ne 0 ]; then
        echo "Error: Failed to pull latest changes, please check repository."
        exit 1
    fi
}

# Function to run all deployment scripts
run_deployment_scripts() {
    echo "Running CYVX Blockchain deployment scripts..."
    ./scripts/init_node.sh && ./scripts/deploy_smart_contracts.sh && \
    ./scripts/deploy_staking.sh && ./scripts/deploy_ai_governance.sh && \
    ./scripts/deploy_security.sh && ./scripts/add_nodes.sh && \
    ./scripts/start_blockchain.sh && ./scripts/setup_governance.sh && \
    ./scripts/health_check.sh

    if [ $? -ne 0 ]; then
        echo "Error: Deployment failed at some point, check individual scripts."
        exit 1
    fi
}

# Function to confirm successful deployment and finalize setup
finalize_setup() {
    echo "CYVX Blockchain deployment completed successfully!"
    echo "All systems operational and secure."
}

# Full self-contained deployment process with ultra-elite automation logic
main() {
    echo "Starting CYVX Blockchain Ultra-Elite Deployment..."
    
    # Step 1: Update and Install Packages
    update_and_install_packages

    # Step 2: Fix missing dependencies
    install_missing_dependencies

    # Step 3: Ensure all necessary files have correct permissions
    set_permissions

    # Step 4: Fix directory and script permissions
    fix_permissions

    # Step 5: Pull the latest CYVX Blockchain repository changes
    pull_latest_changes

    # Step 6: Run the deployment scripts
    run_deployment_scripts

    # Step 7: Finalize and confirm successful deployment
    finalize_setup
}

# Execute the full deployment process
main
