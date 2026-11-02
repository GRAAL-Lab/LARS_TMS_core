# LARS_TMS_core

ROS 2 packages for the LARS and TMS project. This repository contains the core software used to bridge external sensor and telemetry sources into ROS topics for monitoring, logging, and downstream control.

The codebase is organized as a small ROS workspace with three main packages:

- `cpp_mavlink` — receives MAVLink telemetry over UDP and republishes selected data as ROS 2 messages.
- `mavlink_msg` — defines custom ROS message interfaces for MAVLink-derived data.
- `mcc118_driver` — reads analog measurements from a Measurement Computing MCC 118 DAQ HAT and publishes cable tension data.

## Overview

This repository is intended to support data acquisition and integration for robotic systems that combine:

- vehicle or platform telemetry from MAVLink-enabled sources,
- sensor measurements from DAQ hardware,
- ROS-based processing, visualization, and control.

The packages are designed to be built together in a ROS 2 workspace using `colcon`.

## Repository structure

```text
LARS_TMS_core/
├── cpp_mavlink/
│   ├── CMakeLists.txt
│   ├── package.xml
│   ├── README.md
│   ├── include/
│   └── src/
├── mavlink_msg/
│   ├── CMakeLists.txt
│   ├── package.xml
│   ├── README.md
│   └── msg/
├── mcc118_driver/
│   ├── CMakeLists.txt
│   ├── package.xml
│   ├── README.md
│   ├── include/
│   ├── msg/
│   └── src/
├── LICENSE
├── README.md
└── .gitignore
```

## Package descriptions

### 1. `cpp_mavlink`

The `cpp_mavlink` package is a ROS 2 C++ bridge for MAVLink telemetry. It listens for MAVLink packets on a UDP socket, decodes selected message types, and publishes them as ROS topics for downstream consumers.

Typical use cases:

- vehicle telemetry ingestion,
- vehicle state monitoring,
- integration with custom robot control stacks,
- publishing attitude, battery, IMU, pressure, and related data into ROS.

This package depends on:

- `rclcpp`
- `std_msgs`
- `geometry_msgs`
- `sensor_msgs`
- `mavros_msgs`
- `mavlink`
- `OpenCV`
- `mavlink_msg`

### 2. `mavlink_msg`

The `mavlink_msg` package defines custom ROS interface definitions used to expose MAVLink-derived values in a ROS-native way.

Included message types:

- `Attitude.msg`
- `BatteryStatus.msg`
- `IMU.msg`
- `Pressure.msg`

These message definitions are generated with `rosidl` and are used as the interface layer between MAVLink parsing code and ROS consumers.

### 3. `mcc118_driver`

The `mcc118_driver` package interfaces with a Measurement Computing MCC 118 DAQ HAT and publishes analog measurements in ROS-friendly form.

Current behavior:

- opens the MCC 118 device,
- configures continuous analog input acquisition,
- reads channel data at a configured scan rate,
- converts the raw DAQ values to engineering units,
- publishes cable tension as a `geometry_msgs/msg/WrenchStamped` on `/cable_tension`.

This package depends on:

- `ament_cmake`
- `rclcpp`
- `std_msgs`
- `geometry_msgs`
- `rosidl_default_generators`
- MCC DAQ HAT SDK (`daqhats` / `daqhats_utils`)

## Requirements

### Software

- ROS 2 (tested in a ROS 2 workspace style setup)
- `colcon`
- CMake 3.8+
- Python 3
- `rosdep` (recommended)

### External dependencies

- MAVLink development headers / package (`mavlink`)
- `mavros_msgs`
- `OpenCV`
- MCC DAQ HAT SDK for the MCC 118 board

## Installation

Clone the repository into a ROS 2 workspace:

```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/GRAAL-Lab/LARS_TMS_core.git
```

## Building the packages

To build all packages in the repository:

```bash
cd ~/ros2_ws
colcon build --symlink-install
```

## Running the nodes

### MAVLink bridge

Launch the MAVLink publisher node:

```bash
ros2 run cpp_mavlink mavlink_publisher -
```

### MCC118 driver

Start the DAQ publisher node:

```bash
ros2 run mcc118_driver mcc118_publisher
```

The driver publishes measurement data to:

```text
/cable_tension
```

The message type is:

```text
geometry_msgs/msg/WrenchStamped
```

## Published topics and messages

### `cpp_mavlink`

The package republishes MAVLink telemetry onto ROS topics using standard ROS message types and the custom interfaces in `mavlink_msg`.

Typical data includes attitude, battery, IMU, and pressure information, depending on the configured MAVLink traffic and the selected messages.

### `mcc118_driver`

The `mcc118_driver` publishes tension data on a standard ROS wrench topic:

```text
/cable_tension
```

This is a `geometry_msgs/msg/WrenchStamped`, which contains:

- `header.stamp`
- `wrench.force.x`
- `wrench.force.y`
- `wrench.force.z` (if used by the wider system)


## License

This project is licensed under the Apache License 2.0.

See the LICENSE file in the repository for details.

## Acknowledgements

This repository builds on:

- ROS 2 tooling and message generation (`ament_cmake`, `rosidl`),
- MAVLink telemetry standards,
- the Measurement Computing DAQ HAT SDK for MCC 118 hardware.

## Quick start

```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/GRAAL-Lab/LARS_TMS_core.git
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y
colcon build --symlink-install
source install/setup.bash

# Run the launch file
ros2 launch mcc118_driver launchPublisher.py
```
or run the nodes separately
```bash

# Run the MAVLink bridge
ros2 run cpp_mavlink mavlink_publisher

# Run the MCC118 driver
ros2 run mcc118_driver mcc118_publisher
```

This repository is a practical starting point for integrating MAVLink telemetry and DAQ-based force sensing into a ROS 2-based control and monitoring system.
