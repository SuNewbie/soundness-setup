#!/bin/bash
set -e

echo "=== Update & upgrade ==="
sudo apt update && sudo apt upgrade -y

echo "=== Install Rust ==="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo "=== Check Rust version ==="
rustc --version
cargo --version

echo "=== Add Rust env to bashrc if missing ==="
grep -q 'source \$HOME/.cargo/env' ~/.bashrc || echo 'source $HOME/.cargo/env' >> ~/.bashrc
source ~/.bashrc

echo "=== Install Soundness CLI ==="
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

echo "=== Run CLI installer ==="
exec bash -l -c "soundnessup install"

echo "=== Selesai! Restart terminal atau jalankan 'source ~/.bashrc' lagi ==="
