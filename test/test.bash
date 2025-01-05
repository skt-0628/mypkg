#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build

source /opt/ros/foxy/setup.bash
source $dir/ros2_ws/install/setup.bash

timeout 10 ros2 run mypkg system_status > /tmp/mypkg.log

timeout 10 ros2 topic echo /system_status_publisher > /tmp/topic_output.log &

cat /tmp/mypkg.log

cat /tmp/topic_output.log | grep "CPU"
cat /tmp/topic_output.log | grep "Memory"

