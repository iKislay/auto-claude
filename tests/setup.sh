#!/bin/bash
set -e

TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBS_DIR="$TEST_DIR/libs"

mkdir -p "$LIBS_DIR"

# Install bats-core
if [ ! -d "$LIBS_DIR/bats" ] || [ ! -f "$LIBS_DIR/bats/bin/bats" ]; then
    echo "Installing bats-core..."
    rm -rf "$LIBS_DIR/bats"
    git clone https://github.com/bats-core/bats-core.git "$LIBS_DIR/bats"
else
    echo "bats-core already installed."
fi

# Install bats-support
if [ ! -d "$LIBS_DIR/bats-support" ] || [ ! -f "$LIBS_DIR/bats-support/load.bash" ]; then
    echo "Installing bats-support..."
    rm -rf "$LIBS_DIR/bats-support"
    git clone https://github.com/bats-core/bats-support.git "$LIBS_DIR/bats-support"
else
    echo "bats-support already installed."
fi

# Install bats-assert
if [ ! -d "$LIBS_DIR/bats-assert" ] || [ ! -f "$LIBS_DIR/bats-assert/load.bash" ]; then
    echo "Installing bats-assert..."
    rm -rf "$LIBS_DIR/bats-assert"
    git clone https://github.com/bats-core/bats-assert.git "$LIBS_DIR/bats-assert"
else
    echo "bats-assert already installed."
fi

echo "Test dependencies installed in $LIBS_DIR"
