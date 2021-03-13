#!/usr/bin/env bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup component add rust-src

curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.cargo/bin/rust-analyzer
chmod +x ~/.cargo/bin/rust-analyzer

