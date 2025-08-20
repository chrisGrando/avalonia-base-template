#!/bin/bash

# Absolute path to this shell script
SHELL_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Main menu
option=/dev/null

echo "##################################"
echo "#    Compilation Options Menu    #"
echo "##################################"
echo ""
echo "[1] Windows X64"
echo "[2] Windows ARM64"
echo "[3] Linux X64"
echo "[4] Linux ARM64"
echo "[5] MacOSX X64"
echo "[6] MacOSX ARM64"
echo "[x] Quit"
echo ""
echo "Type below the option ID of the corresponding platform and architecture you wish to build this project for:"
read -n 1 -p "> " option
echo -e "\n__________________________________\n"

# Setup runtime and architecture IDs
runtime_id=/dev/null
target_id=/dev/null

if [ "$option" = "1" ]; then
    runtime_id="win-x64"
    target_id="x64"
elif [ "$option" = "2" ]; then
    runtime_id="win-arm64"
    target_id="arm64"
elif [ "$option" = "3" ]; then
    runtime_id="linux-x64"
    target_id="x64"
elif [ "$option" = "4" ]; then
    runtime_id="linux-arm64"
    target_id="arm64"
elif [ "$option" = "5" ]; then
    runtime_id="osx-x64"
    target_id="x64"
elif [ "$option" = "6" ]; then
    runtime_id="osx-arm64"
    target_id="arm64"
else
    exit 0
fi

# Enter project folder
cd $SHELL_PATH

# Build project
for file in *.sln; do
    dotnet msbuild "-t:Restore;Rebuild" "-p:Configuration=Release;RuntimeIdentifier=$runtime_id;PlatformTarget=$target_id" "$file"
done

# End
read -n 1 -p "* Press any key to exit *" -s null
