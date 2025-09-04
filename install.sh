#!/bin/bash
set -e

# 1. Update system
sudo apt update && sudo apt upgrade -y

# 2. Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 3. Load Rust environment
source $HOME/.cargo/env

# 4. Check Rust version
rustc --version
cargo --version

# 5. Permanently add cargo env to bashrc
if ! grep -q 'source $HOME/.cargo/env' ~/.bashrc; then
  echo 'source $HOME/.cargo/env' >> ~/.bashrc
fi
source ~/.bashrc

# 6. Install Soundness CLI
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

# 7. Reload bashrc
source ~/.bashrc

# 8. Install with soundnessup
soundnessup install

