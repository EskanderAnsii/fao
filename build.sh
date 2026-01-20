#!/bin/bash
# Build script for OpenAMR components

set -e

echo "======================================"
echo "OpenAMR Build Script"
echo "======================================"

# Check if OpenAMR directory exists
if [ ! -d "OpenAMR" ]; then
    echo "Error: OpenAMR directory not found!"
    echo "Please run ./setup.sh first to clone the repository."
    exit 1
fi

echo ""
echo "What would you like to build?"
echo "  1) Web UI (React application)"
echo "  2) ROS Packages (requires ROS Noetic)"
echo "  3) Both"
echo "  4) Skip build (just verify setup)"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1|3)
        echo ""
        echo "======================================"
        echo "Building Web UI..."
        echo "======================================"
        
        UI_PATH="OpenAMR/docs/software/UI/OpenAMR_UI_dev"
        
        if [ -d "$UI_PATH" ]; then
            cd "$UI_PATH"
            
            # Check if node_modules exists
            if [ ! -d "node_modules" ]; then
                echo "Installing npm dependencies..."
                npm install
            else
                echo "Dependencies already installed. Skipping npm install."
            fi
            
            echo "Building UI..."
            npm run build
            
            echo ""
            echo "✓ UI build completed successfully!"
            echo "Build output: $UI_PATH/build/"
            
            cd - > /dev/null
        else
            echo "Error: UI directory not found at $UI_PATH"
            exit 1
        fi
        
        if [ "$choice" != "3" ]; then
            break
        fi
        echo ""
        ;&
    2|3)
        echo ""
        echo "======================================"
        echo "Building ROS Packages..."
        echo "======================================"
        
        # Check if ROS is installed
        if [ -z "$ROS_DISTRO" ]; then
            echo "Warning: ROS environment not detected (ROS_DISTRO not set)"
            echo "Please install ROS Noetic or source your ROS setup:"
            echo "  source /opt/ros/noetic/setup.bash"
            echo ""
            read -p "Continue anyway? (y/n): " continue_choice
            if [ "$continue_choice" != "y" ]; then
                exit 1
            fi
        fi
        
        echo "Checking Python dependencies..."
        if ! python3 -c "import flask" 2>/dev/null; then
            echo "Installing Flask..."
            pip3 install flask
        else
            echo "Flask is already installed."
        fi
        
        ROS_PKG_PATH="OpenAMR/docs/software/ROS/OpenAMR_UI_package"
        
        if [ -d "$ROS_PKG_PATH" ]; then
            echo ""
            echo "ROS package location: $ROS_PKG_PATH"
            echo ""
            echo "To build the ROS package, you need to:"
            echo "  1. Create a catkin workspace (if not exists)"
            echo "  2. Copy or symlink the package to the workspace src/"
            echo "  3. Run catkin_make"
            echo ""
            echo "Example:"
            echo "  mkdir -p ~/catkin_ws/src"
            echo "  ln -s $(pwd)/$ROS_PKG_PATH/ui_package ~/catkin_ws/src/"
            echo "  cd ~/catkin_ws"
            echo "  catkin_make"
            echo ""
        else
            echo "Error: ROS package directory not found at $ROS_PKG_PATH"
            exit 1
        fi
        ;;
    4)
        echo ""
        echo "Skipping build. Verifying setup..."
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""
echo "======================================"
echo "Verification Summary"
echo "======================================"

# Verify directory structure
echo "Checking directory structure..."
if [ -d "OpenAMR/docs/hardware" ]; then
    echo "✓ Hardware documentation found"
else
    echo "✗ Hardware documentation missing"
fi

if [ -d "OpenAMR/docs/software/UI/OpenAMR_UI_dev" ]; then
    echo "✓ UI package found"
else
    echo "✗ UI package missing"
fi

if [ -d "OpenAMR/docs/software/ROS/OpenAMR_UI_package" ]; then
    echo "✓ ROS package found"
else
    echo "✗ ROS package missing"
fi

if [ -d "OpenAMR/docs/software/firmware" ]; then
    echo "✓ Firmware directory found"
else
    echo "✗ Firmware directory missing"
fi

echo ""
echo "======================================"
echo "Build process completed!"
echo "======================================"
echo ""
echo "Next steps:"
echo "  - Review documentation in OpenAMR/README.md"
echo "  - Check OpenAMR wiki for detailed setup instructions"
echo "  - Hardware files: OpenAMR/docs/hardware/"
echo "  - Software files: OpenAMR/docs/software/"
echo ""
