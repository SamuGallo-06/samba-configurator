#!/bin/bash
# Script to generate icons at multiple resolutions from icon.png

# Check if icon.png exists
if [ ! -f "icon.png" ]; then
    echo "Error: icon.png not found in current directory"
    exit 1
fi

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed"
    echo "Please install it with: sudo apt install imagemagick"
    exit 1
fi

echo "Generating icons at multiple resolutions..."

# Create icon directories
RESOLUTIONS=(16 22 32 48 64 128 256 512)

for size in "${RESOLUTIONS[@]}"; do
    echo "Creating ${size}x${size} icon..."
    
    # Create directory if it doesn't exist
    mkdir -p "icons/${size}x${size}"
    
    # Generate icon at specified resolution
    convert icon.png -resize ${size}x${size} "icons/${size}x${size}/samba-configurator.png"
    
    if [ $? -eq 0 ]; then
        echo "✓ Created icons/${size}x${size}/samba-configurator.png"
    else
        echo "✗ Failed to create ${size}x${size} icon"
    fi
done

echo ""
echo "Icon generation complete!"
echo "Icon files have been created in the icons/ directory"
