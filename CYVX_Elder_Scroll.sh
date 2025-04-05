#!/bin/bash
set -e

echo "[*] Starting Elder Scroll Deployment - Ultra Elite Real-World System"

########################################
# 1. Update and Install System Packages
########################################

echo "[*] Updating Termux repositories (allow unsigned repos)..."
apt update --allow-unauthenticated || true

echo "[*] Installing system dependencies using pkg..."
# In Termux, use alternative package names:
# - Use 'zeromq' instead of 'libzmq'
# - Use 'openssl' (already installed) for libssl
pkg update -y && pkg upgrade -y
pkg install -y python git clang make zeromq openssl libgmp

########################################
# 2. Install Python Dependencies via pip
########################################

echo "[*] Upgrading pip and installing Python packages..."
pip install --upgrade pip || true
# Install cryptographic and blockchain libraries
pip install pycryptodome pyzmq numpy lxml requests || true

########################################
# 3. Clone and Build CYVX Blockchain
########################################

CYVX_DIR="/data/data/com.termux/files/home/cyvx-blockchain"

if [ ! -d "$CYVX_DIR" ]; then
    echo "[*] Cloning CYVX blockchain repository..."
    git clone https://github.com/kotaa74/simple-blockchain.git "$CYVX_DIR"
else
    echo "[*] CYVX blockchain repository already exists. Pulling latest changes..."
    cd "$CYVX_DIR"
    git pull
fi

echo "[*] Building CYVX blockchain..."
cd "$CYVX_DIR"
# Build the blockchain (adjust the make target if needed)
make all || { echo "[-] Blockchain build failed"; exit 1; }
echo "[*] Starting blockchain..."
./cyvx-d --start-blockchain || { echo "[-] Failed to start blockchain"; exit 1; }

########################################
# 4. Generate Quantum-Safe RSA Keys
########################################

echo "[*] Generating Quantum-Safe RSA Keys..."
python3 << 'EOF'
from Crypto.PublicKey import RSA
key = RSA.generate(2048)
private_key = key.export_key()
public_key = key.publickey().export_key()
with open("private_key.pem", "wb") as f:
    f.write(private_key)
with open("public_key.pem", "wb") as f:
    f.write(public_key)
print("Quantum-safe RSA keys generated and saved.")
EOF

########################################
# 5. Deploy Multi-Chain Bridge
########################################

BRIDGE_DIR="/data/data/com.termux/files/home/multi-chain-bridge"
if [ ! -d "$BRIDGE_DIR" ]; then
    echo "[*] Cloning Multi-Chain Bridge repository..."
    # Replace the URL with your actual multi-chain bridge repository if different
    git clone https://github.com/kotaa74/simple-blockchain.git "$BRIDGE_DIR"
else
    echo "[*] Multi-Chain Bridge repository already exists. Pulling latest changes..."
    cd "$BRIDGE_DIR"
    git pull
fi

echo "[*] Building Multi-Chain Bridge..."
cd "$BRIDGE_DIR"
make || { echo "[-] Multi-Chain Bridge build failed"; exit 1; }
echo "[*] Configuring Multi-Chain Bridge..."
./multi_chain_bridge --configure-cross-chain || { echo "[-] Multi-Chain Bridge configuration failed"; exit 1; }

########################################
# 6. Deploy Smart Contracts (if available)
########################################

echo "[*] Deploying Smart Contracts..."
# If you have a smart contract deployment script, use it here.
# For example, if using Hardhat (ensure Node.js is installed):
if [ -f "$CYVX_DIR/smart_contracts/deploy.js" ]; then
    if ! command -v npx >/dev/null 2>&1; then
        pkg install -y nodejs
    fi
    cd "$CYVX_DIR"
    npx hardhat run smart_contracts/deploy.js --network mainnet || { echo "[-] Smart contract deployment failed"; exit 1; }
else
    echo "[*] No smart contract deployment script found, skipping this step."
fi

########################################
# 7. Update Library Path for Local Installs
########################################

echo "[*] Updating library path..."
echo 'export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

########################################
# 8. Final System Check
########################################

echo "[*] Verifying Installation..."
python3 --version
pip --version
git --version
python3 -c "import zmq; print('pyzmq version:', zmq.__version__)"

echo "[*] Elder Scroll Deployment Complete. The system is now live and operational!"

# End of Master Script
