# OpenAMR Installation and Build Guide

This guide provides step-by-step instructions for setting up and building the OpenAMR (Open Autonomous Mobile Robot) project.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [Detailed Installation](#detailed-installation)
4. [Building Components](#building-components)
5. [Troubleshooting](#troubleshooting)

## Prerequisites

### System Requirements

- **Operating System**: Ubuntu 20.04 LTS (recommended for ROS Noetic support)
- **RAM**: Minimum 4GB (8GB+ recommended)
- **Storage**: At least 5GB free space
- **Internet Connection**: Required for downloading dependencies

### Required Software

#### Essential Tools
```bash
sudo apt-get update
sudo apt-get install -y git curl wget
```

#### For Web UI Development
```bash
# Node.js and npm (version 14.x or higher)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version  # Should be v18.x or higher
npm --version   # Should be 9.x or higher
```

#### For ROS Development (Optional but recommended)
```bash
# ROS Noetic (Ubuntu 20.04)
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y ros-noetic-desktop-full

# Initialize rosdep
sudo rosdep init
rosdep update

# Source ROS setup
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

#### Python Dependencies
```bash
# Python 3 and pip (usually pre-installed on Ubuntu 20.04)
sudo apt-get install -y python3 python3-pip

# Flask for the UI backend
pip3 install flask
```

## Quick Start

### 1. Clone and Setup

```bash
# Clone this repository
git clone https://github.com/EskanderAnsii/fao.git
cd fao

# Run the setup script
./setup.sh
```

This will:
- Clone the OpenAMR repository
- Initialize all git submodules (UI and ROS packages)
- Set up the complete directory structure

### 2. Build (Optional)

```bash
# Run the interactive build script
./build.sh

# Choose an option:
# 1 - Build Web UI only
# 2 - Build ROS packages only
# 3 - Build both
# 4 - Just verify setup
```

## Detailed Installation

### Step 1: Initial Setup

```bash
# Navigate to your workspace
cd ~/workspace  # or your preferred directory

# Clone this repository
git clone https://github.com/EskanderAnsii/fao.git
cd fao
```

### Step 2: Run Setup Script

```bash
./setup.sh
```

Expected output:
```
======================================
OpenAMR Repository Setup Script
======================================
Cloning OpenAMR repository...
Initializing submodules...
======================================
Setup completed successfully!
======================================
```

### Step 3: Verify Installation

```bash
# Check directory structure
ls -l OpenAMR/

# Should show:
# - docs/
# - README.md
# - LICENSE
# - etc.
```

## Building Components

### Building the Web UI

The Web UI is a React application that provides a user interface for controlling the robot.

#### Manual Build

```bash
cd OpenAMR/docs/software/UI/OpenAMR_UI_dev

# Install dependencies
npm install

# Build for production
npm run build

# Or run in development mode
npm run dev
```

#### Using Build Script

```bash
# From the fao root directory
./build.sh
# Select option 1
```

The build output will be in `OpenAMR/docs/software/UI/OpenAMR_UI_dev/build/`

### Building ROS Packages

The ROS packages handle robot navigation, control, and integration.

#### Prerequisites

1. ROS Noetic must be installed (see Prerequisites section)
2. Required ROS packages:

```bash
# Install rosbridge for web communication
sudo apt-get install -y ros-noetic-rosbridge-server

# Install web video server
sudo apt-get install -y ros-noetic-web-video-server

# Install navigation packages (if using Linorobot)
sudo apt-get install -y ros-noetic-navigation
sudo apt-get install -y ros-noetic-gmapping
sudo apt-get install -y ros-noetic-amcl
```

#### Building

```bash
# Create a catkin workspace if you don't have one
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src

# Link or copy the OpenAMR UI package
ln -s ~/workspace/fao/OpenAMR/docs/software/ROS/OpenAMR_UI_package/ui_package ./

# Build the workspace
cd ~/catkin_ws
catkin_make

# Source the workspace
source devel/setup.bash
```

#### Configuration

Edit the configuration file to match your setup:

```bash
# Edit the config file
nano ~/catkin_ws/src/ui_package/param/config.yaml
```

Key parameters to configure:
- `appAddress`: IP address for the web server (e.g., `0.0.0.0` for all interfaces)
- `topics`: ROS topics to subscribe/publish
- `launches`: Launch files for navigation and mapping

### Hardware Setup

The hardware documentation includes:

```bash
# CAD Files and 3D Models
OpenAMR/docs/hardware/CAD_files/

# Bill of Materials (BOM)
OpenAMR/docs/hardware/BOM/

# Electronic Schematics
OpenAMR/docs/hardware/schematics/

# Component Datasheets
OpenAMR/docs/hardware/datasheets/
```

Review these files to understand:
- Mechanical assembly
- Electronic wiring
- Component specifications
- Manufacturing requirements

### Firmware Setup

The firmware is for microcontrollers (Teensy/Arduino):

```bash
# Firmware source code
OpenAMR/docs/software/firmware/
```

**Note**: Firmware development is ongoing. Check the main OpenAMR repository for updates.

## Running the System

### Running the Web UI (Standalone)

```bash
cd OpenAMR/docs/software/UI/OpenAMR_UI_dev
npm run dev
```

Access at: `http://localhost:3000`

### Running with ROS

```bash
# Terminal 1: Start ROS core
roscore

# Terminal 2: Launch the UI package
source ~/catkin_ws/devel/setup.bash
roslaunch ui_package ui.launch

# Terminal 3: Launch robot navigation (if hardware is connected)
# See Linorobot documentation for robot-specific launch files
```

## Troubleshooting

### Common Issues

#### "OpenAMR directory not found"
```bash
# Solution: Run the setup script first
./setup.sh
```

#### "npm: command not found"
```bash
# Solution: Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

#### "ROS_DISTRO not set"
```bash
# Solution: Source ROS setup
source /opt/ros/noetic/setup.bash

# Make it permanent
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
```

#### "catkin_make: command not found"
```bash
# Solution: Install ROS build tools
sudo apt-get install -y python3-catkin-tools
```

#### Build fails with "Cannot find package"
```bash
# Solution: Update and install dependencies
cd ~/catkin_ws
rosdep install --from-paths src --ignore-src -r -y
```

### Getting Help

- **OpenAMR Main Repository**: https://github.com/openAMRobot/OpenAMR
- **OpenAMR Wiki**: https://github.com/openAMRobot/OpenAMR/wiki
- **Issues**: Report issues on the OpenAMR GitHub repository
- **Linorobot**: For ROS navigation questions, see Linorobot documentation

## Next Steps

After successful installation:

1. **Review Documentation**
   ```bash
   cat OpenAMR/README.md
   ```

2. **Explore Hardware Design**
   - Review CAD files for mechanical assembly
   - Check BOM for component sourcing
   - Study schematics for electronics

3. **Test Software**
   - Run the Web UI in development mode
   - Test ROS nodes and topics
   - Verify sensor integration

4. **Hardware Assembly**
   - Follow the assembly guide
   - Connect electronics
   - Flash firmware to microcontrollers

5. **Integration**
   - Configure ROS parameters
   - Calibrate sensors
   - Test navigation

## Additional Resources

- **ROS Tutorials**: http://wiki.ros.org/ROS/Tutorials
- **React Documentation**: https://react.dev/
- **Linorobot**: https://linorobot.org/
- **Flask**: https://flask.palletsprojects.com/

## License

This project is licensed under the MIT License. See the `OpenAMR/LICENSE` file for details.
