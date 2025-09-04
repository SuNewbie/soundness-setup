#!/bin/bash
set -e

# 1. Update system
sudo apt update && sudo apt upgrade -y

# 2. Install Rust (skip kalau sudah ada)
if ! command -v rustc >/dev/null 2>&1; then
  echo "[*] Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
else
  echo "[✔] Rust already installed: $(rustc --version)"
fi

# 3. Load Rust environment
source $HOME/.cargo/env

# 4. Check Rust version
rustc --version
cargo --version

# 5. Add cargo env to bashrc if missing
if ! grep -q 'source $HOME/.cargo/env' ~/.bashrc; then
  echo 'source $HOME/.cargo/env' >> ~/.bashrc
fi
source ~/.bashrc

# 6. Install Soundness CLI (skip kalau sudah ada)
if ! command -v soundnessup >/dev/null 2>&1; then
  echo "[*] Installing Soundness CLI..."
  curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash
  source ~/.bashrc
else
  echo "[✔] Soundness CLI already installed"
fi

# 7. Run soundnessup install (cek PATH dulu)
if command -v soundnessup >/dev/null 2>&1; then
  soundnessup install
elif [ -x "$HOME/.cargo/bin/soundnessup" ]; then
  "$HOME/.cargo/bin/soundnessup" install
else
  echo "[✘] soundnessup not found, try reopening your shell and run: soundnessup install"
  exit 1
fi

echo "[✔] Setup complete!"
