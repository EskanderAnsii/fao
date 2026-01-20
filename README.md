# FAO - OpenAMR Repository Build

This repository contains setup scripts and documentation for building and working with the [OpenAMR (Affordable dual-arm mobile robot for SMEs)](https://github.com/openAMRobot/OpenAMR) project.

## Overview

OpenAMR is an open-source autonomous mobile robot (AMR) project designed for SMEs across multiple industries. This repository helps you quickly set up and build the OpenAMR project with all its components.

## Quick Start

### Prerequisites

- Git
- Linux/Unix environment (Ubuntu recommended for ROS support)
- For full build: ROS Noetic, Python 3, Node.js, npm

### Setup

Run the setup script to clone the OpenAMR repository and initialize all submodules:

```bash
./setup.sh
```

This will:
1. Clone the OpenAMR repository from https://github.com/openAMRobot/OpenAMR.git
2. Initialize and update all git submodules
3. Provide you with the complete project structure

## Repository Structure

After running setup, you'll have:

```
.
├── setup.sh              # Setup script (this automates the cloning process)
├── README.md             # This file
└── OpenAMR/              # Cloned OpenAMR repository
    ├── docs/
    │   ├── hardware/     # CAD files, BOM, schematics, datasheets
    │   └── software/     # ROS packages, UI, firmware
    │       ├── ROS/      # ROS Noetic packages for robot control
    │       ├── UI/       # Web-based user interface (React)
    │       └── firmware/ # Microcontroller firmware
    └── README.md         # Main OpenAMR documentation
```

## What's Included

### Hardware Documentation
- **CAD Files**: Complete 3D models and assembly drawings
- **BOM**: Bill of materials for all components
- **Schematics**: Electronic circuit diagrams
- **Datasheets**: Component specifications

### Software Components

1. **ROS Package** (`OpenAMR/docs/software/ROS/OpenAMR_UI_package/`)
   - Navigation and mapping control
   - Robot control nodes
   - Integration with Linorobot

2. **Web UI** (`OpenAMR/docs/software/UI/OpenAMR_UI_dev/`)
   - React-based user interface
   - Map creation and editing
   - Route planning
   - Robot monitoring and control

3. **Firmware** (`OpenAMR/docs/software/firmware/`)
   - Microcontroller code (in development)
   - Motor control
   - Sensor integration

## Building the Project

### Building the Web UI

```bash
cd OpenAMR/docs/software/UI/OpenAMR_UI_dev
npm install
npm run build
```

### Setting up ROS Packages

```bash
# Install dependencies (assuming ROS Noetic is installed)
sudo apt-get install ros-noetic-rosbridge-server ros-noetic-web-video-server

# Install Python dependencies
pip3 install flask

# Build the ROS package
cd OpenAMR/docs/software/ROS/OpenAMR_UI_package
cd ../../../..  # Go to workspace root
catkin_make
```

## Key Features of OpenAMR

- **Navigation**: LIDAR/SLAM-based autonomous navigation
- **Drive Type**: Differential drive
- **Load Capacity**: Up to 150 kg
- **Speed**: 1200-2000 mm/s
- **Battery**: 24/48V, 8 hours runtime
- **Communication**: Wi-Fi (2.4/5 GHz)

## Next Steps

1. **Hardware Build**: Review `OpenAMR/docs/hardware/` for manufacturing instructions
2. **Software Setup**: Follow the detailed guide in `OpenAMR/docs/software/README.md`
3. **Wiki**: Check the [OpenAMR Wiki](https://github.com/openAMRobot/OpenAMR/wiki/Getting-started) for complete tutorials

## Resources

- **Main Repository**: https://github.com/openAMRobot/OpenAMR
- **Documentation**: See `OpenAMR/README.md` and `OpenAMR/docs/`
- **License**: MIT License (see `OpenAMR/LICENSE`)

## Support

For questions and support, refer to:
- OpenAMR main repository issues
- OpenAMR documentation and wiki
- Linorobot community resources

## License

This setup repository follows the same MIT License as the OpenAMR project.