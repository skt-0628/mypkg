#!/usr/bin/python3
#SPDX-FileCopyrightText: 2025 Takumi Sakata
#SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import psutil


class SystemPublisher(Node):
    def __init__(self):
        super().__init__('system_status_publisher')
        self.publisher_ = self.create_publisher(String, 'system_status_publisher', 10)
        self.timer = self.create_timer(5.0, self.publish_system_status)

    def publish_system_status(self):
        cpu_usage = psutil.cpu_percent(interval=None)
        memory_usage = psutil.virtual_memory().percent
        message = f"CPU: {cpu_usage:.1f}%, Memory: {memory_usage:.1f}%"
        msg = String()
        msg.data = message
        self.publisher_.publish(msg)


def main(args=None):
    rclpy.init(args=args)
    node = SystemPublisher()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

