#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Default installation directory
INSTALL_DIR="/usr/share/samba-configurator"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--install-dir) INSTALL_DIR="$2"; shift 2 ;;
        *) shift ;;
    esac
done

echo "Starting installation of Samba Configurator"
echo "Updating package lists and installing dependencies..."

# Update package lists
apt-get update
if [[ $? -ne 0 ]]; then
    echo "Failed to update package lists"
    exit 1
fi

# Install required packages
apt-get install -y curl samba python3 python3-pip python3-gi gir1.2-gtk-4.0 policykit-1

if [[ $? -ne 0 ]]; then
    echo "Failed to install required packages"
    exit 1
fi

# Copy program files to installation directory
echo "Installing Samba Configurator to $INSTALL_DIR"

mkdir -p "$INSTALL_DIR"
cp *.py "$INSTALL_DIR/"
cp README.md "$INSTALL_DIR/"
cp samba-configurator.desktop /usr/share/applications/
cp -r locale/ "$INSTALL_DIR/locale"

# Install the executable script
cp samba-configurator.sh /usr/bin/samba-configurator
chmod +x /usr/bin/samba-configurator

echo "Installation completed successfully!"
echo "You can now run 'samba-configurator' from the terminal or find it in your applications menu."