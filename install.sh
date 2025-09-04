#!/bin/bash
set -e

SKIP_UPDATE=false

# Cek flag
for arg in "$@"; do
  case $arg in
    --skip-update)
      SKIP_UPDATE=true
      shift
      ;;
  esac
done

if [ "$SKIP_UPDATE" = false ]; then
  echo "=== Update & upgrade ==="
  sudo apt update && sudo apt upgrade -y
else
  echo "=== Skip apt update & upgrade ==="
fi

echo "=== Install Rust if not exists ==="
if ! command -v rustc &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "Rust already installed: $(rustc --version)"
fi

echo "=== Check Rust version ==="
rustc --version
cargo --version

echo "=== Ensure Rust env in bashrc ==="
grep -q 'source \$HOME/.cargo/env' ~/.bashrc || echo 'source $HOME/.cargo/env' >> ~/.bashrc
source ~/.bashrc

echo "=== Install Soundness CLI if not exists ==="
if [ ! -f "$HOME/.cargo/bin/soundnessup" ]; then
  curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash
else
  echo "soundnessup already installed: $($HOME/.cargo/bin/soundnessup --version || echo 'version check failed')"
fi

echo "=== Run CLI installer ==="
"$HOME/.cargo/bin/soundnessup" install || echo "⚠️ soundnessup install failed, try running manually after restarting shell."

echo "=== Done! Restart terminal or run 'source ~/.bashrc' again ==="
