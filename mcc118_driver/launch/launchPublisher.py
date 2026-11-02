from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():

    tension_sensor_node = Node(
        package='mcc118_driver',
        executable='mcc118_publisher',
        name='tension_sensor_node',
        output='screen'
    )

    bluerov2_sensor_node = Node(
        package='cpp_mavlink', 
        executable='mavlink_publisher',
        name='bluerov2_sensor_node',
        output='screen'
    )

    return LaunchDescription([
        tension_sensor_node,
        bluerov2_sensor_node
    ])
