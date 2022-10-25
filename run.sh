#!/bin/sh

echo "Rolling in ..."

# Enter the directory where the script is located
cd src

# Add executable permissions to the script
chmod +x ./configure

# Run config script
./configure

# Make the app
make
