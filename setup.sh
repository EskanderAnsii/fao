#!/bin/bash
# Setup script for OpenAMR repository

set -e

echo "======================================"
echo "OpenAMR Repository Setup Script"
echo "======================================"

# Check if OpenAMR directory already exists
if [ -d "OpenAMR" ]; then
    echo "OpenAMR directory already exists. Skipping clone."
else
    echo "Cloning OpenAMR repository..."
    git clone https://github.com/openAMRobot/OpenAMR.git
fi

echo "Initializing submodules..."
(
    cd OpenAMR
    git submodule update --init --recursive
)

echo ""
echo "======================================"
echo "Setup completed successfully!"
echo "======================================"
echo ""
echo "Directory structure:"
echo "  - OpenAMR/docs/hardware/    - Hardware CAD files, BOM, schematics"
echo "  - OpenAMR/docs/software/    - Software packages (ROS, UI, firmware)"
echo ""
echo "Next steps:"
echo "  1. Review the main README: cat OpenAMR/README.md"
echo "  2. Check hardware documentation: OpenAMR/docs/hardware/"
echo "  3. Check software documentation: OpenAMR/docs/software/"
echo "  4. For detailed installation: See OpenAMR wiki"
echo ""
