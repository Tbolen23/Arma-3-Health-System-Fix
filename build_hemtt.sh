#!/bin/bash

echo "========================================"
echo "ACE Damage Modifier - HEMTT Builder"
echo "========================================"
echo ""

# Check if HEMTT exists
if [ ! -f "./hemtt" ]; then
    echo "HEMTT not found. Downloading latest version..."
    echo ""

    # Determine OS and architecture
    OS="$(uname -s)"
    ARCH="$(uname -m)"

    case "$OS" in
        Linux*)
            if [ "$ARCH" = "x86_64" ]; then
                HEMTT_FILE="hemtt-linux-x64"
            else
                echo "ERROR: Unsupported architecture: $ARCH"
                exit 1
            fi
            ;;
        Darwin*)
            if [ "$ARCH" = "x86_64" ]; then
                HEMTT_FILE="hemtt-macos-x64"
            elif [ "$ARCH" = "arm64" ]; then
                HEMTT_FILE="hemtt-macos-arm64"
            else
                echo "ERROR: Unsupported architecture: $ARCH"
                exit 1
            fi
            ;;
        *)
            echo "ERROR: Unsupported OS: $OS"
            echo "Please manually download HEMTT from:"
            echo "https://github.com/BrettMayson/HEMTT/releases"
            exit 1
            ;;
    esac

    # Download HEMTT
    echo "Downloading $HEMTT_FILE..."
    DOWNLOAD_URL=$(curl -s https://api.github.com/repos/BrettMayson/HEMTT/releases/latest | grep "browser_download_url.*$HEMTT_FILE" | cut -d '"' -f 4)

    if [ -z "$DOWNLOAD_URL" ]; then
        echo "ERROR: Could not find download URL"
        echo "Please manually download HEMTT from:"
        echo "https://github.com/BrettMayson/HEMTT/releases"
        exit 1
    fi

    curl -L "$DOWNLOAD_URL" -o hemtt
    chmod +x hemtt

    echo "HEMTT downloaded successfully!"
    echo ""
fi

echo "Building with HEMTT..."
echo ""

# Run HEMTT build
./hemtt build --release

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo "SUCCESS! Mod built successfully!"
    echo "========================================"
    echo ""
    echo "Your mod is ready in the releases folder!"
    echo "Output: releases/@ACE_Damage_Modifier"
    echo ""
    echo "Next steps:"
    echo "1. Copy to Arma 3 directory"
    echo "2. Test in-game"
    echo "3. Upload to Steam Workshop (see HEMTT_GUIDE.md)"
    echo ""
else
    echo ""
    echo "========================================"
    echo "ERROR! Build failed!"
    echo "========================================"
    echo ""
    echo "Check the error messages above."
    echo ""
    exit 1
fi
