# mavlink_msg

A ROS 2 message package for exposing MAVLink-derived telemetry on ROS topics. This package is intended for use with systems that bridge MAVLink data into ROS, including py_mavlink-based pipelines and custom ROS nodes that need standard message definitions for sensor and state data (For example, the py_mavlink package https://github.com/GRAAL-Lab/py_mavlink). 

## Overview

`mavlink_msg` defines a small set of custom ROS interfaces that mirror commonly used MAVLink messages, allowing them to be published and consumed as native ROS messages. The generated interfaces are designed to be lightweight and easy to integrate into ROS 2 applications for visualization, logging, estimation, or control.

This package contains the following message definitions:

- `Attitude.msg` — roll, pitch, yaw, and angular rates
- `BatteryStatus.msg` — battery voltages, current, charge state, and fault information
- `IMU.msg` — accelerometer, gyroscope, magnetometer, and temperature data
- `Pressure.msg` — absolute and differential pressure readings with temperature data


## Dependencies

This package depends on:

- ROS 2 `ament_cmake`
- `std_msgs`
- `rosidl_default_generators`
- `rosidl_default_runtime`

## Build

From a ROS 2 workspace:

```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/GRAAL-Lab/mavlink_msg.git
cd ~/ros2_ws
colcon build --packages-select mavlink_msg
source install/setup.bash
```

## Typical usage

This package is intended to be used as a message schema layer between MAVLink data and ROS. In a typical setup, a node or bridge (for example, a py_mavlink-based converter) parses MAVLink packets and publishes the corresponding ROS messages on topics such as:

- `/imu/data`
- `/pressure`
- `/attitude`
- `/battery_status`

The generated message definitions are compatible with standard ROS tooling, including topic introspection, logging, and Python/C++ node integration.

## Notes

- This package is a message-only ROS package; it does not implement MAVLink parsing by itself.
- It is best used together with a MAVLink-to-ROS conversion node or custom bridge.
- The package is designed for integration into ROS 2 systems https://github.com/GRAAL-Lab/py_mavlink  where telemetry is published on topics for downstream processing.

## License

This project is licensed under the Apache License 2.0. See the `LICENSE` file for details.
