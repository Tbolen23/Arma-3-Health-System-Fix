#!/bin/bash

echo "========================================"
echo "ACE Damage Modifier - HEMTT Builder"
echo "========================================"
echo ""

# Check if HEMTT exists
if [ -f "./hemtt" ]; then
    echo "HEMTT found!"
else
    echo "HEMTT not found. Downloading automatically..."
    echo ""

    # Determine OS and architecture
    OS="$(uname -s)"
    ARCH="$(uname -m)"

    case "$OS" in
        Linux*)
            if [ "$ARCH" = "x86_64" ]; then
                HEMTT_URL="https://github.com/BrettMayson/HEMTT/releases/download/v1.17.2/linux-x64"
            else
                echo "ERROR: Unsupported architecture: $ARCH"
                exit 1
            fi
            ;;
        Darwin*)
            if [ "$ARCH" = "x86_64" ]; then
                HEMTT_URL="https://github.com/BrettMayson/HEMTT/releases/download/v1.17.2/darwin-x64"
            elif [ "$ARCH" = "arm64" ]; then
                HEMTT_URL="https://github.com/BrettMayson/HEMTT/releases/download/v1.17.2/darwin-arm64"
            else
                echo "ERROR: Unsupported architecture: $ARCH"
                exit 1
            fi
            ;;
        *)
            echo "ERROR: Unsupported OS: $OS"
            exit 1
            ;;
    esac

    # Download HEMTT
    echo "Downloading HEMTT..."
    if command -v curl &> /dev/null; then
        curl -L "$HEMTT_URL" -o hemtt
    elif command -v wget &> /dev/null; then
        wget "$HEMTT_URL" -O hemtt
    else
        echo "ERROR: Neither curl nor wget found. Please install one of them."
        exit 1
    fi

    chmod +x hemtt
    echo "HEMTT downloaded successfully!"
    echo ""
fi

echo "Building with HEMTT..."
echo ""

# Run HEMTT build
./hemtt release

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo "SUCCESS! Mod built successfully!"
    echo "========================================"
    echo ""
    echo "Your mod is ready in: releases/@ACE_Damage_Modifier"
    echo ""
    echo "NEXT STEPS:"
    echo "1. Copy releases/@ACE_Damage_Modifier to your Arma 3 folder"
    echo "2. Enable in Arma 3 Launcher"
    echo "3. Test in-game!"
    echo ""
else
    echo ""
    echo "========================================"
    echo "ERROR! Build failed!"
    echo "========================================"
    echo ""
    exit 1
fi
