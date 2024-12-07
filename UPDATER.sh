#!/bin/bash

# GitHub API URL for the latest release of tModLoader repository
REPO="tModLoader/tModLoader"
API_URL="https://api.github.com/repos/$REPO/releases/latest"

# Fetch the latest release data and extract the .zip download URL
ZIP_URL=$(curl -s $API_URL | grep "browser_download_url.*tModLoader.zip" | cut -d '"' -f 4)

# Check if we found a URL
if [ -z "$ZIP_URL" ]; then
    echo "Failed to find tModLoader.zip in the latest release."
    exit 1
fi

# Download the latest tModLoader.zip
echo "Downloading tModLoader.zip from $ZIP_URL..."
curl -L -o tModLoader.zip "$ZIP_URL"

# Verify download
if [ ! -f tModLoader.zip ]; then
    echo "Download failed or file not found."
    exit 1
fi

echo "Download complete: tModLoader.zip"

# Unzip the downloaded file directly into the current directory
echo "Unzipping tModLoader.zip into the current directory..."
unzip -o tModLoader.zip

# Verify unzip
if [ $? -ne 0 ]; then
    echo "Unzipping failed."
    exit 1
fi

echo "Unzipping complete. Files are in the current directory."

chmod 770 start-tModLoaderServer.sh
rm tModLoader.zip
